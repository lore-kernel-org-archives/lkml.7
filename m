Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E50C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F9920989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sK17qvKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEILXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:23:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32918 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEILXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:23:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so2544472wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QbQVmm5kTPfjwTeheDAImVCSFxDl7nBIwz2lP0tNHF0=;
        b=sK17qvKkXDx4s64pSQNjCngs9OQU52XPrp+gxv4lRk3v8d4mOoIZXVq3Vaarimmlrq
         AOD/w2G5QKINRXCfKMncOcuBu/q+Cx7MK8g1DqFrjzhCh5eewnzXQMzfhaV4xNP4bwY3
         WwjWuxkzk5zDCsy28TQg2hOJ76iS5oHwuDZC8ikEPHdBxtDDJaxQ2P0CGB1wq+M7SEdE
         4WskH5xwUQp3d2G+zChI3dgbcQzbaM57PIGQr1CXrzR9huJ/bYOp3pVa0wWdw0scY7ru
         5KI0u1/3rjHfExx162bvTfZxXt2MX6IGmHkQbVg5TUqG7Z2QHOhNvX+rxJ2zYew8k0Ja
         fChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QbQVmm5kTPfjwTeheDAImVCSFxDl7nBIwz2lP0tNHF0=;
        b=S4Ppzm/Nzt0nVx5gYjM4/nljaCAy9gJ+Vv0xiKJ6Bji4oFA/LVH7HGOqDW4trZA7Cd
         IUyxWZtYmjamvd9vt7eIm7p6Yuk+MYQzcJEhxtoTPFFoXa3mfbkRsd8+DaJPZLftsVs7
         tyMCn7G7sGiv9Wn8Rumq1oOCQkcZkcsWpLbqsrwmt5nDE+EFXkcwTNdnzpVTKbBWBsGg
         T8Xkg261znCjNILvKRhEAlXfNGveQ4vqH0WSG5FP8H5TY5B++U8qGI6qKKS818MB161J
         p7CCQbKd/YeMZTlX/TqH6heyRnjcfD8hNH41bGgnFcMN6KdlmqU+8aqSVzvVjtEhK0JK
         nugQ==
X-Gm-Message-State: APjAAAWZzNhMV9Rm1CgRwcstZsg0Te4dO/hBuNIc1lxLNsK9pJpIhOJm
        mRcYQZRuEu/rvUv3pcqKhxxapA==
X-Google-Smtp-Source: APXvYqwjmio7MmarVn6V+z0/UE3KJNGuVdLA7K6Ckein2WdmuT9vo+z7y8Y4Yugc0VmrpR+bH8NFOw==
X-Received: by 2002:a5d:5501:: with SMTP id b1mr2534545wrv.196.1557401016591;
        Thu, 09 May 2019 04:23:36 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:379:8b00:1910:6694:7019:d3a? ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id p17sm2274853wrg.92.2019.05.09.04.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:23:35 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] pinctrl: meson: add support of
 drive-strength-microamp
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190507115726.23714-1-glaroque@baylibre.com>
 <20190507115726.23714-6-glaroque@baylibre.com>
 <CAFBinCC-wYD1ZJ8Dd6mwd=qAqi8YX0=VacjbEc-bxKrQnZvwDA@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <4e44984f-eb76-87d1-e458-506bcccf1500@baylibre.com>
Date:   Thu, 9 May 2019 13:23:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCC-wYD1ZJ8Dd6mwd=qAqi8YX0=VacjbEc-bxKrQnZvwDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi martin,


thanks for review, i will do a new series to remove err log on get_drive_strength

and integrate your comment


On 5/7/19 8:18 PM, Martin Blumenstingl wrote:
> On Tue, May 7, 2019 at 1:57 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>> drive-strength-microamp is a new feature needed for G12A SoC.
>> the default DS setting after boot is usually 500uA and it is not enough for
>> many functions. We need to be able to set the drive strength to reliably
>> enable things like MMC, I2C, etc ...
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> with the comments below addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
>> ---
>>  drivers/pinctrl/meson/pinctrl-meson.c | 102 ++++++++++++++++++++++++++
>>  drivers/pinctrl/meson/pinctrl-meson.h |  18 ++++-
>>  2 files changed, 119 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
>> index a216a7537564..3da867c13f47 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>> @@ -219,12 +219,56 @@ static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
>>         return 0;
>>  }
>>
>> +static int meson_pinconf_set_drive_strength(struct meson_pinctrl *pc,
>> +                                           unsigned int pin,
>> +                                           u16 drive_strength_ua)
>> +{
>> +       struct meson_bank *bank;
>> +       unsigned int reg, bit;
>> +       unsigned int ds_val;
> you can move ds_val to the line above
>
> [...]
>> +       if (!pc->reg_ds) {
>> +               dev_err(pc->dev, "drive-strength not supported\n");
> I'm getting this on one of my Meson8m2 boards:
> $ # cat /sys/kernel/debug/pinctrl/c1109880.pinctrl-pinctrl-meson/pinconf-pins
> ...
> [  874.748531] meson8-pinctrl c1109880.pinctrl: drive-strength not supported
> [  874.755278] meson8-pinctrl c1109880.pinctrl: drive-strength not supported
> [  874.762086] meson8-pinctrl c1109880.pinctrl: drive-strength not supported
> Pin config settings per pin
> Format: pin (name): configs
> pin 0 (GPIOX_0): input bias disabled
> pin 1 (GPIOX_1): input bias disabled
> pin 2 (GPIOX_2): input bias disabled
> ...
>
> I believe we are not supposed to complain when getting the
> drive-strength when reg_ds is absent.
> all pre-G12A SoCs don't have reg_ds, so we don't need to error-out in
> that case (because that's perfectly valid)
>
> [...]
>> +static int meson_pinconf_get_drive_strength(struct meson_pinctrl *pc,
>> +                                           unsigned int pin,
>> +                                           u16 *drive_strength_ua)
>> +{
>> +       struct meson_bank *bank;
>> +       unsigned int reg, bit;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       if (!pc->reg_ds) {
>> +               dev_err(pc->dev, "drive-strength not supported\n");
> based on your previous explanation (that you want to inform the .dts
> author that he's doing something wrong) I'm happy with this error if
> Linus W. doesn't veto this.
>
>
> Regards
> Martin


Guillaume

