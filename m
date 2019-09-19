Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E86C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4BF21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hVnh4QL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbfISRdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:33:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:60544 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:33:11 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 647A0331659;
        Thu, 19 Sep 2019 13:33:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Q9TZgjlzAhcX; Thu, 19 Sep 2019 13:33:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DD701331651;
        Thu, 19 Sep 2019 13:33:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DD701331651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914389;
        bh=1gK45da2O8eQd2L3+rhRaZR4r+6ax4XV+anAhvsi3Qw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hVnh4QL71SykARVl9rKptz64+8EWaJG7PTrYfa4mIpAJv3wS8igMnuRZn3n5JQZYb
         NZDXmScFVeI6b79nls92He0r7PNj8inwKuFXpjZ5Q3FYeqZdsYjXweg+LV52PeqHWG
         Y7dsMAE2aMMBFl23B5nbZ1UsmGe09sUFICKrUieRhN3uu50yjvMXLfdREX5Zq1ArCj
         rwP0NWLY++oRS3L2BlpSRcngG5ISq3wQcNDvzwz33mdNJYLVGG5kkrXbKHgAbslvhY
         lwI4ApRr8Z9y/8Urz2nBrNdUrR4hLAefDfrfvOZyLtfjvi58NNCH9twqbqxtZVKBY6
         kTbFcFSS65NRA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pJWY0OiNEQYg; Thu, 19 Sep 2019 13:33:09 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C0D78331648;
        Thu, 19 Sep 2019 13:33:09 -0400 (EDT)
Date:   Thu, 19 Sep 2019 13:33:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1285036359.17389.1568914389549.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190919162611.wizldpybn3qd5cik@willie-the-truck>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com> <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com> <20190912134802.mhxyy25xemy5sycm@willie-the-truck> <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com> <20190912154734.j3mmjmqf2iltbenm@willie-the-truck> <1283729551.2396.1568384548023.JavaMail.zimbra@efficios.com> <20190919162611.wizldpybn3qd5cik@willie-the-truck>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load (v2)
Thread-Index: LIklZ+1RB+Ag7NCToU1u/O6uWfKqdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 19, 2019, at 12:26 PM, Will Deacon will@kernel.org wrote:

[...]
>> 
>> The current wording from membarrier(2) is:
>> 
>>               The  "expedited" commands complete faster than the non-expedited
>>               ones; they never block, but have the downside of  causing  extra
>>               overhead.
>> 
>> We could simply remove the "; they never block" part then ?
> 
> I think so, yes. That or, "; they do not voluntarily block" or something
> like that. Maybe look at other man pages for inspiration ;)

OK, let's tackle the man-pages part after the fix reaches mainline though.

[...]
> 
> I reckon you'll be fine using GFP_KERNEL and returning -ENOMEM on allocation
> failure. This shouldn't happen in practice and it removes the fallback
> path.

Works for me! I'll prepare an updated patchset.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
