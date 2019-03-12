Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385EB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552359897;
	bh=TJ+Rb5mqWxqCRiRg4al+kBb8fJTf3b0F/zjChCx8u4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ocQTc1zVKUc2DxNP9apsSyAQ5spaMfzKKEp1r+ZYqmdzvyndYyWoPRmLKRnLx85L4
	 TAqXc+RBiZjiCnxiFHrORko1xvlS9YSucZOB6V4I/1cUJAZkQEymudVFcp9RFb15rj
	 WeLz98SZqv7cwxlBc+HX8zj87pVSVYSjX9SQlY4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCLDEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfCLDEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:04:55 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9BB02173C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552359894;
        bh=TJ+Rb5mqWxqCRiRg4al+kBb8fJTf3b0F/zjChCx8u4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qhLPLge7AiIhlT2T1XQN1NLoFI+glVf7ql/5U+UGd/7jja453wuyn+uxmVos2cCdL
         jTFjFoH6rdzwu2lxCS8JNDt6igwllhNFenz0OIc64CgH6NjlK4TzV+BtnAJReVW1xu
         VSzsCrCDU0bEU3nROAdhcw/shiELLm55apWtDDJA=
Received: by mail-wr1-f47.google.com with SMTP id o9so981763wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:04:53 -0700 (PDT)
X-Gm-Message-State: APjAAAV2z5jVrOuKGOy7D1NNn1QtGfjhbas8ELsA7i8sLEAsEUYfQSZh
        aAyxe+koRt4RL3zbccO8FyqTN40HVShYwqzEGJwGTw==
X-Google-Smtp-Source: APXvYqyPI4aXMLrCNqmVrAn74b7qe8Wt8qYFSCiTLfmHs0/t5pZUN3WHt5YNwapSR+6VuxnbG+W0XcBvhmkTBkMwVwU=
X-Received: by 2002:adf:e54b:: with SMTP id z11mr12966624wrm.330.1552359892352;
 Mon, 11 Mar 2019 20:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190228183220.15626-1-sudeep.holla@arm.com> <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com> <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com> <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
In-Reply-To: <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Mar 2019 20:04:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
Message-ID: <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To:     "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
Cc:     Sudeep Holla <Sudeep.Holla@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        "Bin Lu (Arm Technology China)" <Bin.Lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 6:35 PM Haibo Xu (Arm Technology China)
<Haibo.Xu@arm.com> wrote:
>
> On 2019/3/12 2:34, Sudeep Holla wrote:
> > (I thought I had sent this email, last Tuesday itself, but saw this in my
> > draft today, something went wrong, sorry for the delay)
> >
> > On Tue, Mar 05, 2019 at 02:14:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> >> On 2019/3/4 18:12, Sudeep Holla wrote:
> >>> On Mon, Mar 04, 2019 at 08:25:28AM +0000, Haibo Xu (Arm Technology China) wrote:
> >>>> On 2019/3/1 2:32, Sudeep Holla wrote:
> >>>>> Now that we have a new hook ptrace_syscall_enter that can be called from
> >>>>> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> >>>>> can do some cleanup using the same in syscall_trace_enter.
> >>>>>
> >>>>> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> >>>>> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
> >>>>
> >>>> I think we should not change the logic here. Is so, it will double the report of syscall
> >>>> when PTRACE_SYSEMU_SINGLESTEP is enabled.
> >>>>
> >>>
> >>> I don't think that should happen, but I may be missing something.
> >>> Can you explain how ?
> >>>
> >>
> >> When PTRACE_SYSEMU_SINGLESTEP is enabled, both the _TIF_SYSCALL_EMU and
> >> _TIF_SINGLESTEP flags are set, but ptrace only need to report(send SIGTRAP)
> >> at the entry of a system call, no need to report at the exit of a system
> >> call.
> >>
> > Sorry, but I still not get it, we have:
> >
> > step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP);
> >
> > For me, this is same as:
> > step = ((flags & _TIF_SINGLESTEP) == _TIF_SINGLESTEP)
> > or
> > if (flags & _TIF_SINGLESTEP)
> > step = true;
> >
>
> I don't think so! As I mentioned in the last email loop, when PTRACE_SYSEMU_SINGLESTEP
> is enabled, both the _TIF_SYSCALL_EMU and _TIF_SINGLESTEP flags are set, in which case
> the step should be "false" for the old logic. But with the new logic, the step is "true".
>
> > So when PTRACE_SYSEMU_SINGLESTEP, _TIF_SYSCALL_EMU and _TIF_SINGLESTEP
> > are set and step evaluates to true.
> >
> > So dropping _TIF_SYSCALL_EMU here should be fine. Am I still missing
> > something ?
> >
> > --
> > Regards,
> > Sudeep
> >
>
> For the PTRACE_SYSEMU_SINGLESTEP request, ptrace only need to report(send SIGTRAP)
> at the entry of a system call, no need to report at the exit of a system call.That's
> why the old logic-{step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP)}
> here try to filter out the special case(PTRACE_SYSEMU_SINGLESTEP).
>
> Another way to make sure the logic is fine, you can run some tests with respect to both logic,
> and to check whether they have the same behavior.


tools/testing/selftests/x86/ptrace_syscall.c has a test intended to
exercise this.  Can one of you either confirm that it does exercise it
and that it still passes or can you improve the test?

Thanks,
Andy
