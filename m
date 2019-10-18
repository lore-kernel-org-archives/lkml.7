Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320F320679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437141;
	bh=FxnXi6ieQJiByUUrfBmm0/Y9UkyehQruV0wZx9VOxbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kqvei6w2zFdgitX0jCbZkU3IG6aMtbgRn4vESH7MXFCeCkDWfGRvcrNgvW/+C4ND3
	 CIw7giLSsdku2lF6hgLXTzy+/jun454CMOUAeBFHZqEYIORcvi8O3CQNFAgX9Fwbim
	 KSuyFg0IeBhhSnV02hN7K44L8m8hXDtRDt2wK3ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbfJRWHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732127AbfJRWGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F502245D;
        Fri, 18 Oct 2019 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436415;
        bh=FxnXi6ieQJiByUUrfBmm0/Y9UkyehQruV0wZx9VOxbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8fm2q1Ykhj9xMqkT2LTIW3oWMy9VTdIK6Klv4OJ/oRF9dUnW4OOW4HY+3UOA6dok
         8Phvde1pbv7Bp39AU/ygQoqlCdwbGCcuc/oJsAn3fDatJPSnOZl6hmeoE7/WZCUBpY
         RNQwdI2CktVgFSBk/DYi9RE2W4hYnyUISbbL0yfc=
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
Subject: [PATCH AUTOSEL 4.19 059/100] perf annotate: Fix the signedness of failure returns
Date:   Fri, 18 Oct 2019 18:04:44 -0400
Message-Id: <20191018220525.9042-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 28f4417c3333940b242af03d90214f713bbef232 ]

Callers of symbol__annotate() expect a errno value or some other
extended error value range in symbol__strerror_disassemble() to
convert to a proper error string, fix it when propagating a failure to
find the arch specific annotation routines via arch__find(arch_name).

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-o0k6dw7cas0vvmjjvgsyvu1i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4ef62bcdc80f0..b4946ef48b621 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1875,7 +1875,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 
 	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
-		return -ENOTSUP;
+		return ENOTSUP;
 
 	if (parch)
 		*parch = arch;
-- 
2.20.1

