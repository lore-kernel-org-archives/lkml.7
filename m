Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBFBC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102FA20679
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 08:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN253ceb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfHDIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 04:22:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54335 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfHDIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 04:22:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so71931485wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=66Psv0OU4j9HGWPHJBTS9yJendqgZRDSbxi4tGr7jyQ=;
        b=UN253cebr8iAODMiEiOrMX+QUIdhXqxopi+Gcc6rzKnYYtE4q8A35aYq7qUsSBDJJx
         p5/fIM5ShP88EPuucfKL/GgUskxt9Dklo/0HSMauA9e+i3vEoPr75GoShCSFhYxwbj4I
         Xc4B2qAVdYIvLJcNKjTw28gf+m7VgNmsEdiOts2UL1vRItEOVybPQ59ZY8X+U2tMXgbg
         lNAkkdN5WmW+BA4mp5rDPHoh0kHgt6DRmo//KO/ziFAYHpjSw2kmN1jTEpMBqpitab7D
         gZTa//cu8OoDsXbvh/ITTXIuy+mmqYydzuo5Qq3XJtJFrG8nRIY8X/ao57RuCed77UDt
         FTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66Psv0OU4j9HGWPHJBTS9yJendqgZRDSbxi4tGr7jyQ=;
        b=cfJU8EgL5nPFPeeQJf1Rss/8qvd5W+s4jvOBsx9ig+wuhgEnwxAmTCIUODcTas8321
         nol33kHPWaUne7glpk3sRzbt8BgDUqRmC9P93N+bh/ZWfKvC8WoE1Ef8I2anpZx2nocm
         Ks1whT6kBgWrzCZBJSzeES4A1LK7rK/jvlAj5F2oumNwH6Clv4Y0OUxCvom2MzA6rxwO
         SwLG1mxrx2Do9OSN8Ehzc/WZ4WEsctjOPMbQYfIyDMsrtA0X4ss8mqZSbM+lNWlAivb6
         AtdjyEPxSp3+esiik8UTh1yCeBTPK/owFc2S6E5ALed5W2LfAEdtcepRLdTZVcTAbn3f
         16ug==
X-Gm-Message-State: APjAAAXg5a0w/COSUbAUQZaPlErH+525dSwTzKFOw1Xw013zgvCf270Q
        NzHC1vb7OF7XPpEhLQQwDvmEIIaH
X-Google-Smtp-Source: APXvYqythea5RE1yRzAJbH1DGLvfcE6TAGzeQAHWhHVyKW76aU2Pvh+deXcBm4DCc7CiTmJHmtGQzA==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr12544486wml.59.1564906965217;
        Sun, 04 Aug 2019 01:22:45 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:9900:d80f:58c5:990d:c59b? (p200300EA8F289900D80F58C5990DC59B.dip0.t-ipconnect.de. [2003:ea:8f28:9900:d80f:58c5:990d:c59b])
        by smtp.googlemail.com with ESMTPSA id o26sm168123999wro.53.2019.08.04.01.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 01:22:44 -0700 (PDT)
Subject: [PATCH 2/3] x86/irq: factor out IS_ERR_OR_NULL check from
 platfom-specific handle_irq
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Message-ID: <e9b4d21d-d9eb-51c5-871e-87e3b69d01ec@gmail.com>
Date:   Sun, 4 Aug 2019 10:21:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9b51ac3-b1d6-89a6-e323-4600af22d9de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code can be simplified a little by factoring out the IS_ERR_OR_NULL
check from the platform-specific handle_irq implementations.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/include/asm/irq.h | 2 +-
 arch/x86/kernel/irq.c      | 5 +++--
 arch/x86/kernel/irq_32.c   | 7 +------
 arch/x86/kernel/irq_64.c   | 6 +-----
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 8f95686ec..a176f6165 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -34,7 +34,7 @@ extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
-extern bool handle_irq(struct irq_desc *desc, struct pt_regs *regs);
+extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern __visible unsigned int do_IRQ(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 4215653f8..042f363a8 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -243,8 +243,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
 	desc = __this_cpu_read(vector_irq[vector]);
-
-	if (!handle_irq(desc, regs)) {
+	if (IS_ERR_OR_NULL(desc)) {
 		ack_APIC_irq();
 
 		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
@@ -254,6 +253,8 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 		} else {
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
+	} else {
+		handle_irq(desc, regs);
 	}
 
 	exiting_irq();
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index fc34816c6..a759ca97c 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -148,18 +148,13 @@ void do_softirq_own_stack(void)
 	call_on_stack(__do_softirq, isp);
 }
 
-bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
 	int overflow = check_stack_overflow();
 
-	if (IS_ERR_OR_NULL(desc))
-		return false;
-
 	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))
 			print_stack_overflow();
 		generic_handle_irq_desc(desc);
 	}
-
-	return true;
 }
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 6bf6517a0..cd4595b71 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,13 +26,9 @@
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
-bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	if (IS_ERR_OR_NULL(desc))
-		return false;
-
 	generic_handle_irq_desc(desc);
-	return true;
 }
 
 #ifdef CONFIG_VMAP_STACK
-- 
2.22.0


