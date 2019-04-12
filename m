Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC92C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A7F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555069945;
	bh=hmfkwHbCbx7jkbhUfwdPVGeJFc+0Mz3x9HDNpLBk5tg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=j+e3xIec+87y8xD+sEovOxT6gaz8Y3Bl4Dp8wlqZ2no5z8pOI1U5NtvkLVOWdtEl9
	 nm6Nq7vb1gzo8oRNl05PNktowhL2a5hq24U8eoO+iv3y5WYPbOvFIbcVG043X2+NMC
	 NPLk3isQm1k0b2uHXXfUHaOjtNbkEbUylsOxU1dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDLLwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:52:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46947 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:52:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so11516160wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xeiNOodHiuGjY5I9D6c17AQP3wYOqXEepJEbJGhHFVI=;
        b=q8MWSdxoP+9+yQYArtfoVljbXy1x7AjfgI4wjx7msbUe+apzp6VPuHqoyEhx4cZEFC
         5Q5cCx+WXkipnOEozhVESa2LBkd407dur8HVDMkgO5Q7BZUiZriUpygyKNWQvvMzkXFn
         SixS+/MGHg2L4mwygy+OSWTWgdFFyXTqYF7RqML//uLftNvOK+hjIh6oow/vqL+04pyo
         yZ/WgOdH50K6UUUHO9RH7DaoeK39gB5MtLg0dtdPYGTKTyQ0u6bjXjvSE+5s4xJjTDUg
         JgOcBJ2zQHKlXrQtFkE66znbV1zX6ABW8nbx1ZtiNgyohhz4ifGVbrwUwMR5H+X7gxrN
         EpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xeiNOodHiuGjY5I9D6c17AQP3wYOqXEepJEbJGhHFVI=;
        b=i2h02oML7EIRd2aRsKG078rmmH6npUC8XUeZlH/vLx3q8wEEonDpGRStTKZneRG6ic
         RHSk9MLK+MtkeG5G4Vc1ofzMgJidf/E838IGVfEfYJzY1jxDcsUfvpPL0pDBsOnDthK1
         kFp78DcLM16H7IWl75LFJiF9+Z+9qfE4qoogDlUsJYQmAHBZD1jeocRJ7JXZhGLn6yOj
         /lFqaAtwXuT0jAOaVJfze99V2W9JzmCi1F+gy/ZQ0CF9gAlv4zZiouXjGusqlfh1n/yL
         yBet+ebEddWgEkXW9hDyy2dxDdAEYAIgYXYoE3XAIjDa1YlmbC7GC38Qwt4jvFh52q4/
         cc9A==
X-Gm-Message-State: APjAAAWV544cQZ0G0Bs2WEB4zG8MhLI6ZLGZSwuVPAZRUVfChuGrp6AE
        Ei0pFAOS1q3wZD0+A6oTjAw=
X-Google-Smtp-Source: APXvYqzlTw9luJg5oStFAnsoaHrmHtunliMGieA6OR77+a08f53I44yikVq/XrcPL2iF9nHugDt+Ug==
X-Received: by 2002:adf:e84b:: with SMTP id d11mr33918513wrn.289.1555069942932;
        Fri, 12 Apr 2019 04:52:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m6sm52186775wrr.53.2019.04.12.04.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 04:52:21 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:52:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <20190412115219.GA20767@gmail.com>
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

   # HEAD: 325aa19598e410672175ed50982f902d4e3f31c5 genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Two genirq fixes, plus an irqchip driver error handling fix.

 Thanks,

	Ingo

------------------>
Dan Carpenter (1):
      irqchip/irq-ls1x: Missing error code in ls1x_intc_of_init()

Kefeng Wang (1):
      genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=n

Stephen Boyd (1):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()


 drivers/irqchip/irq-ls1x.c | 1 +
 kernel/irq/chip.c          | 4 ++++
 kernel/irq/irqdesc.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 86b72fbd3b45..353111a10413 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -130,6 +130,7 @@ static int __init ls1x_intc_of_init(struct device_node *node,
 					     NULL);
 	if (!priv->domain) {
 		pr_err("ls1x-irq: cannot add IRQ domain\n");
+		err = -ENOMEM;
 		goto out_iounmap;
 	}
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3faef4a77f71..51128bea3846 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1449,6 +1449,10 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
 	data = data->parent_data;
+
+	if (data->chip->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 13539e12cd80..9f8a709337cf 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -558,6 +558,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
+		mutex_init(&desc[i].request_mutex);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
