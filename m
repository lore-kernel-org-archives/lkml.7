Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29EEC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AAC20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3oJZXWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFFN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:29:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39578 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:29:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so2441000wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dxw1uwc1ttUhPxukM95b/+WkmRUy6HuZlnKOUBJr3/c=;
        b=a3oJZXWAJ7Jk564i4pv4LsLXooK3jw9nvgPJMj/+KqslglQMY87w0YCK76MD2plRi4
         uGFxZNvJhz66Rgno3JjXEvRnQufHYQNvOmk39ezmDCuIAT73DYMz/bLMUOaGkCnCyQsg
         hbtu1Mvw/TaNeNmOc0rqrtas0uWukruGbVky4M0QI280KD7iqwta0CUbHdM9wgIsgNqm
         71fdWP/Vt/SZkcM6fmpXrl5QgOhonvginubqXbBzL5CGPn5qbWZNPW2Jcu3BiDImMCdc
         5Tg1d/ww065w0c1z3zJccWTAMJLBV7+Oh4TNfXeZ7lo0TNuyPDEEUCFlbV51EdtGVbbx
         mDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dxw1uwc1ttUhPxukM95b/+WkmRUy6HuZlnKOUBJr3/c=;
        b=OZ+OBg7zRxSI6WoSI5ye7gofOSwOVuV0NJ/LCKy/lMQrXv6zqilFsD7hmDmXhuD9O7
         iBVjZuiVrPFBzSHZLn82wuEDgackMt+Z6mGjbVJswAQsmB+OEKi0oqmIHy72l/hGogue
         7xf7I3SWeNCjDm1r9w4hB8Um0ChCILbB5yT/p46b6mh+AaPycc4KS2OGq7Js/7/A2Inu
         HBg5TDzTD8WWOjj0vhu7l+y6ZuCPcMRsIcGvAtdXSYcKBwVJtAk/blXAuAyT1j/+wZv+
         RtjN7OWPZXkWjNTxNk1pvs8edltou60Lf6cKntHliFKrOEXBJFH3ElJX9JzVVlutPa8I
         Qm9w==
X-Gm-Message-State: APjAAAV903VY98Cnq5S9501/sjbeCgp18XSibVsFOTddrymKYIRwDFtN
        XacK4ajsqxG7AcjLAFrrmXCqzA==
X-Google-Smtp-Source: APXvYqwskQjUPoFvAPLywsd8VoQs8gyuWhT1PCBf1K+2lH1FY77vhA1Gj83fJjIUMi+zYlR0aLTYUw==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr28645752wru.326.1559827787007;
        Thu, 06 Jun 2019 06:29:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z14sm1799294wrh.86.2019.06.06.06.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:29:46 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] ASoC: msm8916-wcd-digital: Add sidetone
 support
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20190606124242.12941-1-srinivas.kandagatla@linaro.org>
 <20190606152402.2d310b7d@xxx>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <446dd43c-c47e-c7a3-bcef-33241f41e4b0@linaro.org>
Date:   Thu, 6 Jun 2019 14:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606152402.2d310b7d@xxx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2019 14:24, Amadeusz Sławiński wrote:
>> +	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume",
>> LPASS_CDC_IIR1_GAIN_B1_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume",
>> LPASS_CDC_IIR1_GAIN_B2_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume",
>> LPASS_CDC_IIR1_GAIN_B3_CTL,
>> +			0,  -84, 40, digital_gain),
>> +	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume",
>> LPASS_CDC_IIR1_GAIN_B4_CTL,
>> +			0,  -84,	40, digital_gain),
> There seems to be some alignment issue in above line.
> And while I'm commenting this place, there is only 4 Volume controls,
> while there is 5 switches for IIR1 and IIR2, is this right?
> 

Each IIR Filter is 5 Stage, and IIR block is feed with 4 inputs, these 
volumes above refers to each input path.


Thanks,
srini
>> +	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume",
>> LPASS_CDC_IIR2_GAIN_B1_CTL,
