Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533DC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4A206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vO6giWxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfKFKIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:08:07 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45369 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKFKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:08:06 -0500
Received: by mail-wr1-f53.google.com with SMTP id q13so25008001wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RfazqxK++NUeQGibGNsb/xwtl2AjqHTLxKqC49MTjR4=;
        b=vO6giWxhl3D8Ew4bBQphqLy0x5vLotCBC10MctFCYaF30IL9VTV0hCx5csqFpfbOac
         OZ+Fne3LnI3q7YyZNNK7WVZHqdOHesj+x30hKRu+5ukVHog2AS/HmQx7UX4immTCHhGU
         HyUxdJTeevWpRa2LDfBK4du66HGutnLI35hwOza2cemUrgrV0paJ8JOBRoVL3G/iHWZw
         juCb2ZkL8PUFtj23OtQoX9s5Bm+pawpiO3+qDAf7JwrV/UoSqRv6+/pzdRko3aLKx28K
         EjmAbxeqoeGpQV9Ls40nkMIV8mcfuP7a2kuAIdaXoGPpajOc8YLylilehZiPOPu/1IVw
         eINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RfazqxK++NUeQGibGNsb/xwtl2AjqHTLxKqC49MTjR4=;
        b=gfBmWC7ScvJEQ4YhK8OQ9FvI1qe68tXSvg7ZZE8E2AgRhxodnxL0NgFupSLhuTjeQJ
         M/36doAxtMZwZbKYMvt1Jjwba7/82w0stYVEthkglnSbG00ANnkhhmcRslnjDW10nUUP
         6gvOdYiLvhZTLnmiBCTwyixXtc7HrPGtxAEkGvagGDrCCwXEr2mUh5K+0YWxROpsUTVo
         7olmBZyzOSDmsBnXsOtsQN6/HIPPBhCvnCzGmB0GFrJCQtfppn+1I13SVBImeFSs+yBJ
         8K/Zhmh2EcCeaSien9pdY0BdaW1Ls4TME2WSQZDYMtpXL6YI3nSImurxXPJLnUP0LG2i
         H0yg==
X-Gm-Message-State: APjAAAWx+O2hfB5o1A4oeEX0YK7Es84BBJxIQwvTz26sNxKafEeHI0nP
        bJ3MUJsiASOVTxDznMJhl+y4pw==
X-Google-Smtp-Source: APXvYqxLATsv0dpIOklFV3PCz8dC70Zj2vsSWYi/3P2nLGCV6B+BbAH7mLeIYbgJgVf1KaSE2F/j2A==
X-Received: by 2002:adf:b608:: with SMTP id f8mr1716914wre.99.1573034884360;
        Wed, 06 Nov 2019 02:08:04 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j3sm15897267wrs.70.2019.11.06.02.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:08:03 -0800 (PST)
Subject: Re: [PATCH v3 01/11] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-2-srinivas.kandagatla@linaro.org>
 <20191105193100.GB4709@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <315fd1f8-b6b5-5df7-604d-4ca92b31772c@linaro.org>
Date:   Wed, 6 Nov 2019 10:08:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105193100.GB4709@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2019 19:31, Rob Herring wrote:
>> +  vdd-micbias-supply:
>> +    description: A reference to the micbias supply
>> +
>> +  qcom,micbias1-microvolts:
> The standard unit is 'microvolt', not 'microvolts'.
> 
I started with microvolt but dt_bindings_check reported errors.

looking at 
https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/vendor-props.yaml#L19 
  suggested microvolts should be used on vendor properties.

Is this a typo in dt-schema ?

thanks,
--srini
