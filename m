Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2549BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92CC2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfKGMhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:37:12 -0500
Received: from foss.arm.com ([217.140.110.172]:55416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:37:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22DD31B;
        Thu,  7 Nov 2019 04:37:11 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 771D93F6C4;
        Thu,  7 Nov 2019 04:37:10 -0800 (PST)
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
To:     Quentin Perret <qperret@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lwe@gmail.com>, Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20191107090808.GW29418@shao2-debian>
 <fc023bbd-e282-c986-b43b-18ac31b2e362@arm.com>
 <20191107120922.GA82729@google.com> <20191107121551.GB82729@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6a23a062-9b82-668d-7945-8da34f4dc5f0@arm.com>
Date:   Thu, 7 Nov 2019 12:37:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107121551.GB82729@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 12:15, Quentin Perret wrote:
> On Thursday 07 Nov 2019 at 12:09:22 (+0000), Quentin Perret wrote:
>> sched_move_task() follows what Peter called the 'change' pattern, so I'm
>> thinking this is most likely the same issue. Dropping the lock causes an
>> unmitigated race between sched_move_task() and pick_next_task_dl(), so
>> hilarity ensues (set_next_task() being called twice for instance).
> 
> Bah, scratch that. 10e7071b2 is clearly before the pick_next_task()
> rework, so that's not it :(
> 

And besides we don't drop the lock until reaching pick_next_task_fair(),
and the splat says it died on pick_next_task_dl() which happens earlier.

> Quentin
> 
