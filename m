Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E555CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEDB20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNUfXkE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfJaQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:52:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40384 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfJaQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:52:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so9440351qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/XiC2ZxjCtZ5uzLXs9hKjHS/XSAkVhSe7Tt9CJU2+Ic=;
        b=WNUfXkE6fJn1rEDdR3SgO+5IgyX8I6P83vc6xBGHR5+TlFagBoCo2bpHfKnwUEOjP2
         PclZ+edzEjje6QswBdGQC3wfjRz82OKZ85NT0m3sZ/jTkTzaazTpRZaElgbcAXU6BnNK
         ClznPQkky76xTZ6frTP7CjQOFxlV9Ew9ip5p49/NP7vvwWyI+pPXWqA6Mq+ejVkLXZwl
         4fFeh7FbwiJFyiNYS6wu5dVteVPdv6z1y1hmtkbUzlYWM0CxBqeHxPNWS3imf9e9/pBA
         sMVxtNr5FealJmTjO4/41AUnEe1KQIP4bHoMNcmDsfPX2276TiARiYv9eA6gEie2YOnY
         7eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/XiC2ZxjCtZ5uzLXs9hKjHS/XSAkVhSe7Tt9CJU2+Ic=;
        b=JTY+YmNig0f/aFx3GH4TlTKavws813ry4gHY8F8RO2nifDk6+IFC1jTSDfuIXhCxkN
         a2DrOjp9yzVQnTybA8Lf3IZQBtiV5IuJN4S6eua3sQyrK5MrwqcnL5FcZyh6DZLPqnp+
         9DV+X9Hs2C0MTiHBPNl7vM9SoqtOYe3WlfsmzJ2xEloyHeik71MLqlCMtOVEyJAJM0xT
         Dk37G6LvLmMVAMZPVwZ0h2VlSJlcfp0tQ9Nrf9n7NYlCVZ46EqtiXarDFj54xOisUC9Q
         iBSEc5fuI1JKIEG/Y7c6XEyyP/jjM+0/0wOnnxmESdr05x34/AzmrPxdGnuI/Kq0Ygsj
         bzLg==
X-Gm-Message-State: APjAAAUCWGlus7uZBl3YYB++1iGny5UQg9366fAqcDX8coZ8DYw4IjuI
        vUaaJJB9lx/9+d+p7DVsrCcaww==
X-Google-Smtp-Source: APXvYqxPq+Ni+oe0HbjA7+2J66BVDarJ7RzmkP5j4xocGrr14Uil4ECipOvCxCHwhUXkc4wAGz5Ytw==
X-Received: by 2002:ad4:5893:: with SMTP id dz19mr5718758qvb.87.1572540736125;
        Thu, 31 Oct 2019 09:52:16 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id k40sm2523832qta.76.2019.10.31.09.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:52:15 -0700 (PDT)
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <20191031094420.GA19197@e108754-lin> <5DBB0EB0.9050106@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBB113E.8080804@linaro.org>
Date:   Thu, 31 Oct 2019 12:52:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5DBB0EB0.9050106@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 12:41 PM, Thara Gopinath wrote:
> On 10/31/2019 05:44 AM, Ionela Voinescu wrote:
>> Hi Thara,
>>
>> On Tuesday 22 Oct 2019 at 16:34:19 (-0400), Thara Gopinath wrote:
>>> Thermal governors can respond to an overheat event of a cpu by
>>> capping the cpu's maximum possible frequency. This in turn
>>> means that the maximum available compute capacity of the
>>> cpu is restricted. But today in the kernel, task scheduler is 
>>> not notified of capping of maximum frequency of a cpu.
>>> In other words, scheduler is unware of maximum capacity
>>
>> Nit: s/unware/unaware
>>
>>> restrictions placed on a cpu due to thermal activity.
>>> This patch series attempts to address this issue.
>>> The benefits identified are better task placement among available
>>> cpus in event of overheating which in turn leads to better
>>> performance numbers.
>>>
>>> The reduction in the maximum possible capacity of a cpu due to a 
>>> thermal event can be considered as thermal pressure. Instantaneous
>>> thermal pressure is hard to record and can sometime be erroneous
>>> as there can be mismatch between the actual capping of capacity
>>> and scheduler recording it. Thus solution is to have a weighted
>>> average per cpu value for thermal pressure over time.
>>> The weight reflects the amount of time the cpu has spent at a
>>> capped maximum frequency. Since thermal pressure is recorded as
>>> an average, it must be decayed periodically. Exisiting algorithm
>>> in the kernel scheduler pelt framework is re-used to calculate
>>> the weighted average. This patch series also defines a sysctl
>>> inerface to allow for a configurable decay period.
>>>
>>> Regarding testing, basic build, boot and sanity testing have been
>>> performed on db845c platform with debian file system.
>>> Further, dhrystone and hackbench tests have been
>>> run with the thermal pressure algorithm. During testing, due to
>>> constraints of step wise governor in dealing with big little systems,
>>> trip point 0 temperature was made assymetric between cpus in little
>>> cluster and big cluster; the idea being that
>>> big core will heat up and cpu cooling device will throttle the
>>> frequency of the big cores faster, there by limiting the maximum available
>>> capacity and the scheduler will spread out tasks to little cores as well.
>>>
>>
>> Can you please share the changes you've made to sdm845.dtsi and a kernel
>> base on top of which to apply your patches? I would like to reproduce
>> your results and run more tests and it would be good if our setups were
>> as close as possible.
> Hi Ionela
> Thank you for the review.
> So I tested this on 5.4-rc1 kernel. The dtsi changes is to reduce the
> thermal trip points for the big CPUs to 60000 or 70000 from the default
> 90000. I did this for 2 reasons
> 1. I could never get the db845 to heat up sufficiently for my test cases
> with the default trip.
> 2. I was using the default step-wise governor for thermal. I did not
> want little and big to start throttling by the same % because then the
> task placement ratio will remain the same between little and big cores.
> 

So I am not sure though if this is the set up under which Daniel ran
glbench . I will let him comment on it.

> 
> 
> 


-- 
Warm Regards
Thara
