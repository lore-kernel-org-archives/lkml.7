Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A0C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFF921479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FULFs+pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfEVH6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:58:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46301 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEVH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:58:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so1085592wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GHAkYeVRW/vlbv+4Giq061DHjtEKlGHH98fC8Hd4T6c=;
        b=FULFs+pjbx8CFx/gQAp0W7KZGUi3h9Q9BAqvA+O8BsbxrKAoPipjzIsl5qN/Mvmsl1
         1dcxuUcoyUPPlrtZUbZxbCGzGfZf2ykIrGOgIWevqEZsuXquAc0YsBYzHo+EoqarUIpF
         hLZxyXRLNLrVkakJWYy4AhsRVZYNRpGVVj8v8QvRMLUh9yqkFU0yyKZYd0+uJgfyV1Wq
         3vtsQc0v4uTr1Gf6jsJ3oihSLhidlk89CfvtWC/MxEt/WS9vWJgd6v4z06eCWEuNtJNx
         xwQ7yZY51PS/D2u+QSrKK1Lvap/2EI68WciYN4ol9b/0/m0VYWyLZYaK3LXgouijZ1uW
         GpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GHAkYeVRW/vlbv+4Giq061DHjtEKlGHH98fC8Hd4T6c=;
        b=OtTpztuDTmCdaepNa3jYu6B/JUApoSMfFFNBQaIMHyGR2NStP9sx9n7hHW3IrpAyu1
         nN7TLgEZ/Fkei+LHHgkaeJ5qMeuT+1sA5KFDMU/xz8U0bMAMr2pQUI9ISeBF16lFFbXT
         v68GWB2asuHKgVmtLN66/ql7T+QWkKP9kdSdSLyTpLa/OKrIJWCdnMzDoMeUMkxADcIe
         Dc3UHfIt0FBZQfky8sWl7H3LqqFIRFbpq1kKc2kwrnzJWva/2+ae6DKYr9NGN2vxNTmR
         uHBh3lEwhx7uJ6QVapH/3rHSws+3JU6CovdzB5CGmY2vbt+WGT+jvb8njUcT4Rm3vdta
         Pitw==
X-Gm-Message-State: APjAAAUKihBi0UtFE4VJQK2SsZimNP3PqlifG6XLVez2J8V7F3oGVaTY
        RXJfPiYI8RNe9w5NGY0Ws6a2Xw==
X-Google-Smtp-Source: APXvYqyckrgKV1n38zckZ+etnJoUTm0gV39Y0P7uWUcumPygS8i6kzuWmgBBnPrHoFM5KYDd+RZoiw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr44779541wrj.182.1558511880004;
        Wed, 22 May 2019 00:58:00 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id y16sm7339220wru.28.2019.05.22.00.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 00:57:59 -0700 (PDT)
Subject: Re: [PATCH 2/3] clk: meson: g12a: Add support for G12B CPUB clocks
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190521150130.31684-1-narmstrong@baylibre.com>
 <20190521150130.31684-3-narmstrong@baylibre.com>
 <CAFBinCB+DD=hssuswV6M4i1Buv7bs0-6TfPTRVdUrhaprLMb0w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <469affe7-c049-8726-a242-2a003370f952@baylibre.com>
Date:   Wed, 22 May 2019 09:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB+DD=hssuswV6M4i1Buv7bs0-6TfPTRVdUrhaprLMb0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 19:49, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, May 21, 2019 at 5:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Update the Meson G12A Clock driver to support the Amlogic G12B SoC.
>>
>> G12B clock driver is very close, the main differences are :
>> - the clock tree is duplicated for the both clusters, and the
>>   SYS_PLL are swapped between the clusters
>> - G12A has additional clocks like for CSI an other components
> should this also be G12B?

Indeed, another leftover from previous patchset...

> 
> [...]
>> +static struct clk_regmap g12b_cpub_clk_apb_div = {
> if you also think that it's worth it then please add a comment stating
> that this is called "PCLK_mux" in the datasheet
> same goes for the ATB and AXI clocks below as the naming in the driver
> and datasheet differs
> 
>> +       .data = &(struct clk_regmap_div_data){
>> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
>> +               .shift = 3,
>> +               .width = 3,
>> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "cpub_clk_apb_div",
>> +               .ops = &clk_regmap_divider_ro_ops,
>> +               .parent_names = (const char *[]){ "cpub_clk" },
>> +               .num_parents = 1,
>> +       },
>> +};
> I'm assuming you checked that this is really a power of two divider,
> on the Meson8/8b/8m2 SoCs this is a mux between div[2..8]
> (the same goes for the ATB, AXI and trace div clocks below)

Indeed it's not a power of 2 here, it's mux between div[2..8]

I'll also need to update the first cluster aswell...

> 
>> +
>> +static struct clk_regmap g12b_cpub_clk_apb = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
>> +               .bit_idx = 16,
> the public S922X datasheet calls this "PCLK_dis", does this mean you
> need a flag here?
>   .flags = CLK_GATE_SET_TO_DISABLE,

The first cluster register has some description, but with the same
fields naming :
APB_CLK_DIS: set to 1 to manually disable the APB clock...

So you are right, I'll also fix the first cluster clocks.

> 
> [...]
>> +static struct clk_regmap g12b_cpub_clk_atb = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
>> +               .bit_idx = 17,
> the public S922X datasheet calls this "ATCLK_clk_dis", does this mean
> you need a flag here?
>   .flags = CLK_GATE_SET_TO_DISABLE,

Exact

> 
> [...]
>> +static struct clk_regmap g12b_cpub_clk_axi = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
>> +               .bit_idx = 18,
> the public S922X datasheet calls this "ACLKM_clk_dis", does this mean
> you need a flag here?
>   .flags = CLK_GATE_SET_TO_DISABLE,

Exact

> 
> [...]
>> +static struct clk_regmap g12b_cpub_clk_trace = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
>> +               .bit_idx = 23,
> the public S922X datasheet calls this "Trace_clk_dis", does this mean
> you need a flag here?
>   .flags = CLK_GATE_SET_TO_DISABLE,

Exact

Thanks for the review !

Neil

> 
> 
> Regards
> Martin
> 

