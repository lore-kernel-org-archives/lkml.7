Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B7C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C209B206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tc/PfHiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLQJ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:29:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46214 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:29:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so10429061wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=alzctH88nkGm93shdXD815TJhUtkbcFmRm1xB1d3sFA=;
        b=tc/PfHiqx1g9OhIykMghdMOuoCxnyJdDyPEmSV0knr75jcrkVRJZfKmHAYXm0FBKDs
         UYcH2/HU30rCIORaulUyRPU2g20qK1XerGUoLQvh5R/AVgf6VVEscmumSNrBSMV2Qa3h
         ra0DnMItw09nmDb4xque4pdDav7HoQeaCKg7vpm/fsrICZonkm40JYK5j0VJ6ROlMzTD
         6ow4dYP5+wQH/Q3bqg5XlisumxdsJXmQU5VlttKhl7EA0dbEVuzAeDyGnQVIBHfvwqhG
         OhKCA5abYNyJxzr33sL7Z2jL1BOIUcPqfFWI3maLedUfMIYXp9Vi1jawxUDhzqA0CaKQ
         +riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=alzctH88nkGm93shdXD815TJhUtkbcFmRm1xB1d3sFA=;
        b=a/iVwPfz8UF+mL1wXDVuDPhZA2Gy8gibDV/B0N4PM0UaTdKRuc6D2yO9PbsCQX/KIi
         406md1XMYRemTtavbAT+kkeGS92Ltsam3KTdueRoiTEAzURWMGf9QKPwQ1gzc0azWYXV
         3+7LqIa0dcxTvUMk8CwyEfuWwCs6wCB74RKcxnZEoHswobqOoz4EyeKJ1VsolMGIVdTb
         vKVB475Av4HbHjVR1WYo6Sye0Zr1MFd3Gl/ctw6AYyJhw2BRPunrbzv2shlFftRHpPXM
         INKpI1WFaFdwYAOa8rRsxZ2NEw5hTzTgYA/de+TYUr6Q4vvm4hq+sBxEugERHDAnjnpy
         cv6g==
X-Gm-Message-State: APjAAAWnsnqOqbOBsRsgPlGqzkzJFXqrCwOvP2rMX0BqSwh6wBhigTk3
        YF9INwgrSZW2S0AvHI6t5eD/zw==
X-Google-Smtp-Source: APXvYqy/DS/azJ653mUdjjacLdbuxYCf410YHUG5mlvieCYQz0Ahh9MbX5t88z0FLKKawrQe+Eanww==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr37238202wrw.346.1576574979348;
        Tue, 17 Dec 2019 01:29:39 -0800 (PST)
Received: from localhost (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id q8sm2258746wmq.3.2019.12.17.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 01:29:38 -0800 (PST)
References: <20191206074052.15557-1-jian.hu@amlogic.com> <20191206074052.15557-3-jian.hu@amlogic.com> <1j8snhluhg.fsf@starbuckisacylon.baylibre.com> <741284be-2ae8-1102-22bc-c510e822c883@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/6] clk: meson: add support for A1 PLL clock ops
In-reply-to: <741284be-2ae8-1102-22bc-c510e822c883@amlogic.com>
Date:   Tue, 17 Dec 2019 10:29:37 +0100
Message-ID: <1jk16vb8qm.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 17 Dec 2019 at 09:41, Jian Hu <jian.hu@amlogic.com> wrote:

> On 2019/12/12 18:16, Jerome Brunet wrote:
>>
>> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
>>
>>> The A1 PLL design is different with previous SoCs. The PLL
>>> internal analog modules Power-on sequence is different
>>> with previous, and thus requires a strict register sequence to
>>> enable the PLL.
>>>
>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
>>>   drivers/clk/meson/clk-pll.h |  1 +
>>>   drivers/clk/meson/parm.h    |  1 +
>>>   3 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>> index ddb1e5634739..4aff31a51589 100644
>>> --- a/drivers/clk/meson/clk-pll.c
>>> +++ b/drivers/clk/meson/clk-pll.c
>>> @@ -318,6 +318,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>>   	struct clk_regmap *clk =3D to_clk_regmap(hw);
>>>   	struct meson_clk_pll_data *pll =3D meson_clk_pll_data(clk);
>>>   +	/*
>>> +	 * The A1 design is different with previous SoCs.The PLL
>>> +	 * internal analog modules Power-on sequence is different with
>>> +	 * previous, and thus requires a strict register sequence to
>>> +	 * enable the PLL.
>>
>> The code does something more, not completly different. This comment is
>> not aligned with what the code does
> ok, I will correct the comment.
>>
>>> +	 */
>>> +	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>>> +		/* Enable the pll */
>>> +		meson_parm_write(clk->map, &pll->en, 1);
>>> +		udelay(10);
>>> +		/* Enable the pll self-adaption module current */
>>> +		meson_parm_write(clk->map, &pll->current_en, 1);
>>> +		udelay(40);
>>> +		meson_parm_write(clk->map, &pll->rst, 1);
>>> +		meson_parm_write(clk->map, &pll->rst, 0);
>>
>> Here you enable the PLL and self adaptation module then reset the PLL.
>> However:
>> #1 when you enter this function, the PLL should already by in reset
>> and disabled
>> #2 the code after that will reset the PLL again
> For A1 PLLs, There is no reset bit, It will not reset the PLL.
> And in V2, you mentioned PARM 'rst' can be used for one toggling, And 'rs=
t'
> is used for BIT(6) in CTRL2.
>

