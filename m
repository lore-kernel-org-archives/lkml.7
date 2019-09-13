Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED0206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b7L9bJUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfIMRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:07:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:50304 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:07:02 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EF9592D171C;
        Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id yue-XGze4qTf; Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A2C052D1718;
        Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A2C052D1718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568394420;
        bh=Zpt54GcAu1+y1zhlMRf7Z9of314mhTP40sZf/4wSJ6k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=b7L9bJUrGMsrZqHHlvpsQ74rivOOzHREXOf38CXVorQEBG7klYD2FDLbMlG7aBuFl
         YFSQ8HI6qySf8Jvf/Af4prwtBgcdGq8fbQPupzp361rcdkNeRyR88+p/w0Ys4fPTtM
         +2EZBKgSxTP7VpOBFoTsXIYjC+p0WJ05HAj9M6IxBCHyxCD0tsGMV712R7kmN7mV/L
         uzpg0d8COjf02xyY1OHrcswuykeVkCbMyQkQ6N4uInv6NMgXQbTFqq64WWhpfUTkt6
         0nQLmrPpeabBgnMxOLD2Py59HzGrHEJNqz9dgK+14RUY64bg3kOTNq2ZGNM4Z7Y55w
         UyPK9v24TitCQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CgTjKLBCzxk4; Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 89F022D170D;
        Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
Date:   Fri, 13 Sep 2019 13:07:00 -0400 (EDT)
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
Message-ID: <839513130.2802.1568394420373.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190913160416.GA29518@redhat.com>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <20190908134909.12389-1-mathieu.desnoyers@efficios.com> <20190909110036.GC6719@redhat.com> <1629045844.2645.1568388056947.JavaMail.zimbra@efficios.com> <20190913160416.GA29518@redhat.com>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load (v2)
Thread-Index: d+ZoIR+Tk/wAitInD83FFsP1CqY56w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Sep 13, 2019, at 12:04 PM, Oleg Nesterov oleg@redhat.com wrote:

> On 09/13, Mathieu Desnoyers wrote:
>>
>> membarrier_exec_mmap(), which seems to be affected by the same problem.
> 
> IIRC, in the last version it is called by exec_mmap() undef task_lock(),
> so it should fine.

Fair point. Although it seems rather cleaner to use this_cpu_write() in
all 3 sites updating this variable rather than a mix of this_cpu_write
and WRITE_ONCE(), unless anyone objects.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
