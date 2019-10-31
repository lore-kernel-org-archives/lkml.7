Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1754A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciF98ugB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfJaQlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:41:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43897 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:41:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id a194so7636302qkg.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=c2gDWEfkAfx9Q4PE/Rm807WIKTLgFBhcjREw7TevLRs=;
        b=ciF98ugBd0QrAkNL11UiQY+M7NMZbjz4+Pu7HZ+cbK+xsUC2WQuwkUi+rc/nQ3iEtK
         mV2CmBSCTMHvqxUOdzz8KUzarJuLmftQL+dYkSxbCam2L5ctFJ+BiS9HQBbZ0V9MB4TA
         SZ5YSxG1RrfBiRnNak5np+8Gzmom7RJf8SsZn77u2lxX+PrUcG0cRGQq7ypT04rOMvBH
         emytCpQwVKl/x7rXO6dmFt0B1D9axVvaADmGnp1vGZVEe/YzEJfkUsWSghk1rSCPGxZR
         QBg6zuK5N2h/KLF1nmZmbJM1ihBESkqZyah1QjNhl74bCfjn3gkxErqwNCxyzKzw4MOH
         gAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=c2gDWEfkAfx9Q4PE/Rm807WIKTLgFBhcjREw7TevLRs=;
        b=J+abtpDvfKzFXpMMMGIwXkfmdllWq5ewhlgkIZnDPYUbxXBgj+A0NaF1Iv4MLTKgkS
         4PCIa5hcPbh4HABGj5BoM8AK0N8x+Hf8XFHFo5x4g40XZqpLxbG+5o56eyFSLKXcq/pk
         1g7Ebxu8KK0SEjfao16pmh3xTXei/CYIjPOgsDikPzlAF579/jPGf20ouuY8f26GpveI
         wf1aRmzrxxqrBSLSkLEqAao9YspcVY6sFORMg54g41jOaVUtoEB4AgrLBA/FRF+QamyW
         MXuEw2OjBI6X/kK3dxk1QzFHDgrJjopUJraD77nb1Rs2kC5WPlsnoiRu5Kmhz/VhOk9Q
         aJ5g==
X-Gm-Message-State: APjAAAWpK+7MwVpxrAtY8GyFajqrJ7ncxtU8EsfJ373sFDXQMNN0dKHw
        kbDdjVY6/2FOKp/fGwSXZa5JYw==
X-Google-Smtp-Source: APXvYqzRAQ/QuPkY3XTnwzSsBdb38qZCugAfX8/oIVGdsN0CYp480IUG/4aPEVEVg9EBFBgbXAg4zQ==
X-Received: by 2002:a05:620a:13c3:: with SMTP id g3mr873053qkl.109.1572540082370;
        Thu, 31 Oct 2019 09:41:22 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id u7sm2081788qkm.127.2019.10.31.09.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:41:21 -0700 (PDT)
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <20191031094420.GA19197@e108754-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBB0EB0.9050106@linaro.org>
Date:   Thu, 31 Oct 2019 12:41:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191031094420.GA19197@e108754-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 05:44 AM, Ionela Voinescu wrote:
> Hi Thara,
> 
> On Tuesday 22 Oct 2019 at 16:34:19 (-0400), Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event of a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in the kernel, task scheduler is 
>> not notified of capping of maximum frequency of a cpu.
>> In other words, scheduler is unware of maximum capacity
> 
> Nit: s/unware/unaware
> 
>> restrictions placed on a cpu due to thermal activity.
>> This patch series attempts to address this issue.
>> The benefits identified are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The reduction in the maximum possible capacity of a cpu due to a 
>> thermal event can be considered as thermal pressure. Instantaneous
>> thermal pressure is hard to record and can sometime be erroneous
>> as there can be mismatch between the actual capping of capacity
>> and scheduler recording it. Thus solution is to have a weighted
>> average per cpu value for thermal pressure over time.
>> The weight reflects the amount of time the cpu has spent at a
>> capped maximum frequency. Since thermal pressure is recorded as
>> an average, it must be decayed periodically. Exisiting algorithm
>> in the kernel scheduler pelt framework is re-used to calculate
>> the weighted average. This patch series also defines a sysctl
>> inerface to allow for a configurable decay period.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on db845c platform with debian file system.
>> Further, dhrystone and hackbench tests have been
>> run with the thermal pressure algorithm. During testing, due to
>> constraints of step wise governor in dealing with big little systems,
>> trip point 0 temperature was made assymetric between cpus in little
>> cluster and big cluster; the idea being that
>> big core will heat up and cpu cooling device will throttle the
>> frequency of the big cores faster, there by limiting the maximum available
>> capacity and the scheduler will spread out tasks to little cores as well.
>>
> 
> Can you please share the changes you've made to sdm845.dtsi and a kernel
> base on top of which to apply your patches? I would like to reproduce
> your results and run more tests and it would be good if our setups were
> as close as possible.
Hi Ionela
Thank you for the review.
So I tested this on 5.4-rc1 kernel. The dtsi changes is to reduce the
thermal trip points for the big CPUs to 60000 or 70000 from the default
90000. I did this for 2 reasons
1. I could never get the db845 to heat up sufficiently for my test cases
with the default trip.
2. I was using the default step-wise governor for thermal. I did not
want little and big to start throttling by the same % because then the
task placement ratio will remain the same between little and big cores.


> 
>> Test Results
>>
>> Hackbench: 1 group , 30000 loops, 10 runs       
>>                                                Result         SD             
>>                                                (Secs)     (% of mean)     
>>  No Thermal Pressure                            14.03       2.69%           
>>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%         
>>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%           
>>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%         
>>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%           
>>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%  
>>
>> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>>                                                  Result      SD             
>>                                                  (Secs)    (% of mean)     
>>  No Thermal Pressure                              9.452      4.49%
>>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%  
>>
> 
> Do you happen to know by how much the CPUs were capped during these
> experiments?

I don't have any captured results here. I know that big cores were
capped and at times there was capacity inversion.

Also I will fix the nit comments above.

> 
> Thanks,
> Ionela.
> 



-- 
Warm Regards
Thara
