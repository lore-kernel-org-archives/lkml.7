Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15550C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19ED206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="lbA/PVFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCDQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:58:01 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:62109 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCDQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1hHDnrBWRgx1wOpaCGBwWc59L/HnawNq9sjy5Dr/Yyc=; b=lbA/PVFklmDFpvhjv74M8CgiNv
        wybbfOSou8NjJR6iU+4nPmuWwc//5pUq020r82OxVXGeBwAAWA2ZTMqbmCC+rxU7PxW7LpWe88tts
        6/rswrsPg9PEWS1tHfMoOvGgzrWPFmaMPXNLAelAkf5qnWcQrh1JXYlyFytdwF9fau8FOXdODu3Qj
        plwJn+MP1Qu5+GbUw9GNKFT9K47gPxzPq/SfZ2+iD6lulyJPQJuy7Wr/IYFcefopiI+fSE14w5YNs
        GPeDJK9VJMv98oasCZm2cXd+VLS9rnZ3GU/LDq12vmtWbEDmgyh0PqNBFNHbVDHP1Xvt7ikklsL9o
        5gwLBE1w==;
Received: from [10.7.4.141] (port=59860 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h0quO-000JP0-Bi; Mon, 04 Mar 2019 19:57:44 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date:   Mon,  4 Mar 2019 19:57:30 +0300
Message-Id: <20190304165732.24043-2-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 1/3] kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the config file is reassigned through the KCONFIG_CONFIG
makeflag/envvar, this rule still attempts to use the wrong, possibly
nonexistent file.
Let's fix that.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/kconfig/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 1c7ac07def4d..28be91964a20 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -44,14 +44,14 @@ build_xconfig: $(obj)/qconf
 
 localyesconfig localmodconfig: $(obj)/conf
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
-	$(Q)if [ -f .config ]; then 					\
-			cmp -s .tmp.config .config ||			\
-			(mv -f .config .config.old.1;			\
-			 mv -f .tmp.config .config;			\
+	$(Q)if [ -f $(KCONFIG_CONFIG) ]; then 				\
+			cmp -s .tmp.config $(KCONFIG_CONFIG) ||		\
+			(mv -f $(KCONFIG_CONFIG) .tmp.config.old.1;	\
+			 mv -f .tmp.config $(KCONFIG_CONFIG);		\
 			 $< $(silent) --oldconfig $(Kconfig);		\
-			 mv -f .config.old.1 .config.old)		\
+			 mv -f .tmp.config.old.1 $(KCONFIG_CONFIG).old)	\
 	else								\
-			mv -f .tmp.config .config;			\
+			mv -f .tmp.config $(KCONFIG_CONFIG);		\
 			$< $(silent) --oldconfig $(Kconfig);		\
 	fi
 	$(Q)rm -f .tmp.config
-- 
2.20.1

