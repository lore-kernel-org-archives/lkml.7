Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD68C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C69206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLDXW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:22:29 -0500
Received: from foss.arm.com ([217.140.110.172]:39562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfLDXW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:22:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C4D328;
        Wed,  4 Dec 2019 15:22:27 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C243F718;
        Wed,  4 Dec 2019 15:22:26 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix find_idlest_group() to handle CPU
 affinity
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, qais.yousef@arm.com
References: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <738ad52b-d94e-c31a-3d40-56a0aba64453@arm.com>
Date:   Wed, 4 Dec 2019 23:22:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 18:21, Vincent Guittot wrote:
> Because of CPU affinity, the local group can be skipped which breaks the
> assumption that statistics are always collected for local group. With
> uninitialized local_sgs, the comparison is meaningless and the behavior
> unpredictable. This can even end up to use local pointer which is to
> NULL in this case.
> 
> If the local group has been skipped because of CPU affinity, we return
> the idlest group.
> 

I stared at find_idlest_group() before the rework out of curiosity and
AFAICT the "never visit local group" thing was there already. However, we
would only use the load and spare capacity of that group, and the relevant
variables where initialized to ULONG_MAX and 0 respectively. This would lead
us to return 'idlest' (or 'most_spare_sg', but it's the same as 'idlest' now).

So IMO this is just restoring the previous behaviour, which is what we want
methinks.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
