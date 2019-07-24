Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDD8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E6520693
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999478;
	bh=w4us00/9sn9R8EktR5DtQjHif2aVMiSmqh/+yBf/PJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1g5aPwB6UdlCUGYeUwjs46lPolFv3SYQOxCcwwtIociaDrMiV6rGcf8AM0QadsDsg
	 J5U9b2uoI0ZFtDevx2uNtRKBns8DA7V2cpelcXE/sb4DQmhfH7khN/x4t9tJzlalHK
	 Ieywy4ahwVb8bh1q8VvxcdxvDTFHUTWD52z61uvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfGXUR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403799AbfGXTts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:49:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A002F205C9;
        Wed, 24 Jul 2019 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997787;
        bh=w4us00/9sn9R8EktR5DtQjHif2aVMiSmqh/+yBf/PJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxgZBWhYW61JC4u7gQHxSPqWCAwJ5nBSSaky0Bl9/5PKRC9debMtnZb2cGQixGtbH
         wad5QqLnNXx+j671BA5rscSgmbVsnBG/t+wDi+heIypiAH6co41IZoizQxyxqXpQ9H
         QQyVYhS5SskPauDbLIPoZCEI5VdPjuYn4GkJvKpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 143/371] x86/build: Add set -e to mkcapflags.sh to delete broken capflags.c
Date:   Wed, 24 Jul 2019 21:18:15 +0200
Message-Id: <20190724191735.801450037@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bc53d3d777f81385c1bb08b07bd1c06450ecc2c1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1



