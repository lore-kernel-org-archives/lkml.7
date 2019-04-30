Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2420835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556640780;
	bh=v+zgV5M4R6J4QYYnDh9ZCtv6HZ7C7SC+pPnnu649ubg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sGKPqV8YJSJBAZ4/RvCGGiJpWZYuYOWeP+PncPpEX3O93FQuM45rfmB3YFhK4tGTG
	 I/yGyJpfag2Zh1wP834rv1n48gkL/+bE0rmiYcNQLadwzzEu210unKKyEIoXwJ5inb
	 /koa7mEhaEMc7d5gPqIVAeQoWBQMxcQBPkVLW0wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfD3QM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:12:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37032 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfD3QM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:12:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id b12so12160834lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8IWSyZfLA4XVOsmM4DscMmixmVfvW4j4t9n7Z2aPEk=;
        b=W6fmTN0+D899+DLFXEO0qv05jRrqGLHpOnj5hjbo6BgYsF8/3yQk/MgOBusQc/+nur
         zEcvFY9Ms51BaYKVfQUT4d8XQLgPU3hFz4sUMV31rJJ+EwViTRrCjM/neFZh3KWEKiVH
         36y5Lj+2NTIPCZFvYHm6hgeuBfzI0lc+RedSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8IWSyZfLA4XVOsmM4DscMmixmVfvW4j4t9n7Z2aPEk=;
        b=EKkhhSHmwOIhSpuoO4SUveo5ty8XkByP79V/x+pFfGlelFQMUazuQpC7DGlX+hfo8N
         GX3OPTKAVSyL6vzg4oL4oxirzsH1e6PQA04nluU0nxezpFVcYvPYCw31838TQ/X9K5UP
         +VoeWkcLdg37C74nn4ocjjFQ+v/mOe4MmEeUTis4A5gD3d78moCZhje1GckJJiM2JwN0
         1z2/MU+M14RrKYmBENYHkIAJ2Jw4JMXrOhSJszFSqmEyGHF/zFKI7B569L5X3pxsDTbX
         kgpEWbnQ4MUMEmpWhTdsvjyDzjHyzJCNa6yUIWxrem/ebGAdzt2OLzhxgMxREi82kfOM
         glcw==
X-Gm-Message-State: APjAAAV1KPIo0kplLgYmkhTCZ1CQG9m0W055/k6N6u8K/BNMEj2LKxSv
        2ult/Z5+pnJMATTr5M2jjqvCjr2w7Xc=
X-Google-Smtp-Source: APXvYqzmCnxbxykfyQ/NZIozOUcxZbrMJttdvlo6U7GSPfWDcJmqnOLQ4k2KrK6OXP5M2derK1VZDg==
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr4449156ljm.62.1556640774811;
        Tue, 30 Apr 2019 09:12:54 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z6sm1442778ljb.56.2019.04.30.09.12.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:12:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q10so13334533ljc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:12:54 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr11128807ljg.135.1556640377738;
 Tue, 30 Apr 2019 09:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190428133826.3e142cfd@oasis.local.home> <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com> <20190430135602.GD2589@hirez.programming.kicks-ass.net>
In-Reply-To: <20190430135602.GD2589@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:06:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
Message-ID: <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Tue, Apr 30, 2019 at 6:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 29, 2019 at 01:07:33PM -0700, Linus Torvalds wrote:
> >
> > We still have that sti sysexit in the 32-bit code.
>
> We also have both: "STI; HLT" and "STI; MWAIT" where we rely on the STI
> shadow.

I guess the good news is that in all cases we really only ever protect
against a very unlikely race, and if the race happens it's not
actually fatal.

Yes, if we get an NMI and then an interrupt in between the "st;hlt" we
might wait for the next interrupt and get a (potentially fairly
horrible) latency issue. I guess that with maximal luck it might be a
one-shot timer and not get re-armed, but it sounds very very very
unlikely.

Googling around, I actually find a patch from Avi Kivity from back in
2010 for this exact issue, apparently because kvm got this case wrong
and somebody hit it. The patch never made it upstream exactly because
kvm could be fixed and people decided that most real hardware didn't
have the issue in the first place.

In the discussion I found, Peter Anvin tried to get confirmation from
AMD engineers about this too, but I don't see any resolution.

Realistically, I don't think you can hit the problem in practice. The
only way to hit that incredibly small race of "one instruction, *both*
NMI and interrupts" is to have a lot of interrupts going all at the
same time, but that will also then solve the latency problem, so the
very act of triggering it will also fix it.

I don't see any case where it's really bad. The "sti sysexit" race is
similar, just about latency of user space signal reporting (and
perhaps any pending TIF_WORK_xyz flags).

So maybe we don't care deeply about the sti shadow. It's a potential
latecy problem when broken, but not a huge issue. And for the
instruction rewriting hack, moving to "push+sti+ret" also makes a lost
sti shadow just a "possibly odd stack frame visibility" issue rather
than anything deeply fatal.

We can probably just write it off as "some old CPU's (and a smattering
or very rare and not relevant new ones) have potential but unlikely
latency issues because of a historical CPU mis-design - don't do perf
on them".

                Linus
