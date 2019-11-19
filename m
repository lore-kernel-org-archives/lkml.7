Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01066C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C699D22449
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574202601;
	bh=uof2dJFEEcUQ1D6TFhVx7qJFmPUWdTGkUmc5EasLIHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IXm8ziAnE4W7WJvKKYTw6nuKTjy/BT/OQ3jYqptpWsLC03XpNg/GvWLcoOwK/t8lA
	 VeHRPpUA4uQs5aaErbjrCieZq8nhW7QM1osdtX4YOQ+26QjdlrqNHHNZyYoK621FbU
	 OZSFy4gqp5yzQZVEbNlgtn2nz0j+IThD7S69ix6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKSWaA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:30:00 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:41727 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfKSWaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:30:00 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXC0T-0002Ng-JU; Tue, 19 Nov 2019 23:29:57 +0100
Date:   Tue, 19 Nov 2019 22:29:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Andreas =?UTF-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
Message-ID: <20191119222956.23665e5d@why>
In-Reply-To: <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
        <20191119021917.15917-3-afaerber@suse.de>
        <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
        <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernelrocks@gmail.com, james.tai@realtek.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 21:56:48 +0100
Andreas Färber <afaerber@suse.de> wrote:

> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
> > On 2019-11-19 02:19, Andreas Färber wrote:  
> >> +static void rtd1195_mux_enable_irq(struct irq_data *data)
> >> +{
> >> +    struct rtd1195_irq_mux_data *mux_data =
> >> irq_data_get_irq_chip_data(data);
> >> +    unsigned long flags;
> >> +    u32 mask;
> >> +
> >> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
> >> +    if (!mask)
> >> +        return;  
> > 
> > How can this happen? You've mapped the interrupt, so it exists.
> > I can't see how you can decide to fail such enable.  
> 
> The [UMSK_]ISR bits and the SCPU_INT_EN bits are not (all) the same.
> 
> My ..._isr_to_scpu_int_en[] arrays have 32 entries for O(1) lookup, but
> are sparsely populated. So there are circumstances such as WDOG_NMI as
> well as reserved bits that we cannot enable.

But the you should have failed the map. The moment you allow the
mapping to occur, you have accepted the contract that this interrupt is
usable.

> This check should be
> identical to v3; the equivalent mask check inside the interrupt handler
> was extended with "mask &&" to do the same in this v4.

Spurious interrupts are a different matter. What I'm objecting to here
is a simple question of logic, whether or not you are allowed to fail
enabling an interrupt that you've otherwise allowed to be populated.
 
	M.
-- 
Jazz is not dead. It just smells funny...
