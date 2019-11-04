Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD1C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905776;
	bh=T0CouP6WpoDSSLflItbBgJHRt3Dc+ee9mKxmKruvkOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JVCHrR3ui2Q3WZ/ydFzmq/K6OULuxFNj4rX/z/yDiE7xRNxI67l2m5YCoTte/hAUM
	 ng2vwbOEI3F6dEHI+n2PrDThfoodgm6P8bL2DhMZeksIaslICw7jiPNo/aTJ2Jr7K6
	 2Zfb6BGr/ZLdBTaRXzUS8/MqJxjW/xowal/Hd0V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbfKDWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfKDWEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:04:22 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D9E7205C9;
        Mon,  4 Nov 2019 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905062;
        bh=T0CouP6WpoDSSLflItbBgJHRt3Dc+ee9mKxmKruvkOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7auxa1SrurV5PmmljmNO9HXPy9xNJGK+l1ILFWICsotCd5cSfwcTsTrhTBY/+Whd
         cgZgFO6FbY4rXWYIRGiiPLRWEXKKCBSFWKZtJcfBRaS2tMtwi4GBa/2Qlz7pTnliQC
         +D+oFTtHLTg6u+VTs4GJ8c+xpihVDfSKpCbiMHU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.3 016/163] perf annotate: Propagate the symbol__annotate() error return
Date:   Mon,  4 Nov 2019 22:43:26 +0100
Message-Id: <20191104212141.605663467@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 211f493b611eef012841f795166c38ec7528738d ]

We were just returning -1 in symbol__annotate() when symbol__annotate()
failed, propagate its error as it is used later to pass to
symbol__strerror_disassemble() to present a error message to the user,
that in some cases were getting:

  "Invalid -1 error code"

Fix it to propagate the error.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-0tj89rs9g7nbcyd5skadlvuu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2dac51e9e4180..ca8b517e38fa8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2991,7 +2991,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 out_free_offsets:
 	zfree(&notes->offsets);
-	return -1;
+	return err;
 }
 
 #define ANNOTATION__CFG(n) \
-- 
2.20.1



