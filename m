Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F95C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6E20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCSRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:32:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D31DD81E09;
        Tue, 19 Mar 2019 17:32:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E04B5DA2A;
        Tue, 19 Mar 2019 17:32:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 19 Mar 2019 18:32:37 +0100 (CET)
Date:   Tue, 19 Mar 2019 18:32:33 +0100
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
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190319173233.GB11525@redhat.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
 <20190318172024.GB23521@redhat.com>
 <20190318172457.GD18196@e107155-lin>
 <20190318173341.GD23521@redhat.com>
 <20190318174028.GE18196@e107155-lin>
 <20190319170804.GA11525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319170804.GA11525@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Mar 2019 17:32:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19, Oleg Nesterov wrote:
>
> Well, personally I see no point... Again, after the trivial simplification
> x86 does
>
> 	if (work & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> 		ret = tracehook_report_syscall_entry(regs);
> 		if (ret || (work & _TIF_SYSCALL_EMU))
> 			return -1L;
> 	}
>
> this looks simple enough for copy-and-paste.
>
> > If there's a better way to achieve the same
>
> I can only say that if we add a common helper, I think it should absorb
> tracehook_report_syscall_entry() and handle both TIF's just like the code
> above does. Not sure this makes any sense.

this won't work, looking at 6/6 I see that arm64 needs to distinguish
_TRACE and _EMU ... I don't understand this code, but it looks suspicious.
If tracehook_report_syscall_entry() returns nonzero the tracee was killed,
syscall_trace_enter() should just return.

To me this is another indication that consolidation makes no sense ;)

Oleg.

