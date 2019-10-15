Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E346ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591A2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ha9SgCIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfJOMW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:22:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37745 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfJOMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:22:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so23599127wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bDfGVQjLwucspFf3MSlUAeaaGSMNhHbSYDBFpj+ymqQ=;
        b=ha9SgCIwrZh2MxtJXScwcMKk6Va0RXRm1tLKRoE4JY6yiwQgEzIbYwWG0rpoD+tORx
         jRKFisDpTw3E6Eht/caO/XXZotqXmx/Hp1Gvebglm16WMWdgb5gTyc+qZICe7KHXMy67
         g6/p1arXdEU83/5CuMLwO9Ua3JeFtoGFaziC2CCKVbWEszTcBVKl0W5GnC6J6D4yl39J
         PUKNGXJIlTuxS26cNZmhEBNsd26Ektr83Arl/THp2M/Xf+KJNWKCiqBMmBZ8DhPOQAhU
         BUfGekft5l5pXkNomIK9cN6WGOJa9T4Kp1juWhgDM7PGdwcbZ6g0o4SoPrjwsxXDq8DI
         byiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDfGVQjLwucspFf3MSlUAeaaGSMNhHbSYDBFpj+ymqQ=;
        b=OGHQhh/mg0zx7H40Vg2sM1UN20AR/+lpTndtge6PpkUzA4Ql/zpiCw9HWRH79U8dJj
         BEVUUoQ5OEIHA7Makyw8IVvX0R8mC1r6D1WFOQo581XpN4jPJrsIg87oRjLnVejQtf9z
         YOQmZ6HHSVrZqWWBQHcuhaL/Pm5gbMXhEqk6Nb0gQb2nVy8Ez9fwSWxDKkEFbV8QM8W2
         CA8p55wSUs/5dpxzWAFv8UPqehjBcA7SOyd9tgcB++gk4sVexjaAtwoiCmiXMR8BiO8E
         tpH6MhHOTX1XRSya9G37N9GBIotDXzsOYjAWQAfO0lNzuwQPQ6c2/7RxQ0G2tHWJzmDO
         Bu5g==
X-Gm-Message-State: APjAAAWG7KstjBHUfhwtxVdjsMcLCz1RTCpZm6yYiXTbHAOZiv/Ce+9l
        ZQfmj9E0qk9sIX/0QbKy7qhCvg==
X-Google-Smtp-Source: APXvYqw0QWG1LAvYnp2xS0NK5ksIEqdxTKAD+EuCuDvTOJZxyO2DJb/fvjjDXQBy9kl6PqYPyaH4mQ==
X-Received: by 2002:adf:fad2:: with SMTP id a18mr4206443wrs.279.1571142174186;
        Tue, 15 Oct 2019 05:22:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e18sm30040325wrv.63.2019.10.15.05.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 05:22:53 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom
 controller
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
 <20191014171241.GA24989@bogus>
 <76be1a0d-43ea-44c3-ef6c-9f9a2025c7a2@linaro.org>
 <CAL_Jsq+ZBhh2A3yLtOyReHHAET_bvM-ygBtRXeFihAxf0jvDKQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f7977140-c103-7d0d-9523-2212e1029598@linaro.org>
Date:   Tue, 15 Oct 2019 13:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ZBhh2A3yLtOyReHHAET_bvM-ygBtRXeFihAxf0jvDKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2019 12:35, Rob Herring wrote:
> On Mon, Oct 14, 2019 at 12:34 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Thanks Rob for taking time to review,
>>
>> On 14/10/2019 18:12, Rob Herring wrote:
>>> On Fri, Oct 11, 2019 at 04:44:22PM +0100, Srinivas Kandagatla wrote:
>>>> This patch adds bindings for Qualcomm soundwire controller.
>>>>
>>>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>>>> either integrated as part of WCD audio codecs via slimbus or
>>>> as part of SOC I/O.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>>>>    1 file changed, 167 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>>>
>>> Next time, do a DT schema.
>>>
>> Sure! I can do that in next version!
> 
> I meant the next binding you write, not v4. However, ...
> 
> [...]
> 
>>>> += SoundWire devices
>>>> +Each subnode of the bus represents SoundWire device attached to it.
>>>> +The properties of these nodes are defined by the individual bindings.
>>>
>>> Is there some sort of addressing that needs to be defined?
>>>
>> Thanks, Looks like I missed that here.
>>
>> it should be something like this,
>>
>> #address-cells = <2>;
>> #size-cells = <0>;
>>
>> Will add the in next version.
> 
> You need a common soundwire binding for this. You also need to define
> the format of 'reg' and unit addresses. And it needs to be a schema.
> So perhaps this binding too should be.

We already have a common SoundWire bindings in mainline for this

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml?h=v5.4-rc3

Should this binding just make a reference to it instead of duplicating 
this same info here?

--srini


> 
> Rob
> 
