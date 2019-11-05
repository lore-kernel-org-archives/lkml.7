Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47431C17476
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D5E21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFsnwvZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbfKEN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:27:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35951 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388963AbfKEN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:27:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so20132742wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hB3wQvRGrj1ZRhAhArvMifryRxQS5+RNbsqGlKhKgzk=;
        b=VFsnwvZSNKJMSeyhPMRpdB4ZkZ6AYmUUNRhN4Qn+9qfNHNcC6ktaTqN6hlQY8z30qG
         qlF43veqqmkNVZy9CfnyD0A8yBtPAxgvhX1uh+3IhiKA3TksGJ5bYEwJwqDUAyp6qd40
         yRDtgCQeFEhnOzGV3i/z3lUG99341c2z6YYWi7kYJ07qZt7eWSO2fWXgIlifnK0ZclNb
         mBi7qt4Tj1sUxRWtaFORfD2h4hQSbwxU+GQjWBt/F0ItPYmf3/n1RcS4QH+YKJIMMa0u
         WyWxnIrPBBJgV5MVCJsi74KqKHS/skjAwXoKuvF+MVMxXPjU7B9rzIHuFmjaw5OagwRA
         Aoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hB3wQvRGrj1ZRhAhArvMifryRxQS5+RNbsqGlKhKgzk=;
        b=aMyxCvpvqXqyF5NlGgFYJKI8jeZKvORnPqibmMNi45pYRk0Nfcr0iR1pEYgrbMoMaS
         f1NSg+0SJixPJ5UqYzJBSCcGkh81zwN4ms6Kh6ZPbP8xa1/d3QOGHxnvlVd/if8VZ4n4
         wRHfy8L27YkrWIPa1NNdek48YURdueGnli93hsJAvEG7py5waNTqcRLWkfmUv5RaaWf0
         y/3aUrYLX2eQ7aPrTMBZ+fEtjw5dc5dDf/UZfyJvOMIYKBJ0/LpQcqeU/Z/26kLaS+lf
         ARW+sozmyO3Ls/rjU2kckFaQ81a7nD475I6rUVEHrHy9Woe44dbs5D6MEaEDmc1bE4HN
         uiqw==
X-Gm-Message-State: APjAAAX8irYCpICjaSt70bsXpUFhrZWFnEUDTRU8iB+iThECB0ST2eXG
        16g+FJYHlx8fOC99H2om/k2nrg==
X-Google-Smtp-Source: APXvYqylIjqSxRwVDLHiilqgwmzoUpkTemPlTon9ahW0PhuOvXEZCINEZ4digiAahGcNH2/GlE6RAg==
X-Received: by 2002:a1c:411:: with SMTP id 17mr3955910wme.122.1572960467354;
        Tue, 05 Nov 2019 05:27:47 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m25sm995475wmi.46.2019.11.05.05.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 05:27:46 -0800 (PST)
Subject: Re: [PATCH v3 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add bindings
 for gpio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
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
 <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
 <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <502c64dd-a249-bb2c-7bc5-8c66fa66be35@linaro.org>
Date:   Tue, 5 Nov 2019 13:27:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2019 13:25, Linus Walleij wrote:
> On Mon, Nov 4, 2019 at 10:35 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org>  wrote:
> 
>> This controller just has Output enable bits, No pin control properties.
>>
>> As you suggested I can move this to drivers/gpio in next version.
> OK perfect, thanks!
> 
> NB: this probably also affects the compatible-string which contains
> "pinctrl*" right?
Yes, I will suffix it with "-gpio" instead.

thanks,
srini
