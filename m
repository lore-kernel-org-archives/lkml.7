Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2FB208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgAIOOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:14:48 -0500
Received: from foss.arm.com ([217.140.110.172]:59928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbgAIOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:14:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D33C81FB;
        Thu,  9 Jan 2020 06:14:46 -0800 (PST)
Received: from [10.1.27.38] (unknown [10.1.27.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254C93F534;
        Thu,  9 Jan 2020 06:14:43 -0800 (PST)
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
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
From:   Steven Price <steven.price@arm.com>
Message-ID: <09ddfac3-da8d-c039-92a0-d0f51dc3fea5@arm.com>
Date:   Thu, 9 Jan 2020 14:14:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2020 22:52, Nicolas Boichat wrote:
> On Wed, Jan 8, 2020 at 9:23 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, Jan 08, 2020 at 01:23:34PM +0800, Nicolas Boichat wrote:
>>
>>> Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
>>> regulator for their SRAM, let's add support for that.
>>
>>> +     pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
>>> +     if (IS_ERR(pfdev->regulator_sram)) {
>>
>> This supply is required for the devices that need it so I'd therefore
>> expect the driver to request the supply non-optionally based on the
>> compatible string rather than just hoping that a missing regulator isn't
>> important.
> 
> That'd be a bit awkward to match, though... Currently all bifrost
> share the same compatible "arm,mali-bifrost", and it'd seem
> weird/wrong to match "mediatek,mt8183-mali" in this driver? I have no
> idea if any other Mali implementation will require a second regulator,
> but with the MT8183 we do need it, see below.
> 
>> Though I do have to wonder given the lack of any active
>> management of the supply if this is *really* part of the GPU or if it's
>> more of a SoC thing, it's not clear what exactly adding this code is
>> achieving.
> 
> Well if devfreq was working (see patch 7
> https://patchwork.kernel.org/patch/11322851/ for a partial
> implementation), it would adjust both mali and sram regulators, see
> the OPP table in patch 2
> (https://patchwork.kernel.org/patch/11322825/): SRAM voltage needs to
> be increased for frequencies >=698Mhz.
> 
> Now if you have some better idea how to implement this, I'm all ears!

I'm not sure if it's better, but could we just encode the list of regulators into device tree. I'm a bit worried about special casing an "sram" regulator given that other platforms might have a similar situation but call the second regulator a different name.

Steve

> Thanks.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

