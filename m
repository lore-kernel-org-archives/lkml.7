Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446962171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Rr4YH/sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfB1Jcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:32:48 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:55267 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfB1Jcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:32:47 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1S9WBTK019684;
        Thu, 28 Feb 2019 18:32:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1S9WBTK019684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551346332;
        bh=T21f9BGZYFwolqA0jkMCe8FKy+j0rsj1g/dxr1KCSCM=;
        h=From:To:Cc:Subject:Date:From;
        b=Rr4YH/sDRs/2/9OoPA1B2TZu2tzXQMGyoJCZYaGzF+B9SPJSSBGfvKPyQAGvECamH
         6n9krB734325SU5ppwGx4qUK/owYxc6meNxXrc4yBFa3wxKPPJ3YzzKnz4vZTYp/TN
         ZXRB3Ulb1Ol3gIYCSDyKAT7iCPhKP1pLb5Ip/ewQSOqDFgxXQTgZL8JpY3EjtlJ/Z9
         8OQrFwSwgxIHhzsrjO77mOWLDTbejpjef7mcINKSoy+HjtmmSDRWMQMEf6x9mxpZ1o
         MSNsaUgUHrdd3BdMl1/MCfR61raFiL1VOjgaF2Yk3lWV96j21AuLgGxuPzKCFiWCM9
         3hcbCSXDgS8fw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     J P <ppandit@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove commented-out INITRD_COMPRESS
Date:   Thu, 28 Feb 2019 18:32:01 +0900
Message-Id: <1551346321-3676-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code has been commented out since commit b7000adef17a
("Don't set the INITRD_COMPRESS environment variable automatically").

Clean it up now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Makefile b/Makefile
index a8ca8f9..302e1f8 100644
--- a/Makefile
+++ b/Makefile
@@ -936,19 +936,6 @@ ifdef CONFIG_MODULE_COMPRESS
 endif # CONFIG_MODULE_COMPRESS
 export mod_compress_cmd
 
-# Select initial ramdisk compression format, default is gzip(1).
-# This shall be used by the dracut(8) tool while creating an initramfs image.
-#
-INITRD_COMPRESS-y                  := gzip
-INITRD_COMPRESS-$(CONFIG_RD_BZIP2) := bzip2
-INITRD_COMPRESS-$(CONFIG_RD_LZMA)  := lzma
-INITRD_COMPRESS-$(CONFIG_RD_XZ)    := xz
-INITRD_COMPRESS-$(CONFIG_RD_LZO)   := lzo
-INITRD_COMPRESS-$(CONFIG_RD_LZ4)   := lz4
-# do not export INITRD_COMPRESS, since we didn't actually
-# choose a sane default compression above.
-# export INITRD_COMPRESS := $(INITRD_COMPRESS-y)
-
 ifdef CONFIG_MODULE_SIG_ALL
 $(eval $(call config_filename,MODULE_SIG_KEY))
 
-- 
2.7.4

