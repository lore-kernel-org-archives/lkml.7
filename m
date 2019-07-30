Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1320651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfG3OMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:12:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48267 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfG3OMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:12:31 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsSrW-000700-Ep; Tue, 30 Jul 2019 15:12:22 +0100
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Rob Duncan <rduncan@tesla.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nate Case <ncase@tesla.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Patrick Glaser <pglaser@tesla.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
 <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
Date:   Tue, 30 Jul 2019 15:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 14:12, Marco Felsch wrote:
> Hi Charles,
> 
> sorry for jumping in..
> 
> On 19-07-30 13:27, Charles Keepax wrote:
>> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
>>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>>> Cc: Patrick Glaser <pglaser@tesla.com>
>>> Cc: Rob Duncan <rduncan@tesla.com>
>>> Cc: Nate Case <ncase@tesla.com>
>>> ---
>>>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
>>> new file mode 100644
>>> index 000000000000..f80aaf4f1ba0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
>>> @@ -0,0 +1,26 @@
>>> +ST TDA7802 audio processor
>>> +
>>> +This device supports I2C only.
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : "st,tda7802"
>>> +- reg : the I2C address of the device
>>> +- enable-supply : a regulator spec for the PLLen pin
> 
> Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
> regulator for that.
> 
> Regards,
>   Marco
> 

Hi Marco,
We have multiple amplifiers hooked up in a chain, and all the PLLens
are connected to one GPIO. So we need to use a regulator so that
i2c-TDA7802:00 doesn't turn off the PLLen which i2c-TDA7802:01 still
requires.

This is why we use a regulator. Is there GPIO support for this?

Thanks,
Thomas
