Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D1E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx0cD3Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390526AbfIJJkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:40:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390464AbfIJJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:40:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so18743606wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EvP8VdxeT9t7tUbL1sbXB8asiywFNGNg64KnWS1MW/8=;
        b=fx0cD3Czv3GdpUUuYPp8ntM67i13itk37NvtRJvN4QUDr74dVJQzoFDI6jObe83B2p
         +xPRvHOBSpaAtVL/8EFOyh50dU/ZcJynrU9uOQ0SkeNptDHZiG358g1piSuPRlDvYWBy
         B0sfIlpHaNuMgI+SJNMlf9b/gXmKDsAmYnuHdMT9AcLSTLGwDNMElACI033BYcb+hNwi
         gQVUUqkrVhVIMJYBBH3BssIO+BYkycqFOPvLMJJCJXXbQOYDibf57tU1dO+KBstRXdKd
         xh57B7axtmBptTvINYVJJTa6KcWb3bdwuwnioxfdRBTnEgp1WcSeA7BY4upJEuMHHfzq
         vgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvP8VdxeT9t7tUbL1sbXB8asiywFNGNg64KnWS1MW/8=;
        b=ZWRBcY6tex9XOgaJm6qHbGvAFpdJ0iMkI/ayPhE9LNl14e76kDcvyYH3U5Z1A+ij/B
         xqdFUkoBitsw/W5IK4c1/ShbigbsT3mSfivN6+RLwn6n3Kd4ILhnO/XbKa57T2/zYpmS
         GGatkFwg3mJ4npRyfWTi5avb2UtOqk1ZITFilMibDd6lIU6Qu/LIYHwQsG+1sstIBZMO
         Ur3GwkOaU+kZi8tC2Dn3w6MRY6YkFB5a99bxb9yKkuodLJY7XNan+f9KLh1KfJouWbCC
         vbC8NqJMgl4KpX24+FJklGeennxPiu9BopuS2A+8a9xSGDLEcThOpPOo9J9n2t88O9BQ
         RwKQ==
X-Gm-Message-State: APjAAAU8Zirs4P3hP4M0nEyLueQ/oNOSpKNVPRC11ygUK3Fd7OG0Z10u
        OIHsbZm2ltxXtjc+SSW43g5CK3Re4J8=
X-Google-Smtp-Source: APXvYqx6YTkbYPaK6pXh6rsNKD+uabJDnvaSqoeCBw1zGtpV0kynKpKx+Y2SZ/kl5pfRwPYHEAMhxg==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr24899704wrx.192.1568108436046;
        Tue, 10 Sep 2019 02:40:36 -0700 (PDT)
Received: from [192.168.1.6] (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id r9sm30444286wra.19.2019.09.10.02.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:40:35 -0700 (PDT)
Subject: Re: [PATCH 2/5] clk: qcom: apcs-msm8916: get parent clock names from
 DT
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
 <20190826164510.6425-2-jorge.ramirez-ortiz@linaro.org>
 <20190909102117.245112089F@mail.kernel.org> <20190909141740.GA23964@igloo>
 <20190909161704.07FAE20640@mail.kernel.org> <20190909165408.GC23964@igloo>
 <20190910091437.CCA78208E4@mail.kernel.org>
 <fcac3f60-6a96-b3ee-f734-a03636fbbee4@linaro.org>
Message-ID: <3517a1e0-6092-362f-f696-fcc1528ce026@linaro.org>
Date:   Tue, 10 Sep 2019 11:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fcac3f60-6a96-b3ee-f734-a03636fbbee4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 11:34, Jorge Ramirez wrote:
> On 9/10/19 11:14, Stephen Boyd wrote:
>> Quoting Jorge Ramirez-Ortiz, Linaro (2019-09-09 09:54:08)
>>> On 09/09/19 09:17:03, Stephen Boyd wrote:
>>>> But now the binding is different for the same compatible. I'd prefer we
>>>> keep using devm_clk_get() and use a device pointer here and reorder the
>>>> map and parent arrays instead. The clocks property shouldn't change in a
>>>> way that isn't "additive" so that we maintain backwards compatibility.
>>>>
>>>
>>> but the backwards compatibility is fully maintained - that is the main reason
>>> behind the change. the new stuff is that  instead of hardcoding the
>>> names in the source - like it is being done on the msm8916- we provide
>>> the clocks in the dts node (a cleaner approach with the obvious
>>> benefit of allowing new users to be added without having to modify the
>>> sources).
>>>
>>
>> This is not a backwards compatible change.
>>
>>>>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>>>> @@ -429,7 +429,8 @@
>>>>>      compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>>>>>      reg = <0xb011000 0x1000>;
>>>>>      #mbox-cells = <1>;
>>>>> -                   clocks = <&a53pll>;
>>>>> +                 clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
>>>>> +                 clock-names = "aux", "pll";
>>>>>                       #clock-cells = <0>;
>>>>>                };
>>>>>                                                                                                                 
>>
>> Because the "clocks" property changed from
>>
>> 	<&a53pll>
>>
>> to
>>
>> 	<&gcc GPLL0_VOTE>, <&a53pll>
>>
>> and that moves pll to cell 1 instead of cell 0.
>>
>>
> 
> what do you mean by backwards compatible? because this change does not
> break previous clients.

as per the comments I added to the code (in case this helps framing the
discussion)

[..]
legacy bindings only defined the pll parent clock (index = 0) with no
name; when both of the parents are specified in the bindings, the
pll is the second one (index = 1).
[..]



> 
> 
> 
> 
> 
> 
> 

