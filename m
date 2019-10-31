Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274502086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfJaWQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:16:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:16:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6201F1;
        Thu, 31 Oct 2019 15:16:08 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441703F6C4;
        Thu, 31 Oct 2019 15:16:06 -0700 (PDT)
Subject: Re: NULL pointer dereference in pick_next_task_fair
To:     Ram Muthiah <rammuthiah@google.com>,
        Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        mingo@kernel.org, pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
References: <20191028174603.GA246917@google.com>
 <20191029113411.GP4643@worktop.programming.kicks-ass.net>
 <20191029115000.GA11194@google.com>
 <CA+CXyWsoW8ann52pcR66ejRmjJ=4QmoaHTRVhb3=ohe0ZDnm-A@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c3f65c65-9ed3-5c36-ed5a-e84a38d5aa1b@arm.com>
Date:   Thu, 31 Oct 2019 23:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+CXyWsoW8ann52pcR66ejRmjJ=4QmoaHTRVhb3=ohe0ZDnm-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 23:50, Ram Muthiah wrote:
> Quentin and I were able to create a setup which reproduces the issue.
> 
> Given this, I tried Peter's proposed fix and was still able to reproduce the
> issue unfortunately. Current patch is located here -
> https://android-review.googlesource.com/c/kernel/common/+/1153487
> 
> Our mitigation for this issue on the android-mainline branch has been to
> revert 67692435c411 ("sched: Rework pick_next_task() slow-path").
> https://android-review.googlesource.com/c/kernel/common/+/1152564
> 

Still no cigar, but one thing to note is that we got a similar splat on a
Juno just yesterday, here it is fed through decode_stacktrace.sh:

[   22.930829] Mem abort info:
[   22.935904]   ESR = 0x96000006
[   22.938924]   EC = 0x25: DABT (current EL), IL = 32 bits
[   22.944178]   SET = 0, FnV = 0
[   22.947197]   EA = 0, S1PTW = 0
[   22.950300] Data abort info:
[   22.953145]   ISV = 0, ISS = 0x00000006
[   22.956937]   CM = 0, WnR = 0
[   22.959870] user pgtable: 4k pages, 48-bit VAs, pgdp=00000009f3905000
[   22.966243] [0000000000000040] pgd=00000009efa6e003, pud=00000009f41c3003, pmd=0000000000000000
[   22.974858] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[   22.980369] Modules linked in: tda998x drm_kms_helper drm crct10dif_ce ip_tables x_tables ipv6 nf_defrag_ipv6
[   22.990200] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc2-00001-gaa57157be69f #1
[   22.998036] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 19 2018
[   23.008710] pstate: 60000085 (nZCv daIf -PAN -UAO)
[   23.013457] pc : set_next_entity (kernel/sched/fair.c:4156)
[   23.017511] lr : pick_next_task_fair (kernel/sched/fair.c:6829 (discriminator 1))
[   23.021991] sp : ffff800011a13e10
[   23.025267] x29: ffff800011a13e10 x28: 0000000000000000
[   23.030525] x27: ffff800011a13f10 x26: ffff800010c205ec
[   23.035782] x25: ffff000975cea108 x24: ffff800011789000
[   23.041038] x23: ffff8000113cf000 x22: ffff000975ce9b80
[   23.046294] x21: ffff00097ef78d40 x20: ffff000974e21a00
[   23.051550] x19: 0000000000000000 x18: 0000000000000000
[   23.056806] x17: 0000000000000000 x16: 0000000000000000
[   23.062062] x15: 0000000000000000 x14: 00000000000001ad
[   23.067317] x13: 0000000000000001 x12: 071c71c71c71c71c
[   23.072573] x11: 0000000000000500 x10: ffff00097ef77dc8
[   23.077829] x9 : 0000000000000087 x8 : ffff00097ef77de8
[   23.083085] x7 : 0000000000000003 x6 : 0000000000000000
[   23.088340] x5 : 0000000000000000 x4 : 0000000000000000
[   23.093596] x3 : 000000054f6e7800 x2 : 0000000000000000
[   23.098851] x1 : 0000000000000000 x0 : ffff000974e21a00
[   23.104107] Call trace:
[   23.106527] set_next_entity (kernel/sched/fair.c:4156)
[   23.110236] pick_next_task_fair (kernel/sched/fair.c:6829 (discriminator 1))
[   23.114377] __schedule (kernel/sched/core.c:3920 kernel/sched/core.c:4039)
[   23.117828] schedule_idle (kernel/sched/core.c:4165 (discriminator 1))
[   23.121365] do_idle (./arch/arm64/include/asm/current.h:19 ./arch/arm64/include/asm/preempt.h:31 kernel/sched/idle.c:275)
[   23.124557] cpu_startup_entry (kernel/sched/idle.c:355 (discriminator 1))
[   23.128439] secondary_start_kernel (arch/arm64/kernel/smp.c:262)

The faulty line is the very first se dereference in set_next_entity().
As Peter pointed out on IRC, this happens in the 'simple' path (prev is the
idle task).
