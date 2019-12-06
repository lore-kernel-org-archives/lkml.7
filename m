Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91724659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFDom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:44:42 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40554 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfLFDom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:44:42 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB63ifpV014121
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 22:44:41 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB63iark031843
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 22:44:41 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so3439732qvk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 19:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=DehJaUHW45MnJcV0+BTcP6QTaImpm9lbPDDJke7Mmes=;
        b=PUk7x4xuMzr+ZQpuwa5hZxAbALi0040akg+9Xx+8uZwLAjUWJ8I39KYJP4DF+Vnso4
         XR2QyeY/LD6bE/Kz9LAHcPHIosEGjllSSC8FBQhKT3UNPkdrH7jBGvYUOXDx/1U2ghHt
         DvmyFZKFMVza2WrYJumLlGaFaLoCPNEunw/XIG9W6WhbKUfxFAEPK5ow/t66pk/Nh4S/
         RBmsUrfssuXnjj8vUBGWemdGliUVEbcw5sRAML3pHY7tvzjjCsoDM6qzhI0fiGFk1CDr
         ippI3wxYSjfalzHpNDpFvkTrEjb/n9/qs3jrIsoFaLSr6Mq6olzJ8/fAFmTEKgRt9u96
         mcuA==
X-Gm-Message-State: APjAAAUOIh2zq9PWLyVgIvcm9sDPH+VOAd3GNOllLDjmT4PZZGBCzL+Z
        Fh4CHvmLyydT/OkATKJKsaP0o0KK5PJ6a7W51DFjjimIgRUOU7ygPxAK+hXXKFzo7I9p6/NQ2Kk
        B/D9xb+QogwmPkRm5Spn19PKdfgpopUvRmHQ=
X-Received: by 2002:a37:4f10:: with SMTP id d16mr12112574qkb.80.1575603875630;
        Thu, 05 Dec 2019 19:44:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8XGusUbx5y68Z/nmGRJghzyRrtS2aNUezzfFJi1WAmDx72Pu5i2ZFoYlQeM/WmgDCvxxw6w==
X-Received: by 2002:a37:4f10:: with SMTP id d16mr12112561qkb.80.1575603875329;
        Thu, 05 Dec 2019 19:44:35 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id p35sm5817124qtd.12.2019.12.05.19.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 19:44:34 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode: make stub function static inline
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 05 Dec 2019 22:44:33 -0500
Message-ID: <52170.1575603873@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=1 W=1, both sparse and gcc complain:

  CHECK   arch/x86/kernel/cpu/microcode/core.c
./arch/x86/include/asm/microcode_amd.h:56:6: warning: symbol 'reload_ucode_amd' was not declared. Should it be static?
  CC      arch/x86/kernel/cpu/microcode/core.o
In file included from arch/x86/kernel/cpu/microcode/core.c:36:
./arch/x86/include/asm/microcode_amd.h:56:6: warning: no previous prototype for 'reload_ucode_amd' [-Wmissing-prototypes
]
   56 | void reload_ucode_amd(void) {}
      |      ^~~~~~~~~~~~~~~~

And they're right - that function can be a static inline like its brethren.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 209492849566..6685e1218959 100644
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

