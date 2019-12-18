Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61815C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724D24650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfLRVpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34094 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLRVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so3222809qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJEYKRpdvOZyP9yUq3qQQyurrO0vRRGI/xgoq8mO4Fo=;
        b=rCPdqdCF064+znsyY/5syY5qKWwizvRi/Hj1lFH8m0QYFYResohfFnHMJYqrGhVjJk
         fazWsuececg/zRC5qiK/F5gDyLkYWXyM7KI+ySdIJSZxROgLUgP9j/hUeU2lgm79TJGd
         /A/PZ1Y3LHIb/S/y/mfMDP8+IY/B4ae3te/l12OrdsbD2PTZ6qouNX6SBcY893FNS7/a
         2JAdaf+SOlPWRJO4iWlp+T3/xqPqnAs2Y30+WaD3A+WChavRMSygkILK0/pie0RcA1nR
         ugAOsoE/hLJvxwpxSGGUXZxVSifIBobRhNJt1dtmj2VW9kXlfqIbHMR/7wEbnWQ+7yAI
         LXLA==
X-Gm-Message-State: APjAAAVzFWscAgQrUUuJlpN3dwQ0oyL/YUsGEt3Tq5CsA4PxSn3pWeyl
        xatOtn420dtOfJ9aAVf9TYM=
X-Google-Smtp-Source: APXvYqyFJJb+YdMn3TBZdtfcSHZWqkVq5FX909wxq15xy/aTXbpw1dpi352mhByK+XXnyae80ulNfA==
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr4201986qtn.256.1576705521942;
        Wed, 18 Dec 2019 13:45:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/24] arch/powerpc/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:59 -0500
Message-Id: <20191218214506.49252-18-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/powerpc/kernel/setup-common.c    | 3 ---
 arch/powerpc/platforms/cell/setup.c   | 3 ---
 arch/powerpc/platforms/maple/setup.c  | 3 ---
 arch/powerpc/platforms/pasemi/setup.c | 4 ----
 arch/powerpc/platforms/ps3/setup.c    | 4 ----
 5 files changed, 17 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 488f1eecc0de..7f8c890360fe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -949,9 +949,6 @@ void __init setup_arch(char **cmdline_p)
 
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 
-	if (IS_ENABLED(CONFIG_DUMMY_CONSOLE))
-		conswitchp = &dummy_con;
-
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 9680d766f20e..855eedb8d7d7 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -240,9 +240,6 @@ static void __init cell_setup_arch(void)
 	init_pci_config_tokens();
 
 	cbe_pervasive_init();
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 
 	mmio_nvram_init();
 }
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 9cd6f3e1000b..47f73103ef74 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -183,9 +183,6 @@ static void __init maple_setup_arch(void)
 	/* Lookup PCI hosts */
        	maple_pci_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 	maple_use_rtas_reboot_and_halt_if_present();
 
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 05a52f10c2f0..b612474f8f8e 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -147,10 +147,6 @@ static void __init pas_setup_arch(void)
 	/* Lookup PCI hosts */
 	pas_pci_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Remap SDC register for doing reset */
 	/* XXXOJN This should maybe come out of the device tree */
 	reset_reg = ioremap(0xfc101100, 4);
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 8108b9b9b9ea..b29368931c56 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -200,10 +200,6 @@ static void __init ps3_setup_arch(void)
 	smp_init_ps3();
 #endif
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	prealloc_ps3fb_videomemory();
 	prealloc_ps3flash_bounce_buffer();
 
-- 
2.24.1

