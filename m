Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E554DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BFC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566313635;
	bh=u45fl2CiuXt0p0xaBy3mCEToHL5/K6mEgOauKAoLyDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NYQS07FvMrV9kFqHNX3b5C+XdpRLrRga2rvQTQOGVPVTrN3Cb7jZc1U+ddoBa3HB+
	 EvUE5M0jQ1ehLFepwctGGFK6q6WYMkRgnVh/hCnoSX2Do25VJKhL/+aOA9Icpv3uhA
	 ECqHyWBEwh0QU6Dos0gl8g/ZZYwdvkJpEowZ3OL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfHTPHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:07:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:57119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHTPHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:07:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 08:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="183225260"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2019 08:07:12 -0700
Date:   Tue, 20 Aug 2019 09:05:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
Message-ID: <20190820150511.GD11202@localhost.localdomain>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
 <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:59:32AM -0700, John Garry wrote:
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e8f7f179bf77..cb483a055512 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -966,9 +966,13 @@ irq_thread_check_affinity(struct irq_desc *desc, 
> struct irqaction *action)
>   	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
>   	 */
>   	if (cpumask_available(desc->irq_common_data.affinity)) {
> +		struct irq_data *irq_data = &desc->irq_data;
>   		const struct cpumask *m;
> 
> -		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +		if (action->flags & IRQF_IRQ_AFFINITY)
> +			m = desc->irq_common_data.affinity;
> +		else
> +			m = irq_data_get_effective_affinity_mask(irq_data);
>   		cpumask_copy(mask, m);
>   	} else {
>   		valid = false;
> -- 
> 2.17.1
> 
> As Ming mentioned in that same thread, we could even make this policy 
> for managed interrupts.

Ack, I really like this option!
