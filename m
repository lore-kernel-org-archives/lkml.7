Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38844206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1nHUAjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfHVKpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:45:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32925 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfHVKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:45:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so4960920wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/DjOjyPKJGO/AF9O06K0OKutOBMRAX78D/FmEPCYTxg=;
        b=H1nHUAjLEMs4Dr3/Rfk4r8Z7hCsoI3/15V+TnydrEwdtdKJA4Vc1HidnpZVfn+XmKl
         M6c1XvAax0EAAkoyitioea/2HCCVE1kmjwMwIAjvxB+0UG4ZuBIXSXnsrp6qrNbOK2ou
         1LNkD31uLewoJA83SLRrTHR4ab5eKPpOv4kWrt3yq2GQp6I9PhIrrAOu6/f+X6Lc+lTs
         c8lUCbNH5kByi28P2a/nH0BWzQ1kPO3QIEnykizpOuAnVKmFCj3WtHqU77o7TFSxEDVn
         FaxpSJ6tRo8eAhO8WYS62HfIlPeN2EjKweqdADxmZVST0H7rSwQIlVMXXvk5ld4BtERk
         3Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/DjOjyPKJGO/AF9O06K0OKutOBMRAX78D/FmEPCYTxg=;
        b=G27dXbrKx/uDXtssfhmDVhu0uudEglxK5tz7n7BjpwS20m8R9eP8/4/E9ksezpsPxM
         UgQX/Kdt0xQr9YMk7pYPlzAFkYbZW+2eONphHUdcXujirUQ11+BRbtwM/Ogp5B/V8zyV
         EyFI4l3wQy0WtUGiLr9eOOjs2vEiV3FkSZpLUmA/lA9nBiqGIlIbiEZQ8fCc05BDeilt
         frkyOGOgEiPs4zo7Z4ys48bP+fPLh9DMSnw+KDeXO/wFvrKWJwAkPKV2aA7ZnKqaC36I
         Ld2BTf959H6QEy56QFg5ecSfhob6gZeI/rKQ1RFwTfCDoCba1xSBmq3i2LMqANeBzR8L
         z/Xw==
X-Gm-Message-State: APjAAAXZTjocGbnFhcLlBTMxjxRo25QsKiAkeR44Ye1mlipaBi2wx/zX
        nVeSyvUxdcL3A+YXMA4sle8ZRg==
X-Google-Smtp-Source: APXvYqxPje/72ek540Wsgy2FREnCYVC+6jwVQWIqUyJBEi7qym21drEX2bFUj7QhfEDtCBnjXkOH0g==
X-Received: by 2002:adf:e801:: with SMTP id o1mr47743779wrm.45.1566470750528;
        Thu, 22 Aug 2019 03:45:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f134sm5264028wmg.20.2019.08.22.03.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 03:45:49 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim
 and tdm dais
To:     Takashi Iwai <tiwai@suse.de>
Cc:     broonie@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
 <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
 <s5h7e75v7en.wl-tiwai@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
Date:   Thu, 22 Aug 2019 11:45:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5h7e75v7en.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2019 11:09, Takashi Iwai wrote:
> On Thu, 22 Aug 2019 11:56:52 +0200,
> Srinivas Kandagatla wrote:
>>
>> QDSP supports up to 384000 rates on SLIM dais and 352800 rate on TDM dais.
>> Add this missing rates.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
>>   1 file changed, 32 insertions(+), 60 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> index c1a7624eaf17..ae2baefdb6e2 100644
>> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> @@ -18,14 +18,14 @@
>>   			.stream_name = pre" TDM"#num" Playback",	\
>>   			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
>>   				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
>> -				SNDRV_PCM_RATE_176400,			\
>> +				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
> 
> This will support a lot more than advertised, e.g. it contains 64000Hz
> or 22050Hz.  Is this supposed?  If yes, mention it clearly in the
> changelog, too.

Some of the rates inbetween are not in the DSP supported rate list for TDM.

DSP should return error if we try to set any unsupported rate!

--srini
> 
> thanks,
> 
> Takashi
> 
