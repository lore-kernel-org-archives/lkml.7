Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D455CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449652173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfJ3RZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:25:16 -0400
Received: from foss.arm.com ([217.140.110.172]:38426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfJ3RZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:25:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131F71FB;
        Wed, 30 Oct 2019 10:25:15 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976653F6C4;
        Wed, 30 Oct 2019 10:25:11 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
References: <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
 <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
 <20191030171914.GF1686@pauld.bos.csb>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4c52d81f-4b3b-d7e8-c124-b90b4584a6d3@arm.com>
Date:   Wed, 30 Oct 2019 18:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030171914.GF1686@pauld.bos.csb>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 18:19, Phil Auld wrote:
>> Well from the code nobody but us (asymmetric capacity systems) set
>> SD_BALANCE_WAKE. I was however curious if there were some folks who set it
>> with out of tree code for some reason.
>>
>> As Dietmar said, not having SD_BALANCE_WAKE means you'll never go through
>> the slow path on wakeups, because there is no domain with SD_BALANCE_WAKE for
>> the domain loop to find. Depending on your topology you most likely will
>> go through it on fork or exec though.
>>
>> IOW wake_wide() is not really widening the wakeup scan on wakeups using
>> mainline topology code (disregarding asymmetric capacity systems), which
>> sounds a bit... off.
> 
> Thanks. It's not currently set. I'll set it and re-run to see if it makes
> a difference. 
> 

Note that it might do more harm than good, it's not set in the default
topology because it's too aggressive, see 

  182a85f8a119 ("sched: Disable wakeup balancing")

> 
> However, I'm not sure why it would be making a difference for only the cgroup
> case. If this is causing issues I'd expect it to effect both runs. 
> 
> In general I think these threads want to wake up the last cpu they were on.
> And given there are fewer cpu bound tasks that CPUs that wake cpu should,
> more often than not, be idle. 
> 
> 
> Cheers,
> Phil
> 
> 
> 
