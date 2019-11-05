Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4273C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3121A49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFmOdEnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfKEU0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:26:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38973 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:26:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id 15so22448757qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WK0wm7UHiRNiCdFdcI7k8HaWnL7BzBlfZNe4kmd9HH4=;
        b=gFmOdEnVPBMFdorjFTghJIoMxqPnFfiDnHPKN9TFB4YjJD4i82NoHJq4FfVKCCoSIM
         3Ok5fosUiDopRnLeyUNPm0BCe0Cx8FDIMXvdkX6WgnnFGTYayoghwf5C/eFj8Mijbshg
         i5tZB2BtfI1qduCvLHF+hfSOHRPbBeUOsnhgxeMQBKckOxthc4nxeoiOKRQvhukhIG2/
         tPS4h1jk5iNfl219kVpj+prkqa3Sb7oPyDStbTrmzaw0kW7z9fPCutFYrcSJb4SMnK5e
         mYnHVIf+dDrq4Aj2RQRQhf9sgmh+VlUR9q0H+SW3DELxHpZCBjckTsaG0D3XTPC6dLk5
         S1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WK0wm7UHiRNiCdFdcI7k8HaWnL7BzBlfZNe4kmd9HH4=;
        b=eJcHn5bkZIiQTO22DzAa6SRn6FNaODCIdZUSZUeiCLhM3wOXztdH72riu++N2v8gJQ
         mJ4b6JrdwMlb2Yy/NmLnmB0MGc7ooMnKHV5fTHjj7CzhOpUJXyG43/+weeqDg0GiR1BC
         jSAc3x+aZrJbZxLCsK50OkUxQOVdtSXJ6jKhGwSDqbE0nRu0rtjWDIq7G0uEMmF3c5Xf
         g52Q+w1X9gt6qiuqTdTnXvdTvN+IMtFQjK6DzvwzYMavnxnzCMabQdydOFFb/hiX9dyi
         wz9Ys962zxlyBwpU1cOgGY6yNCwmFVfN2a5N5dl3wOAspSreZPszMci+5EAWflecoAkw
         LyIQ==
X-Gm-Message-State: APjAAAWjzaRlUVUPH45SXXGDNLLM28XVSGWwImYDgkc3FlwCa6gvm/V/
        pqas1RBWQGRvg6mRuvU3yjIFbQ==
X-Google-Smtp-Source: APXvYqxDq8YYCyhGcfou7SE+NrBkMYOhW55IJVOFVLrseG1x8DxrUv42BqseHg+ARIXrLOxNSeIb2w==
X-Received: by 2002:a37:f905:: with SMTP id l5mr2109122qkj.90.1572985567586;
        Tue, 05 Nov 2019 12:26:07 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id k128sm2706418qkf.56.2019.11.05.12.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 12:26:06 -0800 (PST)
Subject: Re: [Patch v4 6/6] sched: thermal: Enable tuning of decay period
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
 <20191104161035.GA6680@e108754-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC1DADE.60603@linaro.org>
Date:   Tue, 5 Nov 2019 15:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191104161035.GA6680@e108754-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 11:12 AM, Ionela Voinescu wrote:
> Hi Thara,
> 
> On Tuesday 22 Oct 2019 at 16:34:25 (-0400), Thara Gopinath wrote:
>> Thermal pressure follows pelt signas which means the
>> decay period for thermal pressure is the default pelt
>> decay period. Depending on soc charecteristics and thermal
>> activity, it might be beneficial to decay thermal pressure
>> slower, but still in-tune with the pelt signals.
> 
> I wonder if it can be beneficial to decay thermal pressure faster as
> well.
> 
> This implementation makes 32 (LOAD_AVG_PERIOD) the minimum half-life
> of the thermal pressure samples. This results in more than 100ms for a
> sample to decay significantly and therefore let's say it can take more
> than 100ms for capacity to return to (close to) max when the CPU is no
> longer capped. This value seems high to me considering that a minimum
> value should result in close to 'instantaneous' behaviour, when there
> are thermal capping mechanisms that can react in ~20ms (hikey960 has a
> polling delay of 25ms, if I'm remembering correctly).
> 
> I agree 32ms seems like a good default but given that you've made this
> configurable as to give users options, I'm wondering if it would be
> better to cover a wider range.
> 
>> One way to achieve this is to provide a command line parameter
>> to set the decay coefficient to an integer between 0 and 10.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>> v3->v4:
>> 	- Removed the sysctl setting to tune decay period and instead
>> 	  introduced a command line parameter to control it. The rationale
>> 	  here being changing decay period of a PELT signal runtime can
>> 	  result in a skewed average value for atleast some cycles.
>>
>>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>  kernel/sched/thermal.c                          | 25 ++++++++++++++++++++++++-
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a84a83f..61d7baa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4273,6 +4273,11 @@
>>  			incurs a small amount of overhead in the scheduler
>>  			but is useful for debugging and performance tuning.
>>  
>> +	sched_thermal_decay_coeff=
>> +			[KNL, SMP] Set decay coefficient for thermal pressure signal.
>> +			Format: integer betweer 0 and 10
>> +			Default is 0.
>> +
>>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>>  			xtime_lock contention on larger systems, and/or RCU lock
>>  			contention on all systems with CONFIG_MAXSMP set.
>> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
>> index 0c84960..0da31e1 100644
>> --- a/kernel/sched/thermal.c
>> +++ b/kernel/sched/thermal.c
>> @@ -10,6 +10,28 @@
>>  #include "pelt.h"
>>  #include "thermal.h"
>>  
>> +/**
>> + * By default the decay is the default pelt decay period.
>> + * The decay coefficient can change is decay period in
>> + * multiples of 32.
> 
> This description has to be corrected as well, as per Peter's comment.
> 
> Also, it might be good not to use the value 32 directly but to mention
> that the decay period is a shift of LOAD_AVG_PERIOD. If that changes,
> the translation from decay shift to decay period below will change as
> well.

Hi Ionela,

I sent out the v5 without fixing this. Even if there are no other
comments on v5 I will send out a v6 fixing this.

Regarding a slower decay, we need a strong case for it.



-- 
Warm Regards
Thara
