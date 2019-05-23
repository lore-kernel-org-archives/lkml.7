Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E2C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20142133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bckDOC8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfEWIfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:35:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:35:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so4840248wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DzzNcEdZvY/dgRt+QooOHcGS+wcrH7TNtSJ6fjMgjw=;
        b=bckDOC8aW1UZtLrmV1FChqgsvDze8PMagrhctMfI2+WlrfV8XQwchra6X2n9xx+WtE
         2EvZsnw1GafCiGr6SvL3f1MM6h8DwuCrM5cBrnkSZ+hOF3gHWU7wEJqcTgDJWACGs+sk
         tfFLlGJGBtWxejUgUczqClvodZgRtzHX2ii/WbIO89sKT1cwx27Z+2QHHHS6/5C6kRNX
         H8Ckw18twsa1ViBUOJkDpu4BQbyk8Uq+eWNhZwNLZaSB1c18YdeMpHnaFyMHM0xkK1Rn
         RNA4dZCL7w2lfmiZMEwUpXEfMxcW+QpBNd+QSOsc/zzAgfJB2GrpQ3kry2Ig5KyrckgU
         tCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DzzNcEdZvY/dgRt+QooOHcGS+wcrH7TNtSJ6fjMgjw=;
        b=uTh8nDkGT27Q8kTUQN83ErkK/VMLGMqEAEguYclHnnmBZqMvbJmZfWI8lAqQylG/va
         Y5YfutEWS8dwx7n22S/Jpchhp8E4Yt/gIyPITAPf9M8L76IJr8DEzcmP8YH6gYU/71GD
         H4zIzFcg5e1hCkBtVVTFMOUVNJWKNjRvRvevlJTrnvQnIaiOX9xqTmtLSBe4xv77MJ0w
         D9DTEbwhM5QCj+mS5fT52SBPVdfjNczS/PDL9GUBIDWimYFjxjwB2KyfbP2HcFa9vgsX
         ZVWk1MpoCYu9pTdGv/FLOVdh2Wu081yGSqPfBTyiE37ZZumluQchZIs3eEUuBbcYPThF
         PyIA==
X-Gm-Message-State: APjAAAUWDQ9F2MNFr5THZgzuKBohswXL8cpoVyZuEd76r0avF+xIrjVu
        R8f/bCQ+wOI0qZxfU2CeubLToQ==
X-Google-Smtp-Source: APXvYqy7KwRgWRQNe0kjzqirJRYMkAVBhGTypgALW8EdIb3iHPFjwUQZxo0yacdjCl5PEBpsDf8I9Q==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr11322534wmb.19.1558600548580;
        Thu, 23 May 2019 01:35:48 -0700 (PDT)
Received: from [192.168.1.116] (146.red-95-121-91.dynamicip.rima-tde.net. [95.121.91.146])
        by smtp.gmail.com with ESMTPSA id x5sm31206729wrt.72.2019.05.23.01.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 01:35:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <a3c281d5-d30e-294f-71ab-957decde2ba0@linaro.org>
 <20190502023316.GS14916@sirena.org.uk>
 <dd15d784-f2a1-78c6-3543-69bbcc1143c4@linaro.org>
 <20190503062626.GE14916@sirena.org.uk>
 <229823c4-f5d4-4821-ded1-cc046dd0bd20@linaro.org>
 <20190506043809.GL14916@sirena.org.uk>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <a89763cb-5d50-0927-7912-6ccf38ae1d66@linaro.org>
Date:   Thu, 23 May 2019 10:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190506043809.GL14916@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 06:38, Mark Brown wrote:
> On Fri, May 03, 2019 at 10:29:42AM +0200, Jorge Ramirez wrote:
>> On 5/3/19 08:26, Mark Brown wrote:
>>> On Thu, May 02, 2019 at 01:30:48PM +0200, Jorge Ramirez wrote:
> 
>>> It seems a bit of a jump to add a new driver - it's just another
>>> descriptor and ops structure isn't it?  Though as ever with the Qualcomm
>>> stuff this driver is pretty baroque which doesn't entirely help though I
>>> think it's just another regulator type which there's already some
>>> handling for.
> 
>> So how do we move this forward?
> 
>> To sum up his regulator needs to be able to bypass accesses to
>> SPMI_COMMON_REG_VOLTAGE_RANGE and provide the range in some other way
>> hence the change below
> 
>> I can't find a simpler solution than this since the function does now
>> what is supposed to do for all the regulator types supported in the driver
> 
> The assumption that you need to have this regulator use functions that
> use and provide ranges is the very thing I'm trying to get you to
> change.  It looks like these regulators just need their own
> set_voltage_sel() and get_voltage_sel() then they can use the standard
> linear range mapping functions (and pobably the set_voltage_time_sel()
> needs fixing anyway for all the other regulators).

Right, and I understand what you are asking, is just that I completely
disagree with you. But moving on.

Would you accept if I wrote a separate driver specific to pms405 or do
you want me to integrate in qcom-spmi_regulator.c?

I am asking because none of the ops will use the common functions (I
wont be reusing much code from this qcom-spmi_regulator.c file)

> 
> There's already some conditional code in the probe function for handling
> different operations for the over current protection and SAW stuff, this
> looks like it should fit in reasonably well.  Usually this would be even
> easier as probe functions are just data driven but for some reason more
> than usual of this driver's data initializaiton is done dynamically.
> 


