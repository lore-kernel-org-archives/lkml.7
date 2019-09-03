Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CB922CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S+B+Acs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfICUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:13:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:39972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfICUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:13:18 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 89D542B26AD;
        Tue,  3 Sep 2019 16:13:16 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id puKZCFzi-A_U; Tue,  3 Sep 2019 16:13:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2F94F2B26A9;
        Tue,  3 Sep 2019 16:13:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2F94F2B26A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567541596;
        bh=OBpnBEQngVIyBPnbvPZMnptXtvsASksMY7cFdQ0lF3Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=S+B+Acs+PR1tWyVsKzxubkHBDh7+xqtxfkkp3dUs9fFFJxAFbEltgIkqEOkYZe2iW
         F+1Wvvnmjmmne48U5CrkNZo1Ih+dtSqrTv1DjdxrGufHnl2iBCUAEpv49TK2yj11yD
         b7A2egfrrTF2/G1gc9rjxiQDtvVPwUlESNHxMQof497O8Kocu5OlheWpe1KWaIwilk
         54F1NraiCG0TujufC6JdSn2mD7MbpZSCLGRGEccUT5j1oImEfJQUWGHaPt1SefQrRj
         hRSXPHm5wPwgrvpXIg+LlkgSTTcX5JpI6Xgb3x1+y4cA/AegxnL8dx0vupvvPdrAka
         38VJx8Bxued7A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id iREVIGk4xrlA; Tue,  3 Sep 2019 16:13:16 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 189AC2B26A2;
        Tue,  3 Sep 2019 16:13:16 -0400 (EDT)
Date:   Tue, 3 Sep 2019 16:13:15 -0400 (EDT)
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
Message-ID: <250946344.642.1567541595914.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wiY-Lh1SvzpG2OPh_DUNJMeTTSyfNmx=ALz1UuZ4EiC=g@mail.gmail.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com> <20190903160036.2400-3-mathieu.desnoyers@efficios.com> <CAHk-=wiY-Lh1SvzpG2OPh_DUNJMeTTSyfNmx=ALz1UuZ4EiC=g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Fix: sched/membarrier: READ_ONCE p->mm in
 membarrier_global_expedited
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: READ_ONCE p->mm in membarrier_global_expedited
Thread-Index: bXVkDHRWDIkHySjFGkamrMQYOacg3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 12:23 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 3, 2019 at 9:00 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Due to the lack of READ_ONCE() on p->mm, this code can in fact turn into
>> a NULL deref when we hit do_exit() around exit_mm(). The first p->mm
>> read is before and sees !NULL, the second is after and does observe
>> NULL, which triggers a null pointer dereference.
> 
> This is horribly ugly, and I don't think it is necessary.
> 
> The way to fix the problem you are addressing in patches 2-3 is to
> move the MEMBARRIER_STATE_GLOBAL_EXPEDITED flag from the mm struct to
> the task struct, and avoiding the whole issue with "mm may be released
> at any point" that way.
> 
> Now, your reaction will be "but lots of threads can share an 'mm', so
> we can't do that", but that doesn't seem to be true. Looking at the
> place that _sets_ this, you already handle the single-thread cases
> specially, and the multiple threads has to do a "synchronize_rcu()".
> You might as well either walk the current CPU's and set it in all
> threads where the thread->mm matches the mm. And then you make the
> scheduler set the bit on newly scheduled entities.
> 
> NOTE! When you walk all current cpu's in
> membarrier_register_global_expedited(), you only look at the
> 'task->mm' _value_, you don't dereference it. And that's ok, because
> 'task' itself is stable, it's just mm that can go away.
> 
> Wouldn't that solve the issue much more cleanly?

Indeed it would! I just sent a patch as RFC implementing your idea.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
