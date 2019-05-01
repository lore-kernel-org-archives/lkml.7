Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9098C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826E82085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEAP5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfEAP5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86BC8C053B34;
        Wed,  1 May 2019 15:57:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 83E2A1001E95;
        Wed,  1 May 2019 15:57:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 May 2019 17:57:16 +0200 (CEST)
Date:   Wed, 1 May 2019 17:57:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190501155711.GB30235@redhat.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-4-sudeep.holla@arm.com>
 <20190318153321.GA23521@redhat.com>
 <20190430164413.GA18913@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430164413.GA18913@e107155-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 01 May 2019 15:57:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30, Sudeep Holla wrote:
>
> On Mon, Mar 18, 2019 at 04:33:22PM +0100, Oleg Nesterov wrote:
> >
> > And it seems that _TIF_WORK_SYSCALL_ENTRY needs some cleanups too... We don't need
> > "& _TIF_WORK_SYSCALL_ENTRY" in syscall_trace_enter, and _TIF_WORK_SYSCALL_ENTRY
> > should not include _TIF_NOHZ?
> >
>
> I was about to post the updated version and checked this to make sure I have
> covered everything or not. I had missed the above comment. All architectures
> have _TIF_NOHZ in their mask that they check to do work. And from x86, I read
> "...syscall_trace_enter(). Also includes TIF_NOHZ for enter_from_user_mode()"
> So I don't understand why _TIF_NOHZ needs to be dropped.

I have already forgot this discussion... But after I glanced at this code again
I still think the same, and I don't understand why do you disagree.

> Also if we need to drop, we can address that separately examining all archs.

Sure, and I was only talking about x86. We can keep TIF_NOHZ and even
set_tsk_thread_flag(TIF_NOHZ) in context_tracking_cpu_set() if some arch needs
this but remove TIF_NOHZ from TIF_WORK_SYSCALL_ENTRY in arch/x86/include/asm/thread_info.h,
afaics this shouldn't make any difference.

And I see no reason why x86 needs to use TIF_WORK_SYSCALL_ENTRY in
syscall_trace_enter().

Oleg.

