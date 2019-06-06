Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6FB20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfFFQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:21:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49938 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbfFFQVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:21:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6879A78;
        Thu,  6 Jun 2019 09:21:21 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B963F690;
        Thu,  6 Jun 2019 09:21:20 -0700 (PDT)
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, coresight@lists.linaro.org, corbet@lwn.net
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
 <20190603190133.GA20462@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <99055755-6525-694e-a15d-5de7318a80da@arm.com>
Date:   Thu, 6 Jun 2019 17:21:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603190133.GA20462@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 03/06/2019 20:01, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Thu, May 30, 2019 at 04:11:17PM +0100, Suzuki K Poulose wrote:
>> Update the documentation to reflect the new naming scheme with
>> latest changes.
>>
>> Reported-by: Leo Yan <leo.yan@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   Documentation/trace/coresight.txt | 34 +++++++++++++++++++---------------
>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
>> index efbc832..7b427cf 100644
>> --- a/Documentation/trace/coresight.txt
>> +++ b/Documentation/trace/coresight.txt
>> @@ -326,16 +326,20 @@ amount of processor cores), the "cs_etm" PMU will be listed only once.
>>   A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
>>   listed along with configuration options within forward slashes '/'.  Since a
>>   Coresight system will typically have more than one sink, the name of the sink to
>> -work with needs to be specified as an event option.  Names for sink to choose
>> -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
>> +work with needs to be specified as an event option.
>> +On newer kernels the available sinks are listed in sysFS under:
>> +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
>>   
>> -	root@linaro-nano:~# ls /sys/bus/coresight/devices/
>> -		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
>> -		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
>> -		20070000.etr     20120000.replicator  220c0000.funnel
>> -		23040000.etm  23140000.etm     23340000.etm
>> +	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
>> +	tmc_etf0  tmc_etr0  tpiu0
>>   
>> -	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
>> +On older kernels, this may need to be found from the list of coresight devices,
>> +available under ($SYSFS)/bus/coresight/devices/:
>> +
>> +	root@localhost:/sys/bus/coresight/devices# ls
>> +	etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
>> +
>> +	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
> 
> On the "older" kernels you are referring to one would find the original naming
> convention.  Everything else looks good to me.

True, but do we care what we see there ? All we care about is the location,
where to find them. I could fix it, if you think thats needed.

Cheers
Suzuki
