Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B4C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7152085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0e9eaGJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEAN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:56:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:64236 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfEAN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:56:32 -0400
X-Greylist: delayed 170526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 09:56:31 EDT
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x41Du4f1032765;
        Wed, 1 May 2019 22:56:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x41Du4f1032765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556718965;
        bh=ryhYQnIGLUAdlmkJ0CgmlDpVjLcz8vDYxbO0QCICOE0=;
        h=From:To:Cc:Subject:Date:From;
        b=0e9eaGJD2hULewc4Q/JXTQyET5srmFT2jcjQmeXNBlnVDSwyJBojUPYsSCfmQwD4m
         UgsTDCBEdVNIXl+we2Po+JzKny6iUhSxe4+lDShuLeE13Z1GU06ezVW74wtfsB3mCq
         jFvnsakw++53+9eMCPaql8FFKpLwb9vACzPo9c059m9Uz125fvf3W+MKKNj6leIy2C
         +5RUQI8SGRHLSkGRMxjH+8TReuWeJN7StuB2lp64GhvI1iIUZZ0KdWxhWKU4A1bgnX
         YWUFgiYOlQr5YX0ZuSpHr4seaFWdJhXJ2Lu//ncu4sSOy5L0H9eVjcWM961YZhv0h+
         A+pC6oTu/aK7A==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sh: exclude vmlinux.scr from .gitignore pattern
Date:   Wed,  1 May 2019 22:56:01 +0900
Message-Id: <1556718961-4607-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sh/boot/.gitignore has the pattern "vmlinux*"; this is effective
not only for the current directory, but also for any sub-directories.

So, from the point of .gitignore grammar, the following check-in files
are also considered to be ignored:

  arch/sh/boot/compressed/vmlinux.scr
  arch/sh/boot/romimage/vmlinux.scr

As the manual gitignore(5) says "Files already tracked by Git are not
affected", this is not a problem as far as Git is concerned.

However, Git is not the only program that parses .gitignore because
.gitignore is useful to distinguish build artifacts from source files.

For example, tar(1) supports the --exclude-vcs-ignore option. As of
writing, this option does not work perfectly, but it intends to create
a tarball excluding files specified by .gitignore.

So, I believe it is better to fix this issue.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add more information to the commit log to clarify my main motivation

 arch/sh/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/.gitignore b/arch/sh/boot/.gitignore
index 541087d..f50fdd9 100644
--- a/arch/sh/boot/.gitignore
+++ b/arch/sh/boot/.gitignore
@@ -1,3 +1,4 @@
 zImage
 vmlinux*
 uImage*
+!vmlinux.scr
-- 
2.7.4

