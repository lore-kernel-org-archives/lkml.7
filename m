Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E493C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F64D2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395099AbfHBOvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:51:19 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53233 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395080AbfHBOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:51:17 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1htYti-0008AU-Oe; Fri, 02 Aug 2019 15:51:10 +0100
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
 <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
 <20190801234241.GG5488@sirena.org.uk>
 <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
 <20190802111036.GB5387@sirena.org.uk>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <ab0a2d14-90c0-6c28-2c80-351fccd85e68@codethink.co.uk>
Date:   Fri, 2 Aug 2019 15:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802111036.GB5387@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 12:10, Mark Brown wrote:
> On Fri, Aug 02, 2019 at 09:32:17AM +0100, Thomas Preston wrote:
>> On 02/08/2019 00:42, Mark Brown wrote:
> 
>>> Yes, that's definitely doable - we've got some other drivers with
>>> similar things like calibration triggers exposed that way.
> 
>> One problem with using a kcontrol as a trigger for the turn-on diagnostic
>> is that the diagnostic routine has a "return value".
> 
> You can use a read only control for the readback, or just have it be
> triggered by overwriting the readback value.  You can cache the result.
> 

Keeping the trigger and result together like that would be better I think,
although the routine isn't supposed to run mid way through playback. If
we're mid playback the debugfs routine has to turn off AMP_ON, take the
device back to a known state, run diagnostics, then restore. Which causes
a gap in the audible sound.

>> Hm, maybe a better idea is to have the turn on diagnostic only run on
>> device probe (as its name suggests!), and print something to dmesg:
> 
>> 	modprobe tda7802 turn_on_diagnostic=1
> 
>> 	tda7802-codec i2c-TDA7802:00: Turn on diagnostic 04 04 04 04
> 
>> Kirill Marinushkin mentioned this in the first review [0], it just didn't
>> really sink in until now!
> 
> You could do that too, yeah.  Depends on what this is diagnosing and if
> that'd be useful.
> 

The diagnostic status bits describe situations such as:
- open load (no speaker connected)
- short to GND
- short to VCC
- etc

The intention is to test if all the speakers are connected. So, one might 
have a self test which runs the diagnostic and verifies it outputs:

	00 00 00 00

For example, on my test rig there is only one speaker connected. So it
reads:

	04 04 00 04

Where the second bit is "open load". So this would fail the test.

So in the kcontrol case the test would be something like:

	amixer sset "AMP1 turn on diagnostic" on
	amixer sget "AMP1 diagnostic"

And the module parameter case:

	rmmod tda7802
	modprobe tda7802 turn_on_diagnostic=1
	dmesg | grep "Turn on diagnostic 04 04 04 04"
	rmmod tda7802
	modprobe tda7802

I think the module parameter method is more appropriate for a
"Turn-on diagnostic", even though I don't really like grepping dmesg
for the result. I'll go ahead and implement that unless anyone has a
particular preference for the kcontrol-trigger.

Thanks
