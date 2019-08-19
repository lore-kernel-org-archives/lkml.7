Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6888206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJi933eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfHSTgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:36:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53406 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHSTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:36:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so573169wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6FPvhjprMb5POGPlxTLY0xDeoCHzd15C3+SY9fdk5k=;
        b=rJi933eGitU4j9Hvlmyn3s5GN7M6QuID0k/YBCFrMEFcOOvwXfN5lG1ncYtXC5E7bc
         6XBCoFp6vGxgPB7ODL0XlvpWgnZ+s4vnvRrLUqU6Si0iy48Xn8I4wU9grXXgUB0xhRHt
         uRKFP2h8J5B/6N8FsoI4ogmK5rREO/X7lwlCzHuWqu1VAgF/SsdVIvU9ePTX8rMGsROA
         4qbzypT1o9NTfRZAnIY97jS0zv7cdVz6T6rwELaf47GjwuKCwhr2xWoNUY8LV33QIHow
         vDSasNEG5TinEBxnAzzdxyY0fMR9zSUNlCcndsLtf8S5CQXg1iYAPALDw9pbwDTR3+E4
         lSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6FPvhjprMb5POGPlxTLY0xDeoCHzd15C3+SY9fdk5k=;
        b=gP5iKjSM2WIuZClP+AtnDhlY5G1luB1sLSY5bD5Zn0xk82T/zYBa3joPJunIdFQi3g
         C4UqN5Ql8gm1dZMU0vAk/ra9J7MXPfAdpHLP96Zx7ScGrlHvVV90YTgS/qOcw4seh+T7
         alqdwHL3yIRYEkxS+IuRuT3PhgTHuC+PFAlDg5YU6LIosRQ8xkFoWUZQFFUxThCsOJo1
         3T4somwoNWkEtDgwcI5hUhuj5t5A36I81CqIv+c0/vaJUJ9xmMjhosP5tlfji2OulLM9
         zd/PhKtuhkLMRQxOVdrz6IY39sVKzGpIVEe8Lf9qBWqNSCDym/fVHBlCPf7Hh+vRSzBj
         t5YQ==
X-Gm-Message-State: APjAAAUkFqQeOfN8tD+gppWSijRFWJblIuHLESchMoi9n8pEbYOEPS+W
        BQ/wo5EnNfjDZbv05pIrTFL7iAg3
X-Google-Smtp-Source: APXvYqway+rAl0bhlS8AKPGhmsqB3SOcfk50aa9go4ahBFZmN1QBYsFfJ6s52yMHdJ91EfvoTnxmTw==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr21520140wmb.108.1566243411510;
        Mon, 19 Aug 2019 12:36:51 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f47:db00:69f9:84c:2cc6:baef? (p200300EA8F47DB0069F9084C2CC6BAEF.dip0.t-ipconnect.de. [2003:ea:8f47:db00:69f9:84c:2cc6:baef])
        by smtp.googlemail.com with ESMTPSA id e11sm43489470wrc.4.2019.08.19.12.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:36:51 -0700 (PDT)
Subject: [PATCH v2 2/3] x86/irq: factor out IS_ERR_OR_NULL check from
 platform-specific handle_irq
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Message-ID: <2ec758c7-9aaa-73ab-f083-cc44c86aa741@gmail.com>
Date:   Mon, 19 Aug 2019 21:36:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code can be simplified a little by factoring out the IS_ERR_OR_NULL
check from the platform-specific handle_irq implementations, and by
inlining the remaining call to generic_handle_irq_desc for 64bit
systems.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add "likely" to if clause and reorder it
- For 64bit, remove handle_irq and inline call to generic_handle_irq_desc
---
 arch/x86/include/asm/irq.h | 2 +-
 arch/x86/kernel/irq.c      | 9 +++++++--
 arch/x86/kernel/irq_32.c   | 7 +------
 arch/x86/kernel/irq_64.c   | 9 ---------
 4 files changed, 9 insertions(+), 18 deletions(-)

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
index 4215653f8..f1c8f350d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -243,8 +243,13 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
 	desc = __this_cpu_read(vector_irq[vector]);
-
-	if (!handle_irq(desc, regs)) {
+	if (likely(!IS_ERR_OR_NULL(desc))) {
+#ifdef CONFIG_X86_32
+		handle_irq(desc, regs);
+#else
+		generic_handle_irq_desc(desc);
+#endif
+	} else {
 		ack_APIC_irq();
 
 		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
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
index 6bf6517a0..12df3a4ab 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,15 +26,6 @@
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
-bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
-{
-	if (IS_ERR_OR_NULL(desc))
-		return false;
-
-	generic_handle_irq_desc(desc);
-	return true;
-}
-
 #ifdef CONFIG_VMAP_STACK
 /*
  * VMAP the backing store with guard pages
-- 
2.22.1


