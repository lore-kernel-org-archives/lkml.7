Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3CC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7145214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561798240;
	bh=/en3cZ7ze4I9SRFM0MUVHHWqTF3AL1aYU0JZnNjEz3o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ryqw4D5GFZsAjnUD+58VUpnsQ6CLICy0rxP03ze+jxcLNeNkbNR2ueOXiz5EgbpT5
	 xmVQ32Xf5zroheMmlU9RJeQRIXZHVD2/5wV3b6lIk89S/ybhgSjjlk5R5Zd8fQqfwK
	 /W0y1Fmf38xBMjLwqg46Sx8LWv/xfYv9pZHCXrqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF2Iuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:50:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52001 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2Iuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:50:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so11235067wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NAGWwaVnrbmYRmfFm8BGv8j1VQ13NfKhbV7DoCHWW2k=;
        b=MlA1u5NrKREz807Qztvgx5qqxykcofU1m3G/Ki/Mq38G0rICfYlPzagXHdUMPIGGUM
         gEW0swuMP708pq7N6ej2cktJNOE45mEooqB0pzuVsNMdmOyvt+VfV7feWDeez1HiFfJ0
         vWgXDDA2rfcbiLLUmj6rtxMdzO21y1VwHdEiOCTeeM94KPkVrUuDVngeqLCc6S5cBhqG
         XB+RHMPKldC2H1yUnNs/qDxLZ8j9ix0/ozF4q0kEht2yDIO2dBgCF9H1dpK6JLTokvN3
         iDODTuwpqpvLePnbxCGqN5QtjRae/8QXKlpK1d7jsFRU/clLAcXn7UbchIBkF6++pDDb
         nS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=NAGWwaVnrbmYRmfFm8BGv8j1VQ13NfKhbV7DoCHWW2k=;
        b=YZqZBx55gsh0v6289R9ztgq3psXEtQ+7+g6eozkgGWzG4bPb1sgn4Fr68uQwn0Qnqj
         Q1HjKWSKX0+de0PT62N45vNQ39i8XR65EFmwPE1EXkUtlFDYxY0nRW2lGsX+rNlVlBLI
         pGyXpCbkYnr6U9lvgeAZEkZkjFndkzLUCN3TMWm09f8ox3aeAoEr9Pj/F5C79fG+4WHE
         qfUPUmsMjZCWBsksw7ZmFw1HZBx/BkbFM1/nDSBVv8R8U+i6jynWVVNC9Dt+iTpjiyD6
         9uCWM6EADRWDaAR2u8xEiEke/Xzxoai9Qj8LzFurhiJAKLpUpAwVHZ/UhD2A4GFES9Ik
         zcGw==
X-Gm-Message-State: APjAAAWv0A2aUi+3ofANesS2MKr3YJuJnJMO7tnJ6xnRLlLkZqDN6K7o
        TV1oJO+yBAwW5bu6zRzBnQ7kHhka
X-Google-Smtp-Source: APXvYqyx6p+YoCmqNK7yIz25xmjM41nCwQ6unLNP6gULf7U/9R1SEs8Sz7cKDfMONyNlw6pp4noS9w==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr10182491wmb.171.1561798236084;
        Sat, 29 Jun 2019 01:50:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z6sm4228272wrw.2.2019.06.29.01.50.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 01:50:35 -0700 (PDT)
Date:   Sat, 29 Jun 2019 10:50:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <20190629085033.GA37583@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: a52548dd0491a544558e971cd5963501e1a2024d Merge tag 'irqchip-5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Diverse irqchip driver fixes.

 Thanks,

	Ingo

------------------>
Guo Ren (1):
      irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus

Heyi Guo (1):
      irqchip/gic-v3-its: Fix command queue pointer comparison bug

Paul Burton (1):
      irqchip/mips-gic: Use the correct local interrupt map registers

Peter Ujfalusi (1):
      irqchip/ti-sci-inta: Fix kernel crash if irq_create_fwspec_mapping fail


 arch/mips/include/asm/mips-gic.h  | 30 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c | 15 +++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c  | 35 ++++++++++++++++++++++++-----------
 drivers/irqchip/irq-mips-gic.c    |  4 ++--
 drivers/irqchip/irq-ti-sci-inta.c |  4 ++--
 5 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 558059a8f218..0277b56157af 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -314,6 +314,36 @@ static inline bool mips_gic_present(void)
 	return IS_ENABLED(CONFIG_MIPS_GIC) && mips_gic_base;
 }
 
