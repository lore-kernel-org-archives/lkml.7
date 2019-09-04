Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1BC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AAD23402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619943;
	bh=gFvXK3IG4GFAXcEV6XgFaWxf1Ol+tUwYHXpCyQve8Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yblcgq4mGGCMGeH9SjyS2CcIGAfocM/5O+Fy2R4K6Cfkcc1NaCQAOzR6AT0AtqL5S
	 g97iWmkhFoz1X1si8EvTI/UqYianQP/Xxou5AJi9LdAZAhlbKP/5VZ0OkgWz9gi3ar
	 APTzN6pK95tGAvDite2SHTk/lEC3Q9AfRgKJktNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfIDR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbfIDR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:59:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CA722CF7;
        Wed,  4 Sep 2019 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619940;
        bh=gFvXK3IG4GFAXcEV6XgFaWxf1Ol+tUwYHXpCyQve8Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cVb7hy7XO/uqZXoQNd+4v/AxHC8kz/NqYPSDAjD/ow5PsqbzwTEbS9s8mO3kH4BZ
         NQOvqT05AItBC7I2dP9ryujgcETFagF8VW1c1hxSB8LIbgcA7b9sJW/9RAeMJ2YKI5
         6aPeP5Tq85lDsFhNBl+2VJn4mLUYPsear8jNG7w8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/83] perf bench numa: Fix cpu0 binding
Date:   Wed,  4 Sep 2019 19:53:06 +0200
Message-Id: <20190904175305.134362678@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6bbfe4e602691b90ac866712bd4c43c51e546a60 ]

Michael reported an issue with perf bench numa failing with binding to
cpu0 with '-0' option.

  # perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd
  # Running 'numa/mem' benchmark:

   # Running main, "perf bench numa numa-mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd"
  binding to node 0, mask: 0000000000000001 => -1
  perf: bench/numa.c:356: bind_to_memnode: Assertion `!(ret)' failed.
  Aborted (core dumped)

This happens when the cpu0 is not part of node0, which is the benchmark
assumption and we can see that's not the case for some powerpc servers.

Using correct node for cpu0 binding.

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190801142642.28004-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/bench/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index e58be7eeced83..7b364f2926d4f 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -373,8 +373,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
 
 	/* Allocate and initialize all memory on CPU#0: */
 	if (init_cpu0) {
-		orig_mask = bind_to_node(0);
-		bind_to_memnode(0);
+		int node = numa_node_of_cpu(0);
+
+		orig_mask = bind_to_node(node);
+		bind_to_memnode(node);
 	}
 
 	bytes = bytes0 + HPSIZE;
-- 
2.20.1



