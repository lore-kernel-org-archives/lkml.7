Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7976C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGBO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:29:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfGBO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:29:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717D228;
        Tue,  2 Jul 2019 07:29:23 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D93513F703;
        Tue,  2 Jul 2019 07:29:22 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
 <7111f9d1-62f2-504c-a7ba-958b1c659cc8@arm.com>
 <CAKfTPtBGDZ5P91hwGdHADYpcbOPeniDLE7x3-U9dXDvFVMAi1w@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d71ab6f7-3aab-adb3-f170-7757bde94f7c@arm.com>
Date:   Tue, 2 Jul 2019 15:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBGDZ5P91hwGdHADYpcbOPeniDLE7x3-U9dXDvFVMAi1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2019 11:00, Vincent Guittot wrote:
>> Does that want a
>>
>> Cc: stable@vger.kernel.org
>> Fixes: afdeee0510db ("sched: Fix imbalance flag reset")
> 
> I was not sure that this has been introduced by this patch or
> following changes. I haven't been able to test it on such old kernel
> with my platform
> 

Right, seems like

  65a4433aebe3 ("sched/fair: Fix load_balance() affinity redo path")

also played in this area. From surface level it looks like it only reduced
the amount of CPUs the load_balance() redo can use (and interestingly it
mentions the exact same bug as you observed, through triggered slightly
differently).

I'd be inclined to say that the issue was introduced by afdeee0510db, since
from looking at the code from that time I can see the issue happening:

- try to pull from a CPU with only tasks pinned to itself
- set sgc->imbalance
- redo with a CPU that sees no big imbalance
- goto out_balanced
- env.LBF_ALL_PINNED is still set but we clear sgc->imbalance

>>
>> ?
>>
