Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1CECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B161321721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmzJINmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfJGM1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:27:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:27:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so8600159pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vo/eOLaIbA5/xys1EhkAUTChVY65F/rc67s1TRj6toM=;
        b=lmzJINmtvYtOTelPHr4Qun2GMR4udVEweNf38iCm0MkKZ/AEuIkJVu98CqLUvahfwb
         xwButHhOOdSTlk74Ca8TE3QPhxMphnKWOHfQ6idYiMgYZyJlOcqp8/YLs9MlKPQfkLFB
         9zijhJAUUS72y4LhVtG1URiFq3d8WT5kQuzQPFwdSTNG3TIdRr8+TVYkK8GQYY796hIu
         yCr+vGZYzxGGN57+ORwZPRVJHQQ2nO/HHUk+91E0ZWrbNJaTBHFuEcGeaIGD6x1+lRz+
         6dEDgRkczOh2oWYEuGBLA4KXSWGsdzqFuu5HbijpbfMvO4YChCFVu61sxf4Z7MO2+uzR
         WlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vo/eOLaIbA5/xys1EhkAUTChVY65F/rc67s1TRj6toM=;
        b=N2URpRggRSLci8TeFiC9vB8/sT0gmQocaTRfY40KCRPJp6lSETR6agNYSbx98kxwVP
         PVcSRB10/lS3o+Ab4PPCr5+Y98oceQh/o+xgluzDyBwCaqdu3BtGNNpCyrZzpHCFhVsA
         wFwjJCYDbbbol+enM3LuJiN8sWhLr6ab/FWUcRY0L7imXYF7qSjDKUJlOAF/I4JrXjhC
         tc8QZqkK1FFYQxbXRCeXqfYDxqgHp4SxYPro30ESLG6che7+T0dB+G1qqMA8IGbVvZaK
         w8UBy01P7vuuzLRxVxVTJrPM1yQtIsiYpR8OJoD8+jAkQycOl+s6yPAONd6Vvn4aaQgb
         LZ4Q==
X-Gm-Message-State: APjAAAWP+SILtjCa6zxIHRxDx+W2QJry3e+toSyHRIMV+dFx/49+Jxvj
        AyBZIkZXa6r249U/uU8wjio=
X-Google-Smtp-Source: APXvYqwVUQXMdc3IJOV7AOvEPFDOKCA7npRdo2UmZoYJdG+kd3wdkx/YIAZbMpmqSNjGnWRg90BH/Q==
X-Received: by 2002:a63:fb55:: with SMTP id w21mr30311545pgj.267.1570451273560;
        Mon, 07 Oct 2019 05:27:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f185sm18467820pfb.183.2019.10.07.05.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:27:52 -0700 (PDT)
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>
References: <20191007071610.65714-1-cychiang@chromium.org>
 <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
Date:   Mon, 7 Oct 2019 05:27:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 1:03 AM, Tzung-Bi Shih wrote:
> On Mon, Oct 7, 2019 at 3:16 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>>
>> Add an interface for other driver to query VPD value.
>> This will be used for ASoC machine driver to query calibration
>> data stored in VPD for smart amplifier speaker resistor
>> calibration.
>>
>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>> ---
>>   drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
>>   include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>   create mode 100644 include/linux/firmware/google/google_vpd.h
>>
>> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
>> index db0812263d46..71e9d2da63be 100644
>> --- a/drivers/firmware/google/vpd.c
>> +++ b/drivers/firmware/google/vpd.c
>> @@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
>>                                         info->bin_attr.size);
>>   }
>>
>> +int vpd_attribute_read_value(bool ro, const char *key,
>> +                            char **value, u32 value_len)

FWIW, I don't think the "_value" in this function name adds any value,
unless there is going to be some other read function.

The API should be documented, and state clearly that the caller must release
the returned value.

>> +{
>> +       struct vpd_attrib_info *info;
>> +       struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
>> +
>> +       list_for_each_entry(info, &sec->attribs, list) {
>> +               if (strcmp(info->key, key) == 0) {
>> +                       *value = kstrndup(info->value, value_len, GFP_KERNEL);
> 
> Value is not necessary a NULL-terminated string.
> kmalloc(info->bin_attr.size) and memcpy(...) would make the most
> sense.
> 
kmemdup() ?

> The value_len parameter makes less sense.  It seems the caller knows
> the length of the value in advance.
> Suggest to change the value_len to report the length of value.  I.e.
> *value_len = info->bin_attr.size;
>  > Also please check the return value for memory allocation-like
> functions (e.g. kstrndup, kmalloc) so that *value won't be NULL but
> the function returned 0.
> 
>> +                       return 0;
>> +               }
>> +       }
>> +       return -EINVAL;

Maybe something like -ENOENT would be more appropriate here.

>> +}
>> +EXPORT_SYMBOL(vpd_attribute_read_value);
>> +

I would suggest to use EXPORT_SYMBOL_GPL().

>>   /*
>>    * vpd_section_check_key_name()
>>    *
>> diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
>> new file mode 100644
>> index 000000000000..6f1160f28af8
>> --- /dev/null
>> +++ b/include/linux/firmware/google/google_vpd.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Google VPD interface.
>> + *
>> + * Copyright 2019 Google Inc.
>> + */
>> +
>> +/* Interface for reading VPD value on Chrome platform. */
>> +
>> +#ifndef __GOOGLE_VPD_H
>> +#define __GOOGLE_VPD_H
>> +
>> +#include <linux/types.h>
>> +
>> +int vpd_attribute_read_value(bool ro, const char *key,
>> +                            char **value, u32 value_len);
>> +
>> +#endif  /* __GOOGLE_VPD_H */
>> --
>> 2.23.0.581.g78d2f28ef7-goog
>>
> 

