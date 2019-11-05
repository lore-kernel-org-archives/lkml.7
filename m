Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63BC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1F72087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDLv+Sbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfKEVCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:02:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47013 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:02:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id u22so31167760qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zg26McjFW7UB5WJyEo/zWeNbTyP74z4JHjOixB1u4Nc=;
        b=SDLv+SbpuNfC0wESWQYe7govCJ9feq2KNTY/8rY2Rm0V1T9UPxEjeHedFSZ4LMqO8g
         /o93NogmGoZ7v1pdIM67u09SuvIk/13Zyqhy9EmOAXqvbm4WxS8ZvkFcA8Xj855o0rXy
         UvASwrlp78FuBOJeRSFWutbnFUNN3Eh43QE09rWbJtC6fl/lVuAUiYJt4Yj5e9uqvlFv
         gHZEBVRXL2fENOXyPPy1O8N85tuWrX+F0HCvE+s3haFuKFNd8elrFt/79I4cbrrSSH/C
         2HV/zP05NSXh4vlbMQBSUsim8HfUS2AyC9e69h8M1quit/q19+MVZaKndyaZSbsWPLvt
         Z4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zg26McjFW7UB5WJyEo/zWeNbTyP74z4JHjOixB1u4Nc=;
        b=Y+YjpTEVyWmWVaQYvWR3PFtJO/o9ZiWiCpgp7zzSzsdss0TmIe2Oabtk7Z5Dgqktrr
         wfMrT0EceNZOGyBsx6g4fUkCU36QE1XO54M99cH9QdEzaPQhSls7HgL8VWxIRtDMQCjh
         Es7xoWWTGDOqO/W3a1n2mIWpPIh8399JICzZmEqTuhwe8LmOInodXnpnhi/vAsZuFiDe
         U8EADrYR4mFrY45meGvlebg34TJebcwUKhPeveeKV4ErkI29peQv2z01Xd/awlrLLti1
         zMcSJOfn7g/TCzQ+FzVp9hechdZs/nSzmnCMlAk3lLR57bS7DMxPtqwUlpQ+kbVY5oDN
         gykA==
X-Gm-Message-State: APjAAAXecQ559NTj6QNrdcoGxfsIK2G/DWFf0U4oMnKajFm8TkZDBDh1
        LEj4YRipvzrwbuddpHkh1a1ZAg==
X-Google-Smtp-Source: APXvYqwB3NA1BvsIHt1qe0N49CIArpDuNPzHUNslcukySdIdv9CafyV39mMF/QJ8mpZxiWR6hLs3Dw==
X-Received: by 2002:ac8:1a88:: with SMTP id x8mr20078096qtj.65.1572987721632;
        Tue, 05 Nov 2019 13:02:01 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 197sm11296742qkh.80.2019.11.05.13.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:02:00 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC1E348.2090104@linaro.org>
Date:   Tue, 5 Nov 2019 16:02:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191105202037.GA17494@e108754-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
> Hi Thara,
> 
> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
> [...]
>> +static void trigger_thermal_pressure_average(struct rq *rq)
>> +{
>> +#ifdef CONFIG_SMP
>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
>> +				per_cpu(thermal_pressure, cpu_of(rq)));
>> +#endif
>> +}
> 
> Why did you decide to keep trigger_thermal_pressure_average and not
> call update_thermal_load_avg directly?
> 
> For !CONFIG_SMP you already have an update_thermal_load_avg function
> that does nothing, in kernel/sched/pelt.h, so you don't need that
> ifdef. 
Hi,

Yes you are right. But later with the shift option added, I shift
rq_clock_task(rq) by the shift. I thought it is better to contain it in
a function that replicate it in three different places. I can remove the
CONFIG_SMP in the next version
> 
> Thanks,
> Ionela.
> 
>> +
>>  /*
>>   * All the scheduling class methods:
>>   */
>> -- 
>> 2.1.4
>>


-- 
Warm Regards
Thara
