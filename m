Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C6DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E2320665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zL1VfzQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfFYHzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:55:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:55:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7t2HU3518401
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:55:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7t2HU3518401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561449302;
        bh=rpTqlAr3NjNz0wKYHh5t9GllnyJIj/sh1rb3LA5nGcY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zL1VfzQpy8CVGXohhPJ1TzsycFmn6AqmdNk0qG+oQbeJ7eliZmVxyvl+FdE/Ojlri
         sAs4gTER24/4ZfbITGy34i0qsDFsNnWJ4KStqiG3zAmFWm9NGWgZgBKiJwcJVnrxoE
         uVYkreslsA44hHHkRUEL30mnntCEdUCNEXLAig24M04Artzt9JK3H5Lvc4sltRZc1j
         2t1E/sno28Jj98JmdOCviFk617a1I1xNnQTW69y8PwbfTPAJbfxIvwfWFXQdnQ/TVs
         a3LNCGInCcJ3+YaiThv8qWttmw39YmIj9nCl2W1xiL5Yt799TqfJ1bCe4Tx9JHE3Sb
         UHlw3Dpo7VTow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7t20J3518394;
        Tue, 25 Jun 2019 00:55:02 -0700
Date:   Tue, 25 Jun 2019 00:55:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-bc53d3d777f81385c1bb08b07bd1c06450ecc2c1@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bp@alien8.de, hpa@zytor.com, yamada.masahiro@socionext.com
Reply-To: yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, bp@alien8.de, mingo@kernel.org
In-Reply-To: <20190625072622.17679-1-yamada.masahiro@socionext.com>
References: <20190625072622.17679-1-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Add 'set -e' to mkcapflags.sh to delete
 broken capflags.c
Git-Commit-ID: bc53d3d777f81385c1bb08b07bd1c06450ecc2c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bc53d3d777f81385c1bb08b07bd1c06450ecc2c1
Gitweb:     https://git.kernel.org/tip/bc53d3d777f81385c1bb08b07bd1c06450ecc2c1
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 25 Jun 2019 16:26:22 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:52:05 +0200

x86/build: Add 'set -e' to mkcapflags.sh to delete broken capflags.c

Without 'set -e', shell scripts continue running even after any
error occurs. The missed 'set -e' is a typical bug in shell scripting.

For example, when a disk space shortage occurs while this script is
running, it actually ends up with generating a truncated capflags.c.

Yet, mkcapflags.sh continues running and exits with 0. So, the build
system assumes it has succeeded.

It will not be re-generated in the next invocation of Make since its
timestamp is newer than that of any of the source files.

Add 'set -e' so that any error in this script is caught and propagated
to the build system.

Since 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special target"),
make automatically deletes the target on any failure. So, the broken
capflags.c will be deleted automatically.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20190625072622.17679-1-yamada.masahiro@socionext.com

---
 arch/x86/kernel/cpu/mkcapflags.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index d0dfb892c72f..aed45b8895d5 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -4,6 +4,8 @@
 # Generate the x86_cap/bug_flags[] arrays from include/asm/cpufeatures.h
 #
 
+set -e
+
 IN=$1
 OUT=$2
 
