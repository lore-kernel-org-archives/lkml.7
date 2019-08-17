Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212BBC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E021721
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 01:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CM9xBLyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfHQBgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 21:36:52 -0400
Received: from mail.efficios.com ([167.114.142.138]:57410 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfHQBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 21:36:52 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A3A642C8933;
        Fri, 16 Aug 2019 21:36:50 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fF-kLxWnN6pU; Fri, 16 Aug 2019 21:36:50 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 205ED2C8930;
        Fri, 16 Aug 2019 21:36:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 205ED2C8930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566005810;
        bh=96IAPoPyhNwCRUJnxRSwtU1kXmraj/p1+Xr9UEL1eek=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CM9xBLyWwxkLSO/6MqFwv941L7m4F3uxH24Q0TjmrgpW14EoOySOtudTDpLTWQXXB
         obhOseuxl+r8Y4SkAseInWd/o8mpJz8BVR4VTK3FX1UIYTsuuyvAFwnL9kuK9IxKO5
         BrpZWxAbeT1QsH1VwdCU9/dDNDic61uPJ4fPuxQDNKsbcZNVh50IHOm3BlJY8go4Wk
         RtlN+fbzxnrIsR9aHhuNTOsF3stWDlcEI/wBVqL41cas0QcKcSZk5Qxa3wpguoF9xG
         kI1CaYXgk9Nk9lucTXFyfq0hoA5Va76IHe1s07kVpjZB4Ev9aqTAiaY1UmeRclN9XW
         A8mamxa4KL+Hw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 58D9Cft72E0O; Fri, 16 Aug 2019 21:36:50 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 008D82C8926;
        Fri, 16 Aug 2019 21:36:49 -0400 (EDT)
Date:   Fri, 16 Aug 2019 21:36:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de> <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: FtzrAEkFElsTg1M7nrKVRqIiganZVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 5:04 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Aug 16, 2019 at 1:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Can we finally put a foot down and tell compiler and standard committee
>> people to stop this insanity?
> 
> It's already effectively done.
> 
> Yes, values can be read from memory multiple times if they need
> reloading. So "READ_ONCE()" when the value can change is a damn good
> idea.
> 
> But it should only be used if the value *can* change. Inside a locked
> region it is actively pointless and misleading.
> 
> Similarly, WRITE_ONCE() should only be used if you have a _reason_ for
> using it (notably if you're not holding a lock).
> 
> If people use READ_ONCE/WRITE_ONCE when there are locks that prevent
> the values from changing, they are only making the code illegible.
> Don't do it.

I agree with your argument in the case where both read-side and write-side
are protected by the same lock: READ/WRITE_ONCE are useless then. However,
in the scenario we have here, only the write-side is protected by the lock
against concurrent updates, but reads don't take any lock.

If WRITE_ONCE has any use at all (protecting against store tearing and
invented stores), it should be used even with a lock held in this
scenario, because the lock does not prevent READ_ONCE() from observing
transient states caused by lack of WRITE_ONCE() for the update.

So why does WRITE_ONCE exist in the first place ? Is it for documentation
purposes only or are there actual situations where omitting it can cause
bugs with real-life compilers ?

In terms of code change, should we favor only introducing WRITE_ONCE
in new code, or should existing code matching those conditions be
moved to WRITE_ONCE as bug fixes ?

Thanks,

Mathieu

> 
> But in the *absence* of locking, READ_ONCE/WRITE_ONCE is usually a
> good thing.  The READ_ONCE actually tends to matter, because even if
> the value is used only once at a source level, the compiler *could*
> decide to do something else.
> 
> The WRITE_ONCE() may or may not matter (afaik, thanks to concurrency,
> modern C standard does not allow optimistic writes anyway, and we
> wouldn't really accept such a compiler option if it did).
> 
> But if the write is done without locking, it's good practice just to
> show you are aware of the whole "done without locking" part.
> 
>               Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
