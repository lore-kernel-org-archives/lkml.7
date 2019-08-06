Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3D206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MAo4u0lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfHFGXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:23:42 -0400
Received: from m12-13.163.com ([220.181.12.13]:56005 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731594AbfHFGXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NKt2U
        0XciXEyfQgGeM1oGcrEzerIfbKQX/kvjjpEBTc=; b=MAo4u0lrNnHuMVgRCv4z+
        rQ3y25+7tH8zKB/iTPHr5E6cpVNNs+OZrl+ZH1aiBpGfl3DK4nRgyjwpY2B6u4F7
        Fn1SXk1E/sKxtmdjXD+5wiWs/JzeWLoEzcixKOuORCHldGl7t3NBv4k4ecc07iHS
        xIubMnGMNVxxRDkFos9dsQ=
Received: from localhost.localdomain (unknown [112.25.212.39])
        by smtp9 (Coremail) with SMTP id DcCowADH18faHEldtgTmEA--.42022S2;
        Tue, 06 Aug 2019 14:23:23 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangx.jy@cn.fujitsu.com, Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] kbuild: Remove unused variable TMPO of ld-option
Date:   Tue,  6 Aug 2019 14:23:16 +0800
Message-Id: <20190806062316.30784-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADH18faHEldtgTmEA--.42022S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr13Gr1fJF17ZFykJw4kCrg_yoWfWwbE9F
        yIqFy0qanxta1rAr1kAa1FgrWak34UGFsaqw1rKr47C3sFk395KanrJrZ7Ja429anrJFn3
        WFWqqr98WryfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbsYwUUUUUU==
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiEBsJXlWBncr0pQAAsO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ld-option implementation has been simplified so variable TMPO
is no longer needed.

Fixes: Commit 0294e6f4a000 ("kbuild: simplify ld-option implementation")
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 scripts/Kbuild.include | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 4b0432e095ae..13a6f627351d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -91,12 +91,11 @@ TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
 # automatically cleaned up.
 try-run = $(shell set -e;		\
 	TMP="$(TMPOUT).$$$$.tmp";	\
-	TMPO="$(TMPOUT).$$$$.o";	\
 	if ($(1)) >/dev/null 2>&1;	\
 	then echo "$(2)";		\
 	else echo "$(3)";		\
 	fi;				\
-	rm -f "$$TMP" "$$TMPO")
+	rm -f "$$TMP")
 
 # as-option
 # Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
-- 
2.21.0


