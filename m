Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92839C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E6C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOcUFrVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:18:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46882 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:18:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id w73so1923659qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/hDwCGeeSguyBKj4Fp15XEiI0c2OmnUXshUEZiKjvic=;
        b=nOcUFrVmoBLtELYzn19gqpgdL6lqd8/zxeKcMCG1KnyGpuT0cc7bXXIJRFvat5kLO9
         f82RD08wKFZLqnVZAhZejfooWAFVin8j4WGV+5qyQWjuTFmG/xOJbeYaY2oez7wIoe/N
         FlJjk5fB/VglDc0MuP2dB2iNLcq5OPJ3umIOgiG4ogTAStjwNmaDwwxJsUH9Gq/MUbVk
         vF0OVgTSaKpbztlK3BCtfACRcBoxJi/cZuhLJw5yAZyGIyb+tRItws7/6kLOZxpPAQZ2
         cDXwP06ulnFNJmvkbwnNPC3v0BgROCJM+ouPNzyMqA/WI+DpmsHLZRYW+1JmsvuyqrVa
         7nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/hDwCGeeSguyBKj4Fp15XEiI0c2OmnUXshUEZiKjvic=;
        b=Vt0iZjgJ4ldYcpyHSRjNbj/Sl1TDQvRQ2D2pRUhsBLzOeAYM2gipKpx55iGZRIPqZC
         0sD5hADSzYUgSpGhpZ7fGCu9zQToIYSeeLHgo2JVlbMsvZfY1bbQTVyqw8hmEO/paZN6
         zioWvJIhw27s/HzheKG/Eg//c1/Vtj73vkwcnkPSOW1PzHcyQf7jSABC7uRcC8I1a8IR
         RTC8YMDrolob8afzVWOvhqgT8tEqXacHksLZreNlsCyrGW07HwUT8puUSLsCtdjeTQHu
         3j1frfQuJTkOWVEvMo07O2hFqQ7NJhpT4/35Lxdi0B0GUMDTnEgdhkKnxdEtmnK/VytF
         SYRg==
X-Gm-Message-State: APjAAAVbRHPGe9PA232YYoc0jFReHJzMu70MNEc64SsdCKU/6jjc2Jf+
        YK8o+mBM/ZvPheWjB5xrpLmZhA==
X-Google-Smtp-Source: APXvYqyakPUL5iwcPLO9LT8Gh/4NvwZNQxQoNPzx1tZtvu2U18X7pOC53Je2hqOIsLYU9sGeYLE6Mw==
X-Received: by 2002:a37:4388:: with SMTP id q130mr34675157qka.62.1556288280358;
        Fri, 26 Apr 2019 07:18:00 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id s66sm12591776qkd.90.2019.04.26.07.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 07:17:58 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
 <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
 <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC31314.3070700@linaro.org>
Date:   Fri, 26 Apr 2019 10:17:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2019 08:45 AM, Vincent Guittot wrote:
> On Thu, 25 Apr 2019 at 12:57, Quentin Perret <quentin.perret@arm.com> wrote:
>>
>> On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
>>> +/* Per cpu structure to keep track of Thermal Pressure */
>>> +struct thermal_pressure {
>>> +     unsigned long scale; /* scale reflecting average cpu max capacity*/
>>> +     unsigned long acc_scale; /* Accumulated scale for this time window */
>>> +     unsigned long old_scale; /* Scale value for the previous window */
>>> +     unsigned long raw_scale; /* Raw max capacity */
>>> +     unsigned long age_stamp; /* Last time old_scale was updated */
>>> +     unsigned long last_update; /* Last time acc_scale was updated */
>>> +     spinlock_t lock; /* Lock for protecting from simultaneous access*/
>>> +     /* Timer for periodic update of thermal pressure */
>>> +     struct timer_list timer;
>>
>> Do you actually need the periodic update ? You only really need to
>> update the 'scale' value when updating the LB stats no ? Nobody
>> accesses that value in between two LBs.
> 
> Do you mean calling a variant of sched_update_thermal_pressure() in
> update_cpu_capacity() instead of periodic update ?
> Yes , that should be enough

Hi,

I do have some concerns in doing this.
1. Updating thermal pressure does involve some calculations for
accumulating, averaging, decaying etc which in turn could have some
finite and measurable time spent in the function. I am not sure if this
delay will be acceptable for all systems during load balancing (I have
not measured the time involved). We need to decide if this is something
we can live with.

2. More importantly, since update can happen from at least two paths (
thermal fw and periodic timer in case of this patch series)to ensure
mutual exclusion,  the update is done under a spin lock. Again calling
from update_cpu_capacity will involve holding the lock in the load
balance path which is possible not for the best.
For me, updating out of load balance minimizes the disruption to
scheduler on the whole.

But if there is an over whelming support for updating the statistics
from the LB , I can move the code.

Regards
Thara

> 
>>
>> Thanks,
>> Quentin


-- 
Regards
Thara
