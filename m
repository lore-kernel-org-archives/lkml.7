Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB22C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355F4208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfFGIs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:48:56 -0400
Received: from foss.arm.com ([217.140.110.172]:35822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFGIsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:48:55 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 04:48:55 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3228D344;
        Fri,  7 Jun 2019 01:40:51 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3CB3F246;
        Fri,  7 Jun 2019 01:40:50 -0700 (PDT)
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
To:     leo.yan@linaro.org
Cc:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        corbet@lwn.net
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
 <20190603190133.GA20462@xps15> <99055755-6525-694e-a15d-5de7318a80da@arm.com>
 <20190607022136.GE5970@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <78c98c28-4f3f-825b-18e1-c71fb63a80eb@arm.com>
Date:   Fri, 7 Jun 2019 09:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607022136.GE5970@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

>>>>    A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
>>>>    listed along with configuration options within forward slashes '/'.  Since a
>>>>    Coresight system will typically have more than one sink, the name of the sink to
>>>> -work with needs to be specified as an event option.  Names for sink to choose
>>>> -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
>>>> +work with needs to be specified as an event option.
>>>> +On newer kernels the available sinks are listed in sysFS under:
>>>> +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
>>>> -	root@linaro-nano:~# ls /sys/bus/coresight/devices/
>>>> -		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
>>>> -		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
>>>> -		20070000.etr     20120000.replicator  220c0000.funnel
>>>> -		23040000.etm  23140000.etm     23340000.etm
>>>> +	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
>>>> +	tmc_etf0  tmc_etr0  tpiu0
>>>> -	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
>>>> +On older kernels, this may need to be found from the list of coresight devices,
>>>> +available under ($SYSFS)/bus/coresight/devices/:
>>>> +
>>>> +	root@localhost:/sys/bus/coresight/devices# ls
>>>> +	etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
>>>> +
>>>> +	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
>>>
>>> On the "older" kernels you are referring to one would find the original naming
>>> convention.  Everything else looks good to me.
>>
>> True, but do we care what we see there ? All we care about is the location,
>> where to find them. I could fix it, if you think thats needed.
> 
> IIUC, either the old kernel or newer kernel, both we can find the event
> from ($SYSFS)/bus/event_source/devices/cs_etm/sinks/; the only
> difference between them is the naming convention.

The cs_etm/sinks was only added with the CPU-wide trace support. So, if someone
refers to this document alone and then tries to do something on on older kernel,
which is quite possible for a production device running a stable kernel, {s,}he
might be surprised.

> 
> So the doc can use the same location to find event for both new and
> old kernel, and explain the naming convention difference?

My question is really, does the naming convention matter ? What you see
under the directory is the name. But yes, I am open to add a section to
explain the fact that we changed the naming scheme, if everyone agrees
to it.

Cheers
Suzuki
