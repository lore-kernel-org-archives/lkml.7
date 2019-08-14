Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E45C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF73A20679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749435;
	bh=kIEbfTT98/uEJP80obzZQD5GGPh94hBZFFRRdsXv5eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sBx3lxGacFpQiyKPK8xtPAnDyZlRPP5Nz4wLN5cQBsj2PqkKs+zM1KmF7ohPsuuQE
	 QSgsj2k3AbpY5jZllmxcrZ/RN7v31ZJO4tvEcdCyGoRn3C7O7qmCwMc8pcLUDNKotl
	 44WqebvTulArWXjTllSmzv4w26ZpgaZUf7DAWxlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHNCXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfHNCXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D1E20842;
        Wed, 14 Aug 2019 02:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749428;
        bh=kIEbfTT98/uEJP80obzZQD5GGPh94hBZFFRRdsXv5eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9fhZOrljr0mygM1hvRuxReRDT/TLNPdPqGYqO9Xd8aepRFJ/xYR4xSVl06Gv/kiE
         kvtc3Ab5PPuEkBHxZqdT6BosSOKWg+Ll6k2cPGyOk8lXfEaNdG4n1vPrY0dXDTjHMk
         2MpGPlU4ztrebslaIvjyji3n+nEswiIylC7I1ZBM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 14/33] perf bench numa: Fix cpu0 binding
Date:   Tue, 13 Aug 2019 22:23:04 -0400
Message-Id: <20190814022323.17111-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

