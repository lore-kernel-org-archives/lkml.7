Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E23C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF562067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556577037;
	bh=tzpQmf1nc0glofIUMLUbHjOLVGa8e1BFtJ73oG32PBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FUVzqC3TsUWZ9kAakRqri77wVifISFkiMd7UTCMXxOeChDkj73N9yTbcPwIFoWzV4
	 x4gilpqyCL+rvc78KTd/duakcs1ZHCkiceoTCOzyAFaIlrxLBjG7FgtqdUSLwCf/kw
	 vluuv95KX+uQKvorpsuKRtQ9M6GB+MFc/KIzQoWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfD2Wag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:30:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45070 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfD2Wag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:30:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id m18so6281156lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zppnOAypDVs0+r50a/pgPPi939wuWm5h1LCIlM9HNjM=;
        b=QGBVwSJZ+kKUqIc42rXPpG7fGPox/UQOJvcW9dOTrKQfMY8buV4dJTLpAAWokmELmK
         1QZP7Kjs19NM9LlDsb1C2eVy/w/POK2OPqqQq5iTLBCRv0p0etTN59O7wWkp7HYo9QnX
         W/o3H6va7lHP1PpJd24/V6e9rjLzYhqt6DdjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zppnOAypDVs0+r50a/pgPPi939wuWm5h1LCIlM9HNjM=;
        b=Tk9TrDR1P0dmpdjMl7/qdaDJDXZGSGiKI+bRU1xMrhsXxCJFW6W5FwzsmYjVppvpDx
         HDrohGGjVUg1Y1xR6oUhOitg79i6yDRSX0uNW5jrO6uu+bO7XS0WoMo02vIrVx+Oo+Y5
         l6zljZLTqnFQcqNvHcMR/yXrHleMHVTQeSOxSbfPeD84arpPf7cKkB6kdhmyncy0d8dr
         7r3UUyH0VEkOq6IfEulL5norg1FeJt9Llgz/D9agfh/Hr1AEyuA8WOV0VczMTsT+i5um
         cBKeBosJZMF+7nleRtP6X5jLi9iSO5sNQsjz+Qyk8nSoJCI5Ze12Tm0FyXguSElQwx27
         CE6g==
X-Gm-Message-State: APjAAAVKxEizCHVHLx8R/WBNZ1Hg4QmpFgmWGwTWUDSiGZX9re8DE6zp
        h/BA0CL/9CtgQLSsDCyO+wHvSpIqUmI=
X-Google-Smtp-Source: APXvYqxDbU1Ud1UgNBs2YwhTuKEv+MPIzbk8jgXDqtlA9yO9Tbs5Ux+ors3HubnQlMi5bR0u0OYWmg==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr33453109ljt.75.1556577033160;
        Mon, 29 Apr 2019 15:30:33 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o17sm1676763lji.23.2019.04.29.15.30.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:30:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w23so9128779lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:30:32 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr33003752lfa.136.1556576545296;
 Mon, 29 Apr 2019 15:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-4-nstange@suse.de> <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home> <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com> <20190429220814.GF31379@linux.intel.com>
In-Reply-To: <20190429220814.GF31379@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 15:22:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
Message-ID: <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 3:08 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> FWIW, Lakemont (Quark) doesn't block NMI/SMI in the STI shadow, but I'm
> not sure that counters the "horrible errata" statement ;-).  SMI+RSM saves
> and restores STI blocking in that case, but AFAICT NMI has no such
> protection and will effectively break the shadow on its IRET.

Ugh. I can't say I care deeply about Quark (ie never seemed to go
anywhere), but it's odd. I thought it was based on a Pentium core (or
i486+?). Are you saying those didn't do it either?

I have this dim memory about talking about this with some (AMD?)
engineer, and having an alternative approach for the sti shadow wrt
NMI - basically not checking interrupts in the instruction you return
to with 'iret'. I don't think it was even conditional on the "iret
from NMI", I think it was basically any iret also did the sti shadow
thing.

But I can find no actual paper to back that up, so this may be me just
making sh*t up.

> KVM is generally ok with respect to STI blocking, but ancient versions
> didn't migrate STI blocking and there's currently a hole where
> single-stepping a guest (from host userspace) could drop STI_BLOCKING
> if a different VM-Exit occurs between the single-step #DB VM-Exit and the
> instruction in the shadow.  Though "don't do that" may be a reasonable
> answer in that case.

I thought the sti shadow blocked the single-step exception too? I know
"mov->ss" does block debug interrupts too.

Or are you saying that it's some "single step by emulation" that just
miss setting the STI_BLOCKING flag?

                   Linus
