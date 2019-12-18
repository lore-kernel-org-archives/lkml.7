Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB84C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E093F206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLRLzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:55:18 -0500
Received: from mxwww.masterlogin.de ([95.129.51.220]:42554 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLRLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:55:17 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 06:55:16 EST
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 51E8196385;
        Wed, 18 Dec 2019 11:46:44 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id B137E3FC84;
        Wed, 18 Dec 2019 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.76.99.135.bambit.de [185.76.99.135])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 21E728099B;
        Wed, 18 Dec 2019 11:46:44 +0000 (UTC)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-kbuild@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Add DTC_CPP_FLAGS
Date:   Wed, 18 Dec 2019 12:46:25 +0100
Message-Id: <20191218114625.28438-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this Patch we are able to change cpp-preprocessor options
(e.g. -D...) for using conditions (#ifdef) in devicetree files
and dynamically add include searchpaths

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fa32f83b2d7..c722a6c7786a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -177,7 +177,7 @@ DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
-		 -undef -D__DTS__
+		 -undef -D__DTS__ $(DTC_CPP_FLAGS)
 
 # Useful for describing the dependency of composite objects
 # Usage:
-- 
2.17.1

