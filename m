Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4606924650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578150191;
	bh=rWfLsX7FvE6XFx5/wr1y7YTz71JBQxR4Rw7itajfC2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8IgnXwODGQKohgQxtjz4OwJ7H1EStK++MbdZGUaeKy5rFGO0LFAsM0WKg86naYjl
	 ms2OG6AT2DENvDd2lxVg6mGo7sWe+MWK93f/WJnAeeOCf5ulCrNTKjeWiH1UiL1Ilz
	 5o2/NaCLjJs1fV/ehZs8PxxPY6bxKAPYPX9Z2zUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgADPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:03:01 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53563 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:03:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004F2gcW018492;
        Sun, 5 Jan 2020 00:02:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004F2gcW018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578150166;
        bh=BflCds3eDfZKKkb79ngQRy2WmRBR4w8cbD1yLoBTetY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0W+BeWxwmpgJoaJCKv644PAmFlZKKPxRKKj5DtfjAAH6ozoptNbKkh7SjP8Iki3G
         EGpwga3ewU6nG+c04MU5dClubeoxgU1eJydXnbtfyStbJrhYo7A4iKwN3TU7bAWKQe
         3D54nbHKIDMxsg7DEe8EVfhNj8vQ7E2zpLSU5lJ+04aJC4MbLwr5GAIdIkHglQnDf6
         jdI3OI5eduAOJC1NpYD0p1WGDJt3xnIIDEDofKQ7Yp7XGbtOi5L+0P5z0ipup++qv4
         sNosRY3bLjkJogUuWqDpvyrs8nsPRYKHKCku6VBm5oa9eeETua/PLOSIV2rCGUAzSn
         DK017OKWvJ+9w==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] initramfs: make compression options not depend on INITRAMFS_SOURCE
Date:   Sun,  5 Jan 2020 00:02:31 +0900
Message-Id: <20200104150238.19834-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104150238.19834-1-masahiroy@kernel.org>
References: <20200104150238.19834-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if INITRAMFS_SOURCE is empty, usr/gen_initramfs.sh generates a
tiny default initramfs, which is embedded in vmlinux.

So, defining INITRAMFS_COMPRESSION* options should be valid irrespective
of INITRAMFS_SOURCE.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 usr/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index 72f50a21c051..43934c128010 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -102,7 +102,6 @@ config RD_LZ4
 
 choice
 	prompt "Built-in initramfs compression mode"
-	depends on INITRAMFS_SOURCE!=""
 	optional
 	help
 	  This option allows you to decide by which algorithm the builtin
@@ -211,7 +210,6 @@ config INITRAMFS_COMPRESSION_LZ4
 endchoice
 
 config INITRAMFS_COMPRESSION
-	depends on INITRAMFS_SOURCE!=""
 	string
 	default ""      if INITRAMFS_COMPRESSION_NONE
 	default ".gz"   if INITRAMFS_COMPRESSION_GZIP
-- 
2.17.1

