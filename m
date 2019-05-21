Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558423355;
	bh=hOh+RlnPFo7RDchTKOLy53fDELfyUR8IDfUYfO6Mlxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ec4y6EeULiF2zWsyj5si4GUSdSz9XSnihgKCSiFYhoMHPJA+wyVWE0iXNBYUyhKQy
	 Y9LzuMa/wJEvtL+iPswnPA57GnyAkPkEMMbCUe7xH/tyPq2TZm2+YVIgR/EUQ9sxOZ
	 e14Znzuk5YKg68C+TCEWEdRx7zWHsXZx3FJ7fNeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfEUHWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfEUHWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:22:33 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D962173E;
        Tue, 21 May 2019 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558423352;
        bh=hOh+RlnPFo7RDchTKOLy53fDELfyUR8IDfUYfO6Mlxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T2hMNb3EytR111dOUWutnKK5ww5/WnkUYmYrKtlIiPawKRaAgL+dVfPg59fbLA+Qm
         kkpqlaOILq5wdbMGkxQ5QsS374+49k7RAOwiB3KL0M/+gZMjTzKtXF96iDxu7GN8mp
         o9lE+28O0V53ka5oPmWpiyMA73AV1uXnfJsmsmHw=
Received: by mail-wm1-f54.google.com with SMTP id x64so1732697wmb.5;
        Tue, 21 May 2019 00:22:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVx8aXGHcFbxT/ZpHPMcovPABaNq8VO4GH0s3iEkPgmc/X4GU7n
        gseYIx5EBOOL+B4ybqUsa2QLblag5R+6FrUhPSI=
X-Google-Smtp-Source: APXvYqyfLfm7QJZr+q0ou9ZZE4032xmy4uDh93UD26byRCCZhzrx7/M/BMI4fdydZlwfNUxivGlnrq3jIS2WQY8KJNo=
X-Received: by 2002:a7b:c844:: with SMTP id c4mr2177288wml.108.1558423350726;
 Tue, 21 May 2019 00:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <1557741339-29331-1-git-send-email-guoren@kernel.org> <1557741339-29331-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1557741339-29331-2-git-send-email-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 May 2019 15:22:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQSnVKo_sXF8BSYUcKWOkXOkX3z96zCEBfa4iUPjN9UDA@mail.gmail.com>
Message-ID: <CAJF2gTQSnVKo_sXF8BSYUcKWOkXOkX3z96zCEBfa4iUPjN9UDA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] irqchip/irq-csky-mpintc: Add triger type and priority
To:     marc.zyngier@arm.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, Ren Guo <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
ping ... Any problem ?

Thx
 Guo Ren

