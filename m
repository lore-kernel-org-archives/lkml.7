Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A447C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C550E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3fNQM3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfDQRSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:18:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32786 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfDQRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:18:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so28282977qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JhS8pc2yma7trc4CGdV2c7DTHjg1el+uhsJsWLazdnw=;
        b=q3fNQM3EuTItkXcR0GTSwjQ416LDrSF+9Jz9l90gKdHOOBlJS9/UFxfUxq/rh3RrDp
         4QKUf/k8JmOj8wE4JkrAqGngrJd6ZBUStiLvuuFkYOL8zhLmh/5ALQN9lePE0B+aTt4F
         y9tUhHH5PNsZHioNEA+KwkGAjNt9GNUVjrDqdug72NctpJ/z9c7DkIw0JzIzOyeQ8cQD
         JcKtDVDBM5lcg/AZtUVQEVc8pO8jwbViZBxD/MdrYmLaZcFRChoIk/4vEF3x3VBCSItm
         rXu+5iMfXh6/vYkp1B1/2z29G9XRTdti4kQX7uLBiBphxdBnOHsZ6qMIYC34nIbWX7GB
         WqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JhS8pc2yma7trc4CGdV2c7DTHjg1el+uhsJsWLazdnw=;
        b=tTbs66rrYnyf8PZ2lBPQMFHKUNhXL9AVEtmHFOMNJt7Ft0bwxAUHxValFX93HP4thD
         Gzbe6c2lshQwVSkPm4KWn8ZWLD0IDwUJcuc7D2DcbGXW3F/2siHKTxlhmWnLAKgktW7E
         QBp4xt6fNG9B/7lBrYIGzhiwJiAnrG6SrHLg6pzDcmDMSm0aJzzDVSTNeO8wBkxmAsfK
         1Z6zJhhHZVSEQS64/kjbnFLCMrKTmpB90EtmVFxQO7xh2cLqd1iklX5QYoAPVcLX5Jbo
         +GzKlpw9llBxIGrWs4T4s9ejDNm1CtFpzlSzcWs6uKrOFzdpuJXYF6D6jbA7vVLj/sZ8
         sMDQ==
X-Gm-Message-State: APjAAAVqlkcIlT6PBkcfhdLgBn4OntBX+zwcdisINu7Z04ty1t0YeTns
        mRWoYcP9fa6kKj86LPTBpMdxUw==
X-Google-Smtp-Source: APXvYqwTKgYurSCsX24h+iXwyfcoPBxSQq15hEWWkt4egqAkf6DF5DQvq0GcN51+brgN+Q5qonW0Vg==
X-Received: by 2002:ac8:3736:: with SMTP id o51mr73273075qtb.223.1555521501289;
        Wed, 17 Apr 2019 10:18:21 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id m189sm33348727qkf.2.2019.04.17.10.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:18:19 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CB75FD9.3070207@linaro.org>
Date:   Wed, 17 Apr 2019 13:18:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190417053626.GA47282@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/17/2019 01:36 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>> The test results below shows 3-5% improvement in performance when
>> using the third solution compared to the default system today where
>> scheduler is unware of cpu capacity limitations due to thermal events.
> 
> The numbers look very promising!

Hello Ingo,
Thank you for the review.
> 
> I've rearranged the results to make the performance properties of the 
> various approaches and parameters easier to see:
> 
>                                          (seconds, lower is better)
> 
> 			                 Hackbench   Aobench   Dhrystone
>                                          =========   =======   =========
> Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
> Instantaneous thermal pressure               10.16    141.63        1.15
> Thermal Pressure Averaging:
>       - PELT fmwk                             9.88    134.48        1.19
>       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
>       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
>       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12
> 
> 
> Firstly, a couple of questions about the numbers:
> 
>    1)
> 
>       Is the 1.012 result for "non-PELT 250 msecs Dhrystone" really 1.012?
>       You reported it as:
> 
>              non-PELT Algo. Decay : 250 ms   1.012                   7.02%

It is indeed 1.012. So, I ran the "non-PELT Algo 250 ms" benchmarks
multiple time because of the anomalies noticed.  1.012 is a formatting
error on my part when I copy pasted the results into a google sheet I am
maintaining to capture the test results. Sorry about the confusion.
> 
>       But the formatting is significant 3 digits versus only two for all 
>       the other results.
> 
>    2)
> 
>       You reported the hackbench numbers with "10 runs" - did the other 
>       benchmarks use 10 runs as well? Maybe you used fewer runs for the 
>       longest benchmark, Aobench?
 Hackbench and dhrystone are 10 runs each. Aobench is part of phoronix
test suit and the test suite runs it six times and gives the per run
results, mean and stddev. On my part,  I ran aobench just once per
configuration.

> 
> Secondly, it appears the non-PELT decaying average is the best approach, 
> but the results are a bit coarse around the ~250 msecs peak. Maybe it 
> would be good to measure it in 50 msecs steps between 50 msecs and 1000 
> msecs - but only if it can be scripted sanely:

non-PELT looks better overall because the test results are quite
comparable (if not better) between the two solutions and it takes care
of concerns people raised when I posted V1 using PELT-fmwk algo
regarding reuse of utilization signal to track thermal pressure.

Regarding the decay period, I agree that more testing can be done. I
like your suggestions below and I am going to try implementing them
sometime next week. Once I have some solid results, I will send them out.

My concern regarding getting hung up too much on decay period is that I
think it could vary from SoC to SoC depending on the type and number of
cores and thermal characteristics. So I was thinking eventually the
decay period should be configurable via a config option or by any other
means. Testing on different systems will definitely help and maybe I am
wrong and there is no much variation between systems.

Regards
Thara

> 
> A possible approach would be to add a debug sysctl for the tuning period, 
> and script all these benchmark runs and the printing of the results. You 
> could add another (debug) sysctl to turn the 'instant' logic on, and to 
> restore vanilla kernel behavior as well - this makes it all much easier 
> to script and measure with a single kernel image, without having to 
> reboot the kernel. The sysctl overhead will not be measurable for 
> workloads like this.
> 
> Then you can use "perf stat --null --table" to measure runtime and stddev 
> easily and with a single tool, for example:
> 
>   dagon:~> perf stat --null --sync --repeat 10 --table ./hackbench 20 >benchmark.out
> 
>   Performance counter stats for './hackbench 20' (10 runs):
> 
>            # Table of individual measurements:
>            0.15246 (-0.03960) ######
>            0.20832 (+0.01627) ##
>            0.17895 (-0.01310) ##
>            0.19791 (+0.00585) #
>            0.19209 (+0.00004) #
>            0.19406 (+0.00201) #
>            0.22484 (+0.03278) ###
>            0.18695 (-0.00511) #
>            0.19032 (-0.00174) #
>            0.19464 (+0.00259) #
> 
>            # Final result:
>            0.19205 +- 0.00592 seconds time elapsed  ( +-  3.08% )
> 
> Note how all the individual measurements can be captured this way, 
> without seeing the benchmark output itself. So difference benchmarks can 
> be measured this way, assuming they don't have too long setup time.
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara
