Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECEB21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QZYKTcaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfIYPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:50:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:57590 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfIYPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:50:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A9ED7335AEC;
        Wed, 25 Sep 2019 11:50:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nq34majohdaM; Wed, 25 Sep 2019 11:50:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1749E335AE6;
        Wed, 25 Sep 2019 11:50:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1749E335AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1569426636;
        bh=GDXL2zBD8kvV0WzbzXzJ1B5F6oF7zpTdqPV/W3I2liE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QZYKTcaLjjFCxG0wyStTqP9KhCM/t2E9+TfG8c+2/LgOkRMIJpSL8cpwKNNT6AuTN
         x3KRn4fo9XqgWTx+Xt0tAviT4yElAMQsPICXVY2Y9zu0K5YmQUPdkoSwQWP8hGTju+
         rTxNHBteJmT+B5UatpTbtDM4DYpcwHwmEzC1mIZUtQiA8p5SsYo+f0SmJnZrlIO/yp
         Twn/rVNktwjqP4ySgwaFeekFjxG5UPR2yqKXafex2VkyYpZdztcQeV9Xw3zWHTO91A
         K2TsvctMzUln49EKXQLsSvXpLQYd7pkmJ14bP+21Ko/eFEHqf2qMZJ9viPSb2R3bWe
         4uMOvWkHuwEwQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9nNg678A0s0j; Wed, 25 Sep 2019 11:50:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EB471335ADD;
        Wed, 25 Sep 2019 11:50:35 -0400 (EDT)
Date:   Wed, 25 Sep 2019 11:50:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <680386266.3864.1569426635751.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190925080732.GC4536@hirez.programming.kicks-ass.net>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com> <20190923090636.GH2349@hirez.programming.kicks-ass.net> <485879119.4072.1569250532294.JavaMail.zimbra@efficios.com> <20190925080732.GC4536@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 5.4 0/7] Membarrier fixes and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: Membarrier fixes and cleanups
Thread-Index: 24jVcQEvv8VYqsQvJy+Zyvm2xjujtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 25, 2019, at 4:07 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Sep 23, 2019 at 10:55:32AM -0400, Mathieu Desnoyers wrote:
>> ----- On Sep 23, 2019, at 5:06 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Thu, Sep 19, 2019 at 01:36:58PM -0400, Mathieu Desnoyers wrote:
>> >> Hi,
>> >> 
>> >> Those series of fixes and cleanups are initially motivated by the report
>> >> of race in membarrier, which can load p->mm->membarrier_state after mm
>> >> has been freed (use-after-free).
>> >> 
>> > 
>> > The lot looks good to me; what do you want done with them (them being
>> > RFC and all) ?
>> 
>> I can either re-send them without the RFC tag, or you can pick them directly
>> through the scheduler tree.
> 
> I've picked them up (and fixed them up, they didn't apply to tip) and
> merge them with Eric's task_rcu_dereference() patches.
> 
> I'll push it out in a bit.

Thanks Peter!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
