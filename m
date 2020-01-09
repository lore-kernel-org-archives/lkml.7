Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A89C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F9F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgAIQxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:53:09 -0500
Received: from foss.arm.com ([217.140.110.172]:34632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbgAIQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:53:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4EBE1FB;
        Thu,  9 Jan 2020 08:53:07 -0800 (PST)
Received: from [10.1.38.29] (e122027.cambridge.arm.com [10.1.38.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D45A3F703;
        Thu,  9 Jan 2020 08:53:04 -0800 (PST)
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <20200108052337.65916-5-drinkcat@chromium.org>
 <20200108132302.GA3817@sirena.org.uk>
 <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
 <09ddfac3-da8d-c039-92a0-d0f51dc3fea5@arm.com>
 <20200109162814.GB3702@sirena.org.uk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a40baddb-cbab-d8fc-3fd9-0582f1b5b24e@arm.com>
Date:   Thu, 9 Jan 2020 16:53:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109162814.GB3702@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 16:28, Mark Brown wrote:
> On Thu, Jan 09, 2020 at 02:14:42PM +0000, Steven Price wrote:
>> On 08/01/2020 22:52, Nicolas Boichat wrote:
> 
>>> That'd be a bit awkward to match, though... Currently all bifrost
>>> share the same compatible "arm,mali-bifrost", and it'd seem
>>> weird/wrong to match "mediatek,mt8183-mali" in this driver? I have no
>>> idea if any other Mali implementation will require a second regulator,
>>> but with the MT8183 we do need it, see below.
> 
> This doesn't sound particularly hard, just new.  Plenty of other devices
> have quirks done based on the SoC they're in or the IP revision, this
> would just be another of those quirks.
> 
>>> Well if devfreq was working (see patch 7
>>> https://patchwork.kernel.org/patch/11322851/ for a partial
>>> implementation), it would adjust both mali and sram regulators, see
>>> the OPP table in patch 2
>>> (https://patchwork.kernel.org/patch/11322825/): SRAM voltage needs to
>>> be increased for frequencies >=698Mhz.
> 
>>> Now if you have some better idea how to implement this, I'm all ears!
> 
> Set a flag based on the compatible, then base runtime decisions off
> that.
> 
>> I'm not sure if it's better, but could we just encode the list of
>> regulators into device tree. I'm a bit worried about special casing an
>> "sram" regulator given that other platforms might have a similar
>> situation but call the second regulator a different name.
> 
> Obviously the list of regulators bound on a given platform is encoded in
> the device tree but you shouldn't really be relying on that to figure
> out what to request in the driver - the driver should know what it's
> expecting. 

 From a driver perspective we don't expect to have to worry about power 
domains/multiple regulators - the hardware provides a bunch of power 
registers to turn on/off various parts of the hardware and this should 
be linked (in hardware) to a PDC which sorts it out. The GPU/PDC handles 
the required sequencing. So it *should* be a case of turn power/clocks 
on and go.

However certain integrations may have quirks such that there are 
physically multiple supplies. These are expected to all be turned on 
before using the GPU. Quite how this is best represented is something 
I'm not sure about.

> Bear in mind that getting regulator stuff wrong can result
> in physical damage to the system so it pays to be careful and to
> consider that platform integrators have a tendency to rely on things
> that just happen to work but aren't a good idea or accurate
> representations of the system.  It's certainly *possible* to do
> something like that, the information is there, but I would not in any
> way recommend doing things that way as it's likely to not be robust.
> 
> The possibility that the regulator setup may vary on other platforms
> (which I'd expect TBH) does suggest that just requesting a bunch of
> supply names optionally and hoping that we got all the ones that are
> important on a given platform is going to lead to trouble down the line.

Certainly if we miss a regulator the GPU isn't going to work properly 
(some cores won't be able to power up successfully). However at the 
moment the driver will happily do this if someone provides it with a DT 
which includes regulators that it doesn't know about. So I'm not sure 
how adding special case code for a SoC would help here.

> Steve, please fix your mail client to word wrap within paragraphs at
> something substantially less than 80 columns.  Doing this makes your
> messages much easier to read and reply to.

Sorry about that - I switched to my laptop to escape the noisy work 
going on outside the office, and apparently that was misconfigured. 
Hopefully fixed now, thanks for letting me know!

Steve
