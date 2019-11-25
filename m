Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7965DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574687857;
	bh=N4FgeYZKkiQT8Iejbx6PZtDZ69kmI+hro5t6gn41U8s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PrgM/6tdbI4prOJ3smgFlmH551BCNAcH/5NgYLZ5fa+HQQRysj2qR152TF4g8tK2Q
	 thqFDOrR5VGIeBJNWYZaHLsC/3lbPEsG5EG76Tz/NJuBI3kG75rq/TEvUrPGcBDuUx
	 tBFceYhlIf7HGBcoCemMZi9xMgcuM8DhRzW8IrMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKYNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:17:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:17:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so5963886wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UDLB+hS1jJmJ3wYcAAWpOrQoHI8SabS9Sb+YslLdlM4=;
        b=Hw60Gmt28Vrso94r8urKA0qlQk4b1sL2MNU2G7Yeb6jrPGefxXKQjcs6a828r/7QEv
         sPNkzf0Zxw34u2IcM/CNS0+cyqXFAiBBcUiFKtosv9cAJPX/2EHlxsGeGP/PnpH9CxyE
         GTf6HiyvpTcoj4vt4CcSwXcL6w+XKTUpAJQGXsF95yiYY2UvxnJt6d1E5v94Xp7bVY0f
         YyCfV/l7M556zL6lRoriS4ApAbqG+HPUr0MY/35K0aaLntx8CIWKI2PwpsgMOd/k5xq0
         +B+xfDCnstIPME2Tl6sxCKNkyNtQ22/LjP2JQf+C4vP0DrmyTX7myNm6AgFMO9r/dv/m
         0ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=UDLB+hS1jJmJ3wYcAAWpOrQoHI8SabS9Sb+YslLdlM4=;
        b=un4nqmZ5/efvXg4gp23bTlHfMThtTd/kT7GSLcJnncGNqddrLAJ8vtApkwQaBDWQhX
         t8SuAx9KKFS1+GDiemhRGgAqBBbHxnnppAiXsbIDvbI2iuHA+GfQoO/gka9vBZ2tncAB
         favfPPDAC3z/guwxn+8QImJDYs+d0Xj4n7R/JdsObYlT8V+emQq37J3lc44lj6EYM1vx
         f61KiBsshTFkHReCWu4e/csbAIRsBtBTm017I892Vo0CfVnBM4ESXfPGSfd6Df7uYH51
         QndwJ/zMQ7cSfj0j0vWtckvdMsWgu4lWgTLwYfje6+vUaqco27iNPMi3gwBjYVSWuBUo
         93Iw==
X-Gm-Message-State: APjAAAWUM+B+jQu20CWMnWmafyR/fJBryk/1IMF+e5iXJaSfeX/4y7qn
        URAHo6USBzEla7qPD46MHB0=
X-Google-Smtp-Source: APXvYqy+hiP6QfQv9auMidhNFgImL/qFKT3WwfodC0mJ5w6ZxLJtN5czS4V99glRqCempRArWIJU+Q==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr26808528wmj.134.1574687852244;
        Mon, 25 Nov 2019 05:17:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm7970002wmm.45.2019.11.25.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:17:31 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:17:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/apic changes for v5.5
Message-ID: <20191125131729.GA79722@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

   # HEAD: 2579a4eefc04d1c23eef8f3f0db3309f955e5792 x86/ioapic: Rename misnamed functions

Two changes: a cleanup and a fix for an (old) race for oneshot threaded 
IRQ handlers.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (2):
      x86/ioapic: Prevent inconsistent state when moving an interrupt
      x86/ioapic: Rename misnamed functions


 arch/x86/kernel/apic/io_apic.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d6af97fd170a..913c88617848 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1725,19 +1725,20 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
-	/* If we are moving the irq we need to mask it */
+	/* If we are moving the IRQ we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
-		mask_ioapic_irq(data);
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
 }
 
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
-	if (unlikely(masked)) {
+	if (unlikely(moveit)) {
 		/* Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
@@ -1766,15 +1767,17 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the IRQ is masked in the core, leave it: */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 }
 #endif
@@ -1783,11 +1786,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 {
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	unsigned long v;
-	bool masked;
+	bool moveit;
 	int i;
 
 	irq_complete_move(cfg);
-	masked = ioapic_irqd_mask(irq_data);
+	moveit = ioapic_prepare_move(irq_data);
 
 	/*
 	 * It appears there is an erratum which affects at least version 0x11
@@ -1842,7 +1845,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)
