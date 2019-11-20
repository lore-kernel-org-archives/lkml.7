Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D572243E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574245458;
	bh=+vUR0c8tmH82Sr70+8QvKKOVqOHrxUMGvFuQhnOzlGk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=uvQCOjxx7S268F7OlIMVJ4ngigj8OkZ4zCPEpLvkMkWOV2CzwWGefXfvgM6Ashod3
	 0D48RgFrw7pLlRzxg5dB1WTJtLrVVx/JsWCrB099i2Qx46h6r8j9PBS4NRVxzm56uA
	 xTiYOQt5xPSH1rI7SSjYARU5SoGm2E3pCWAzcIiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfKTKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:24:17 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54174 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbfKTKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:24:17 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXN9a-0001Lb-Iw; Wed, 20 Nov 2019 11:24:06 +0100
To:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/5] genirq: introduce =?UTF-8?Q?irq=5Fdomain=5Ftra?=  =?UTF-8?Q?nslate=5Fonecell?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 10:24:06 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Yash Shah <yash.shah@sifive.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <jason@lakedaemon.net>,
        <bmeng.cn@gmail.com>, <atish.patra@wdc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
In-Reply-To: <alpine.DEB.2.21.1911201034240.6731@nanos.tec.linutronix.de>
References: <1574233128-28114-1-git-send-email-yash.shah@sifive.com>
 <1574233128-28114-2-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.1911201034240.6731@nanos.tec.linutronix.de>
Message-ID: <31ed00455bd8374b26ea6b649c14e288@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: tglx@linutronix.de, yash.shah@sifive.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, jason@lakedaemon.net, bmeng.cn@gmail.com, atish.patra@wdc.com, sagar.kadam@sifive.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-20 09:34, Thomas Gleixner wrote:
> On Wed, 20 Nov 2019, Yash Shah wrote:
>
>> Add a new function irq_domain_translate_onecell() that is to be used 
>> as
>> the translate function in struct irq_domain_ops for the v2 IRQ API.
>
> What is the V2 IRQ API?

I believe that's a reference to a rather misleading comment in 
irqdomain.h:

#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
	/* extended V2 interfaces to support hierarchy irq_domains */

which we could drop, as everything refers to hierarchical domain
support.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