+/**
+ * mips_gic_vx_map_reg() - Return GIC_Vx_<intr>_MAP register offset
+ * @intr: A GIC local interrupt
+ *
+ * Determine the index of the GIC_VL_<intr>_MAP or GIC_VO_<intr>_MAP register
+ * within the block of GIC map registers. This is almost the same as the order
+ * of interrupts in the pending & mask registers, as used by enum
+ * mips_gic_local_interrupt, but moves the FDC interrupt & thus offsets the
+ * interrupts after it...
+ *
+ * Return: The map register index corresponding to @intr.
+ *
+ * The return value is suitable for use with the (read|write)_gic_v[lo]_map
+ * accessor functions.
+ */
+static inline unsigned int
+mips_gic_vx_map_reg(enum mips_gic_local_interrupt intr)
+{
+	/* WD, Compare & Timer are 1:1 */
+	if (intr <= GIC_LOCAL_INT_TIMER)
+		return intr;
+
+	/* FDC moves to after Timer... */
+	if (intr == GIC_LOCAL_INT_FDC)
+		return GIC_LOCAL_INT_TIMER + 1;
+
+	/* As a result everything else is offset by 1 */
+	return intr + 1;
+}
+
 /**
  * gic_get_c0_compare_int() - Return cp0 count/compare interrupt virq
  *
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961ab6cc..a4c1aacba1ff 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -89,8 +89,19 @@ static int csky_irq_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	/* Enable interrupt destination */
-	cpu |= BIT(31);
+	/*
+	 * The csky,mpintc could support auto irq deliver, but it only
+	 * could deliver external irq to one cpu or all cpus. So it
+	 * doesn't support deliver external irq to a group of cpus
+	 * with cpu_mask.
+	 * SO we only use auto deliver mode when affinity mask_val is
+	 * equal to cpu_present_mask.
+	 *
+	 */
+	if (cpumask_equal(mask_val, cpu_present_mask))
+		cpu = 0;
+	else
+		cpu |= BIT(31);
 
 	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + offset);
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1e364d3ad9c5..f0523916232d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -744,32 +744,43 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
 }
 
 static int its_wait_for_range_completion(struct its_node *its,
-					 struct its_cmd_block *from,
+					 u64	prev_idx,
 					 struct its_cmd_block *to)
 {
-	u64 rd_idx, from_idx, to_idx;
+	u64 rd_idx, to_idx, linear_idx;
 	u32 count = 1000000;	/* 1s! */
 
-	from_idx = its_cmd_ptr_to_offset(its, from);
+	/* Linearize to_idx if the command set has wrapped around */
 	to_idx = its_cmd_ptr_to_offset(its, to);
+	if (to_idx < prev_idx)
+		to_idx += ITS_CMD_QUEUE_SZ;
+
+	linear_idx = prev_idx;
 
 	while (1) {
+		s64 delta;
+
 		rd_idx = readl_relaxed(its->base + GITS_CREADR);
 
-		/* Direct case */
-		if (from_idx < to_idx && rd_idx >= to_idx)
-			break;
+		/*
+		 * Compute the read pointer progress, taking the
+		 * potential wrap-around into account.
+		 */
+		delta = rd_idx - prev_idx;
+		if (rd_idx < prev_idx)
+			delta += ITS_CMD_QUEUE_SZ;
 
-		/* Wrapped case */
-		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
+		linear_idx += delta;
+		if (linear_idx >= to_idx)
 			break;
 
 		count--;
 		if (!count) {
-			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
-					   from_idx, to_idx, rd_idx);
+			pr_err_ratelimited("ITS queue timeout (%llu %llu)\n",
+					   to_idx, linear_idx);
 			return -1;
 		}
+		prev_idx = rd_idx;
 		cpu_relax();
 		udelay(1);
 	}
@@ -786,6 +797,7 @@ void name(struct its_node *its,						\
 	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
 	synctype *sync_obj;						\
 	unsigned long flags;						\
+	u64 rd_idx;							\
 									\
 	raw_spin_lock_irqsave(&its->lock, flags);			\
 									\
@@ -807,10 +819,11 @@ void name(struct its_node *its,						\
 	}								\
 									\
 post:									\
+	rd_idx = readl_relaxed(its->base + GITS_CREADR);		\
 	next_cmd = its_post_commands(its);				\
 	raw_spin_unlock_irqrestore(&its->lock, flags);			\
 									\
-	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
+	if (its_wait_for_range_completion(its, rd_idx, next_cmd))	\
 		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
 }
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d32268cc1174..f3985469c221 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -388,7 +388,7 @@ static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
 	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd = irq_data_get_irq_chip_data(d);
 
-	write_gic_vl_map(intr, cd->map);
+	write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
 	if (cd->mask)
 		write_gic_vl_smask(BIT(intr));
 }
@@ -517,7 +517,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
-		write_gic_vo_map(intr, map);
+		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 011b60a49e3f..ef4d625d2d80 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -159,9 +159,9 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	parent_fwspec.param[1] = vint_desc->vint_id;
 
 	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
-	if (parent_virq <= 0) {
+	if (parent_virq == 0) {
 		kfree(vint_desc);
-		return ERR_PTR(parent_virq);
+		return ERR_PTR(-EINVAL);
 	}
 	vint_desc->parent_virq = parent_virq;
 
