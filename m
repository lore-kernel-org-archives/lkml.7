Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B84FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305AE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437177;
	bh=sv3AcplPh/x/HJ/H3hvgJUOAaTDB7KXd0y7Ec48YC/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ADoxDNsTCtjSGEvhBcCMg4ghe2TITBUz8mI/riearzyMjlcXBL7hQoEe0ipwDHwdi
	 hzr0i85fLR3ZSDwjJCcJDI7oVORIsZ9DoZ+ujSJ0t1MAPhJLp6KNiq1i8+EbYjD1yI
	 siFyaJT7TYdkpJcDlypbxvrHHuiPlYwsFoWMuyIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393695AbfJRWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732236AbfJRWG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C81222D1;
        Fri, 18 Oct 2019 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436418;
        bh=sv3AcplPh/x/HJ/H3hvgJUOAaTDB7KXd0y7Ec48YC/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lKXPEGTL/iPV41dNgS2vdjHOoBTGdnPwQwCM7+7tCBjuDWCoFCRy6TkVAIvm8DcV
         Mtj1qMtL24rRSeK60fal7Z4rhXJn1xCmZoulX+Gmgi81SYaH9p41OtkD3c+Q92NQjj
         C+3d3EqArbQ/X5z3kvTO+AtIWHcqsDPxPptJGWhI=
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
Subject: [PATCH AUTOSEL 4.19 061/100] perf annotate: Return appropriate error code for allocation failures
Date:   Fri, 18 Oct 2019 18:04:46 -0400
Message-Id: <20191018220525.9042-61-sashal@kernel.org>
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

[ Upstream commit 16ed3c1e91159e28b02f11f71ff4ce4cbc6f99e4 ]

We should return errno or the annotation extra range understood by
symbol__strerror_disassemble() instead of -1, fix it, returning ENOMEM
instead.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-8of1cmj3rz0mppfcshc9bbqq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 83a3ad4256c5b..6958d7eed5bed 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1614,7 +1614,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_path = strdup(filename);
 	if (!build_id_path)
-		return -1;
+		return ENOMEM;
 
 	/*
 	 * old style build-id cache has name of XX/XXXXXXX.. while
@@ -2732,7 +2732,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
 	if (notes->offsets == NULL)
-		return -1;
+		return ENOMEM;
 
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
-- 
2.20.1

