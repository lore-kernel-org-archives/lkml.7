Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB11020652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0cm5Hn+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFYH2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:28:18 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:47154 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfFYH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:28:18 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x5P7QdLL027637;
        Tue, 25 Jun 2019 16:26:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x5P7QdLL027637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561447599;
        bh=5AaDSiMBTC0S/hgXdywuV5MWuEsJ//DnTJVaKA14u9c=;
        h=From:To:Cc:Subject:Date:From;
        b=0cm5Hn+D125z52GdMOnXdaEPCEsdcEhXfLpSzQ3SCrTKU91clpc4VaBk6CG6PJI0h
         WjpI3Jsg5/USglOojuGprz2LUCpofbpGn+ANvqa3qdbdOptDHFNpjyTkgKnYy/MiM1
         i0mAxtxcm8KXCfzsazvZhgmt+/cgo3Qo+uOxI//A3y2Au+LyAqiOq6kAVVNZmZLai8
         Ib3LI/OjioN6qZVCj1ns1aPeLZF3Uk+q4UzDmlEgljGElYN8zCIQ8KwIGmBDwELgyS
         UJrK9CuEMGuPQWqJpZ0VisQW4Ks4i/Sed4KSlVWtpf5CzgF1VozLCVf9YMS19JlhGM
         MV71wsHjwPjFQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: add 'set -e' to mkcapflags.sh to delete broken capflags.c
Date:   Tue, 25 Jun 2019 16:26:22 +0900
Message-Id: <20190625072622.17679-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Make automatically deletes the target on any failure. So, the broken
capflags.c will be deleted automatically.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
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
 
-- 
2.17.1

