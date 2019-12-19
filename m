Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559BCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202102465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/WGetXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSSJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:09:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbfLSSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576778961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/UuWE5iB/RyjWBan0UMgNWZPd7K5HnqvrjPuVvMCPQ=;
        b=L/WGetXS/a3NorVZjyEtuz93O3uhuUPT0JVoqe9YUSsE6G8JrdsLE633TYmXEBmiKEzbtj
        vQXyGOWh6eWA6lgD6f1PvN1Q5J9po984zZ/0yuvl/mNQFmr/pSUj9LIVVNfgXzpD31tPCF
        FJg7xJtg8VV1acCyqR4hXWJKrKF/wt0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-HrtrUf8NOl-flMN1YShoNQ-1; Thu, 19 Dec 2019 13:09:20 -0500
X-MC-Unique: HrtrUf8NOl-flMN1YShoNQ-1
Received: by mail-qv1-f69.google.com with SMTP id e26so3224226qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 10:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/UuWE5iB/RyjWBan0UMgNWZPd7K5HnqvrjPuVvMCPQ=;
        b=O1IdTl4VvavNsPzkvESPxbiZ8vHYyJch+dN63FiG5e4LZJChYuES/V2aRc0U4lwirt
         oAXPjkq0BJdrdn4ZCjDFxykvohjPho4RxAiaZhflRZzxcKpTYq18ceN42LLT7Vc8+fIJ
         XG3vRW0lVvsQiSchHy5HY8Bg18+RMWp/cd9PqTLnd0jOQ006id/CHfGyIPLYDFfj83FS
         crYQ0I5LGbUL1PJEY98AhYtSADRjwHirkvFAq8oFKq79xP8XS6kxHoQUggaXmNKc5A+3
         rix3INGwCq/fkZ/z7s5cs1cl44KU08yDkG1uC2LBfWnzADKoImCyYgoksZbP8htV4MlC
         63dw==
X-Gm-Message-State: APjAAAU7OO6qo0Y7JGGg3tRKEi7fuy1lZj9bBE0jufdM0qqbOH6cYg3c
        8ggha1j0a1L7p4j6LrcgoFrbQVmlTgWSM1JMAW2+lffGSFw3E0VR97fsm4mv+aHiVbaCBeVUruY
        /zo4EJjkZqqxU+ybXRiYTu3io
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr8993620qvb.107.1576778959962;
        Thu, 19 Dec 2019 10:09:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsi4u8Z3I2cOEMDhMn/OwFZGmWWlCbg2KzCcSh4HrnTuS9mL5SHylOJMY9IIuZGN6oOtsNIg==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr8993595qvb.107.1576778959615;
        Thu, 19 Dec 2019 10:09:19 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id g18sm1934624qki.13.2019.12.19.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:09:18 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:09:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20191219180917.GA7031@xz-x1>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
 <20191219161115.GA18672@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219161115.GA18672@ming.t460p>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:11:15AM +0800, Ming Lei wrote:
> OK, please try the following patch:
> 
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 6c8512d3be88..0fbcbacd1b29 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -13,6 +13,7 @@ enum hk_flags {
>  	HK_FLAG_TICK		= (1 << 4),
>  	HK_FLAG_DOMAIN		= (1 << 5),
>  	HK_FLAG_WQ		= (1 << 6),
> +	HK_FLAG_MANAGED_IRQ	= (1 << 7),
>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1753486b440c..0a75a09cc4e8 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/task_work.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "internals.h"
>  
> @@ -212,12 +213,33 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  {
>  	struct irq_desc *desc = irq_data_to_desc(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	const struct cpumask *housekeeping_mask =
> +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
>  	int ret;
> +	cpumask_var_t tmp_mask;
>  
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> -	ret = chip->irq_set_affinity(data, mask, force);
> +	if (!zalloc_cpumask_var(&tmp_mask, GFP_KERNEL))
> +		return -EINVAL;
> +
> +	/*
> +	 * Userspace can't change managed irq's affinity, make sure
> +	 * that isolated CPU won't be selected as the effective CPU
> +	 * if this irq's affinity includes both isolated CPU and
> +	 * housekeeping CPU.
> +	 *
> +	 * This way guarantees that isolated CPU won't be interrupted
> +	 * by IO submitted from housekeeping CPU.
> +	 */
> +	if (irqd_affinity_is_managed(data) &&
> +			cpumask_intersects(mask, housekeeping_mask))
> +		cpumask_and(tmp_mask, mask, housekeeping_mask);
> +	else
> +		cpumask_copy(tmp_mask, mask);
> +
> +	ret = chip->irq_set_affinity(data, tmp_mask, force);
>  	switch (ret) {
>  	case IRQ_SET_MASK_OK:
>  	case IRQ_SET_MASK_OK_DONE:
> @@ -229,6 +251,8 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  		ret = 0;
>  	}
>  
> +	free_cpumask_var(tmp_mask);
> +
>  	return ret;
>  }
>  
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 9fcb2a695a41..008d6ac2342b 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> +		if (!strncmp(str, "managed_irq,", 12)) {
> +			str += 12;
> +			flags |= HK_FLAG_MANAGED_IRQ;
> +			continue;
> +		}
> +
>  		pr_warn("isolcpus: Error, unknown flag\n");
>  		return 0;
>  	}

Thanks for the quick patch.  I'll test after my current round of tests
finish and update.  I'll probably believe this will work for us as
long as it "functionally" works :) (after all it won't even need a RT
environment because it's really about where to put some IRQs).  So
IMHO the more important thing is whether such a solution could be
acceptable by the upstream.

Thanks,

-- 
Peter Xu

