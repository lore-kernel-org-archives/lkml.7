Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C8C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0552072A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfKORKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:10:08 -0500
Received: from foss.arm.com ([217.140.110.172]:33936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKORKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:10:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F6D31B;
        Fri, 15 Nov 2019 09:10:08 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE003F6C4;
        Fri, 15 Nov 2019 09:10:06 -0800 (PST)
Subject: Re: [PATCH v2] sched/uclamp: Fix overzealous type replacement
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
References: <20191115103908.27610-1-valentin.schneider@arm.com>
 <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
 <f4fcc45e-7609-3836-162a-0a1839134bcf@arm.com>
Message-ID: <2dce8a83-b358-d975-bf43-8088b3bc5557@arm.com>
Date:   Fri, 15 Nov 2019 17:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f4fcc45e-7609-3836-162a-0a1839134bcf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 14:29, Valentin Schneider wrote:
> On 15/11/2019 14:07, Vincent Guittot wrote:
>>> -static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
>>> +static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
>>
>> Out of curiosity why uclamp decided to use unsigned int to manipulate
>> utilization instead of unsigned long which is the type of util_avg ?
>>
> 
> I didn't stare at the discussion much, but I think it stems from the
> design choices behind struct uclamp_se: everything is crammed in an unsigned
> int bitfield. Let me see if I can find some relevant mails.
> 

So I think a relevant mail is:

https://lore.kernel.org/lkml/20180912174236.GB24106@hirez.programming.kicks-ass.net/

Other than that, the uclamp_se.value field was 'int' in v1 and has been
'unsigned int' for all following versions. uclamp_bucket.value is a bitfield
of an 'unsigned long' just because we want more headroom for the tasks count,
AFAICT.
