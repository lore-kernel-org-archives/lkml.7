Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B38C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCAE206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JaYWa6uE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNPaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:30:04 -0500
Received: from mail.efficios.com ([167.114.142.138]:49130 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:30:04 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C943D41EF34;
        Thu, 14 Nov 2019 10:30:02 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GafNEX8iSwe2; Thu, 14 Nov 2019 10:30:02 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5B3FE41EF31;
        Thu, 14 Nov 2019 10:30:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B3FE41EF31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1573745402;
        bh=AvTeKCGgoP6UwyZIW9re0q4KBrw1MiiN762zJDFBeTU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JaYWa6uEpB0327zzAEc6404aorwZPriCxMgwlmRqGEWF7odx8u50yV04rskGvoIkJ
         vjmRcBIs5rVRzcrjkNUexRb3QnQ6LsRUppA2s39FEqZ9stHY2R/kBtr5r88QeZ9peR
         GpyYyS7gqqhirwFJrz0AF8S4KFCegMsZ+IyxlJSdw+xNeDSOwhOd80NYSA84RXe+X1
         r0dyfD5ojuwKegojbb1lXpx5RykDRInzeJVMwBTVwoZLvO5Hyk830sWoH5Ivv3eMp3
         qfF/okqt99Rdx69pu+6EerewQuTtBJjpbYXf8Ne+2L6ApZzwFAhvZ36Cr3tgKWMG3k
         Bjo76esD91JYQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id BOWoKGWznvZg; Thu, 14 Nov 2019 10:30:02 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id F1F0D41EF23;
        Thu, 14 Nov 2019 10:30:01 -0500 (EST)
Date:   Thu, 14 Nov 2019 10:30:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Message-ID: <1849439575.148.1573745401685.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191114152829.GA4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org> <20191111132458.162172862@infradead.org> <394483573.90.1573659752560.JavaMail.zimbra@efficios.com> <20191114135311.GW4131@hirez.programming.kicks-ass.net> <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com> <20191114151323.GK2865@paulmck-ThinkPad-P72> <135240750.136.1573744944568.JavaMail.zimbra@efficios.com> <20191114152829.GA4131@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3869)
Thread-Topic: x86/kprobes: Fix ordering
Thread-Index: 8sJONkpl+FM/HNDAhoITrgY+ypVVLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 14, 2019, at 10:28 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Nov 14, 2019 at 10:22:24AM -0500, Mathieu Desnoyers wrote:
> 
>> >> > So what we do, after enabling the regular kprobe, is call
>> >> > synchronize_rcu_tasks() to wait for each task to have passed through
>> >> > schedule(). That guarantees no task is preempted inside the kprobe
>> >> > shadow (when it triggers it ensures it resumes execution at an
>> >> > instruction boundary further than 5 bytes away).
>> >> 
>> >> Indeed, given that synchronize_rcu_tasks() awaits for voluntary context
>> >> switches (or user-space execution), it guarantees that no task was preempted
>> >> within the kprobe shadow.
>> >> 
>> >> Considering that synchronize_rcu_tasks() is meant only for code rewriting,
>> >> I wonder if it would make sense to include the core serializing guarantees
>> >> within this RCU API ?
>> > 
>> > As in have synchronize_rcu_tasks() do the IPI-sync love before doing
>> > the current wait-for-voluntary-context-switch work?
>> 
>> This is what I have in mind, yes, based on the assumption that the only
>> intended use-case for synchronize_rcu_tasks() is code patching.
> 
> I don't think that is needed. As per the patch under discussion, we
> unconditionally need that IPI-sync (even for !optimized) but we only
> need the synchonize_rcu_tasks() thing for optimized kprobes.
> 
> Also, they really do two different things. Lets not tie them together.

I'm fine with this approach, I just thought it would be good to consider
the alternative.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
