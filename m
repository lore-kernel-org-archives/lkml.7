Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789A120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGaI5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:57:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38038 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGaI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:57:31 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hskQ5-0003o4-QJ; Wed, 31 Jul 2019 09:57:13 +0100
Subject: Re: [alsa-devel] [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Patrick Glaser <pglaser@tesla.com>,
        Rob Duncan <rduncan@tesla.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Nate Case <ncase@tesla.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
 <20190730145844.GI4264@sirena.org.uk>
 <fe11c806-2285-558c-e35c-d8f61de00784@codethink.co.uk>
 <20190731060644.yrewu2kvrlootyyl@pengutronix.de>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <820e2ea9-14a2-795c-9b78-e8f2a30afdb1@codethink.co.uk>
Date:   Wed, 31 Jul 2019 09:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731060644.yrewu2kvrlootyyl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2019 07:06, Marco Felsch wrote:
> Hi Thomas,
> 
> again sorry for jumping in..
> 

Np!

> On 19-07-30 18:26, Thomas Preston wrote:
>> On 30/07/2019 15:58, Mark Brown wrote:
>>> On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
>>>> +	case SND_SOC_BIAS_STANDBY:
>>>> +		err = regulator_enable(tda7802->enable_reg);
>>>> +		if (err < 0) {
>>>> +			dev_err(component->dev, "Could not enable.\n");
>>>> +			return err;
>>>> +		}
>>>> +		dev_dbg(component->dev, "Regulator enabled\n");
>>>> +		msleep(ENABLE_DELAY_MS);
>>>
>>> Is this delay needed by the device or is it for the regulator to ramp?
>>> If it's for the regulator to ramp then the regulator should be doing it.
>>>
>>
>> According to the datasheet the device itself takes 10ms to rise from 0V
>> after PLLen is enabled. There are additional rise times but they are
>> negligible with default capacitor configuration (which we have).
>>
>> Good to know about the regulator rising configuration though. Thanks.
> 
> Isn't it the regulator we mentioned to not use that because it is a
> GPIO?
> 

Yeah it is - I intend to switch PLLen to gpio API.
