Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF1CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9732A21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbz46ZF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfKDJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:35:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDJfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:35:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so16154420wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/q/Jy46HAl5qDXGb5pMNUar0Ktcd+mxfRNJZDPc+0iA=;
        b=cbz46ZF4/8Y+P96GJfJgqFSAzXtlzcvpN6rYWoHc+Bc8gxO/OHCXy9vBcfZbht65VU
         cfjEYKbmRFxx8c4gfyYUwt5aF45wDHFz4Me5jgojTPUDHsJar6DdJRq1Tb5wvK89nWCx
         mJw8dvIDh0chO6vIDUmC2KucxY+vz8LaxmwiPaqqK+yw6RXFVnJzYYQAov7GqelcbGm0
         snLp2xSC+qkU8IQ4Jc3t1h87nvBIDMCQCt4RxtWiPdRSa8ibUa4AzoFq0ddXg47PRpL/
         mkHd/qFeSuq4B1l1WrRgn9gfigdbvZmzt0P5bdt2KC2q1mQ9O+nQekY19UFuTT0firaM
         U+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/q/Jy46HAl5qDXGb5pMNUar0Ktcd+mxfRNJZDPc+0iA=;
        b=fP94HeABjwowEDAqQ7kW0jiJflwBnk7Vgi4XoGM2itBwc7+okxxZh3bkpVtHD4OqJC
         9o/BbTrrkOvxut4wG2IIKRAZbA7H6kdydIzOc+4gC05G0lTMPMX0NTl8q9RI6bbKgZ0+
         TzG2GlmXkMAV2zX/cjqu5LqtSJBHmRcFp6X3ojvdO79qKmw3dy5QCClniPWzTdPmVpjx
         G9vILIWX+PrNQMrqBCPXtfvBkoSir5MtEKZoQCvRSbCPkRTLkH3+SvNFfJ6NcdfxSlC+
         CKYWNP6h27shS3AqD3g+G231SbScqnGawAjBDI1aVOOGP553+E/upx2wvxFOvxoGAlAV
         8p+w==
X-Gm-Message-State: APjAAAUvj2KH/zLaKc4vCF257RcQxenaaDLLO7gyAbxJB5UQGWA3SEB4
        WU4wDzio5xemE9UwEI7hzLLnKA==
X-Google-Smtp-Source: APXvYqxElW8oVQU4a1AD6VV1NNkiEHVf6/MACgp9Py33Zz2M9a29Io3XDGtIDAPS4xVT66PYeZxpHQ==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr21444957wri.130.1572860135741;
        Mon, 04 Nov 2019 01:35:35 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b8sm9771016wrt.39.2019.11.04.01.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 01:35:34 -0800 (PST)
Subject: Re: [PATCH v3 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add bindings
 for gpio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, vinod.koul@linaro.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-9-srinivas.kandagatla@linaro.org>
 <CACRpkdYc-3Nk7VGj8mAjaM4C0dc_X7ZOK0cptW2Sr+kKwvyFVg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
Date:   Mon, 4 Nov 2019 09:35:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYc-3Nk7VGj8mAjaM4C0dc_X7ZOK0cptW2Sr+kKwvyFVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing this!

On 03/11/2019 23:19, Linus Walleij wrote:
> On Tue, Oct 29, 2019 at 12:29 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
>> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
>> gpio controller to control 5 gpios on the chip. This patch adds
>> required device tree bindings for it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../pinctrl/qcom,wcd934x-pinctrl.yaml         | 52 +++++++++++++++++++
> 
> The bindings look OK, but remind me if I have asked before (sorry then)
> does these GPIOs expose some pin control properties and that is why
> the driver is placed under pin control rather than the GPIO namespace?
> 
I don't remember you asking about this before :-),

This controller just has Output enable bits, No pin control properties.

As you suggested I can move this to drivers/gpio in next version.

Thanks,
srini
