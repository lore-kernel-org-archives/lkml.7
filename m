Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2420C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 10:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58720838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577529714;
	bh=BFFr5Pm34/zLJe/ZvSMWrNK6ekgSNljecH5sN9hXx6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SJCN3FKXgAL4HlhwqoLuTjM1gFjwcHi+jgDAIbGGTXnbIDksJG2PDym5IoLoJOWSD
	 O+EMfIsJf6HEhESUnXqd5NGHGuhqa4V4dJxVb9eh1Jza/rWSJG3tT9Uhnb8dy4kTDq
	 JY1lSJeK1ylmLGbr3ikcdgzK70iylCR3/cpQsDhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfL1Klx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 05:41:53 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:53316 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfL1Klx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 05:41:53 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Dec 2019 05:41:52 EST
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1il9XY-0003x6-Oe; Sat, 28 Dec 2019 10:41:48 +0000
Date:   Sat, 28 Dec 2019 10:41:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH v3 28/32] KVM: arm64: GICv4.1: Add direct injection
 capability to SGI registers
Message-ID: <20191228104147.0e658aa9@why>
In-Reply-To: <c009fb1f-f4ec-22d5-ba7d-58426837c8af@huawei.com>
References: <20191224111055.11836-1-maz@kernel.org>
        <20191224111055.11836-29-maz@kernel.org>
        <c009fb1f-f4ec-22d5-ba7d-58426837c8af@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019 17:19:36 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> Hi Marc,
> 
> On 2019/12/24 19:10, Marc Zyngier wrote:
> > Most of the GICv3 emulation code that deals with SGIs now has to be
> > aware of the v4.1 capabilities in order to benefit from it.
> > 
> > Add such support, keyed on the interrupt having the hw flag set and
> > being a SGI.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---  
> 
> > diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> > index 0d090482720d..6ebf747a7806 100644
> > --- a/virt/kvm/arm/vgic/vgic-mmio.c
> > +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> > @@ -290,6 +345,20 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,  
> >   >   		raw_spin_lock_irqsave(&irq->irq_lock, flags);
> >   > +		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {  
> > +			/* HW SGI? Ask the GIC to inject it */  
> 
> Shouldn't this be "Ask the GIC to clear its pending state"?

yeah, a silly copy-paste mistake, thanks for spotting this!

> Otherwise looks good!

Thanks for taking the time to review this work!

	M.
-- 
Jazz is not dead. It just smells funny...
