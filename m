Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA08C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfLLVeC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:34:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfLLVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:34:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ifW5s-0002Gz-6F; Thu, 12 Dec 2019 22:33:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA17D1C2930;
        Thu, 12 Dec 2019 22:33:55 +0100 (CET)
Date:   Thu, 12 Dec 2019 21:33:55 -0000
From:   tip-bot2 for Valdis =?utf-8?q?Kl=C4=93tnieks?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Make stub function static inline
Cc:     valdis.kletnieks@vt.edu, Borislav Petkov <bp@suse.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <52170.1575603873@turing-police>
References: <52170.1575603873@turing-police>
MIME-Version: 1.0
Message-ID: <157618643564.30329.7127565633998846101.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     82c881b28aa89215a760e39c5f6bcde2d6ce4918
Gitweb:        https://git.kernel.org/tip/82c881b28aa89215a760e39c5f6bcde2d6ce4918
Author:        Valdis Klētnieks <valdis.kletnieks@vt.edu>
AuthorDate:    Thu, 05 Dec 2019 22:44:33 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 12 Dec 2019 22:29:00 +01:00

x86/microcode/AMD: Make stub function static inline

When building with C=1 W=1 (and when CONFIG_MICROCODE_AMD=n, as Luc Van
Oostenryck correctly points out) both sparse and gcc complain:

  CHECK   arch/x86/kernel/cpu/microcode/core.c
  ./arch/x86/include/asm/microcode_amd.h:56:6: warning: symbol \
	  'reload_ucode_amd' was not declared. Should it be static?
    CC      arch/x86/kernel/cpu/microcode/core.o
  In file included from arch/x86/kernel/cpu/microcode/core.c:36:
  ./arch/x86/include/asm/microcode_amd.h:56:6: warning: no previous \
	  prototype for 'reload_ucode_amd' [-Wmissing-prototypes]
     56 | void reload_ucode_amd(void) {}
        |      ^~~~~~~~~~~~~~~~

And they're right - that function can be a static inline like its
brethren.

Signed-off-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/52170.1575603873@turing-police
---
 arch/x86/include/asm/microcode_amd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 2094928..6685e12 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -53,6 +53,6 @@ static inline void __init load_ucode_amd_bsp(unsigned int family) {}
 static inline void load_ucode_amd_ap(unsigned int family) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
-void reload_ucode_amd(void) {}
+static inline void reload_ucode_amd(void) {}
 #endif
 #endif /* _ASM_X86_MICROCODE_AMD_H */
