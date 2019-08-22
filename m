Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3730C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19D2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nxq7R1Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfHVLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:39:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfHVLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:39:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so5086014wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYxhK4tmZbhyjMnt/y1lwTBDE/zNgacAepBTpnIf8Uc=;
        b=Nxq7R1QgdvfedWqDUHsKr0WuYiavoarilWtg9TTnsXoGd6xnhfDq+pl0vQJf1JHi1v
         VSZ01SOsYm/kZYvZJBYszRfGcR3PWC3QQ+yz6tt5SdGi0YdvOkLGyvsUJEqdbLifmH8T
         vMnMWvceVNFrYynalfmfiw6nI9fSkjcxv1R3BzIefusIJb02pvRfZuOzEs+eXDNop4ap
         y8RE9QOQdcBSBxBmIvk6Kfcb+oKy4325IkloL4X3HEhGUdvAw8Od+M+1WueQIsKsXoJ4
         U+r3sPCd9ZLg/M2W0BTZunOo8iNTCKT1qHMWMsO+Rm+duWrHPdZuRBU/0tYVX+/kddR1
         +vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYxhK4tmZbhyjMnt/y1lwTBDE/zNgacAepBTpnIf8Uc=;
        b=B95GI+VIi1Y6HQHY1azVk1ZCbWecTd4euvKFZQ5Mlm5c3ZDJ6mSBYSs5kK8CGy/MS9
         9Rgvb544QAJ1S15oPoAHsL/JcNUDFgg8jFFV4B/AHsNhvqn9Iv1ZFtbgX/8y1IfUOYpW
         FNnDDAWN56utbmS84Zier7qsW8O896rx7PvoOwj6jPyVIietIwCt1IMg8nACB6bj9lvz
         d3PMexkj83NYPwovLUrbHHXRPHUGV/ePh3SQl5DFBbRNWIeMP5B2eS+hOq3fYbt46Rfl
         UbmTDiMz5Ld72y/K+WHexsnVotV5e3K/Iu25TkAa9bVO7E5OKtdhp3pa8Aw/8T6UOXm0
         uUQg==
X-Gm-Message-State: APjAAAUWdlazjmHoIwM5CkPLEpt58fHO32i6l6+hTxe4ckeHT4KdvWGm
        K2MOxr7I70UK1v89V//v5Q1gSg==
X-Google-Smtp-Source: APXvYqxRZ0KMwV1W16oEuDyxJS9Tbb96AW5nxUCH4UelQ2zLFQPZXZOPW/9+I0ic21HJIA5akDkdmQ==
X-Received: by 2002:adf:a55d:: with SMTP id j29mr4561053wrb.275.1566473970887;
        Thu, 22 Aug 2019 04:39:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d16sm35791918wrj.47.2019.08.22.04.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 04:39:30 -0700 (PDT)
Subject: Re: [PATCH] ALSA: usb-audio: Fix the mixer control range limiting
 issue
To:     Takashi Iwai <tiwai@suse.de>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Deepa Madiregama <dmadireg@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Meng Wang <mwang@codeaurora.org>
References: <20190821100225.9254-1-srinivas.kandagatla@linaro.org>
 <s5h7e7678le.wl-tiwai@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <292a1950-3f2a-0099-eb37-bad202c47c23@linaro.org>
Date:   Thu, 22 Aug 2019 12:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5h7e7678le.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/2019 18:05, Takashi Iwai wrote:
> On Wed, 21 Aug 2019 12:02:25 +0200,
> Srinivas Kandagatla wrote:
>>
>> From: Deepa Madiregama <dmadireg@codeaurora.org>
>>
>> - mixer_ctl_set() function is limiting the volume level
>>    to particular range. This results in incorrect initial
>>    volume setting for that device.
>> - In USB mixer while calculating the dBmin/dBmax values
>>    resolution factor is hardcoded to 256 which results in
>>    populating the wrong values for dBmin/dBmax.
>> - Fix is to use appropriate resolution factor while
>>    calculating the dBmin/dBmax values.
> 
> This change doesn't sound right.  Basically the values returned from
> USB-audio FEATURE UNIT or MIXER UNIT are always in 1/256 dB unit, per
> definition.  And we pass dB min/max to user-space as TLV_DB_MINMAX(),
> i.e. TLV points just both min and max, no matter what scale is.  I
> believe that the current code is correct in this regard.
> 
> So, it's either a firmware bug that gives the wrong values back, or
> the case we still don't cover, e.g. multiple RANGE values for
> UAC2/UAC3.
> 
> Please check what exactly doesn't work as expected.  Which value is
> returned from the USB-audio device and what is wrongly interpreted.
> 

Thanks for the detailed review.

I see https://www.usb.org/sites/default/files/audio10.pdf clearly 
specifies Mixer unit is always 1/256dB units.

This patch has been carried in Qcom downstream kernels for past many 
years to fix very low Initial volume setting on some USB headsets like 
Logitech S-150 USB Speakers and Nokia HS-82 USB headset.

Its highly likely that its a firmware bug!, but I will try to get it 
retested on latest kernel and collect some logs!

Thanks,
srini


> 
> thanks,
> 
> Takashi
> 
> 
>> Signed-off-by: Deepa Madiregama <dmadireg@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
>> Signed-off-by: Meng Wang <mwang@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/usb/mixer.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 5070a6a76ab3..a67448327d07 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -1248,8 +1248,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
>>   	/* USB descriptions contain the dB scale in 1/256 dB unit
>>   	 * while ALSA TLV contains in 1/100 dB unit
>>   	 */
>> -	cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 256;
>> -	cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 256;
>> +	cval->dBmin =
>> +		(convert_signed_value(cval, cval->min) * 100) / (cval->res);
>> +	cval->dBmax =
>> +		(convert_signed_value(cval, cval->max) * 100) / (cval->res);
>>   	if (cval->dBmin > cval->dBmax) {
>>   		/* something is wrong; assume it's either from/to 0dB */
>>   		if (cval->dBmin < 0)
>> -- 
>> 2.21.0
>>
