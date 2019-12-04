Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB304C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4E920675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfLDKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:09:24 -0500
Received: from foss.arm.com ([217.140.110.172]:53902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfLDKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:09:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25FF41FB;
        Wed,  4 Dec 2019 02:09:22 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF7C3F52E;
        Wed,  4 Dec 2019 02:09:20 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <65ff440a-187e-43e9-37b4-52fa381283f2@arm.com>
Date:   Wed, 4 Dec 2019 10:09:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 09:42, Qais Yousef wrote:
> On 12/04/19 09:06, Vincent Guittot wrote:
>> Hi John,
>>
>> On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> wrote:
>>>
>>> With today's linus/master on db845c running android, I'm able to
>>> fairly easily reproduce the following crash. I've not had a chance to
>>> bisect it yet, but I'm suspecting its connected to Vincent's recent
>>> rework.
>>
>> Does the crash happen randomly or after a specific action ?
>> I have a db845 so I can try to reproduce it locally.
> 
> Isn't there a chance we use local_sgs without initializing it in that function?
> AFAICS we define local_sgs on the stack but not always could be populated with
> the right values. I can't see tmp_sgs being used in the function too. Could
> this cause the/a problem?
> 
>  8377         struct sg_lb_stats local_sgs, tmp_sgs;
> .
> .
> .
>  8399                 if (local_group) {
>  8400                         sgs = &local_sgs;
>  8401                         local = group;
>  8402                 } else {
>  8403                         sgs = &tmp_sgs;
>  8404                 }
>  8405
>  8406                 update_sg_wakeup_stats(sd, group, sgs, p);
> 

local_sgs is initialized in the first update_sg_wakeup_stats() entry
(the local sched_group is always the first one in the sd->groups list),
and tmp_sgs is whatever non local group we're iterating over, see:

		if (local_group) {
			sgs = &local_sgs;
			local = group;
		} else {
			sgs = &tmp_sgs;
		}

and that sgs is populated in

		update_sg_wakeup_stats(sd, group, sgs, p);


> Cheers
> 
> --
> Qais Youef
> 
