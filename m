Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10354C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D054A20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="QSy/yd9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCHMaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:30:23 -0500
Received: from office2.cesnet.cz ([195.113.144.244]:52286 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:30:22 -0500
Received: from localhost (unknown [IPv6:2001:718:1:2e:9077:1a3:d51f:f1d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id B9E21400052;
        Fri,  8 Mar 2019 13:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1552048220;
        bh=SBBa6lnP9fD+d6QoieQY26EXoZCaDtsyg2OKmlZnQ9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QSy/yd9P1lunywE43Y2sagg4AQnAWWs49T+a4Mnx5cwpmswBxkxlDGPECdD7c4Kri
         J7BFFutNXlq5lz1FfN3EHxASM2SvlEAKvLnq5DFik1SADU0wwmNGMBa/RjHEUmnh3s
         aLqT4L15ZfKmoSJ+ovwDW1gUbjULld3XP985DK24=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Allocate =?iso-8859-1?Q?irq=5Fchip_dynamic?=
Date:   Fri, 08 Mar 2019 13:30:19 +0100
MIME-Version: 1.0
Message-ID: <a79af7cc-20e7-4a52-b77f-24f40ddca23d@cesnet.cz>
In-Reply-To: <CACRpkdYJHyj+TMOde=veQsj8m+xFf0XGEnT0DS0qgMXCSA5iOA@mail.gmail.com>
References: <20190111162516.28197-1-poeschel@lemonage.de>
 <CACRpkdZFFu=wgHw0BqXUHiC5euGwWuYbr5bH60zDvFr+q394=w@mail.gmail.com>
 <7ce47f34-ed9f-44ac-b966-68e3bbf3b052@cesnet.cz>
 <CACRpkdYJHyj+TMOde=veQsj8m+xFf0XGEnT0DS0qgMXCSA5iOA@mail.gmail.com>
Organization: CESNET
User-Agent: Trojita/v0.7-377-g27bf90aa; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p=C3=A1tek 8. b=C5=99ezna 2019 10:15:50 CET, Linus Walleij wrote:
> On Tue, Mar 5, 2019 at 4:19 PM Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> wro=
te:
>
>> This commit should probably go to 5.0-stable and 4.20-stable as well
>
> I doubt that this commit is fixing a regression, but who knows...
>> If I cherry-pick the following two commits to my 5.0, my board boots once
>> again:
>>=20
>> 16f4372fd7a5 pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
>> 19ab5ca9b77d pinctrl: mcp23s08: Allocate irq_chip dynamic
>
> Hm weird.

My working theory is that this is because I have two physical chips on the=20=

same SPI CS. If I am correct, it works like this between 4.20 and current=20
gpio-next:

- GPIO expander #1 is initialized, including the irqchip
- GPIO expander #2 is initialized, and the irqchip initialization fails
- an interrupt on a shared IRQ line which is common to GPIO expanders #1=20
and #2 and one other unrelated device starts to be processed
- GPIO expander #1 says "not mine interrupt"
- GPIO expander #2 attempts to dereference a null pointer becase since=20
171948ea33e14, the gpiochip->irq.irq_enable/disable are not initialized

>> As on "why am I hitting this while nobody else did", my board has a shared=

>> IRQ line which is active during bootup, perhaps that might have something
>> to do with this -- I don't know.
>
> Sounds like the code in mcp23s08 .probe() should write to all
> registers clearing and disabling interrupts before proceeding to
> request interrupts or register the irqchip, else it will fire immediately
> and cause oopses.

I do not think that this would help me. My IRQ line is shared with another=20=

chip, so it can be physically asserted even if this particular GPIO=20
expander doesn't generate an interrupt.

I suspect that this configuration (multiple MCP23S17 on one SPI CS, and an=20=

IRQ line shared with something else) is quite rare...

With kind regards,
Jan
