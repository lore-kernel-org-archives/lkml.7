Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C105C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519BE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSaG+QmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbfDYToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:44:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52982 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:44:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id j13so727171wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tt8mNhXexP5cg9uhSRxxyNlGYkAskhLpxbV2LkdxD6Y=;
        b=sSaG+QmXd+R5NUJEYgAPBcCi/9L6KrZYAMO6Wxet44YSiAA95Y2zEqQTRxEXLRfC90
         C6IWDFNP+CgOuQmsdeqGcTN2K5GyXiB/pypQ1gReN5z72cfK++GZN1mnJpeSl/pG4ljQ
         3bwxXykXAViZ20dfbg8o1pp4gMja6eXm2+WCyni1jTKbO61t8fKRxH+KYc2AhRiHw/+U
         SK3cvjdbDN6zT0F4ml5tyuKgVE7NS/Ia2Q04kSaeLzk3sKPpTe20TAyDZfolekf0VqOY
         1E7NKDbayBxaKKEckHgd3Z7qvcDk1nVLjyuAnjS7CQqJD4vyEbP1KaKTya5BQVgmXffe
         +Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tt8mNhXexP5cg9uhSRxxyNlGYkAskhLpxbV2LkdxD6Y=;
        b=dzknYsL7lEaIEuQCL7ZKgVivPPXJmpwZPGD01UXquulEa2qZ56PSB5riYT9futBcQ5
         KpgONhhBR2u5ZKSONLz8WsTH39nieQtU/upQm5iUuwRCy1Xsjti+wcpHSz1Anj4t3TD3
         EA8yF9kOlP+ShbxS4lD2IcjkZWx/AADCz/lqPSThf0zKuQi/hUOYsn+vMCE1zCC+j1rn
         O0DFYT0GkppUDchJyJ/Cx4C+hV7JbsvTmMeaGJTrenQzBxi6I4TkjAYXyrUP2XaG76LU
         NX4lBfE9K6WxL3Z6WskMygwn1n0eg5VCiVjyJ/j06kwg7efd8D2E0BpLIEmsKOOYHRgK
         ho6A==
X-Gm-Message-State: APjAAAUWhbz3o/S8XCZSLvt6yXfEqlUzdaKs9cH6eobd4Fvp3zbRNt+h
        j+YTcHJHfNm8OwYpbrHeKhe0gg==
X-Google-Smtp-Source: APXvYqzcZVum/kmcNgir9ebf6JLC7hJy1u6Hu0SIMy3hz2CJfGPsx1QMCpNfu+dMUIpbY3Z+gnQ8rw==
X-Received: by 2002:a1c:9691:: with SMTP id y139mr4467449wmd.64.1556221442727;
        Thu, 25 Apr 2019 12:44:02 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id g19sm21039391wmh.17.2019.04.25.12.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:44:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190204090301.GC23441@sirena.org.uk>
 <95276ca0-6896-a595-867a-184a518fa31f@linaro.org>
 <20190425183736.GF23183@sirena.org.uk>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <022b3c6a-e356-3c5a-3c46-c6edcf4f8cd5@linaro.org>
Date:   Thu, 25 Apr 2019 21:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190425183736.GF23183@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 20:37, Mark Brown wrote:
> On Fri, Apr 19, 2019 at 07:29:48PM +0200, Jorge Ramirez wrote:
>> On 2/4/19 10:03, Mark Brown wrote:
> 
>>>> +	/* we know we only have one range for this type */
>>>> +	if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
>>>> +		return range;
> 
>>> Rather than have special casing for the logical type in here it seems
>>> better to just provide a specific op for this logical type, you could
>>> always make _find_range() call into that one if you really want code
>>> reuse here.  You already have separate ops for this regulator type
>>> anyway.
> 
>> sorry I dont quite understand your point.
> 
> If you need to skip the majority of the contents of the function for
> some regulators just define a separate function for those regulators and
> give them different ops structures rather than using the same ops
> structure and handling it in the functions.

sure this is 101 as a general rule: but this is not applicable to the
situation that I described in my original note, so I dont think you read
my points.

> 
>> But also I am not sure I see the benefits with respect to the proposed
>> change...
> 
> The benefit is that the selection of which operations to use is done in
> only one place (the selection of the ops structure) rather than in
> multiple places (the selection of the ops structure and the contents of
> the operations).

all right, how do you propose that we handle
spmi_regulator_select_voltage_same_range() then?

the way I see it, if I follow your suggestion and since we are not
allowed to extend spmi_regulator_find_range(), the only options are:

1) duplicate verbatim this whole function
(spmi_regulator_select_voltage_same_range) with a minor change (this
amount of code duplication in the kernel seems rather unnecessary to me)

2) modify the struct spmi_regulator definition with a new operation that
calls a different implementation of find range (seems a massive overkill)

because both seem wrong to me, can you confirm that you are ok with one
of those two options? or if not give an alternative?

But I still would like to understand why you think it is wrong extending
spmi_regulator_find_range() to support HFS430.

Are you saying that this function should not exist for this regulator?

Sure the HFS430 doesnt use the register SPMI_COMMON_REG_VOLTAGE_RANGE
and therefore doesnt need to use it to find its range....but that doesnt
mean that the semantics of spmi_regulator_find_range are invalid.

The way I understand your concern, you seem to be assuming that
spmi_regulator_find_range means something like
spmi_regulator_find_range_from_reg_voltage but that is not the case or
if it is maybe it should be renamed.....









