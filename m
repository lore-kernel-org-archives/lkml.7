Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F4C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F589214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYmkJ9Qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfDRAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:07:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42556 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:07:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so165106qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zJ9zh28NNxNh3Mw1cRnRKx8H/+GM9GuFzONlOu2SyYc=;
        b=JYmkJ9QefanONbT6nQVDyMVgHYNN1vwhRwqgoassTx30TcDtTRgBHapuoxdylzGPeH
         wso71vDaR74ZK1C0mVuk8HIrTXn/NbZavQwHzfj6Sa4s0lWOZY3614DoNN/uKsZDmZ64
         4VSyad1+amOLsWk0zxEMcSTZQ29DEhxWcqO5KTjlHE0dOyOMHWB0UhbPCCq0JjGN3tz3
         FCsmZHj9/Eb6Q78lvtjCxfVxOiXbTdwV0j4r+T4zhz0FBksZFLYUGhUnnvhynMrtOv+I
         zcImfQnDVc3FHtTIMe2x5iactiKQHsjzceYhp9xcpFX8cLQxnZsUepLUsUBii01JxksD
         An7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zJ9zh28NNxNh3Mw1cRnRKx8H/+GM9GuFzONlOu2SyYc=;
        b=EFgmxxJ7apLsi+NL0s/K6MSOQ7MS77SgDpZAe5SrwkbP8TV6vLJIkxI3pntxZjzYMa
         L1gwEOtfYwWPyiNHonbiAHVgXpIKiRi7VEYxqC2ZDXAV/ZY93PJU/FwM2jORsIW5BfFH
         nyj8zVRV7W1kBYiEQ2Wq47fvP4Ya+6KK45WLFOFvXDQLLhCK0Dsq58n+d07T9REfQGyq
         SMZpc0341Mzv9Nz6qE0JWZfYD8R3S1fuxsnD1/3I1F26m94+sOfOswa5san5K4pbTEPK
         nGuRIqs6OxyKd7YeZGlQZkKsJnILItvN7FKGHfsCaDJGpuQ2YG6hVi0p1l1MbftmOwH9
         RCMg==
X-Gm-Message-State: APjAAAXkx/hbmtZaFKgHx7uREa++LNFeCoPChch+FnVX0uZ1hPhZX99+
        9NRGqG7yvxGRN+nSDhn6TXVOiw==
X-Google-Smtp-Source: APXvYqzO/O9O2Mkl/YJiO5BtHZ2rlF6ywprFRbxoclw+dzZhShbkcQFD+Rr7U27LKjvl5bzjwYY/Kg==
X-Received: by 2002:ae9:edd0:: with SMTP id c199mr67749053qkg.116.1555546047721;
        Wed, 17 Apr 2019 17:07:27 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id p27sm365605qte.25.2019.04.17.17.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 17:07:26 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com> <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CB7BFBC.9090007@linaro.org>
Date:   Wed, 17 Apr 2019 20:07:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190417182932.GB5140@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 02:29 PM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>>
>> On 04/17/2019 01:36 AM, Ingo Molnar wrote:
>>>
>>> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>
>>>> The test results below shows 3-5% improvement in performance when
>>>> using the third solution compared to the default system today where
>>>> scheduler is unware of cpu capacity limitations due to thermal events.
>>>
>>> The numbers look very promising!
>>
>> Hello Ingo,
>> Thank you for the review.
>>>
>>> I've rearranged the results to make the performance properties of the 
>>> various approaches and parameters easier to see:
>>>
>>>                                          (seconds, lower is better)
>>>
>>> 			                 Hackbench   Aobench   Dhrystone
>>>                                          =========   =======   =========
>>> Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
>>> Instantaneous thermal pressure               10.16    141.63        1.15
>>> Thermal Pressure Averaging:
>>>       - PELT fmwk                             9.88    134.48        1.19
>>>       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
>>>       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
>>>       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12
>>>
>>>
>>> Firstly, a couple of questions about the numbers:
>>>
>>>    1)
>>>
>>>       Is the 1.012 result for "non-PELT 250 msecs Dhrystone" really 1.012?
>>>       You reported it as:
>>>
>>>              non-PELT Algo. Decay : 250 ms   1.012                   7.02%
>>
>> It is indeed 1.012. So, I ran the "non-PELT Algo 250 ms" benchmarks
>> multiple time because of the anomalies noticed.  1.012 is a formatting
>> error on my part when I copy pasted the results into a google sheet I am
>> maintaining to capture the test results. Sorry about the confusion.
> 
> That's actually pretty good, because it suggests a 35% and 15% 
> improvement over the vanilla kernel - which is very good for such 
> CPU-bound workloads.
> 
> Not that 5% is bad in itself - but 15% is better ;-)
> 
>> Regarding the decay period, I agree that more testing can be done. I 
>> like your suggestions below and I am going to try implementing them 
>> sometime next week. Once I have some solid results, I will send them 
>> out.
> 
> Thanks!
> 
>> My concern regarding getting hung up too much on decay period is that I 
>> think it could vary from SoC to SoC depending on the type and number of 
>> cores and thermal characteristics. So I was thinking eventually the 
>> decay period should be configurable via a config option or by any other 
>> means. Testing on different systems will definitely help and maybe I am 
>> wrong and there is no much variation between systems.
> 
> Absolutely, so I'd not be against keeping it a SCHED_DEBUG tunable or so, 
> until there's a better understanding of how the physical properties of 
> the SoC map to an ideal decay period.
> 
> Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
> tracking approach. I suppose there's some connection of this to Energy 
> Aware Scheduling? Or not ...
Mmm.. Not so much. This does not have much to do with EAS. The feature
itself will be really useful if there are asymmetric cpus in the  system
rather than symmetric cpus. In case of SMP, since all cores have same
capacity and assuming any thermal mitigation will be implemented across
the all the cpus, there won't be any different scheduler behavior.

Regards
Thara
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara
