Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86EBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A1420989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L/h96bMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEILZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:25:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEILZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:25:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so97890wrl.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qu8EFyx1RYwBMH9ABcsp970ZpeO13Jjnq3l+ZsRNLGc=;
        b=L/h96bMyP4sbfcIes0jd00888NxzJqfZrZyAIQk+hnercmv4rlnZBs1Ozw0nXgpQbH
         tHIaIe7AF0o/yekpCa3uhSI2FB34IFkmRKnrx8qztyD9W0mmHcNYUirjZAwPD77Zyys+
         bQigGcpAhNAaqn3J6gMNpmrfgL1U1eQeeD83Yhy9TxLsl2b0+NhTmqawG0DwqwOEse5O
         jZoIGkE1YbXPr4nkYHLgWJml1mJokBdlmqO100AkpaQW9gHvDEvSieYlsO0s9KHtcDwo
         +V4Px+FfauqUTn3ekAcP6Er12scd77+WYDvFae8j8CqLzeIr91KXkddsIrt4xIhjYGmc
         idrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qu8EFyx1RYwBMH9ABcsp970ZpeO13Jjnq3l+ZsRNLGc=;
        b=kIvsWniziGVS1ZrUW9jKmSQ73Dc3zHdXRS4MXkuuqKoajVooPCCbqMQE6fRxCNWCo9
         vlBl+6Q5KXKDCj8ISmUW+luA+6LL6e4+TCibJ+pCyeJ654IwQwds+bmC70ZIQsrcrRd7
         u/UHp1isz7B/93GBjFjji9/0LbK9H/MkqbVUFZseXN+qV+7uNXYXMeMyqQWbnS5PCROT
         KiGdDLFIfXo/wy/3v5m0L/vhJlmIfoEt7h+afYAox8jn/XLMmAPucJb0X2In7dD1YMK7
         94CwMI9Z+gjUAUH1hDrva4lqJWKGYPHXOYDFtYmLeDmeoQefg/h4XE0cad0+1OaNlsbI
         rTUw==
X-Gm-Message-State: APjAAAUy7pcE27P8K43xc3KcpNTikyezP8YRpR+wzVBdz5dIuSlVL8OZ
        G2/WoMT+/1PS7+a3eJpqQ2puZg==
X-Google-Smtp-Source: APXvYqxkgkcwMsgvY8OwH0/UFYR9RdwILD9DhHe3pbBmYXh3YTjihk194EhuB5bpA4dK8th2VPj0zw==
X-Received: by 2002:adf:9cc8:: with SMTP id h8mr2586136wre.308.1557401135633;
        Thu, 09 May 2019 04:25:35 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:379:8b00:1910:6694:7019:d3a? ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id d6sm2079136wrp.9.2019.05.09.04.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:25:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] pinctrl: meson: Rework enable/disable bias part
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190507115726.23714-1-glaroque@baylibre.com>
 <20190507115726.23714-5-glaroque@baylibre.com>
 <CAFBinCBQSE7wh367Aa25zwtDphsx8Z_KGDTn8dcSCir6bLvq_A@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <c3246e0e-897f-4139-91da-5850a596c713@baylibre.com>
Date:   Thu, 9 May 2019 13:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBQSE7wh367Aa25zwtDphsx8Z_KGDTn8dcSCir6bLvq_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Martin,

same as previous patch i will do a new serie with your comments.


On 5/7/19 7:53 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> On Tue, May 7, 2019 at 1:57 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>> rework bias enable/disable part to prepare drive-strength integration
> if it was my patch I would add "no functional changes" at the end to
> make it explicit that this only changes the structure of the code.
>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> with the minor comments from below addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
>> ---
>>  drivers/pinctrl/meson/pinctrl-meson.c | 79 ++++++++++++++++-----------
>>  1 file changed, 48 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
>> index 96a4a72708e4..a216a7537564 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>> @@ -174,13 +174,57 @@ int meson_pmx_get_groups(struct pinctrl_dev *pcdev, unsigned selector,
>>         return 0;
>>  }
>>
>> +static int meson_pinconf_disable_bias(struct meson_pinctrl *pc,
>> +                                     unsigned int pin)
>> +{
>> +       struct meson_bank *bank;
>> +       unsigned int reg, bit = 0;
>> +       int ret;
>> +
>> +       ret = meson_get_bank(pc, pin, &bank);
>> +       if (ret)
>> +               return ret;
> add an empty line here to keep it consistent with the rest of the code
>
> [...]
>>  static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
>>                              unsigned long *configs, unsigned num_configs)
>>  {
>>         struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
>>         struct meson_bank *bank;
> bank is not read anymore (it's passed to meson_get_bank to set it, but
> then it's not read, which is probably why my compiler doesn't
> complain)
>
>>         enum pin_config_param param;
>> -       unsigned int reg, bit;
>>         int i, ret;
>>
>>         ret = meson_get_bank(pc, pin, &bank);
>> @@ -192,44 +236,17 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
>>
>>                 switch (param) {
>>                 case PIN_CONFIG_BIAS_DISABLE:
>> -                       dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
>> -
>> -                       meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
>> -                                              &bit);
>> -                       ret = regmap_update_bits(pc->reg_pullen, reg,
>> -                                                BIT(bit), 0);
>> +                       ret = meson_pinconf_disable_bias(pc, pin);
>>                         if (ret)
>>                                 return ret;
>>                         break;
>>                 case PIN_CONFIG_BIAS_PULL_UP:
>> -                       dev_dbg(pc->dev, "pin %u: enable pull-up\n", pin);
>> -
>> -                       meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
>> -                                              &reg, &bit);
>> -                       ret = regmap_update_bits(pc->reg_pullen, reg,
>> -                                                BIT(bit), BIT(bit));
>> -                       if (ret)
>> -                               return ret;
>> -
>> -                       meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
>> -                       ret = regmap_update_bits(pc->reg_pull, reg,
>> -                                                BIT(bit), BIT(bit));
>> +                       ret = meson_pinconf_enable_bias(pc, pin, 1);
> use "true" instead of "1"?
>
>>                         if (ret)
>>                                 return ret;
>>                         break;
>>                 case PIN_CONFIG_BIAS_PULL_DOWN:
>> -                       dev_dbg(pc->dev, "pin %u: enable pull-down\n", pin);
>> -
>> -                       meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
>> -                                              &reg, &bit);
>> -                       ret = regmap_update_bits(pc->reg_pullen, reg,
>> -                                                BIT(bit), BIT(bit));
>> -                       if (ret)
>> -                               return ret;
>> -
>> -                       meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
>> -                       ret = regmap_update_bits(pc->reg_pull, reg,
>> -                                                BIT(bit), 0);
>> +                       ret = meson_pinconf_enable_bias(pc, pin, 0);
> use "false" instead of "0"?
>
> one overall comment: thank you for working on this!
> in my opinion it's a good preparation step to ensure that
> meson_pinconf_set is easy to understand even if we add more
> functionality here
>
>
> Regards
> Martin


guillaume

