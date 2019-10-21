Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7D52086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDlWwKAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfJUVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:04:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43340 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfJUVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:04:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id a194so10095332qkg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nmmE+tP3DDwbQMMti1c8oIlUXbXa4eZTH+dE14lntAc=;
        b=xDlWwKAoVigd2nyp0APe3pK7HfgxOBecUUi1J2+FpXEw5MukI+4lDzJwZL+IwCLQ09
         yHCeXa/4EME5H+e7O/Xt99QYV0bUvXj2tNPfNbRTclMCk48hkRoW6I3Oo50b5/mr6gXq
         D0REdxaKel9Ve5B2Wo/M3mFgNZoRqvQybbs4F6ODZBCNMrIe9aKpTKu/e9uMQ8bz8W9h
         XdDKMcPMliCKizaMAnOB4RkhZSAWc4jurrIgR4b9BzxdcUrMkM6wdlRSaNp1BNORTR/K
         uF+WOOm8FRrjgVtpHVDgDgzLFSGUsm2b5HDMGEZ7a9fQCtBifqNOoGOsh7L7uDe0wZIq
         L4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nmmE+tP3DDwbQMMti1c8oIlUXbXa4eZTH+dE14lntAc=;
        b=Y921RHmb2o/wdXryF5JHvxaY1RpTjr3nIQYXR2ipbaf1fkw695MnG2vK0XyfMPm1td
         I+CG8MDgFzXuluzgQD7timn4x8je8XP5XWXr5SP3hvRniVwNpL7jGaWU8kgltm6y22Gx
         bwcPbz9cTNNHigD5xy8yFYVt1k6ZHZA1Rt2TryjtGZECLYdQEjn2m8sbf1zwdeLhu0D7
         LS+nxFKr6ne3bDAMsfgpVxikm8QiiH3HX/HZh+vaqzOlPEhanDzpHC/Zb+6MQUJFG3Ad
         p0/Mfb90WPpoOyyhZwkY+d+Lh2fMM4G0qfvYlnyMLGf2k9uZ9v14O3QXq0zE8n/BriUm
         OsuQ==
X-Gm-Message-State: APjAAAUU5Qk9uMUqvvG+Nxk+sKlROo+yh1oTMEYvzsQbcYWxAnP3Bq7u
        KNnIlt+8L4x9+l5cwf952OPJiLdnSuk=
X-Google-Smtp-Source: APXvYqyCyiHfONbk3hmg9uLwTY6Hrm2+Xjnj9FWW7MpBACeV5zbNV7EXy0Thz+FrIzB/WxfukZcypg==
X-Received: by 2002:ae9:dd07:: with SMTP id r7mr24687548qkf.248.1571691838732;
        Mon, 21 Oct 2019 14:03:58 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id y29sm7491267qtc.8.2019.10.21.14.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 14:03:57 -0700 (PDT)
Subject: Re: [Patch v3 7/7] sched: thermal: Enable tuning of decay period
To:     Quentin Perret <qperret@google.com>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
 <20191015101452.GA237548@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DAE1D3C.4090008@linaro.org>
Date:   Mon, 21 Oct 2019 17:03:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191015101452.GA237548@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

Thanks for the review.
On 10/15/2019 06:14 AM, Quentin Perret wrote:
> Hi Thara,
> 
> On Sunday 13 Oct 2019 at 20:58:25 (-0400), Thara Gopinath wrote:
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 00fcea2..5056c08 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -376,6 +376,13 @@ static struct ctl_table kern_table[] = {
>>  		.mode		= 0644,
>>  		.proc_handler	= proc_dointvec,
>>  	},
>> +	{
>> +		.procname	= "sched_thermal_decay_coeff",
>> +		.data		= &sysctl_sched_thermal_decay_coeff,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec,
> 
> Perhaps change this for 'sched_proc_update_handler' with min and max
> values ? Otherwise userspace is allowed to write nonsensical values
> here. And since sysctl_sched_thermal_decay_coeff is used to shift, this
> can lead to an undefined behaviour.
Will do
> 
> Also, could we take this sysctl out of SCHED_DEBUG ? I expect this to be
> used/tuned on production devices where SCHED_DEBUG should theoretically
> be off.

I will take it out of SCHED_DEBUG. I am wondering if this should be
a runtime control at all. Because this is a shift this changes the
accumulating window for the thermal pressure signal. A runtime change
will not guarantee a clean start of the window. May be I should make
this a config option.

> 
> Thanks,
> Quentin
> 


-- 
Warm Regards
Thara
