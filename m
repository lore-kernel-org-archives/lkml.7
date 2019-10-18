Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31802222D2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436226;
	bh=T0CouP6WpoDSSLflItbBgJHRt3Dc+ee9mKxmKruvkOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UyRXmg38VKQJ2INQF9M53/8NWkYKaTp1WUstxv0ykHG1EV91fMvzsXMIGL6l58Wac
	 PzyUVTO20E+7xOv8ayxAYiUAdD3S7UjfbCocheY0Ejdw3FYHKoa8f897yB/eTRsb3K
	 0VDmqB3vFnNOFvLyDnVMg34L5yMCGvSWXax6NRnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJRWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfJRWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:03:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC75222D3;
        Fri, 18 Oct 2019 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436222;
        bh=T0CouP6WpoDSSLflItbBgJHRt3Dc+ee9mKxmKruvkOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8NbQ3LCUNHVG2+A9ZAdSZeSoe29um+mKyENNTgbFMmBriNYsEcrQ+131N5H0oUEh
         t4ec5ZkJLwmhG82PpslCHlZo370lX1JgqzZKnxZzpamVZevqMEnPQ6sz+tgfpOHMY3
         WilrM0EpRXBI2XMBQT7QMj2kKM5RGX6hjVVc0Dec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 11/89] perf annotate: Propagate the symbol__annotate() error return
Date:   Fri, 18 Oct 2019 18:02:06 -0400
Message-Id: <20191018220324.8165-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

