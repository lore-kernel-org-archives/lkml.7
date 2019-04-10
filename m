Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F753C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8BC20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUEgtDBc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TAACRG5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfDJLQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:16:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfDJLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:16:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F305E60FF3; Wed, 10 Apr 2019 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554894984;
        bh=0N0Rp+YhmYk/ZmowLAHt3qhV3V9KVP/SqK8yVqOQvSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jUEgtDBc6x/VWyrj0rnVmy54V7mWdZTpd3mLBpQrvXgt3EyxIqhMwoug5Y4/RAfke
         17YaqlWZ/87M+ZkUOeDhsHjtUPD5020yiGK7PfLB1wAtgui8MC3+HxuRSjVIQ4D2Yd
         dFqWZgjZ6c1q4ztcYVru9NRiqyW68deqFbnzi+t8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5CC73602DC;
        Wed, 10 Apr 2019 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554894980;
        bh=0N0Rp+YhmYk/ZmowLAHt3qhV3V9KVP/SqK8yVqOQvSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TAACRG5lKgt3Vg0iomSoE387BZvISKrMWOO0/bZa3fkN5f4Vp9t8ASt1L2VpbVorS
         EWl91MaOR7EgV1KY3sFSKB1ANVCTLU2yQ7OG92TXEfS9fS+e5ROy3tuhOr6UahdBIR
         QWvZYpqbpG+py6Hd+gQQR334JYdMGDd0QU/FDqh0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Apr 2019 16:46:20 +0530
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
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
In-Reply-To: <20190410103316.sxev2f54klemq2p6@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
 <20190410103316.sxev2f54klemq2p6@vireshk-i7>
Message-ID: <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-10 16:03, Viresh Kumar wrote:
> On 28-03-19, 20:58, Sibi Sankar wrote:
>> Add support to parse and update OPP tables attached to the cpu nodes.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 4b0b50403901..5c268dd2346c 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -73,6 +73,25 @@ static unsigned int 
>> qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>>  	return policy->freq_table[index].frequency;
>>  }
>> 
>> +static int qcom_find_update_opp(struct device *cpu_dev, unsigned long 
>> freq,
>> +				unsigned long volt)
>> +{
>> +	int ret;
>> +	struct dev_pm_opp *opp;
>> +
>> +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
>> +	if (IS_ERR(opp)) {
>> +		ret = dev_pm_opp_add(cpu_dev, freq, volt);
> 
> With my comment on the other patch, you can just call
> dev_pm_opp_update_voltage() and if that fails then call 
> dev_pm_opp_add().

yeah that should simplify things.

Also through the above approach I cannot
really disable opps that the OSM does not
support. I can only try enabling opp's that
OSM supports. But that would require all
opp's nodes to start with "disabled" but
that is not allowed I guess.

> 
>> +	} else {
>> +		dev_pm_opp_disable(cpu_dev, freq);
>> +		ret = dev_pm_opp_update_voltage(cpu_dev, freq, volt);
>> +		dev_pm_opp_enable(cpu_dev, freq);
> 
> Perhaps no one else should be using the CPU OPP table at this point of 
> time and
> so we can get away with disable and enable stuff ? Just add a comment 
> on why
> that works.

we can get away without enable/disable here

> 
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>>  				    struct cpufreq_policy *policy,
>>  				    void __iomem *base)
>> @@ -81,11 +100,16 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  	u32 volt;
>>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>>  	struct cpufreq_frequency_table	*table;
>> +	int ret;
>> 
>>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>  	if (!table)
>>  		return -ENOMEM;
>> 
>> +	ret = dev_pm_opp_of_add_table(cpu_dev);
>> +	if (ret)
>> +		dev_dbg(cpu_dev, "Couldn't add OPP table\n");
>> +
>>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>  		data = readl_relaxed(base + REG_FREQ_LUT +
>>  				      i * LUT_ROW_SIZE);
>> @@ -104,7 +128,7 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>> 
>>  		if (freq != prev_freq && core_count == max_cores) {
>>  			table[i].frequency = freq;
>> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> +			qcom_find_update_opp(cpu_dev, freq * 1000, volt);
>>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>>  				freq, core_count);
>>  		} else {
>> @@ -125,7 +149,8 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  			if (prev_cc != max_cores) {
>>  				prev->frequency = prev_freq;
>>  				prev->flags = CPUFREQ_BOOST_FREQ;
>> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>> +				qcom_find_update_opp(cpu_dev, prev_freq * 1000,
>> +						     volt);
>>  			}
>> 
>>  			break;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
