Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E247FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A0A215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575018742;
	bh=D7C4w+4s2X0XNpRConTGLaydGNgZ/tefnnJz0BmjCbQ=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=suMi0DYUmslx5ACNZc0ppPWHBVUlCI+DWvvOsJjArXL1TDmypkhudlMH889BHqL8N
	 YfSkfKpBk9P7pwESge394Y1sxOYw1wGfLxnQa2ckIEyEN6k8nhVqarbYGozzj/kxcy
	 S+fKoOugc6Cfc7UPhbCcIPEtbDsStGDNlUMULIHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfK2JMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:12:22 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:47315 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbfK2JMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:12:21 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iacJu-00053w-Nt; Fri, 29 Nov 2019 10:12:10 +0100
To:     Yash Shah <yash.shah@sifive.com>
Subject: RE: [PATCH v3 5/6] gpio: sifive: Add GPIO driver for SiFive SoCs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Nov 2019 09:12:10 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <bmeng.cn@gmail.com>,
        <atish.patra@wdc.com>, Sagar Kadam <sagar.kadam@sifive.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
In-Reply-To: <CH2PR13MB33682C26386CB4EE8A7EA1C98C460@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1574661437-28486-1-git-send-email-yash.shah@sifive.com>
 <1574661437-28486-6-git-send-email-yash.shah@sifive.com>
 <CACRpkdY7fGvTPcwwC0XU+XN2w_QUCj0MmOYhp183P3Lj7Qw8WA@mail.gmail.com>
 <CH2PR13MB33682C26386CB4EE8A7EA1C98C460@CH2PR13MB3368.namprd13.prod.outlook.com>
Message-ID: <208a63e8819b84f9dc03f270f2606294@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yash.shah@sifive.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, tglx@linutronix.de, jason@lakedaemon.net, bmeng.cn@gmail.com, atish.patra@wdc.com, sagar.kadam@sifive.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-29 06:27, Yash Shah wrote:
>> -----Original Message-----
>> From: Linus Walleij <linus.walleij@linaro.org>
>> Sent: 28 November 2019 17:50
>> To: Yash Shah <yash.shah@sifive.com>
>> Cc: bgolaszewski@baylibre.com; robh+dt@kernel.org;
>> mark.rutland@arm.com; palmer@dabbelt.com; Paul Walmsley ( Sifive)
>> <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu; 
>> tglx@linutronix.de;
>> jason@lakedaemon.net; maz@kernel.org; bmeng.cn@gmail.com;
>> atish.patra@wdc.com; Sagar Kadam <sagar.kadam@sifive.com>; linux-
>> gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Sachin 
>> Ghadi
>> <sachin.ghadi@sifive.com>
>> Subject: Re: [PATCH v3 5/6] gpio: sifive: Add GPIO driver for SiFive 
>> SoCs
>>
>> On Mon, Nov 25, 2019 at 6:58 AM Yash Shah <yash.shah@sifive.com> 
>> wrote:
>>
>> > Adds the GPIO driver for SiFive RISC-V SoCs.
>> >
>> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> > [Atish: Various fixes and code cleanup]
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I suppose Marc will merge all patches into the irqchip tree as they 
>> are logically
>> dependent? If you want the GPIO bindings and this driver directly 
>> merged
>> (no deps) then I can do that as well.
>
> Yes, the GPIO driver have logical dependency on irqchip patches. It
> is best if Marc merges all the patches into the irqchip tree.
>
> @Marc Zyngier, Are you going to merge all the patches into the 
> irqchip tree?

I'm happy to pick this up, but that's definitely 5.6 material as
I stopped collecting new 5.5 features a couple of weeks ago.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
