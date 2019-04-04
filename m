Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB267C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7064320855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nMxrWD8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfDDSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:39:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44094 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDDSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:39:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34Id6jZ022168;
        Thu, 4 Apr 2019 13:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554403146;
        bh=k2FUpvDVR8Bx/qAVbyK8j7vj7T8VgY6V4ucAFGtit7s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nMxrWD8YRkHrw1C8B6KpRcdd53MgOYCoB6czCU75+XP1fEuMezsESWz0VgCAKRfjQ
         On/J6AZhoP2bN1jHSDPbfYtvQe4yF2dmilIl77f9ptB0UJzQve+UGxVa/NPuBvvect
         c8qgGTOeE7VlJfoLFEfgTDSYU/8gomTebO0ti50o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34Id61V037201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 13:39:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 13:39:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 13:39:06 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34Id3d2069458;
        Thu, 4 Apr 2019 13:39:04 -0500
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
To:     Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch> <20190404141730.GE49658@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <0cb5a5e3-6801-9888-6b17-c1f54f597a16@ti.com>
Date:   Fri, 5 Apr 2019 00:09:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404141730.GE49658@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/19 7:47 PM, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
>> Hello Nathan,
>>
>> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
>>> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
>>> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
>>> static because its prototype was not defined in a header. Unfortunately,
>>> this causes a build warning on multi_v7_defconfig because this function
>>> is not used anywhere in this translation unit:
>>>
>>> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
>>> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
>>>
>>> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
>>> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
>>> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
>>> Make unexported functions static"), which is probably where this should
>>> have happened.
>>
>> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
>> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
>> function being removed here). It is a part of an attempt to add event capture
>> for OMAP. Of course I would like this functionality to be implemented, but
>> as I do not have a time to continue, I cannot really object removing this
>> function.
>>
>> Just in case you'd be interested in finishing this task ;-)
> 
> Well seems like no other takers :) We can always find the missing
> function in git history when needed, so I suggest we apply this.
> 
> Adding Keerthy to Cc as he just posted a similar patch.

I posted the duplicate. Thanks for looping in.

> 
> Regards,
> 
> Tony
> 
