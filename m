Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB9EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5BD2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2HWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:22:14 -0500
Received: from olimex.com ([184.105.72.32]:47448 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfK2HWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:22:13 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 23:22:04 -0800
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a64: olinuxino: Add VCC-PG
 supply
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20191126110508.15264-1-stefan@olimex.com>
 <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
 <0c1d7377-7064-f509-ffc5-bd1e8f2fbaa8@olimex.com>
 <20191128103301.vjpkvjscy45ycgwg@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <1e0509cc-4afc-d46f-84a9-5e54c60c9d7b@olimex.com>
Date:   Fri, 29 Nov 2019 09:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128103301.vjpkvjscy45ycgwg@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/19 12:33 PM, Maxime Ripard wrote:
Hi Maxime,
> Hi Stefan,
>
> On Wed, Nov 27, 2019 at 09:07:40AM +0200, Stefan Mavrodiev wrote:
>> On 11/26/19 6:27 PM, Maxime Ripard wrote:
>>> Hi Stefan,
>>>
>>> On Tue, Nov 26, 2019 at 01:05:08PM +0200, Stefan Mavrodiev wrote:
>>>> On A64-OLinuXino boards, PG9 is used for USB1 enable/disable. The
>>>> port is supplied by DLDO4, which is disabled by default. The patch
>>>> adds the regulator as vcc-pg, which is later used by the pinctrl.
>>>>
>>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>>> ---
>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>>> index 01a9a52edae4..c9d8c9c4ef20 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>>>> @@ -163,6 +163,10 @@
>>>>    	status = "okay";
>>>>    };
>>>>
>>>> +&pio {
>>>> +	vcc-pg-supply=<&reg_dldo4>;
>>> The equal sign should have spaces around it.
>>>
>>> Also, can you please list all the bank supplies while you're at it?
>> Sure. Should the supplies defined as regulators names be added also to the
>> pio node?
>> For example reg_aldo1 is named "vcc-pe".
> As far as I can tell, the A64 has regulators for PC, PD, PE, PG and
> PL, so you should list those (PL being under r_pio)

After quick check I've found a bug (maybe?). It's not possible to specify
vcc-pl-supply, because of this:

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/sunxi/pinctrl-sunxi.c#L778

During the probe of the pmu, the pinctrl tries to get a regulator, that 
doesn't exist yet.
Because of this the system doesn't start (as expected).

I've tried to ignore -EPROBE_DEFER. This seems to work, but only because 
the regulator for
PL is defined as "regulator-always-on". The problem is that the refcount 
is not incremented.
So if you export one gpio and the unexport it, the regulator will be 
disabled. I'm not sure
how this can be resolved.

Should I skip vcc-pl-supply for now and list the other bank supplies?


Stefan

>
>> Also, since the commit message will be different for better representation
>> of the changes, should I send the next
>> patch as v2 or as a new one?
> Either way works for me as long as the commit message matches the changes.
>
> Thanks!
> Maxime
