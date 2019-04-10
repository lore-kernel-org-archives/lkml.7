Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D588D218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PVaBbpvZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m1v9Chb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfDJLI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:08:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfDJLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:08:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E4010608FC; Wed, 10 Apr 2019 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554894504;
        bh=rJSENwHpVSGkmLpEeLhi96m7eZ/z3OjZPaejuZNMBSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PVaBbpvZ2MTwmjpDOBBBEnEWU/lHsyeVM+VgzUI3aWfd/gyYtLnNMyv7unLd1YwAW
         zuOzU27Ama6iJ6qNJezfDJrXS3gKZMCsS6dYHXxNpjt5k0pTQek3DjjUFFN1Gqei/n
         EsSjbz7t+lJ+ApN3Xo0OGFiMXNTJkhzRy3Gbnr/4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 656BA608FC;
        Wed, 10 Apr 2019 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554894502;
        bh=rJSENwHpVSGkmLpEeLhi96m7eZ/z3OjZPaejuZNMBSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1v9Chb43qrWaQujes6RiBSR8gWUyo68TtUDgE3nb3EyDPsK9BcVpzC8f06NLdxz4
         lU/tVxOOy/EOPQ1nVVM163n5/pxgJvZXJOAwwQb3Yb3gPGtlfDBRA/ikKeNmH/aR0s
         YAvTR9vPzfWtOeby+6FcAPVMwfgbe90oYFzVNF/w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Apr 2019 16:38:22 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH RFC 6/9] OPP: Add and export helper to update voltage
In-Reply-To: <20190410102429.r6j6brm5kspmqxc3@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-7-sibis@codeaurora.org>
 <20190410102429.r6j6brm5kspmqxc3@vireshk-i7>
Message-ID: <bccbe28d586be4304122e3fba27e7d67@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Viresh,
Thanks for the review!

On 2019-04-10 15:54, Viresh Kumar wrote:
> On 28-03-19, 20:58, Sibi Sankar wrote:
>> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
>> of an opp for a given frequency. This will be useful to update the 
>> opps
>> with voltages read back from firmware.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/opp/core.c     | 62 
>> ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_opp.h | 10 +++++++
>>  2 files changed, 72 insertions(+)
>> 
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index addaf7aae9ae..c066cd120a33 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2090,6 +2090,68 @@ int dev_pm_opp_disable(struct device *dev, 
>> unsigned long freq)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>> 
>> +static int _opp_update_voltage(struct device *dev, unsigned long 
>> freq,
>> +			       unsigned long u_volt)
>> +{
>> +	struct opp_table *opp_table;
>> +	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
>> +	int r = 0;
> 
> s/r/ret/
> 
>> +
>> +	/* Find the opp_table */
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table)) {
>> +		r = PTR_ERR(opp_table);
>> +		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
> 
> Why dev_warn instead of dev_err which is normally used in this file ? 
> And you
> weren't searching for OPP but opp_table. Put out the correct error 
> message
> please.

yeah I'll use dev_err (I'll fix the same in
_opp_set_availability too)

> 
>> +		return r;
>> +	}
>> +
>> +	mutex_lock(&opp_table->lock);
>> +
>> +	/* Do we have the frequency? */
>> +	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
>> +		if (tmp_opp->rate == freq) {
>> +			opp = tmp_opp;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (IS_ERR(opp)) {
>> +		r = PTR_ERR(opp);
>> +		goto unlock;
>> +	}
>> +
>> +	/* update only if the opp is disabled */
>> +	if (opp->available)
>> +		goto unlock;
>> +
> 
> What about reusing dev_pm_opp_find_freq_exact() instead of the above 
> code in
> this routine ?

yes I'll use that

> 
>> +	opp->supplies[0].u_volt = u_volt;
>> +
>> +unlock:
>> +	mutex_unlock(&opp_table->lock);
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +	return r;
>> +}
>> +
>> +/**
>> + * dev_pm_opp_update_voltage() - find and update voltage of an opp
>> + *				 for a given frequency
>> + * @dev:	device for which we do this operation
>> + * @freq:	OPP frequency to update voltage
>> + * @u_volt:	voltage requested for this opp
>> + *
>> + * This is useful only for devices with single power supply.
>> + *
>> + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available 
>> for the
>> + * copy operation, returns 0 if no modification was done OR 
>> modification was
>> + * successful.
>> + */
>> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
>> +			      unsigned long u_volt)
>> +{
>> +	return _opp_update_voltage(dev, freq, u_volt);
> 
> Remove the unnecessary wrapper and open code this routine here. While 
> at it, you
> should updated min/max/target and not just target voltage.

will fix this in the next-respin

> 
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
>> +
>>  /**
>>   * dev_pm_opp_register_notifier() - Register OPP notifier for the 
>> device
>>   * @dev:	Device for which notifier needs to be registered
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index d7cb0e65c4f0..58490f6839ce 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned 
>> long freq);
>> 
>>  int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>> 
>> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
>> +			      unsigned long u_volt);
>> +
>>  int dev_pm_opp_register_notifier(struct device *dev, struct 
>> notifier_block *nb);
>>  int dev_pm_opp_unregister_notifier(struct device *dev, struct 
>> notifier_block *nb);
>> 
>> @@ -265,6 +268,13 @@ static inline int dev_pm_opp_disable(struct 
>> device *dev, unsigned long freq)
>>  	return 0;
>>  }
>> 
>> +static inline int dev_pm_opp_update_voltage(struct device *dev,
>> +					    unsigned long freq,
>> +					    unsigned long u_volt)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int dev_pm_opp_register_notifier(struct device *dev, 
>> struct notifier_block *nb)
>>  {
>>  	return -ENOTSUPP;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
