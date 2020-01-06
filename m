Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA5C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04909207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fT6SCqfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAFJKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:10:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgAFJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:10:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so14516748wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YAKuC3wFwI+CXcdF8S7FL6f/ZbYh+aygiTA+JHhgVc=;
        b=fT6SCqfFDxAfYyPaxe6fPt46NaZBg05eLaakaY5OWtAAWuA8tlYq/1EhcgGwgR/lm7
         TB9OPasW7dnE+2SpOJkKnm56dXd2SYUgO6eC/bM+Wpn5qxyKB1aQv7XPTrvYDu10REr7
         0AdNnaPOQ+InCGPLWxqNqC6wxk5DcECL+gxYWEY8yHGfJ6n/Cbrg+cqd/bGK2uYAxQX9
         VWEJ0pdBZcygVY4J9H8sVEKXRUlD1/IMyEsZN8p8h+JRIlYz/plscGmswdweTxXZnf5Q
         DbMn5NwXqqx8rXN+xbQZu6Ujc3uBwbIy6JIPb00/PbHZmlGf/VBknqwm+0Qq/Ns9PAv7
         yA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YAKuC3wFwI+CXcdF8S7FL6f/ZbYh+aygiTA+JHhgVc=;
        b=PAOJmayRuLUkw7kIKD+suSEGhfGxS4HXmEptek0SQGJ0YGlRw+96xqrRtC3uaxMqhY
         VPrXIwYAvlX5qVDC+DMeY5DHzGLmBSs7bpA7NsbsB0RQopqsitRKDSOGQQmzWenYU/Pi
         /Cqkh5HWnRozBaclYBxid1Q5JHLE3HCBY645Zn6TD0QkAov77Tkv6TgNAKDajh4bEU6c
         niOqovkaMeWz+Ul1kIkUitRr5TivJqdXf5ZGBMkPLRUSZHYS3d+HtcUWm215ciLlaJIU
         BEclxGCM87oyfhz8MySRqdObNc6p2dUgRF0LSAEDn+ywrVLce16H9JHdkqQnvLmtDIzK
         RLGA==
X-Gm-Message-State: APjAAAVvCCe2nxuhTfHPCx/FAbyd0voJxD8Jc92Zg0Gz+YqgsfYjtAFZ
        zYK7lUHsoapSq7VYBXIWECQXz18IPTcEFD+dDcZoyg==
X-Google-Smtp-Source: APXvYqzAomKzQkxDUIrNi/Whr2s8NAVXtV7E9CPmSzog947HVmDY807POnBYfNs9xS73M7WtrMQ2fd94nJ5uHmoRjVo=
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr31955396wmc.64.1578301830614;
 Mon, 06 Jan 2020 01:10:30 -0800 (PST)
MIME-Version: 1.0
References: <1578024801-39039-1-git-send-email-yash.shah@sifive.com> <1578024801-39039-3-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1578024801-39039-3-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 6 Jan 2020 14:40:19 +0530
Message-ID: <CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-Z_FaOr8LPni+s_615Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: cacheinfo: Add support to determine no. of
 L2 cache way enabled
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bin Meng <bmeng.cn@gmail.com>, green.wan@sifive.com,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 9:44 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> In order to determine the number of L2 cache ways enabled at runtime,
> implement a private attribute using cache_get_priv_group() in cacheinfo
> framework. Reading this attribute ("number_of_ways_enabled") will return
> the number of enabled L2 cache ways at runtime.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/include/asm/sifive_l2_cache.h |  2 ++
>  arch/riscv/kernel/cacheinfo.c            | 31 +++++++++++++++++++++++++++++++
>  drivers/soc/sifive/sifive_l2_cache.c     |  5 +++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
> index 04f6748..217a42f 100644
> --- a/arch/riscv/include/asm/sifive_l2_cache.h
> +++ b/arch/riscv/include/asm/sifive_l2_cache.h
> @@ -10,6 +10,8 @@
>  extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
>  extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
>
> +int sifive_l2_largest_wayenabled(void);
> +
>  #define SIFIVE_L2_ERR_TYPE_CE 0
>  #define SIFIVE_L2_ERR_TYPE_UE 1
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 4c90c07..29bdb21 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpu.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <asm/sifive_l2_cache.h>
>
>  static void ci_leaf_init(struct cacheinfo *this_leaf,
>                          struct device_node *node,
> @@ -16,6 +17,36 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>         this_leaf->type = type;
>  }
>
> +#ifdef CONFIG_SIFIVE_L2
> +static ssize_t number_of_ways_enabled_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       return sprintf(buf, "%u\n", sifive_l2_largest_wayenabled());
> +}
> +
> +static DEVICE_ATTR_RO(number_of_ways_enabled);
> +
> +static struct attribute *priv_attrs[] = {
> +       &dev_attr_number_of_ways_enabled.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group priv_attr_group = {
> +       .attrs = priv_attrs,
> +};
> +
> +const struct attribute_group *
> +cache_get_priv_group(struct cacheinfo *this_leaf)
> +{
> +       /* We want to use private group for L2 cache only */
> +       if (this_leaf->level == 2)
> +               return &priv_attr_group;
> +       else
> +               return NULL;
> +}
> +#endif /* CONFIG_SIFIVE_L2 */
> +

Instead of this, I would suggest to implement a generic ops
structure.

In arch/riscv/include/asm/cacheinfo.h:

struct riscv_caceinfo_ops {
    const struct attribute_group * (*get_priv_group)(struct cacheinfo
*this_leaf);
};

void riscv_set_cacheinfo_ops(struct riscv_caceinfo_ops *ops);

In arch/riscv/riscv/kernel/cacheinfo.h

static struct riscv_caceinfo_ops *rv_cache_ops;

void riscv_set_cacheinfo_ops(struct riscv_caceinfo_ops *ops)
{
    rv_cache_ops = ops;
}
EXPORT_SYMBOL_GPL(riscv_set_cacheinfo_ops);

const struct attribute_group *
cache_get_priv_group(struct cacheinfo *this_leaf)
{
    if (rv_cache_ops && rv_cache_ops->get_priv_group)
        return rv_cache_ops->get_priv_group(this_leaf)
    return NULL;
}

Above will be a separate patch. In future, we can add more
ops for SOC specific cacheinfo.

Using riscv_set_cacheinfo_ops() you can have another patch
to implement SiFive L2 info entirely in drivers/soc/sifive/sifive_l2_cache.c

Also, I would strongly recommend moving
arch/riscv/include/asm/sifive_l2_cache.h
TO
include/soc/sifive/sifive_l2_cache.h

>  static int __init_cache_level(unsigned int cpu)
>  {
>         struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index a9ffff3..f1a5f2c 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -107,6 +107,11 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
>
> +int sifive_l2_largest_wayenabled(void)
> +{
> +       return readl(l2_base + SIFIVE_L2_WAYENABLE);
> +}
> +
>  static irqreturn_t l2_int_handler(int irq, void *device)
>  {
>         unsigned int add_h, add_l;
> --
> 2.7.4
>

Regards,
Anup
