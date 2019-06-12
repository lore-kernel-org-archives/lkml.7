Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05759C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694D21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="JO0+Cu/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439905AbfFLPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:02:46 -0400
Received: from node.akkea.ca ([192.155.83.177]:35090 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408269AbfFLPCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:02:42 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 8D73E4E204B; Wed, 12 Jun 2019 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1560351761; bh=v6z1WEtCF2fp4wYe56LRARRx9Esiw5fI6QhY0kCLmO4=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=JO0+Cu/YGtgmYx6NAWZcY1i5pinFHmUbP98a2MCXKNC+E2p59MUB9Ovk5hXVUoKnJ
         2uTd1KSqXskIAEnViwmJtLyEBAVeOrXP2g6FBmBHFR3qHwZAz28XwbbhFIoep9xdxb
         0NuaLvcfqyoj023w2kd4qLAL6SbHDELgqwgkn/lQ=
To:     Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v15 0/3] Add support for the Purism Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Jun 2019 09:02:41 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Shawn Guo <shawnguo@kernel.org>, angus.ainslie@puri.sm,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
In-Reply-To: <20190610135258.GA7976@xo-6d-61-c0.localdomain>
References: <20190528125747.1047-1-angus@akkea.ca>
 <20190605090315.GJ29853@dragon>
 <db174b0173d0bcdb9ab5ff4e2e1cc4bc@www.akkea.ca>
 <20190610135258.GA7976@xo-6d-61-c0.localdomain>
Message-ID: <b1de3d5fd352744f2c1f4e7bae266d01@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 2019-06-10 07:52, Pavel Machek wrote:
> On Wed 2019-06-05 06:48:05, Angus Ainslie wrote:
>> On 2019-06-05 03:03, Shawn Guo wrote:
>> >On Tue, May 28, 2019 at 05:57:44AM -0700, Angus Ainslie (Purism) wrote:
>> >>The Librem5 devkit is based on the imx8mq from NXP. This is a default
>> >>devicetree to boot the board to a command prompt.
>> >>
>> >>Changes since v14:
>> >>
>> >>Add regulator-always-on for the SNVS regulators.
>> >>Added pgc nodes.
>> >>Fixed charger pre-current.
>> >
>> >Since Pavel was reviewing your patches, you should copy him on the new
>> >version.  Has this version addressed all his review comments?
>> >
>> 
>> Sorry I had meant to include him in the CC.
>> 
>> I believe so but don't want to speak for him so we should see if he
>> has anymore.
> 
> I did not check the code, sorry.
> 
> I still believe your shutdown voltage is too low; try that. Battery
> will go down from 3V
> to 2.8V in seconds, so you don't really gain anything by using lower
> threshold, and you
> may not even have enough time to shutdown the system if you set it too 
> low.
> 
> Normally something like 3.0V, 3.2V is reasonable shutdown voltage.
> 

I took another look at the BQ25896 datasheet and the minimum-sys-voltage 
register is limited to 3.0-3.7 V.

I'll submit a new version.

Angus

> Best regards,
> 										Pavel

