Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5C021852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UpbOhLcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfDENac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:30:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730492AbfDENaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:30:24 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E29981EC0104;
        Fri,  5 Apr 2019 15:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554471023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIKtaQH2qKoj/MFNhj1qBE6CTWzgi4175jKfB+rUcHU=;
        b=UpbOhLcOln9DZRh4+bSLAqViy7XSstnbn3lpSu0AUvfaxZPKr3KK2FtVcsrfm0s2+2Olk+
        x3OziwLL8sOJwY4/q8vCgv2mKlOnvylk2l51KhpNieNlp4NSlnqi2ndDNnrsa9Ap5+CEn+
        hGGMXTqT4V+0Z5KZtDsf4+J+RPG4X4k=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>
Subject: [PATCH 3/3] x86/microcode: Deprecate MICROCODE_OLD_INTERFACE
Date:   Fri,  5 Apr 2019 15:30:10 +0200
Message-Id: <20190405133010.24249-4-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405133010.24249-1-bp@alien8.de>
References: <20190405133010.24249-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This is the ancient loading interface which requires special tools to be
used. The bigger problem with it is that it is as inadequate for proper
loading of microcode as the late microcode loading interface is because
it happens just as late.

iucode_tool's manpage already warns people that it is deprecated.

Deprecate it and turn it off by default along with a big warning in the
Kconfig help. It will go away sometime in the future.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..5a0a752f3ddd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1330,8 +1330,16 @@ config MICROCODE_AMD
 	  processors will be enabled.
 
 config MICROCODE_OLD_INTERFACE
-	def_bool y
+	bool "Ancient loading interface (DEPRECATED)"
+	default n
 	depends on MICROCODE
+	---help---
+	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
+	  which was used by userspace tools like iucode_tool and microcode.ctl.
+	  It is inadequate because it runs too late to be able to properly
+	  load microcode on a machine and it needs special tools. Instead, you
+	  should've switched to the early loading method with the initrd or
+	  builtin microcode by now: Documentation/x86/microcode.txt
 
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
-- 
2.21.0

