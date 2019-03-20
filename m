Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D86218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCTRC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:02:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfCTRC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3C6A78;
        Wed, 20 Mar 2019 10:02:25 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF7D3F614;
        Wed, 20 Mar 2019 10:02:23 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:02:19 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Cc:     <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        guoheyi@huawei.com, Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [RFC] Question about enable doorbell irq and halt_poll process
Message-ID: <20190320170219.510f2e1e@why.wild-wind.fr.eu.org>
In-Reply-To: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
References: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 21:25:47 +0800
"Tangnianyao (ICT)" <tangnianyao@huawei.com> wrote:

> Hi, all
> 
> Using gicv4, when guest is waiting for irq, it sends wfi and traps to kvm.
> When vlpi is forwarded to PE after its_vpe_deschedule, before halt_poll in
> kvm_vcpu_block, halt_poll may increase latency for this vlpi getting to guest.
> In halt_poll process, it checks if there's pending irq for vcpu using pending_last.
> However, doorbell is not enable at this moment and vlpi or doorbell can not set
> pending_last true, to stop halt_poll. It will run until halt_poll time ends, if
> there's no other physical irq coming in the meantime. And then vcpu is scheduled out.
> This pending vlpi has to wait for vcpu getting schedule in next time.
> 
> Should we enable doorbell before halt_poll process ?

Enabling doorbells can be quite expensive. Depending on the HW, this is
either:

- a write to memory (+DSB, potential cache maintenance), a write to the
  INVLPI register, and a poll of the SYNC register
- a write to memory (+DSB, potential cache maintenance), potentially
  a string of DISCARD+SYNC+MAPI+SYNC commands, and an INV+SYNC command

Frankly, you want to be careful with that. I'd rather enable them late
and have a chance of not blocking because of another (virtual)
interrupt, which saves us the doorbell business.

I wonder if you wouldn't be in a better position by drastically
reducing halt_poll_ns for vcpu that can have directly injected
interrupts.

In any case, this is something that we should measure, not guess.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
