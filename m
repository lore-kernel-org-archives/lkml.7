Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D821D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439210AbfJYJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:49:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439180AbfJYJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9075628;
        Fri, 25 Oct 2019 02:49:36 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485953F71F;
        Fri, 25 Oct 2019 02:49:35 -0700 (PDT)
Subject: Re: [RESEND PATCH v4] drm: Don't free jobs in
 wait_event_interruptible()
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Sharat Masetty <smasetty@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>
References: <20191024162424.38548-1-steven.price@arm.com>
 <CAH9NwWdviH0gohPxZY97izenbSDnbQCL4kLeANg7UeCR7u1UUw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d703ad9c-8aca-ca29-5727-d3e2ddad62bf@arm.com>
Date:   Fri, 25 Oct 2019 10:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAH9NwWdviH0gohPxZY97izenbSDnbQCL4kLeANg7UeCR7u1UUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2019 10:43, Christian Gmeiner wrote:
> Am Do., 24. Okt. 2019 um 18:25 Uhr schrieb Steven Price <steven.price@arm.com>:
>>
>> drm_sched_cleanup_jobs() attempts to free finished jobs, however because
>> it is called as the condition of wait_event_interruptible() it must not
>> sleep. Unfortuantly some free callbacks (notibly for Panfrost) do sleep.
>>
>> Instead let's rename drm_sched_cleanup_jobs() to
>> drm_sched_get_cleanup_job() and simply return a job for processing if
>> there is one. The caller can then call the free_job() callback outside
>> the wait_event_interruptible() where sleeping is possible before
>> re-checking and returning to sleep if necessary.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> 
> Without this patch I get the following warning:

Thanks, if you've got an (easily) reproducible case, can you check which
commit this fixes. I *think*:

Fixes: 5918045c4ed4 ("drm/scheduler: rework job destruction")

But I haven't got a reliable way of reproducing this (with Panfrost).

Thanks,

Steve

> 
> [  242.935254] ------------[ cut here ]------------
> [  242.940044] WARNING: CPU: 2 PID: 109 at kernel/sched/core.c:6731
> __might_sleep+0x94/0xa8
> [  242.948242] do not call blocking ops when !TASK_RUNNING; state=1
> set at [<38751e36>] prepare_to_wait_event+0xa8/0x180
> [  242.958923] Modules linked in:
> [  242.962010] CPU: 2 PID: 109 Comm: 130000.gpu Not tainted 5.4.0-rc4 #10
> [  242.968551] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  242.975112] [<c0113160>] (unwind_backtrace) from [<c010cf34>]
> (show_stack+0x10/0x14)
> [  242.982879] [<c010cf34>] (show_stack) from [<c0c065ec>]
> (dump_stack+0xd8/0x110)
> [  242.990213] [<c0c065ec>] (dump_stack) from [<c0128adc>] (__warn+0xc0/0x10c)
> [  242.997194] [<c0128adc>] (__warn) from [<c0128f10>]
> (warn_slowpath_fmt+0x8c/0xb8)
> [  243.004697] [<c0128f10>] (warn_slowpath_fmt) from [<c01598bc>]
> (__might_sleep+0x94/0xa8)
> [  243.012810] [<c01598bc>] (__might_sleep) from [<c0c246e4>]
> (__mutex_lock+0x38/0xa1c)
> [  243.020571] [<c0c246e4>] (__mutex_lock) from [<c0c250e4>]
> (mutex_lock_nested+0x1c/0x24)
> [  243.028600] [<c0c250e4>] (mutex_lock_nested) from [<c064f020>]
> (etnaviv_cmdbuf_free+0x40/0x8c)
> [  243.037233] [<c064f020>] (etnaviv_cmdbuf_free) from [<c06503a0>]
> (etnaviv_submit_put+0x38/0x1c8)
> [  243.046042] [<c06503a0>] (etnaviv_submit_put) from [<c064177c>]
> (drm_sched_cleanup_jobs+0xc8/0xec)
> [  243.055021] [<c064177c>] (drm_sched_cleanup_jobs) from [<c06419b4>]
> (drm_sched_main+0x214/0x298)
> [  243.063826] [<c06419b4>] (drm_sched_main) from [<c0152890>]
> (kthread+0x140/0x158)
> [  243.071329] [<c0152890>] (kthread) from [<c01010b4>]
> (ret_from_fork+0x14/0x20)
> [  243.078563] Exception stack(0xec691fb0 to 0xec691ff8)
> [  243.083630] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [  243.091822] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  243.100013] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  243.106795] irq event stamp: 321
> [  243.110098] hardirqs last  enabled at (339): [<c0193854>]
> console_unlock+0x430/0x620
> [  243.117864] hardirqs last disabled at (346): [<c01934cc>]
> console_unlock+0xa8/0x620
> [  243.125592] softirqs last  enabled at (362): [<c01024e0>]
> __do_softirq+0x2c0/0x590
> [  243.133232] softirqs last disabled at (373): [<c0130ed0>]
> irq_exit+0x100/0x18c
> [  243.140517] ---[ end trace 8afcd79e9e2725b2 ]---
> 