oh my ! What is it then ? Why do you need to toggle it ? What does is do ?

> Quote V2 the HIFI PLL init_regs definition=EF=BC=9A
>
>
> +static const struct reg_sequence a1_hifi_init_regs[] =3D {
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL1, .def =3D 0x01800000 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001100 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL3, .def =3D 0x100a1100 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL4, .def =3D 0x00302000 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x01f18440 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x11f18440, .delay_us =3D 10=
 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x15f18440, .delay_us =3D 40=
 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001140 },
> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001100 },
> +};
>
> So maybe another new PARM should be defined to avoid the ambiguity.
> What do you think about it?

This is not the point of my comment Jian !

I'm assuming here that you have tested your v4 before sending and that
it work (hopefully)

The fact is that with this code, when disabled the bit behind rst
(whatever it is) is set. So when you get to enable the bit is already set.
The code you sent does the same as the snip I gave you in the reply.

Now, if your PLL is THAT different, maybe it would be best if you could
clearly explain how it works, what bit should be set and why. Then we
will be able to figure out how the driver has to be restructured.

>
>>
>> So if what you submited works, inserting the following should accomplish
>> the same thing:
>>
>> ---8<---
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index 489092dde3a6..9b38df0a7682 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -330,6 +330,13 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>          /* Enable the pll */
>>          meson_parm_write(clk->map, &pll->en, 1);
>>
>> +       if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>> +               udelay(10);
>> +               /* Enable the pll self-adaption module current */
>> +               meson_parm_write(clk->map, &pll->current_en, 1);
>> +               udelay(40);
>> +       }
>> +
>>          /* Take the pll out reset */
>>          meson_parm_write(clk->map, &pll->rst, 0);
>> --->8---
>>
>>
>>
>>
>>> +	}
>>> +
>>>   	/* do nothing if the PLL is already enabled */
>>>   	if (clk_hw_is_enabled(hw))
>>>   		return 0;
>>
>> In any case, nothing should be done on the clock before this check
>> otherwise you might just break the clock
>>
> OK, I will put the enabled check ahead.
>>> @@ -347,6 +364,10 @@ static void meson_clk_pll_disable(struct clk_hw *h=
w)
>>>     	/* Disable the pll */
>>>   	meson_parm_write(clk->map, &pll->en, 0);
>>> +
>>> +	/* Disable PLL internal self-adaption module current */
>>> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
>>> +		meson_parm_write(clk->map, &pll->current_en, 0);
>>>   }
>>>     static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long
>>> rate,
>>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>>> index 367efd0f6410..30f039242a65 100644
>>> --- a/drivers/clk/meson/clk-pll.h
>>> +++ b/drivers/clk/meson/clk-pll.h
>>> @@ -36,6 +36,7 @@ struct meson_clk_pll_data {
>>>   	struct parm frac;
>>>   	struct parm l;
>>>   	struct parm rst;
>>> +	struct parm current_en;
>>>   	const struct reg_sequence *init_regs;
>>>   	unsigned int init_count;
>>>   	const struct pll_params_table *table;
>>> diff --git a/drivers/clk/meson/parm.h b/drivers/clk/meson/parm.h
>>> index 3c9ef1b505ce..c53fb26577e3 100644
>>> --- a/drivers/clk/meson/parm.h
>>> +++ b/drivers/clk/meson/parm.h
>>> @@ -20,6 +20,7 @@
>>>   	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
>>>     #define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
>>> +#define MESON_PARM_CURRENT(p)			(!!((p)->width))
>>
>> Why do we need that ?
> OK, I will remove it ,and use 'MESON_PARM_APPLICABLE' instead
>>
>>>     struct parm {
>>>   	u16	reg_off;
>>
>> .
>>

