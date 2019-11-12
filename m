Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68604C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573556312;
	bh=0tn0SSq34Svy8n1BIxdttpUNZiZ/1cS4utciXJL4s+E=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=vQMUNwFal79uR6zDLRfcCtlMbsOHnzAaF8HSItMnQNNp6jl2K301isrz+lKmIhr0V
	 tcYB0Sm8HiFIjFgqEFlHh2MwMZRtQQOLlzRjcAhlRU+pvrmNLVLUrFbZvMUm1dJi7k
	 ZK3h/+PDC+KUSr1De+cvx0h3kQX62LHhOemVk9hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLK6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:58:31 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:55582 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfKLK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:58:31 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUTsQ-0005QJ-GI; Tue, 12 Nov 2019 11:58:26 +0100
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v7 0/2] Add support for Layerscape external interrupt  lines
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Nov 2019 12:07:47 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
In-Reply-To: <184b684a-7712-a280-fdc2-83d7abd3cbd4@rasmusvillemoes.dk>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
 <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
 <184b684a-7712-a280-fdc2-83d7abd3cbd4@rasmusvillemoes.dk>
Message-ID: <8e1877ab5a1fecace3b2383789bdf404@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux@rasmusvillemoes.dk, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kurt@linutronix.de, olteanv@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-12 11:27, Rasmus Villemoes wrote:
> On 11/11/2019 11.24, Marc Zyngier wrote:
>> On 2019-11-07 13:30, Rasmus Villemoes wrote:
>
>>> Rasmus Villemoes (2):
>>>   dt/bindings: Add bindings for Layerscape external irqs
>>>   irqchip: add support for Layerscape external interrupt lines
>>>
>>>  .../interrupt-controller/fsl,ls-extirq.txt    |  49 +++++
>>>  drivers/irqchip/Kconfig                       |   4 +
>>>  drivers/irqchip/Makefile                      |   1 +
>>>  drivers/irqchip/irq-ls-extirq.c               | 197 
>>> ++++++++++++++++++
>>>  4 files changed, 251 insertions(+)
>>>  create mode 100644
>>>
>>> 
>>> Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>>>  create mode 100644 drivers/irqchip/irq-ls-extirq.c
>>
>> Applied to irqchip-next.
>
> Thanks! Can I assume that branch doesn't get rebased so 87cd38dfd9e6 
> is
> a stable SHA1? I want to send a patch adding the node to 
> ls1021a.dtsi,
> and I hope not to have to wait another release cycle.

I usually try to avoid rebasing it, unless something really bad shows 
up.

Now, just adding a node to a DT shouldn't break anything, right? You
should be able to do that change and get things working magically once
this code hits mainline.

Or am I missing something?

         M.
-- 
Jazz is not dead. It just smells funny...
