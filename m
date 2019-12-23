Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9A0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcmL1Iix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLWTTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:19:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726787AbfLWTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577128736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mzx7EajUgz38eFycZmsM7uAu4xER5dc8+eCa4aPC7kM=;
        b=NcmL1IixcM1nsKpeU/H8v8m1dJVkSwN88p4jCmeeIh0wlsCuxG3Wpnbd9l7t0dAL29TgUR
        b+S0oUCKj+dei0Sl8u4u5JTJkBIygY65NjafHJRQEAZ3yAm3xNcVc/cgZa9uqQyKtP8BLS
        xz1fJ7SEPs/igBCMGohG5scCBAM4RuU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-6ao2L9F3Nh2Re3TxSj_Iiw-1; Mon, 23 Dec 2019 14:18:54 -0500
X-MC-Unique: 6ao2L9F3Nh2Re3TxSj_Iiw-1
Received: by mail-qk1-f198.google.com with SMTP id 143so11690994qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 11:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mzx7EajUgz38eFycZmsM7uAu4xER5dc8+eCa4aPC7kM=;
        b=ib0diZ5gMf2bKKB78wClt+So3OFqfeAvGf27bQoi3P2CjkdT9gvXVCSo2xnjwB8nMJ
         2zCRUoCSEgRNFsoap1iTwwLaGY3cZRLc3+7LahFbYo5rDR1xejaO11j8lxSqNbrQqEyg
         lAULSFao6vnNstBSPI8u4Kl4E+BQsAWSwpGJAcuGoivyQqRM3O6oLGAMjzPw68YKwGOp
         8kpLOD2TNueeaPm5RPKJNe91T2Glqibwr3yvHdCG80hYqv4xAxrxhbtCVL78RRv6wv6q
         Dh+MQ1KTLqctScfBMFWRuMZjjOscUOaVf8+C5xaFhOfWo7Gdw7vb93ihYQduW9kLCvZW
         kBfg==
X-Gm-Message-State: APjAAAWL2rXY7yE0VsRJf+Tozj4En8K+H4fYBBhB41eokt4d/Sd465QZ
        5dcA1xpbnxzlO/BjrxdAz5xiswp5cxD8EXTBweZ2kmvN56+J37jHmnOhyEUa74ETz3e2iaENYCW
        9QtrSORqKLUUhJDHCiuCYH8nd
X-Received: by 2002:ac8:7501:: with SMTP id u1mr24486593qtq.149.1577128734120;
        Mon, 23 Dec 2019 11:18:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm9a4lxMK6LF7QqNyD0QLlhLiSQOueiUSxA++dap0npGYGI52Q+yT1gDgURMuOXGsSQdSk6Q==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr24486575qtq.149.1577128733847;
        Mon, 23 Dec 2019 11:18:53 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id g4sm6639888qtg.35.2019.12.23.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 11:18:52 -0800 (PST)
Date:   Mon, 23 Dec 2019 14:18:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20191223191851.GA90172@xz-x1>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
 <20191219161115.GA18672@ming.t460p>
 <20191219180917.GA7031@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219180917.GA7031@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 01:09:17PM -0500, Peter Xu wrote:
> On Fri, Dec 20, 2019 at 12:11:15AM +0800, Ming Lei wrote:
> > OK, please try the following patch:
> > 
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 6c8512d3be88..0fbcbacd1b29 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -13,6 +13,7 @@ enum hk_flags {
> >  	HK_FLAG_TICK		= (1 << 4),
> >  	HK_FLAG_DOMAIN		= (1 << 5),
> >  	HK_FLAG_WQ		= (1 << 6),
> > +	HK_FLAG_MANAGED_IRQ	= (1 << 7),
> >  };
> >  
> >  #ifdef CONFIG_CPU_ISOLATION
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 1753486b440c..0a75a09cc4e8 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/task.h>
> >  #include <uapi/linux/sched/types.h>
> >  #include <linux/task_work.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include "internals.h"
> >  
> > @@ -212,12 +213,33 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  {
> >  	struct irq_desc *desc = irq_data_to_desc(data);
> >  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	const struct cpumask *housekeeping_mask =
> > +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> >  	int ret;
> > +	cpumask_var_t tmp_mask;
> >  
> >  	if (!chip || !chip->irq_set_affinity)
> >  		return -EINVAL;
> >  
> > -	ret = chip->irq_set_affinity(data, mask, force);
> > +	if (!zalloc_cpumask_var(&tmp_mask, GFP_KERNEL))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Userspace can't change managed irq's affinity, make sure
> > +	 * that isolated CPU won't be selected as the effective CPU
> > +	 * if this irq's affinity includes both isolated CPU and
> > +	 * housekeeping CPU.
> > +	 *
> > +	 * This way guarantees that isolated CPU won't be interrupted
> > +	 * by IO submitted from housekeeping CPU.
> > +	 */
> > +	if (irqd_affinity_is_managed(data) &&
> > +			cpumask_intersects(mask, housekeeping_mask))
> > +		cpumask_and(tmp_mask, mask, housekeeping_mask);
> > +	else
> > +		cpumask_copy(tmp_mask, mask);
> > +
> > +	ret = chip->irq_set_affinity(data, tmp_mask, force);
> >  	switch (ret) {
> >  	case IRQ_SET_MASK_OK:
> >  	case IRQ_SET_MASK_OK_DONE:
> > @@ -229,6 +251,8 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  		ret = 0;
> >  	}
> >  
> > +	free_cpumask_var(tmp_mask);
> > +
> >  	return ret;
> >  }
> >  
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 9fcb2a695a41..008d6ac2342b 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >  			continue;
> >  		}
> >  
> > +		if (!strncmp(str, "managed_irq,", 12)) {
> > +			str += 12;
> > +			flags |= HK_FLAG_MANAGED_IRQ;
> > +			continue;
> > +		}
> > +
> >  		pr_warn("isolcpus: Error, unknown flag\n");
> >  		return 0;
> >  	}
> 
> Thanks for the quick patch.  I'll test after my current round of tests
> finish and update.  I'll probably believe this will work for us as
> long as it "functionally" works :) (after all it won't even need a RT
> environment because it's really about where to put some IRQs).  So
> IMHO the more important thing is whether such a solution could be
> acceptable by the upstream.

I've tested this patch, it works for us.  "isolcpus=managed_irq,2-9"
gives me:

[root@rt-vm 32]# pwd
/proc/irq/32
[root@rt-vm 32]# cat smp_affinity
003
[root@rt-vm 32]# cat effective_affinity
001

Thomas, do you think Ming's solution could be accepted?

Thanks,

-- 
Peter Xu

