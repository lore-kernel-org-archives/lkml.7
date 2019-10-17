Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C885ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02620872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgGpKj4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407644AbfJQP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:28:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42902 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405767AbfJQP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:28:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so2226109qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HxxMlxSnOHFXolbR3XOteHFHB5Y0fMxkCzdRoCJf6PE=;
        b=xgGpKj4TXIiDL2Gz1GlKIH2KXJ8E6eseq0BY8b2KgfYyfK58FKJ11SlPKH8K1smi82
         L35ggCBPhbbXjWHssTvzJuk2pRSddXo67qbvFKhD+7P7wfVM9p3w003AYYu8QtKBaLJz
         2SJRD9C4OCcncGkLr7jZ2LP3TOFI8Sp+9Xk2N2oJ+ONxCVLOy74EoTgOEUOE+XXMxYRa
         ISeYQhHPojhyy3MYnhOZ0R3NAvNFbQSY0iurBuFneYei4WRR+xP9dr2kzGnCDdO6RPm7
         XLA9Vf5fWpP8i8KPY1PnpPutVSmCO3oIC/2fxPyaK+tVs2q+0oPxB5/iKp+Q8A+wOtjT
         MxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HxxMlxSnOHFXolbR3XOteHFHB5Y0fMxkCzdRoCJf6PE=;
        b=cfvIzypg6Wcd1Kf1BKCOmxTlOEPxXcSUOlc71e/0SlqKs+V54OkKbReCHjN2Gq7Ypx
         FmgNwRkzTOvM44DDi9IyR9pcneqcLjcvqzbAKhrPVZB6GwEm9g8m8WEoJ4rLCj1Ehdxw
         RGsO4bN0YUG6XsjqR41ZN9N7aEN0assAvB0zLrkJfVCSP1jHdL1Yy1s+YfS0/dAfGDW5
         jFywehU3Hw/WyiquiXTWMXxvnhMs9DlXGj71/g4waSzcubmUvGWRRDZ2Yk9u0xGjNagz
         WRatiPEJlC0jbVsKEz+g1C0rXTdxxSPyCGgIOuCqj2y5/6U7SDu5+AHdhcSGSfadcRlA
         K2IQ==
X-Gm-Message-State: APjAAAX/CdsbJ+57uGTUOqxqGWVBx7xjS74cZxLUGFGQ+0wXtQICrFYn
        E+oR40bsEq4Z5gR2/M8r47MyLZiWChx2zg==
X-Google-Smtp-Source: APXvYqyp4wRR1ov3vJ/c6kD326l229dgP5IfCEwdoMk3qpE+kXLbkjhLaTm41gj0At0tLw14+faOlw==
X-Received: by 2002:a37:98c1:: with SMTP id a184mr3628260qke.119.1571326100082;
        Thu, 17 Oct 2019 08:28:20 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q200sm1230672qke.114.2019.10.17.08.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:28:19 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
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
Message-ID: <5DA88892.5000408@linaro.org>
Date:   Thu, 17 Oct 2019 11:28:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf,
Thanks for the review!

On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> RPMh power controller hosts mx domain that can be used as thermal
>> warming device. Add a sub-node to specify this.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> index eb35b22..fff695d 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> @@ -18,6 +18,16 @@ Required Properties:
>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>>  various OPPs for different platforms as well as Power domain indexes
>>
>> += SUBNODES
>> +RPMh alsp hosts power domains that can behave as thermal warming device.
>> +These are expressed as subnodes of the RPMh. The name of the node is used
>> +to identify the power domain and must therefor be "mx".
>> +
>> +- #cooling-cells:
>> +       Usage: optional
>> +       Value type: <u32>
>> +       Definition: must be 2
>> +
> 
> Just wanted to express a minor thought about this. In general we use
> subnodes of PM domain providers to represent the topology of PM
> domains (subdomains), this is something different, which I guess is
> fine.
> 
> I assume the #cooling-cells is here tells us this is not a PM domain
> provider, but a "cooling device provider"?
Yep.
> 
> Also, I wonder if it would be fine to specify "power-domains" here,
> rather than using "name" as I think that is kind of awkward!?
Do you mean "power-domain-names" ? I am using this to match against the
genpd names defined in the provider driver.

Warm Regards
Thara

