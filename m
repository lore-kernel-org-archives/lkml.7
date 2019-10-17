Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321AEFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0D721925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6pUbq9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440410AbfJQQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:10:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40732 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440007AbfJQQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:10:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so4361276qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ny/2VRd+nYPZUv6lS3IfSjlpgoq8xpi9csSapod3I6s=;
        b=l6pUbq9ZGqeQIvaa+cnqcCYOZi3/jNJwbPMtbnUlqNj5QrnM7UA5gdH8mg31AIVZw7
         xbDPlG5/P/SVpJ9MZJuRe5wCTxjXPIoTALKfEwdgVOUU2bOqWVeNWrb4KMd+gwGckI0w
         wsFgaQ19vhES8njgHStqgeVRteJmqB8m7rfbo9PPz3Ntl/JoqGDsLYq31epfCFEonk/4
         bU0kmkmCDnUxhGPOcmSg4klgOzFoTMIWpdzpvFEzAU+h0INKwg9Gz8Gj5GpjqKVf66VF
         5j+Su/AzFBvV1tpBywTqzx7NbzMKjLHaKwZuDVUyNBAPtDB8/d2ze4SAhyy+Zr4/57kn
         mtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ny/2VRd+nYPZUv6lS3IfSjlpgoq8xpi9csSapod3I6s=;
        b=XKNwAzrxWLjFnxshmbQkjErXs5KPXzDveENCqx63PzQp/zV0W7r4qJ+S/yOUHUNPRA
         FjvjxWRsZGQ5cKLIj4CrGA+AYSXMSx1H9Ajy5VKpCB0XE0qk/kZJYfpvBKRz++KfGQy4
         HbPJsJBF1NclbxCYxlOf00P8SybjnYHOoVr5uuap/0Ak1TaEqkfjmoVOuJuXUhihqk+X
         3rAmW55BlOrUEMJG6gLmW5iijozvuNNlcG4K1ciGi0zJt/Npk+li1NksnvIkcdDwsU0u
         CWa+oR0NtEbH+qSI/j9zAKT0d8QQFv06Ap9xC+biG7zI7sNnyozm6OKsquUQlKlBS8nr
         S4pw==
X-Gm-Message-State: APjAAAVyVPeN9aEVYQtIke2J4YtsoW176FzH2G0oIFiV04kA7OuhrgJA
        4Lvoe7161iBL3I01pcbrhjoxt/zuKCoh2A==
X-Google-Smtp-Source: APXvYqx7+OyfLaAXGwBd1NAptH2mQwrN3MtccpUFsF1to9AWMls4vwHB38FXDo1TgrgbkHExtFCy9A==
X-Received: by 2002:ac8:3ac6:: with SMTP id x64mr4619046qte.51.1571328618066;
        Thu, 17 Oct 2019 09:10:18 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id m15sm984714qka.104.2019.10.17.09.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 09:10:16 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org>
 <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA89267.30806@linaro.org>
Date:   Thu, 17 Oct 2019 12:10:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2019 11:43 AM, Ulf Hansson wrote:
> On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Hello Ulf,
>> Thanks for the review!
>>
>> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
>>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>>
>>>> RPMh power controller hosts mx domain that can be used as thermal
>>>> warming device. Add a sub-node to specify this.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>> index eb35b22..fff695d 100644
>>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>>>> @@ -18,6 +18,16 @@ Required Properties:
>>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>>>>  various OPPs for different platforms as well as Power domain indexes
>>>>
>>>> += SUBNODES
>>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
>>>> +These are expressed as subnodes of the RPMh. The name of the node is used
>>>> +to identify the power domain and must therefor be "mx".
>>>> +
>>>> +- #cooling-cells:
>>>> +       Usage: optional
>>>> +       Value type: <u32>
>>>> +       Definition: must be 2
>>>> +
>>>
>>> Just wanted to express a minor thought about this. In general we use
>>> subnodes of PM domain providers to represent the topology of PM
>>> domains (subdomains), this is something different, which I guess is
>>> fine.
>>>
>>> I assume the #cooling-cells is here tells us this is not a PM domain
>>> provider, but a "cooling device provider"?
>> Yep.
>>>
>>> Also, I wonder if it would be fine to specify "power-domains" here,
>>> rather than using "name" as I think that is kind of awkward!?
>> Do you mean "power-domain-names" ? I am using this to match against the
>> genpd names defined in the provider driver.
> 
> No. If you are using "power-domains" it means that you allow to
> describe the specifier for the provider.
Yep. But won't this look funny in DT ? The provider node will have a sub
node with a power domain referencing to itself Like below: Is this ok ?

rpmhpd: power-controller {
                                compatible = "qcom,sdm845-rpmhpd";
                                #power-domain-cells = <1>;

			...
			...
				mx_cdev: mx {
                                        #cooling-cells = <2>;
                                        power-domains = <&rpmhpd	SDM845_MX>;
                                };
				
> 
> From Linux point of view, it means you can use dev_pm_domain_attach()
> to hook up the corresponding device with the PM domain.

Yes. Only the thermal framework does not populate cdev->dev->of_node.
But it should be a trivial thing to fix it. Also if I end up creating a
separate device, it should not matter.
> 
> Using "power-domain-names" is just to allow to specify a name rather
> than an index, which makes sense if there is more than one index.
> Perhaps you can state that the "power-domain-names" should be there
> anyway, to be a little bit future proof if ever multiple index
> (multiple PM domains).
> 
> Kind regards
> Uffe
> 


-- 
Warm Regards
Thara
