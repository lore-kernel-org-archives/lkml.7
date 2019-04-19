Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45419C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02B8204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Owm4+QAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfDSSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:40:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:39406 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfDSSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:40:02 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9ACC21D9A2B;
        Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id TaPe6DAuX5dl; Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 498D61D9A27;
        Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 498D61D9A27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555677728;
        bh=pEHDv+jZ2369hFuQkuoa29R/WECxSOIAolYsOELFy+A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Owm4+QAt3yeQquylmtNgBggrFNAo3mxoyvXgrqrPdQI5alMLCh6vsbjWNgISjudjq
         bgxkkhqJc25poRA0qrB4k8I+bNyVz+nAQxb/ChjIDEHMZW6zzEkUMcyBARlbd+8Xsi
         XWVGXa2D3LugrmZbLVSsUWVjYdN6ON7H9eOyKLCDPYBmkE8cQMrzA6yOp2/kdcuhlc
         U564y2UpgIw14CF0kHCOdHwiz1z3hYdqlq3v4bkJVKXgcEkMfZltdvX2mnPOYl4vvk
         Ex0sYOVauaa5N4ry/C4xx8UDnBh8B/idhI+O6g0+fGioTQDXrQXRbdw9aXsM4Q+E2y
         sp9U5mnSJmlng==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id P6LnwFeBP42F; Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2F21F1D9A21;
        Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
Date:   Fri, 19 Apr 2019 08:42:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <161476507.73.1555677728159.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190419104123.GB111210@gmail.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <20190419104123.GB111210@gmail.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Restartable Sequences updates for 5.1
Thread-Index: 6kE7X8q3e71ywsCOvbg6ISVHokY78Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 6:41 AM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Those changes aiming at 5.1 include one comment cleanup, the removal of
>> the rseq_len field from the task struct which serves no purpose
>> considering that the struct size is fixed by the ABI, and a selftest
>> improvement adapting the number of threads to the number of detected
>> CPUs, which is nicer for smaller systems.
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> Mathieu Desnoyers (3):
>>   rseq: cleanup: Reflect removal of event counter in comments
>>   rseq: cleanup: remove rseq_len from task_struct
>>   rseq/selftests: Adapt number of threads to the number of detected cpus
>> 
>>  arch/arm/kernel/signal.c                       | 3 +--
>>  arch/x86/kernel/signal.c                       | 5 +----
>>  include/linux/sched.h                          | 4 ----
>>  kernel/rseq.c                                  | 9 +++------
>>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>>  5 files changed, 10 insertions(+), 18 deletions(-)
> 
> Looks good, I've applied these to tip:core/rseq to make sure they don't
> miss the v5.2 merge window.
> 
> (Let me know if you wanted to handle this differently.)

That's fine by me!

Thanks,

Mathieu


> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
