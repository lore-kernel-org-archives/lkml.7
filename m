Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF29C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB59A2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK0P1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:27:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfK0P1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:27:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19F430E;
        Wed, 27 Nov 2019 07:27:40 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391603F68E;
        Wed, 27 Nov 2019 07:27:40 -0800 (PST)
Subject: Re: RT scheduler is suboptimal when an RT thread preempts another RT
 in terms of choosing a core to migrate
To:     "Rafikov, Rustem" <Rustem.Rafikov@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CH2PR19MB3896AFE1D13AD88A17160860FC700@CH2PR19MB3896.namprd19.prod.outlook.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c059a741-ceaa-4801-8237-afd2ffbb0f5e@arm.com>
Date:   Wed, 27 Nov 2019 16:27:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CH2PR19MB3896AFE1D13AD88A17160860FC700@CH2PR19MB3896.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 01:43, Rafikov, Rustem wrote:
> Hi,
> 
> When an RT thread preempts another RT thread it migrates the latter one to a core. 
> The way RT scheduler chooses a core is quite suboptimal. Let me give an example from a "production" server with 32 total physical cores.
> There are SCHED_NORMAL threads (affined to particular core each) and 2+ groups of RT threads (allowed to run everywhere). 
> Scheduler trace showed that most cases RT scheduler preempts a normal prio thread from a core to put evicted RT one on rather than using an idle core the system had a plenty of which according the trace.
> 
> I reproduced the behavior on a vanilla 4.18.0 kernel with a micro test where I created 10 SCHED_NORMAL affined to 10 cores,
> 3 RT/69 with 0xFFFFFFFF affinity and a few RT/79 threads kicking off other RTs from CPUs every 5 msec. 
> Other cores were idle but RT/69 never migrated to them.
> 
> The problem seems to be in how mapping in cpupri structure is updated:
> 1) Fair scheduler does not update/read from there. So we don't know if a SCHED_NORMAL left a cpu. Well, that may be OK.
> 2) RT scheduler uses cpupri to find a core to migrate to, but it updates it incorrectly:
> - RT->RT works fine [2]
> - But RT->IDLE or RT->SCHED_NORMAL [1] is not right - in both cases it sets RT_MAX(100) which is min NORMAL!
> It's totally okay to set it to RT_MAX for all of NORMALs but not for IDLE. BTW - IDLE means swapper which has pri=120 :)
> 
> See below traced with kprobes.
> 
> [1] IDLE->RT/79->IDLE
> #1. <idle>-0     [001] d.h. 14717592.107294: myprobe3: (cpupri_set+0x0/0x100) cpu=1 newp=14 oldpri=0001
> #2. <...>-157332 [001] d... 14717592.107313: myprobe3: (cpupri_set+0x0/0x100) cpu=1 newp=64 oldpri=0051
> 
> Decoding the output at #1 cpu=1 newp=14 oldpri=0001
> - cpu = 1 - it happens on core 1
> - newp=14 - the priority of a thread being scheduled in is 0x14 which is RT-79 (our test thread)
> - oldpri=0001 - a priority of previous thread on that CPU. "1" means NORMAL in 0-101 scale. This is incorrect by itself because the core was IDLE!
> Let's try to figure out why it is not '0' (IDLE) by looking at the last line - cpu=1 newp=64 oldpri=0051
> - newp=64 says that the priority of a thread being scheduled in is 0x64 which min NORMAL. So, it is not 140 how we could expect when switching to IDLE thread.
> - oldpri=0051 this is 81 - priority of our RT-79 thread in 0-101 scale
> 
> 
> [2] RT/69->RT/79>RT/69
> #1. <...>-158253 [001] d.h. 14723119.396120: myprobe3: (cpupri_set+0x0/0x100) cpu=1 newp=14 oldpri=0047 #2. <...>-158254 [001] d... 14723119.396122: myprobe3: (cpupri_set+0x0/0x100) cpu=1 newp=1e oldpri=0051 Line #1 -  "cpu=1 newp=14 oldpri=0047"  switching to 0x14, RT-79 thread
> - old pri currently on cpu is 0x47 in 0-101 scale OR RT-69
> Line#2 - switching to 0x1e - RT-69. This is correct value of the thread being scheduled in!
> - oldppri=0051 - RT-69 in 0-101 scale

I have seen the same thing. cp->pri_to_cpu[CPUPRI_IDLE] (CPUPRI_IDLE=0)
is never used. So cpupri_find() always skips over it.

There was
https://lore.kernel.org/r/1415260327-30465-2-git-send-email-pang.xunlei@linaro.org
in 2014 but it didn't go mainline.
