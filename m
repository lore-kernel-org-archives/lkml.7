Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3966AC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172C32067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgAIGyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:54:51 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:19459 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:54:51 -0500
Received: from [10.28.39.63] (10.28.39.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 9 Jan
 2020 14:55:14 +0800
Subject: Re: [PATCH v5 2/5] clk: meson: add support for A1 PLL clock ops
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191227094606.143637-1-jian.hu@amlogic.com>
 <20191227094606.143637-3-jian.hu@amlogic.com>
 <CAFBinCC4Fgn3QQ6H-TWO_Xx+USonzMDZDyvJBfYp-_6=pmKdLQ@mail.gmail.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <ee163cd0-a05e-5147-c307-e9870535b1dd@amlogic.com>
Date:   Thu, 9 Jan 2020 14:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCC4Fgn3QQ6H-TWO_Xx+USonzMDZDyvJBfYp-_6=pmKdLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.63]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

Thanks for your review

On 2019/12/28 0:53, Martin Blumenstingl wrote:
> Hi Jian,
> 
> On Fri, Dec 27, 2019 at 10:46 AM Jian Hu <jian.hu@amlogic.com> wrote:
> [...]
>> @@ -294,9 +298,12 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
>>   {
>>          struct clk_regmap *clk = to_clk_regmap(hw);
>>          struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>> +       int ret = 0;
>>
>> -       if (meson_parm_read(clk->map, &pll->rst) ||
>> -           !meson_parm_read(clk->map, &pll->en) ||
>> +       if (MESON_PARM_APPLICABLE(&pll->rst))
>> +               ret = meson_parm_read(clk->map, &pll->rst);
>> +
>> +       if (ret || !meson_parm_read(clk->map, &pll->en) ||
>>              !meson_parm_read(clk->map, &pll->l))
>>                  return 0;
> I had to read this part twice to understand what it's doing because I
> misunderstood what "ret" is used for (I thought that some "return ret"
> is missing)
> my proposal to make it easier to read:
> ...
> if (MESON_PARM_APPLICABLE(&pll->rst) &&
>      meson_parm_read(clk->map, &pll->rst))
>    return 0;
> 
> if (!meson_parm_read(clk->map, &pll->en) ||
>      !meson_parm_read(clk->map, &pll->l))
>                   return 0;
> ...
> 
> please let me know what you think about this
I was intended to use 'ret' to store the return value of pll->rst.

If pll->rst exists, it will get it. Otherwise, the ret will be zero.

Your proposal is a good way for it. I will use it.
> 
>> @@ -321,6 +328,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>          /* do nothing if the PLL is already enabled */
>>          if (clk_hw_is_enabled(hw))
>>                  return 0;
>> +       /*
>> +        * Compared with the previous SoCs, self-adaption module current
>> +        * is newly added for A1, keep the new power-on sequence to enable the
>> +        * PLL.
>> +        */
>> +       if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>> +               /* Enable the pll */
>> +               meson_parm_write(clk->map, &pll->en, 1);
>> +               udelay(10);
>> +               /* Enable the pll self-adaption module current */
>> +               meson_parm_write(clk->map, &pll->current_en, 1);
>> +               udelay(40);
>> +               /* Enable lock detect module */
>> +               meson_parm_write(clk->map, &pll->l_detect, 1);
>> +               meson_parm_write(clk->map, &pll->l_detect, 0);
>> +               goto out;
>> +       }
> in all other functions you are skipping the pll->rst register by
> checking for MESON_PARM_APPLICABLE(&pll->rst)
> I like that because it's a pattern which is easy to follow
> 
> do you think we can make this part consistent with that?
> I'm thinking of something like this (not compile-tested and I dropped
> all comments, just so you get the idea):
It is a good idea. I will test it.
> ...
> if (MESON_PARM_APPLICABLE(&pll->rst)
>    meson_parm_write(clk->map, &pll->rst, 1);
> 
> meson_parm_write(clk->map, &pll->en, 1);
> 
> if (MESON_PARM_APPLICABLE(&pll->rst))
>    meson_parm_write(clk->map, &pll->rst, 0);
> 
> if (MESON_PARM_APPLICABLE(&pll->current_en))
>    meson_parm_write(clk->map, &pll->current_en, 1);
> 
> if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>    meson_parm_write(clk->map, &pll->l_detect, 1);
>    meson_parm_write(clk->map, &pll->l_detect, 0);
> }
> 
> if (meson_clk_pll_wait_lock(hw))
> ...
> 
> I see two (and a half) benefits here:
> - if there's a PLL with neither the pll->current_en nor the pll->rst
> registers then you get support for this implementation for free
> - the if (MESON_PARM_APPLICABLE(...)) pattern is already used in the
> driver, but only for one register (in your example when
> MESON_PARM_APPLICABLE(&pll->current_en) exists you also modify the
> pll->l_detect register, which I did not expect)
> - only counts half: no use of "goto", which in my opinion makes it
> very easy to read (just read from top to bottom, checking each "if")
> 
I see, I will verify it.
> 
> Martin
> 
> .
> 
