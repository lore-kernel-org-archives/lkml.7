Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB33C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618312081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZjHJldh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390117AbfIJJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:34:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfIJJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:34:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so18699649wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1s+ZG63MAQccFl9RI5BId8EEo4YivDiX7geRRVwkm2s=;
        b=VZjHJldhG0W3JDoaKZJebBv6Nu1AnmYHqVop5+xyxHcpiFcHKhSdgyCvDLtabgiUkb
         aNZrPr+1tl2zkEnl3X0VUImt6sUHiofe+F3X5IHEHfpOytlb1OKMc9KJgJVHsWiwpBfQ
         mqHdMk0u2gQrQsxKFF8iXB3C3no8IW1ubgYLNVaytshnavnPzwBpOh1bIpmkG1fLPjR0
         cdOere/WA0hk5zOsZtPATfWVO4CrPuImlrzrs3nMsaq9nzjuGK2/3E61mIfm4Ca/dDXq
         53RNh3xlJM+xnY42EOq4e6q7174kRNQkYhVyj3oZmGOvtAKlHQR8NTbzzcXLdt9Z7bjp
         G5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1s+ZG63MAQccFl9RI5BId8EEo4YivDiX7geRRVwkm2s=;
        b=Y7oZw7MD2mweywTHc/HPGsCfnaFE/9Wozj2xw5AOE8bSSfId1CdzomU5mmVcmrMbYI
         7bQhKOgcFLxTX/537romWO1c9My8dLSt4aQs6FKNc44XAz0mtYOqtz4toFukLIGJjGgE
         inlo09xHWrpgggw00GHkl0vOKp06eLbVy8qzcsuiAKeBR21YetQIclrD3c91Kpwbr4y6
         yojAFxaLOoNEqMA9nwvL96V5aF+mJqGiDmSmffIOyTOz98kvNmcAXDy7GrIsVSJKts/y
         NLR91+/10svsRnWiaCsRoU42huYSOpSUs0DEpFinM47eXUhyTQZ+jzpEgy1CcRBr4teS
         3e0g==
X-Gm-Message-State: APjAAAVKG5H2CHaVBSPMAi9qpUEChjtVXPWF8Ve0HQKesVnfN4qHt8VL
        4PLpnOMiBDArbVZbgd7PMp274A58F8Q=
X-Google-Smtp-Source: APXvYqxJvqDDgTOUB+fbAweVs87j9YToDzCTcDRxjeiuUhtOrOlS+jia9dUzciDQe9YIL2egPmffog==
X-Received: by 2002:adf:de03:: with SMTP id b3mr23565048wrm.14.1568108087657;
        Tue, 10 Sep 2019 02:34:47 -0700 (PDT)
Received: from [192.168.1.6] (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id 74sm2332116wma.15.2019.09.10.02.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:34:47 -0700 (PDT)
Subject: Re: [PATCH 2/5] clk: qcom: apcs-msm8916: get parent clock names from
 DT
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <fcac3f60-6a96-b3ee-f734-a03636fbbee4@linaro.org>
Date:   Tue, 10 Sep 2019 11:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910091437.CCA78208E4@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 11:14, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz, Linaro (2019-09-09 09:54:08)
>> On 09/09/19 09:17:03, Stephen Boyd wrote:
>>> But now the binding is different for the same compatible. I'd prefer we
>>> keep using devm_clk_get() and use a device pointer here and reorder the
>>> map and parent arrays instead. The clocks property shouldn't change in a
>>> way that isn't "additive" so that we maintain backwards compatibility.
>>>
>>
>> but the backwards compatibility is fully maintained - that is the main reason
>> behind the change. the new stuff is that  instead of hardcoding the
>> names in the source - like it is being done on the msm8916- we provide
>> the clocks in the dts node (a cleaner approach with the obvious
>> benefit of allowing new users to be added without having to modify the
>> sources).
>>
> 
> This is not a backwards compatible change.
> 
>>>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>>> @@ -429,7 +429,8 @@
>>>>      compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>>>>      reg = <0xb011000 0x1000>;
>>>>      #mbox-cells = <1>;
>>>> -                   clocks = <&a53pll>;
>>>> +                 clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
>>>> +                 clock-names = "aux", "pll";
>>>>                       #clock-cells = <0>;
>>>>                };
>>>>                                                                                                                 
> 
> Because the "clocks" property changed from
> 
> 	<&a53pll>
> 
> to
> 
> 	<&gcc GPLL0_VOTE>, <&a53pll>
> 
> and that moves pll to cell 1 instead of cell 0.
> 
> 

what do you mean by backwards compatible? because this change does not
break previous clients.







