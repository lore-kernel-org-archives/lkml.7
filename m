Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D694C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6B2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfG2I7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:59:31 -0400
Received: from foss.arm.com ([217.140.110.172]:40234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG2I7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:59:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09400337;
        Mon, 29 Jul 2019 01:59:31 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC823F575;
        Mon, 29 Jul 2019 01:59:29 -0700 (PDT)
Subject: Re: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running
 bw in push_dl_task()
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-2-dietmar.eggemann@arm.com>
 <20190726121159.10fd1138@sweethome>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <531f753a-57ba-408f-42e0-15252d7b1c32@arm.com>
Date:   Mon, 29 Jul 2019 09:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726121159.10fd1138@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 11:11 AM, luca abeni wrote:
> Hi Dietmar,
> 
> On Fri, 26 Jul 2019 09:27:52 +0100
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
>> push_dl_task() always calls deactivate_task() with flags=0 which sets
>> p->on_rq=TASK_ON_RQ_MIGRATING.
> 
> Uhm... This is a recent change in the deactivate_task() behaviour,
> right? Because I tested SCHED_DEADLINE a lot, but I've never seen this
> issue :)

Looks like it was v5.2 commit 7dd778841164 ("sched/core: Unify p->on_rq
updates").

> Anyway, looking at the current code the change looks OK. Thanks for
> fixing this issue!

[...]
