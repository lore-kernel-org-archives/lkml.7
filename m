Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AD621881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mUrRUWBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfICRVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:21:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:44812 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfICRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:21:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 529902AEA62;
        Tue,  3 Sep 2019 13:21:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HuspNp_6jbic; Tue,  3 Sep 2019 13:21:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D64F22AEA5F;
        Tue,  3 Sep 2019 13:21:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D64F22AEA5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567531291;
        bh=8W1y/k8ozjUQKoYOIzp5YQ/tuvpFb6A67tgZKI8ovac=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mUrRUWBVSTcq3XxQL+5obJgH0aaxhYRPRGkyHcA5Tz7gW9lMinVBmde2TFEEIvxZY
         0q/c5+xRgR/r9SiUcqUNXZihGQOoj+64innKKXKUyTwSJB4SoaT62Y+Zd3PgSpbZNV
         FMBuJYSdvJL6gxy65edxbwUqGGYumHe13jXv60sMxf27zEicj+abRBct0jIV5KXdCz
         t0K79FmglWYEtClOk+xk5bg6hpejK7SWVcnIzRoXYlLsgL26ymDA820u4y12Av4LDd
         MqCmqwiJeLPy92IrmRM4w60RNcE88fPzqy4uSmK1fiX7xGabv93LWfnr1lENqpR/Yt
         RLYX/kIhGxaUA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ywcJYgbmsvi8; Tue,  3 Sep 2019 13:21:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B7C162AEA56;
        Tue,  3 Sep 2019 13:21:31 -0400 (EDT)
Date:   Tue, 3 Sep 2019 13:21:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1154084146.53.1567531291520.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wgD6U97778Zz_-iMtyu47Nn3L9Mr2K5wq1afiMyE=eosg@mail.gmail.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com> <20190903160036.2400-2-mathieu.desnoyers@efficios.com> <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com> <1188636562.23.1567529794307.JavaMail.zimbra@efficios.com> <CAHk-=wgD6U97778Zz_-iMtyu47Nn3L9Mr2K5wq1afiMyE=eosg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Fix: sched: task_rcu_dereference: check
 probe_kernel_address return value
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched: task_rcu_dereference: check probe_kernel_address return value
Thread-Index: LGQmbDY0z1tH5Z0unmpMBlrVb+uSWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 1:14 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 3, 2019 at 9:56 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Then I must be misunderstanding something.
>>
>> probe_kernel_address() is a macro wrapping probe_kernel_read().
> 
> Don't look at probe_kernel_address().
> 
> As long as you only look at that, you will be missing the big picture.
> 
> Instead, look at the code below it:
> 
>        /*
>         * Pairs with atomic_dec_and_test() in put_task_struct(). If this task
>         * was already freed we can not miss the preceding update of this
>         * pointer.
>         */
>        smp_rmb();
>        if (unlikely(task != READ_ONCE(*ptask)))
>                goto retry;
> 
> 
> That code is the code that verifies "ok, the pointer was valid over
> the whole sequence, so the probe_kernel_address() must have succeeded"
> 
> So the code *does* check for success, but it does so using a
> *stronger* check than the return value of probe_kernel_address().
> 
> If the task on the runqueue hasn't changed, then the
> probe_kernel_read() cannot have failed.
> 
> But the reverse test is not true: if the probe_kernel_read()
> succeeded, that doesn't guarantee that the value we read was
> consistent.
> 
> So the check for failure is there, and the check that does exist is
> the correct and stronger check.
> 
> Which is why checking the return value of probe_kernel_read() is
> immaterial and pointless.
> 
> But a comment about this above the probe_kernel_read() may indeed be
> worth it, since it seems to be unclear to so many people.
> 
> The code basically just wants to do a kernel memory access, knowing
> that it's speculative. And the _only_ reason for using
> probe_kernel_read() is that with DEBUG_PAGEALLOC you might have a page
> fault on the speculative access.
> 
> But we do the speculation verification check afterwards, and that's
> the important part.

Indeed, thanks for the explanation. Given that this code will likely be
changed by patchsets submitted by others which will possibly remove the
entire thing, and that it currently works as intended, I do not plan on
submitting any further patch to that function at this stage.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
