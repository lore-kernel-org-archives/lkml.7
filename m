Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68293C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E920878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiWOjvLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfDXENn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:13:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44517 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXENm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:13:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id y5so10016617qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gn7rK0B9/eSlSI85DtD0W9jgqm3yeCYqZOhHbw08jS4=;
        b=fiWOjvLlZOm7gIlf8ejA2rc9r71SLsXuQjK9maF8VGnBgebFo/XytEKm5B3UT3mEFO
         6jDMJ6SLPvc4HKZ5x69/11mi9IquNfd6I5c6NS+9S72q31JwEbO7qRJaAf7D95WWsnOH
         mkdTthy5YxsU0LoBnTpImL+jMPHAb+qWHw5atN/x+QK5dcQhRYvXJzGciS7wu+PO58ur
         E0rrNvbVSJEILAvZ1jK+w/l5ArYHI2OxpJfo9FhFj3q7cFRbu2ylGA9rSqgA/9FyaIpf
         6DA5zifwQ1m+5TE8ESoMQW/AodjrCs7gE+50b3V5lCihc2KTh2osZF1vl05rS4GzgUki
         Hi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gn7rK0B9/eSlSI85DtD0W9jgqm3yeCYqZOhHbw08jS4=;
        b=ueXlWsb0jjbbJM3dmleVvLoxdeh7v3l0DxJmbLlRLh/sKNOJGg+G0BJGGvyYprYSki
         L6pe28sUZ9kPtlr6gmlRBxRtdCuqO3qxOEffterp95VvbxU5HQtrRc01yk59QdWIsglo
         S8v4lFMRRFAibOg2v/Ip0inQUjSrb37HWN8e46n8Y2OzRf+FBw1XygORsa/FD1zSqaSc
         6WbZDDWkAkGsFSuFTUNQnMMfmI+0nw92xoo/QUAjaMLL2YoVbW/D83o8/lPBRPebc/Fi
         Y0TCcy7SuPsedd4A20+LXaTch8dJzUYDQh0KY0lRRV6Z6OiBkcT/7OXyvaTdj3pICks1
         qe2Q==
X-Gm-Message-State: APjAAAU1hrNW27BHkUinnVYyQwlnqHsabTYJtukLQf4+Q5UgKA/stEux
        Zf+knhKfMwuTW/BDeLRZPsR5vA==
X-Google-Smtp-Source: APXvYqxqUjh7WokEe+vb7gS69ivwktg2BK7z9Scyv6F460xJ1W+ViU3SoxW7BjuRzFSiXqMC5LtjmA==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr22700134qkj.6.1556079221738;
        Tue, 23 Apr 2019 21:13:41 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id 50sm5955692qtn.73.2019.04.23.21.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 21:13:41 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
To:     Quentin Perret <quentin.perret@arm.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
 <20190418101418.5kiw5hkxoflbsvlj@queper01-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CBFE274.8010103@linaro.org>
Date:   Wed, 24 Apr 2019 00:13:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190418101418.5kiw5hkxoflbsvlj@queper01-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 06:14 AM, Quentin Perret wrote:
> On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
>> +/**
>> + * Function to update thermal pressure from cooling device
>> + * or any framework responsible for capping cpu maximum
>> + * capacity.
>> + */
>> +void sched_update_thermal_pressure(struct cpumask *cpus,
>> +				   unsigned long cap_max_freq,
>> +				   unsigned long max_freq)
>> +{
>> +	int cpu;
>> +	unsigned long flags = 0;
>> +	struct thermal_pressure *cpu_thermal;
>> +
>> +	for_each_cpu(cpu, cpus) {
> 
> Is it actually required to do this for each CPU ? You could calculate
> the whole thing once for the first CPU, and apply the result to all CPUs
> in the policy no ? All CPUs in a policy are capped and uncapped
> synchronously.
Hmm. You are right that all cpus in a policy are capped and uncapped
synchronously from the thermal framework point of view. But the thermal
pressure decay can happen at different times for each cpu and hence the
update has to be done on a per cpu basis(especially to keep track of
other age and other variables in the averaging and accumulating
algorithm). It can be separated out but I think it will just make the
solution more complicated.
> 
>> +		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
>> +		if (!cpu_thermal)
>> +			return;
>> +		spin_lock_irqsave(&cpu_thermal->lock, flags);
>> +		thermal_pressure_update(cpu_thermal, cap_max_freq, max_freq, 1);
>> +	}
>> +}


-- 
Regards
Thara
