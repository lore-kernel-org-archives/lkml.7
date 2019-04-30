Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A35C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A9720652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pf+614SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3P57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:57:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45266 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3P57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:57:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so16704361qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gZc317wuD1wbgeY5vQ6WXA+XogYTxvSjh3WMAaMRQk8=;
        b=pf+614SSRmJat7hai5KpQaUn2sVGsPaeD+fhpnLm6lyNigcq1xeziUrtKuGPrM7+Fd
         L78npxYX6CHANhBM/eK0DdMvp7cznSNYQexe4PP9lr794B69yhdj+n11TBP4qVhGges7
         6iv8Zje3k8Q2U9jCfeLCP1Zu+aqkxNbqJz0l6LJXLGfgH7/FEgrlCBRZbAHo7tX3yyK7
         mVexbNkdPuSBpn6MdV4jWSuRyNIBJPHlkkVnHsCnhXgPlIAqrJRkmP23QVNO7OUG+zKf
         CFM1ot3oZUz/LaKqQp473jLm57M04ps7xmem41uFIT7Y8ha+80HG4D+A5LyM92DDqim9
         PCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gZc317wuD1wbgeY5vQ6WXA+XogYTxvSjh3WMAaMRQk8=;
        b=b1E1tjSJ6iW5Odea8+wcIrSOsoOVtKDKFE72M7U6CvXZz5UXGMF64nPL4zbnDXoU2U
         JG0xVlgFOaeiKcskjTQyAUr+mUZVfvfkMq0uJwYxsAS5HhsFKX3nAcwHcuSipPSjSuPq
         pLFQdGHUp2fuWNS7XXrz74D8aGbbkDAXCSQJ3hq3JrBcVy8jqWBXGGli12gkfaDQ78pI
         8M9hLlanQHEmj2FcSnlCyICX7YsEesFWmyaXaao4ZGTuuMbCYxJOtvTnuYbThJ4vLAuN
         eRrbakQq2nA24AkRSKq1chjjbM2/raI/XvT16xGEX8omqMoVDFoYbFiiUCbIzvQ2FBGr
         /dwQ==
X-Gm-Message-State: APjAAAXempB7R+lC3OJarJClzNheuISmnP/Jmilvt1jPlHY/H8l1Uuto
        OpgGqhD59S34tCm0hstVTKQ+JA==
X-Google-Smtp-Source: APXvYqwPkBce/hpdy1KtdCnK+v57K+XfotmBTSekH6qYC2Er7OW/BVCEHDu3ttt2/MCm9mkgFTgU9A==
X-Received: by 2002:a0c:8b6f:: with SMTP id d47mr53957863qvc.135.1556639877995;
        Tue, 30 Apr 2019 08:57:57 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id j129sm18896076qkd.51.2019.04.30.08.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:57:56 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC87082.20802@linaro.org>
Date:   Tue, 30 Apr 2019 11:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2019 09:29 AM, Ionela Voinescu wrote:
> Hi Thara,
> 
>>
>> 			Hackbench: (1 group , 30000 loops, 10 runs)
>> 				Result            Standard Deviation
>> 				(Time Secs)        (% of mean)
>>
>> No Thermal Pressure             10.21                   7.99%
>>
>> Instantaneous thermal pressure  10.16                   5.36%
>>
>> Thermal Pressure Averaging
>> using PELT fmwk                 9.88                    3.94%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 500 ms   9.94                    4.59%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 250 ms   7.52                    5.42%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 125 ms   9.87                    3.94%
>>
>>
> 
> I'm trying your patches on my Hikey960 and I'm getting different results
> than the ones here.
> 
> I'm running with the step-wise governor, enabled only on the big cores.
> The decay period is set to 250ms.
> 
> The result for hackbench is:
> 
> # ./hackbench -g 1 -l 30000
> Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
> Each sender will pass 30000 messages of 100 bytes
> Time: 20.756
> 
> During the run I see the little cores running at maximum frequency
> (1.84GHz) while the big cores run mostly at 1.8GHz, only sometimes capped
> at 1.42GHz. There should not be any capacity inversion.
> The temperature is kept around 75 degrees (73 to 77 degrees).
> 
> I don't have any kind of active cooling (no fans on the board), only a
> heatsink on the SoC.
> 
> But as you see my results(~20s) are very far from the 7-10s in your
> results.
> 
> Do you see anything wrong with this process? Can you give me more
> details on your setup that I can use to test on my board? 

Hi Ionela,

I used the latest mainline kernel with sched/ tip merged in for my
testing. My hikey960 did not have any fan or heat sink during testing. I
disabled cpu cooling for little cores in the dts files.
Also I have to warn you that I have managed to blow up my hikey960. So I
no longer have a functional board for past two weeks or so.

I don't have my test scripts to send you, but I have some of the results
files downloaded which I can send you in a separate email.
I did run the test 10 rounds.

Also I think 20s is too much of variation for the test results. Like I
mentioned in my previous emails I think the 7.52 is an anomaly but the
results should be around the range of 8-9 s.

Regards
Thara

> 
> Thank you,
> Ionela.
> 


-- 
Regards
Thara
