Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AAA218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbfHBIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:32:26 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36593 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbfHBIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:32:25 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1htSz4-0002ns-CI; Fri, 02 Aug 2019 09:32:18 +0100
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
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
Date:   Fri, 2 Aug 2019 09:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801234241.GG5488@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 00:42, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 05:28:11PM +0100, Thomas Preston wrote:
>> On 30/07/2019 16:50, Mark Brown wrote:
> 
>>> Like I say it's not just debugfs though, there's the standard driver
>>> interface too.
> 
>> Ah right, I understand. So if we run the turn-on diagnostics routine, there's
>> nothing stopping anyone from interacting with the device in other ways.
> 
>> I guess there's no way to share that mutex with ALSA? In that case, it doesn't
>> matter if this mutex is there or not - this feature is incompatible. How
>> compatible do debugfs interfaces have to be? I was under the impression anything
>> goes. I would argue that the debugfs is better off for having the mutex so
>> that no one re-reads "diagnostic" within the 5s poll timeout.
> 
> It's not really something that's supported; like Charles says the DAPM
> mutex is exposed but if the regular controls would still be able to do
> stuff.  It is kind of a "you broke it, you fix it" thing but on the
> other hand it's better to make things safer if we can since it might not
> be obvious later on why things are broken.
> 
>> Alternatively, this diagnostic feature could be handled with an external-handler
>> kcontrol SOC_SINGLE_EXT? I'm not sure if this is an atomic interface either.
>>
>> What would be acceptable?
> 
> Yes, that's definitely doable - we've got some other drivers with
> similar things like calibration triggers exposed that way.
> 

One problem with using a kcontrol as a trigger for the turn-on diagnostic
is that the diagnostic routine has a "return value".

It goes like this:
- Bring device to low-quiescent state
- Initiate diagnostics
- Poll for diagnostics-complete bit
- Read the four channel status registers

The final read clears the status registers, so this isn't something I
can just do with regmap.

One idea I had was to initiate the turn-on diagnostics using a kcontrol,
whose handler saves the four channel status registers and an epoch in
tda7802_priv. Then this can be read from debugfs. But it seems strange
to have to turn on this control over here, then go over there and read
this value.

Hm, maybe a better idea is to have the turn on diagnostic only run on
device probe (as its name suggests!), and print something to dmesg:

	modprobe tda7802 turn_on_diagnostic=1

	tda7802-codec i2c-TDA7802:00: Turn on diagnostic 04 04 04 04

Kirill Marinushkin mentioned this in the first review [0], it just didn't
really sink in until now!

[0] https://lkml.org/lkml/2019/6/14/1344
