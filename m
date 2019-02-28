Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F2C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2482184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q9KZ5ySq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbfB1Ofw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:35:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfB1Ofw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:35:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1SEZWFP093942;
        Thu, 28 Feb 2019 08:35:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551364532;
        bh=6Nyf+ff0HglNrT/E5oQmwk+05/6p8sCzidlDz8JDJZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q9KZ5ySq9EQzWyY14XshFc/HlJAp7CniOQnuIDHeg56YrosANW6UPKosA2DNBkONX
         QoUK7mdWNtNTZadV7xMJ8aTLdov5MzRNPZdE6731HHa1lMnTGF0ZEIpOQBazww1ynA
         sFn77qqSR3RO8PgAOdp+l5wxg7MqN74MD79J7NsA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1SEZW61008165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 08:35:32 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 28
 Feb 2019 08:35:31 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 28 Feb 2019 08:35:31 -0600
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1SEZTE4017104;
        Thu, 28 Feb 2019 08:35:30 -0600
Subject: Re: hdmi-codec: modifying params in hw_params() callback
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
 <421c1217-6ff6-6ca2-8169-db026284fb29@ti.com>
 <20190228131059.i4nffuylja5p6tjv@shell.armlinux.org.uk>
From:   Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d2fd3be9-2dc4-511d-0755-24d6949ce967@ti.com>
Date:   Thu, 28 Feb 2019 16:35:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228131059.i4nffuylja5p6tjv@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 15:10, Russell King - ARM Linux admin wrote:
> On Thu, Feb 28, 2019 at 02:54:29PM +0200, Jyri Sarha wrote:
>> On 28/02/2019 14:15, Russell King - ARM Linux admin wrote:
>>> Hi all,
>>>
>>> While looking at hdmi-codec issues, I spotted this code:
>>>
>>> static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>>>                                 struct snd_pcm_hw_params *params,
>>>                                 struct snd_soc_dai *dai)
>>> {
>>> ...
>>>         if (params_width(params) > 24)
>>>                 params->msbits = 24;
>>>
>>> params->msbits is a parameter that is negotiated and refined by
>>> libasound, and is part of the ALSA constraint system.  The "Writing an
>>> ALSA driver" documentation says about the hw_params callback:
>>>
>>> "This is called when the hardware parameter (``hw_params``) is set up
>>>  by the application, that is, once when the buffer size, the period
>>>  size, the format, etc. are defined for the pcm substream."
>>>
>>> which suggests we should only be reading the parameters, not writing
>>> to them.
>>>
>>> What's more is that the msbits is a parameter that is refined with
>>> userspace, so surely the above should be a declared constraint?
>>>
>>
>> Certainly not a constraint. While HDMI can only pass up to 24-bit per
>> sample audio the most (or at least the two I have worked with) encoders
>> can take 32-bit wide (and probably wider) samples trough i2s. So the
>> system can play 32-bit samples, just the 4 LSB is ignored.
> 
> You have not explained why "not a constraint".  From the explanation
> that Mark gave me on IRC, msbits is the number of bits that the codec
> respects, whereas the sample bits is the number of bits in the sample.
> If sample bits - msbits != 0, then that is the number of bits ignored.
> Mark basically described it as "feel free to send me more than 24 bits
> but I'm ignoring the LSBs".
> 
> If the msbits is limited to 24, then userspace gets to know about that
> limitation when negotiating with ALSA if it is a constraint.  If it
> isn't a constraint, userspace has no way to know.
> 
>> Actually there is very little difference between the case of playing
>> 32-bit stereo audio with matching i2s bclk ratio, and playing 24-bit
>> stereo audio with 64-bit bclk ratio. Especially when the 4 LSB is anyway
>> ignored like in HDMI audio case.
> 
> You mean 8 LSB throughout the above two paragraphs.
> 
>>> Digging a bit deeper, ASoC passes a private copy of the params to each
>>> codec - a copy is made, then fixups for TDM slots are applied, followed
>>> by any topology fixups by the DAI link (be_hw_params_fixup) before the
>>> codec driver's hw_params() callback is made.  Afterwards, ASoC reads
>>> back the rate, channels and physical (memory) width and stores them
>>> in the codec's DAI structure.  The msbits are not read.
>>>
>>> hdmi-codec also seems to do nothing with the msbits parameter other
>>> than the above code.
>>>
>>> So, all in all, it seems that the above code limiting msbits is
>>> redundant - nothing will read this modified value.  Can we kill it?
>>>
>>
>> It certainly looks that way, so yes. In any case struct
>> snd_soc_dai_driver .playback.sig_bits = 24 should be all that is needed.
> 
> This sets a constraint to limit msbits to 24 for any sample width
> in core ASoC code, doing exactly what you said "certainly not" to
> above.
> 
> It also means that the quoted code in hdmi-codec's hw_params() is
> redundant for another reason.
> 
> See the description of:
> snd_pcm_hw_constraint_msbits() in sound/core/pcm_lib.c,
> soc_pcm_set_msb() and soc_pcm_apply_msb() in sound/soc/soc-pcm.c.
> 
> Can you please clarify, because there seems to be some confusion.
> 

If I understand right, the only confusion here is around the term
"constraint". I did not follow that you meant in strictly alsa-term. Yes
we should set msbits pcm_lib constraint to 24 (as hdmi-codec aready
does), because HDMI interface can not deliver more than 24 bits per
sample, and any extra LSB bit will be ignored.


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
