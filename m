Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894DC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B269A2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPfoLkqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJ3O1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:27:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33192 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3O1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:27:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id 71so2953946qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0Vz1KDYCDT2nsHaipdZBgphD7z8UkOtZoGz67YhDtMM=;
        b=JPfoLkqBMtflePcsG2m0PMHTXAiStkOEa8LPn1smF+pru4l/wbDQztqjA/77KBu5b8
         +4+TM8gotpTQHMlqQgNgVarr6Ksgg2u76AA+c/CPubiyByGEFkoBr5/J+fDLdtW5Xc98
         x9EB/fmVJdZnaEdGdCSCY8Mp0JtRoMcMRDAofwL/xaDRcV18nSTVhzE0kDrQiLVPuMl8
         Kyv4XqSMWKENZC3EVFmg9K+7/953SfZyjKmawXRQBMCmgdT/+2UGixJM2HCgx5PBD2PN
         JB+8SsoBrgiZ8e3NJe7G5Qv6gti7JjjIby6foHIcDiQtgmEUZKDe4iVyT6S4d4l4naPe
         QkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0Vz1KDYCDT2nsHaipdZBgphD7z8UkOtZoGz67YhDtMM=;
        b=G0O3tnutFBVOtYXWQC+tb41dPM8oSXU7YXZtii6/OfcEI2Ry7MXNeEcJh434ypRFvn
         GjUYkdzfVNGoFD1j00B4bBqHNMj3Er4U/nR/mRLkwWZpWERfAJSMoLazT1FT6catn8Of
         2jDKl6di4yeQbFJLimwNZErSX00J5ezI06yhOm6SFr11qyQCj83Yxa6Pu5Zn+eq5ReeK
         yvqUsZ0ovQ1wF0D49NaXr7lwmGNhcx+QdhSiVIIuzCVTULU9y0F5BeN/LJf8xXpsrSYj
         0jDvI33jPH5OhCjCAViivRyQeHmIFV+giv4XWv8T16BriwScGl8VcS3LL7bIK/hhz52x
         wJag==
X-Gm-Message-State: APjAAAU7TZ9YL2gacqcD2y0JDjuL7yinG8jrjfnaYI2nCkKMbeHp10Zn
        ebvwz2uGlGL2uQYDfPK1BiboPmTDHPHnww==
X-Google-Smtp-Source: APXvYqy8cFexzqoRmYs3AGz0CkYOjQU34dt4clEvGmzbKsx0WtTc2MzW3Kg6ruCf0gqi2mYNZ7Ht2w==
X-Received: by 2002:a37:7943:: with SMTP id u64mr104655qkc.295.1572445665090;
        Wed, 30 Oct 2019 07:27:45 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id y33sm300083qta.18.2019.10.30.07.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:27:44 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org>
 <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
 <5DA89267.30806@linaro.org> <20191029013648.GB27045@bogus>
 <CAPDyKFpiyvGg0+bXDVCbfr+yW0SOH6DhVgAiav8ZnE8TSF6EHQ@mail.gmail.com>
 <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DB99DDE.3090308@linaro.org>
Date:   Wed, 30 Oct 2019 10:27:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On 10/29/2019 04:16 PM, Rob Herring wrote:
> On Tue, Oct 29, 2019 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 29 Oct 2019 at 02:36, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Thu, Oct 17, 2019 at 12:10:15PM -0400, Thara Gopinath wrote:
>>>> On 10/17/2019 11:43 AM, Ulf Hansson wrote:
>>>>> On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>>>>
>>>>>> Hello Ulf,
>>>>>> Thanks for the review!
>>>>>>
>>>>>> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
>>>>>>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>>>>>>
>>>>>>>> RPMh power controller hosts mx domain that can be used as thermal
>>>>>>>> warming device. Add a sub-node to specify this.
>>>>>>>>
>>>>>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>>>>>> ---
>>>>>>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>>>>>> index eb35b22..fff695d 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>>>>>> @@ -18,6 +18,16 @@ Required Properties:
>>>>>>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>>>>>>>>  various OPPs for different platforms as well as Power domain indexes
>>>>>>>>
>>>>>>>> += SUBNODES
>>>>>>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
>>>>>>>> +These are expressed as subnodes of the RPMh. The name of the node is used
>>>>>>>> +to identify the power domain and must therefor be "mx".
>>>>>>>> +
>>>>>>>> +- #cooling-cells:
>>>>>>>> +       Usage: optional
>>>>>>>> +       Value type: <u32>
>>>>>>>> +       Definition: must be 2
>>>>>>>> +
>>>>>>>
>>>>>>> Just wanted to express a minor thought about this. In general we use
>>>>>>> subnodes of PM domain providers to represent the topology of PM
>>>>>>> domains (subdomains), this is something different, which I guess is
>>>>>>> fine.
>>>>>>>
>>>>>>> I assume the #cooling-cells is here tells us this is not a PM domain
>>>>>>> provider, but a "cooling device provider"?
>>>>>> Yep.
>>>>>>>
>>>>>>> Also, I wonder if it would be fine to specify "power-domains" here,
>>>>>>> rather than using "name" as I think that is kind of awkward!?
>>>>>> Do you mean "power-domain-names" ? I am using this to match against the
>>>>>> genpd names defined in the provider driver.
>>>>>
>>>>> No. If you are using "power-domains" it means that you allow to
>>>>> describe the specifier for the provider.
>>>> Yep. But won't this look funny in DT ? The provider node will have a sub
>>>> node with a power domain referencing to itself Like below: Is this ok ?
>>>>
>>>> rpmhpd: power-controller {
>>>>                                 compatible = "qcom,sdm845-rpmhpd";
>>>>                                 #power-domain-cells = <1>;
>>>>
>>>>                       ...
>>>>                       ...
>>>>                               mx_cdev: mx {
>>>>                                         #cooling-cells = <2>;
>>>>                                         power-domains = <&rpmhpd      SDM845_MX>;
>>>>                                 };
>>>>
>>>
>>> The whole concept here seems all wrong to me. Isn't it what's in the
>>> power domain that's the cooling device. A CPU power domain is not a
>>> cooling device, the CPU is. Or we wouldn't make a clock a cooling
>>> device, but what the clock drives.
>>
>> Well, I don't think that's entirely correct description either.
>>
>> As I see it, it's really the actual PM domain (that manages voltages
>> for a power island), that needs to stay in full power state and
>> increase its voltage level, as to warm up some of the silicon. It's
>> not a regular device, but more a characteristics of how the PM domain
>> can be used.
> 
> First I've heard of Si needing warming...
Cold regions and non-closing of circuits is what I am told.
> 
> I think I'd just expect the power domain provider to know which
> domains to power on then.
I will just retain #cooling-cells in the power domain provider and let
the driver identify the actual power domains.

> 
> Rob
> 


-- 
Warm Regards
Thara
