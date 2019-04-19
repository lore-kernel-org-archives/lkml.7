Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682DC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B9020449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C95pXoBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDSSjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfDSSjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7138404wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeeK+4fGjrU4vqlzd/7AFedjWhtk6+BBBhN4X/Rg8U4=;
        b=C95pXoBTeNMgILGOz/upObfPozh8QiOToT2VcYXy6pLHkQ4QWgFw8SJquMo0KyWlC4
         VFlRnY3MLa4AgxPr4RaSGnD89nqb/hllMmIN7GjXRTQJbsZTvxIG+NN9jyJQ7Ody5D8Y
         7vHk2OH04ewWAjALJ4CrApkYcU/ytaHLDlAQPP2PB1nx7cw4SqPUuIOL3wBpY8xLCmT9
         qd4qU3fA4xwhnHDTH/i3LLLHCcloXE2ISgvoaxpg1dwhdFvM+at8Ej2OZa1xXctoB98k
         645QXiALZs9RnpAQLdqMR7fSxsGOrNmYOlnurnCIfpr+Ck427ORxaOOQ8HJO14tMSnwH
         nMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeeK+4fGjrU4vqlzd/7AFedjWhtk6+BBBhN4X/Rg8U4=;
        b=Kr1ypbcS6CtQBHty2NLbKR1fVfrfks7K5OL9DAIhnkNXGAM64eFGYk8dc8PgPOUFp2
         wy7jBbYF2dMtdI/Eyx7ypK3SDvInS8GVgvBTEny7wfQTofdEwuyOf5aKO898yRAQniby
         ZYX5vyvXx2dfDh2OJrnEN0ZA/wDNjRZOKj6Ez1p85KUkqj082KHrjWCFtMr0Juh6dfv/
         hXwnwnBmC4Wxuam+g03q7+9UQTcB/rrocJIR5w1MXB/Nbv2bl+7UXUGPjIau3s7tOqB6
         QpN0q5hhlLh69Q1YW9bnB5r2V7iJ/OZ1Ilv+myLSeb0aL+/QnUHuUExmCcq7x2cOJ2fI
         2kPg==
X-Gm-Message-State: APjAAAVJ81b65G7SaRaEe6d4zsNG+j9S7SU3RsJqm0wKpt2FP9NjAgqN
        IcyKkqDCpmC55zrWzo+vOq4JdQ==
X-Google-Smtp-Source: APXvYqyYpErmvuHbiIGpqBuZMRF+2JFnhUXE5ij4D9H5gW/XPOa9YjZMcVoQUUbh07NXygzuN9N1xA==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr3201071wma.91.1555694990937;
        Fri, 19 Apr 2019 10:29:50 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id c16sm7436450wme.31.2019.04.19.10.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 10:29:50 -0700 (PDT)
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <95276ca0-6896-a595-867a-184a518fa31f@linaro.org>
Date:   Fri, 19 Apr 2019 19:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190204090301.GC23441@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 10:03, Mark Brown wrote:
> On Mon, Jan 28, 2019 at 12:45:03PM +0100, Jorge Ramirez-Ortiz wrote:
> 
>> @@ -653,6 +708,10 @@ spmi_regulator_find_range(struct spmi_regulator *vreg)
>>  	range = vreg->set_points->range;
>>  	end = range + vreg->set_points->count;
>>  
>> +	/* we know we only have one range for this type */
>> +	if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
>> +		return range;
>> +
>>  	spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, &range_sel, 1);
>>  
>>  	for (; range < end; range++)
> 
> Rather than have special casing for the logical type in here it seems
> better to just provide a specific op for this logical type, you could
> always make _find_range() call into that one if you really want code
> reuse here.  You already have separate ops for this regulator type
> anyway.

sorry I dont quite understand your point.

static struct regulator_ops spmi_hfs430_ops = {
	/* always on regulators */
	.set_voltage_sel	= spmi_regulator_hfs430_set_voltage, *
	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel, *
	.get_voltage		= spmi_regulator_hfs430_get_voltage,
	.map_voltage		= spmi_regulator_common_map_voltage, *
	.list_voltage		= spmi_regulator_common_list_voltage,
	.get_mode		= spmi_regulator_hfs430_get_mode,
	.set_mode		= spmi_regulator_hfs430_set_mode,
};

find_range affects the functions above with *

You are right and I can easily adjust the private
spmi_regulator_hfs430_set_voltage. And since it is quite small I can
also _duplicate_ the common function spmi_regulator_set_voltage_time_sel
with a small change for hfs430.

But spmi_regulator_common_map_voltage ends up being a large function and
I dont see the point in replicating it to save the "if" statement above.

why cant different logical_types extend spmi_regulator_find_range(..)?

Or maybe are you saying that I should add a new interface to struct
spmi_regulator that implements priv_find_range(..) for the logical types
that dont want to use the common implementation?

But also I am not sure I see the benefits with respect to the proposed
change...


> 
>> +static unsigned int spmi_regulator_hfs430_get_mode(struct regulator_dev *rdev)
>> +{
>> +	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
>> +	u8 reg;
>> +	int ret;
>> +
>> +	ret = spmi_vreg_read(vreg, SPMI_HFS430_REG_MODE, &reg, 1);
>> +	if (ret) {
>> +		dev_err(&rdev->dev, "failed to get mode");
>> +		return ret;
>> +	}
>> +
>> +	if (reg == SPMI_HFS430_MODE_PWM)
>> +		return REGULATOR_MODE_NORMAL;
>> +
>> +	return REGULATOR_MODE_IDLE;
>> +}
> 
> I'd have expected a switch statement here, ideally flagging a warning or
> error if we get a surprising value in there.

this implementation follows what the common function
spmi_regulator_common_get_mode implements (ie, checks for a case and
defaults if that is not the one; and when defaulting,  there is no
reporting that it is actually defaulting: ie, defaulting is not being
interpreted as an error..should it?)

> 
>> +static int spmi_regulator_hfs430_set_mode(struct regulator_dev *rdev,
>> +					  unsigned int mode)
>> +{
>> +	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
>> +	u8 reg = mode == REGULATOR_MODE_NORMAL ? SPMI_HFS430_MODE_PWM :
>> +						 SPMI_HFS430_MODE_AUTO;
> 
> Please write a normal if statement (or switch statement) to help
> legibility.
> 

ok.