<guoren@kernel.org> =E4=BA=8E2019=E5=B9=B45=E6=9C=8813=E6=97=A5=E5=91=A8=E4=
=B8=80 =E4=B8=8B=E5=8D=885:55=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Support 4 triger types:
>  - IRQ_TYPE_LEVEL_HIGH
>  - IRQ_TYPE_LEVEL_LOW
>  - IRQ_TYPE_EDGE_RISING
>  - IRQ_TYPE_EDGE_FALLING
>
> Support 0-255 priority setting for each irq.
>
> All of above could be set in DeviceTree file and it still compatible
> with the old DeviceTree format.
>
> Changes for V3:
>  - Use IRQ_TYPE_LEVEL_HIGH as default instead of IRQ_TYPE_NONE
>  - Remove unnecessary loop in csky_mpintc_handler
>
> Changes for V2:
>  - Fixup this_cpu_read() preempted problem.
>  - Optimize the coding style.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-csky-mpintc.c | 113 ++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 106 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky=
-mpintc.c
> index c67c961..5bc0868 100644
> --- a/drivers/irqchip/irq-csky-mpintc.c
> +++ b/drivers/irqchip/irq-csky-mpintc.c
> @@ -17,6 +17,7 @@
>  #include <asm/reg_ops.h>
>
>  static struct irq_domain *root_domain;
> +
>  static void __iomem *INTCG_base;
>  static void __iomem *INTCL_base;
>
> @@ -29,11 +30,13 @@ static void __iomem *INTCL_base;
>
>  #define INTCG_ICTLR    0x0
>  #define INTCG_CICFGR   0x100
> +#define INTCG_CIPRTR   0x200
>  #define INTCG_CIDSTR   0x1000
>
>  #define INTCL_PICTLR   0x0
> +#define INTCL_CFGR     0x14
> +#define INTCL_PRTR     0x20
>  #define INTCL_SIGR     0x60
> -#define INTCL_HPPIR    0x68
>  #define INTCL_RDYIR    0x6c
>  #define INTCL_SENR     0xa0
>  #define INTCL_CENR     0xa4
> @@ -41,21 +44,66 @@ static void __iomem *INTCL_base;
>
>  static DEFINE_PER_CPU(void __iomem *, intcl_reg);
>
> +static unsigned long *__trigger;
> +static unsigned long *__priority;
> +
> +#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_B=
ASE))
> +
> +#define TRIG_BYTE_OFFSET(i)    ((((i) * 2) / 32) * 4)
> +#define TRIG_BIT_OFFSET(i)      (((i) * 2) % 32)
> +
> +#define PRI_BYTE_OFFSET(i)     ((((i) * 8) / 32) * 4)
> +#define PRI_BIT_OFFSET(i)       (((i) * 8) % 32)
> +
> +#define TRIG_VAL(trigger, irq) (trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(ir=
q)))
> +#define TRIG_VAL_MSK(irq)          (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(ir=
q))))
> +#define PRI_VAL(priority, irq) (priority << PRI_BIT_OFFSET(IRQ_OFFSET(ir=
q)))
> +#define PRI_VAL_MSK(irq)         (~(0xff << PRI_BIT_OFFSET(IRQ_OFFSET(ir=
q))))
> +
> +#define TRIG_BASE(irq) \
> +       (TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
> +       (this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CIC=
FGR)))
> +
> +#define PRI_BASE(irq) \
> +       (PRI_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
> +       (this_cpu_read(intcl_reg) + INTCL_PRTR) : (INTCG_base + INTCG_CIP=
RTR)))
> +
> +static DEFINE_SPINLOCK(setup_lock);
> +static void setup_trigger_priority(unsigned long irq, unsigned long trig=
ger,
> +                                  unsigned long priority)
> +{
> +       unsigned int tmp;
> +
> +       spin_lock(&setup_lock);
> +
> +       /* setup trigger */
> +       tmp =3D readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
> +
> +       writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
> +
> +       /* setup priority */
> +       tmp =3D readl_relaxed(PRI_BASE(irq)) & PRI_VAL_MSK(irq);
> +
> +       writel_relaxed(tmp | PRI_VAL(priority, irq), PRI_BASE(irq));
> +
> +       spin_unlock(&setup_lock);
> +}
> +
>  static void csky_mpintc_handler(struct pt_regs *regs)
>  {
>         void __iomem *reg_base =3D this_cpu_read(intcl_reg);
>
> -       do {
> -               handle_domain_irq(root_domain,
> -                                 readl_relaxed(reg_base + INTCL_RDYIR),
> -                                 regs);
> -       } while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
> +       handle_domain_irq(root_domain,
> +               readl_relaxed(reg_base + INTCL_RDYIR), regs);
>  }
>
>  static void csky_mpintc_enable(struct irq_data *d)
>  {
>         void __iomem *reg_base =3D this_cpu_read(intcl_reg);
>
> +       setup_trigger_priority(d->hwirq, __trigger[d->hwirq],
> +                                __priority[d->hwirq]);
> +
>         writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
>  }
>
> @@ -73,6 +121,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
>         writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
>  }
>
> +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
> +{
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               __trigger[d->hwirq] =3D 0;
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               __trigger[d->hwirq] =3D 1;
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               __trigger[d->hwirq] =3D 2;
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               __trigger[d->hwirq] =3D 3;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_SMP
>  static int csky_irq_set_affinity(struct irq_data *d,
>                                  const struct cpumask *mask_val,
> @@ -105,6 +175,7 @@ static struct irq_chip csky_irq_chip =3D {
>         .irq_eoi        =3D csky_mpintc_eoi,
>         .irq_enable     =3D csky_mpintc_enable,
>         .irq_disable    =3D csky_mpintc_disable,
> +       .irq_set_type   =3D csky_mpintc_set_type,
>  #ifdef CONFIG_SMP
>         .irq_set_affinity =3D csky_irq_set_affinity,
>  #endif
> @@ -125,9 +196,29 @@ static int csky_irqdomain_map(struct irq_domain *d, =
unsigned int irq,
>         return 0;
>  }
>
> +static int csky_irq_domain_xlate_cells(struct irq_domain *d,
> +               struct device_node *ctrlr, const u32 *intspec,
> +               unsigned int intsize, unsigned long *out_hwirq,
> +               unsigned int *out_type)
> +{
> +       if (WARN_ON(intsize < 1))
> +               return -EINVAL;
> +
> +       *out_hwirq =3D intspec[0];
> +       if (intsize > 1)
> +               *out_type =3D intspec[1] & IRQ_TYPE_SENSE_MASK;
> +       else
> +               *out_type =3D IRQ_TYPE_LEVEL_HIGH;
> +
> +       if (intsize > 2)
> +               __priority[*out_hwirq] =3D intspec[2];
> +
> +       return 0;
> +}
> +
>  static const struct irq_domain_ops csky_irqdomain_ops =3D {
>         .map    =3D csky_irqdomain_map,
> -       .xlate  =3D irq_domain_xlate_onecell,
> +       .xlate  =3D csky_irq_domain_xlate_cells,
>  };
>
>  #ifdef CONFIG_SMP
> @@ -161,6 +252,14 @@ csky_mpintc_init(struct device_node *node, struct de=
vice_node *parent)
>         if (ret < 0)
>                 nr_irq =3D INTC_IRQS;
>
> +       __priority =3D kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL)=
;
> +       if (__priority =3D=3D NULL)
> +               return -ENXIO;
> +
> +       __trigger  =3D kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL)=
;
> +       if (__trigger =3D=3D NULL)
> +               return -ENXIO;
> +
>         if (INTCG_base =3D=3D NULL) {
>                 INTCG_base =3D ioremap(mfcr("cr<31, 14>"),
>                                      INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
> --
> 2.7.4
>
