Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642FFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B28420652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfD2N3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:29:13 -0400
Received: from foss.arm.com ([217.140.101.70]:57052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2N3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42367A78;
        Mon, 29 Apr 2019 06:29:12 -0700 (PDT)
Received: from [10.1.198.115] (r-obsd-amd64.cambridge.arm.com [10.1.198.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5F633F71A;
        Mon, 29 Apr 2019 06:29:09 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
Date:   Mon, 29 Apr 2019 14:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

> 
> 			Hackbench: (1 group , 30000 loops, 10 runs)
> 				Result            Standard Deviation
> 				(Time Secs)        (% of mean)
> 
> No Thermal Pressure             10.21                   7.99%
> 
> Instantaneous thermal pressure  10.16                   5.36%
> 
> Thermal Pressure Averaging
> using PELT fmwk                 9.88                    3.94%
> 
> Thermal Pressure Averaging
> non-PELT Algo. Decay : 500 ms   9.94                    4.59%
> 
> Thermal Pressure Averaging
> non-PELT Algo. Decay : 250 ms   7.52                    5.42%
> 
> Thermal Pressure Averaging
> non-PELT Algo. Decay : 125 ms   9.87                    3.94%
> 
> 

I'm trying your patches on my Hikey960 and I'm getting different results
than the ones here.

I'm running with the step-wise governor, enabled only on the big cores.
The decay period is set to 250ms.

The result for hackbench is:

# ./hackbench -g 1 -l 30000
Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 20.756

During the run I see the little cores running at maximum frequency
(1.84GHz) while the big cores run mostly at 1.8GHz, only sometimes capped
at 1.42GHz. There should not be any capacity inversion.
The temperature is kept around 75 degrees (73 to 77 degrees).

I don't have any kind of active cooling (no fans on the board), only a
heatsink on the SoC.

But as you see my results(~20s) are very far from the 7-10s in your
results.

Do you see anything wrong with this process? Can you give me more
details on your setup that I can use to test on my board?

Thank you,
Ionela.
