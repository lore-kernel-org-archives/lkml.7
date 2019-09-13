Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E458C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5349F20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J9wIDRik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403886AbfIMPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:21:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:56164 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbfIMPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:21:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 233132D13B1;
        Fri, 13 Sep 2019 11:21:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CFoNyovJVe_P; Fri, 13 Sep 2019 11:20:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3EEBF2D13AB;
        Fri, 13 Sep 2019 11:20:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3EEBF2D13AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568388057;
        bh=uyjeHRABbg33hV2BOaw8TWyHoPbqXM+813BJEngMtQw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=J9wIDRikZY7PrhNElCf5wOIuUg9NgaBfuo0Xnk1hxPG5kCr/WLon7xAceBqgqbVR+
         R9E6wpEISVY0EEruJ6edkV7y0HE446R41OhHKnOd7Ks8BtjYhNTDQZbzg9XWKxLX7a
         M0T1jBM1QyehUYnTKp0TKz+6MegBsiP5a0ds+oIEVhgVLunV+14Opo65Rkk7snMWBI
         fr0Jzi6TM1WOUPjUuyGLuXlTCu0+YnKEMX23rfG5cZ2obL2ftkcuddn/0jfGZsDRFT
         MxmoNKlRw+AlM0A4Mc6dybQVR4ZIuH/6e61xIOX6jpzzAJ1Jc3P3YN3xQSn3DGOUcy
         yX4vgP1KgYG1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id utNUGfVAnKKJ; Fri, 13 Sep 2019 11:20:57 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 256932D13A2;
        Fri, 13 Sep 2019 11:20:57 -0400 (EDT)
Date:   Fri, 13 Sep 2019 11:20:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1629045844.2645.1568388056947.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190909110036.GC6719@redhat.com>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <20190908134909.12389-1-mathieu.desnoyers@efficios.com> <20190909110036.GC6719@redhat.com>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load (v2)
Thread-Index: SLK12JUbrQMEyYCzu/XRb/7xOGRepw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 9, 2019, at 7:00 AM, Oleg Nesterov oleg@redhat.com wrote:

> On 09/08, Mathieu Desnoyers wrote:
>>
>> +static void sync_runqueues_membarrier_state(struct mm_struct *mm)
>> +{
>> +	int membarrier_state = atomic_read(&mm->membarrier_state);
>> +	bool fallback = false;
>> +	cpumask_var_t tmpmask;
>> +	int cpu;
>> +
>> +	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1) {
>> +		WRITE_ONCE(this_rq()->membarrier_state, membarrier_state);
> 
> This doesn't look safe, this caller can migrate to another CPU after
> it calculates the per-cpu ptr.
> 
> I think you need do disable preemption or simply use this_cpu_write().

Good point! I'll use this_cpu_write() there and within
membarrier_exec_mmap(), which seems to be affected by the same problem.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
