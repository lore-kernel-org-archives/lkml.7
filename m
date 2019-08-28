Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F785C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6F2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfH1KZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:25:06 -0400
Received: from foss.arm.com ([217.140.110.172]:56982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1KZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:25:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8BA337;
        Wed, 28 Aug 2019 03:25:04 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFFA23F59C;
        Wed, 28 Aug 2019 03:25:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
 <ee4ac9c8-ac70-e56a-2aa9-9cce2e5aa25b@arm.com>
 <CAKfTPtA1-8u2LCiq5o1go_M7FywBao-EDxCHMfsxEN8es4pXcw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <020cd226-ded2-274b-f62b-8db17b65e729@arm.com>
Date:   Wed, 28 Aug 2019 11:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA1-8u2LCiq5o1go_M7FywBao-EDxCHMfsxEN8es4pXcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2019 10:26, Vincent Guittot wrote:
[...]
>>>   busiest group.
>>> - calculate_imbalance() decides what have to be moved.
>>
>> That's nothing new, isn't it? I think what you mean there is that the
> 
> There is 2 things:
> -part of the algorithm is new and fixes wrong task placement
> -everything has been consolidated in the 3 functions above whereas
> there were some bypasses and hack in the current code
> 

Right, something like that could be added in the changelog then.

[...]
>>> @@ -7745,10 +7793,10 @@ struct sg_lb_stats {
>>>  struct sd_lb_stats {
>>>       struct sched_group *busiest;    /* Busiest group in this sd */
>>>       struct sched_group *local;      /* Local group in this sd */
>>> -     unsigned long total_running;
>>
>> Could be worth calling out in the log that this gets snipped out. Or it
>> could go into its own small cleanup patch, since it's just an unused field.
> 
> I can mention it more specifically in the log but that's part of those
> meaningless metrics which is no more used

I'm a git blame addict so I like having things split up as much as possible
(within reason). Since that cleanup can live in its own patch, it should
be split as such IMO.
