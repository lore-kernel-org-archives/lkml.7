Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHPOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:02:08 -0400
Received: from foss.arm.com ([217.140.110.172]:57462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHPOCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:02:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0769C344;
        Fri, 16 Aug 2019 07:02:07 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD583F694;
        Fri, 16 Aug 2019 07:02:05 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com, pjt@google.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
 <2994a6ee-9238-5285-3227-cb7084a834c8@arm.com>
 <7C1833A8-27A4-4755-9B1E-335C20207A66@linux.alibaba.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <39d1affb-9cfa-208d-8bf4-f4c802e8c7f9@arm.com>
Date:   Fri, 16 Aug 2019 15:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7C1833A8-27A4-4755-9B1E-335C20207A66@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 08:08, Liangyan wrote:
> Please check below dmesg log with “WARN_ON(cfs_rq->runtime_remaining > 0)”. If apply my patch, the warning is gone.  Append the reproducing case in the end.
> 

[...]

Huh, thanks for the log & the reproducer. I'm still struggling to
understand how we could hit the condition you're adding, since
account_cfs_rq_runtime() shouldn't be called for throttled cfs_rqs (which
I guess is the bug). Also, if the cfs_rq is throttled, shouldn't we
prevent any further decrement of its ->runtime_remaining ?

I had a look at the callers of account_cfs_rq_runtime():

- update_curr(). Seems safe, but has a cfs_rq->curr check at the top. This
  won't catch throttled cfs_rq's because AFAICT their curr pointer isn't
  NULL'd on throttle.

- check_enqueue_throttle(). Already has a cfs_rq_throttled() check.

- set_next_task_fair(). Peter shuffled the whole set/put task thing
  recently but last I looked it seemed all sane.

I'll try to make sense of it, but have also Cc'd Paul since unlike me he
actually knows this stuff.
