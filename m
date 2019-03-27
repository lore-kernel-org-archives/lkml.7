Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63360C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E3B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXIPsV2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfC0SAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:00:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfC0SAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:00:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so3665904plr.7;
        Wed, 27 Mar 2019 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TU0W09h/7m7ftvEgIfADq5dLO08GU6CTDfqTFxZ91jk=;
        b=JXIPsV2V4UzfGXpSETLamwBuoTET/F93d1iUB5qRPsNUwb4n6zwOtkjbKto0OcffnV
         1sTP4a0NWqjYQeiNSWcGNg7EqS+GE1IyuYuHhdjLYyw0PEgeB3YwKYHK0L1VsvnN6roB
         52y43AgoQdClxKXe8kS4WpB17LlR1zyKgQTtiijQ3Dk7P7j1Vf8YZhIRKQ95mJnOkNoF
         qPjsuClrJzSqKN89eWLLRtbmTH16Zqw1OzhGDbpCmF3/lgtbwEfN4sikWTX8UEgKzb6f
         C4Dw6uBsIMhT8iWmyD7smVuW/cavoqlNtTF5W1xDu1tPKBcHwCgPa6hXO3BzrRhPpUW+
         caMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TU0W09h/7m7ftvEgIfADq5dLO08GU6CTDfqTFxZ91jk=;
        b=JOlJib9sn86nRtk0Pggea/lWEflOpIua+ny8LG4NGpUzcdwqk+glkEvnJPVHlvpZcV
         tUN/5B/hg322+JXfndL/uOsWuuuvRJ3Q70vBmt2YXClftqS1B/Dv4fi4IidD9wJYYrU8
         gI+amvBGNTgWkRkUl2s5E7flaV7qmKZzPr8ffeuqto5GEoK1onBntve3PxDy4guOxfkt
         Lw9OtKhTw5yxNu+OyaHn7+X8MHcdkI23Q/KpmIxv/5m2K8iAjWL66pODqKky0N50ueOj
         wLTtjVULYb9onv6RCiro0VqcW/Mi7EZ9uo/q28FoStsYsXZjHnHwwDwHpYbAC5gvN17e
         eYQA==
X-Gm-Message-State: APjAAAUK3D5PwawPDIw2TIozuKGGvQg+O5oWT5/Na9xVtiD3Eyq9jb0r
        ohlIvwObWww61zf9jChFyKY=
X-Google-Smtp-Source: APXvYqwGjdLEMGO2axeeoSTCBlKYOUpMMnz3XT58fu/dQbQ2rtMMHr+QMxffwtAXa/28ZeRcIJ7PrQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr38564865plk.105.1553709602889;
        Wed, 27 Mar 2019 11:00:02 -0700 (PDT)
Received: from gmail.com ([2620:0:1008:fd00:ed8e:8493:d2b7:8f54])
        by smtp.gmail.com with ESMTPSA id g67sm34103689pfg.94.2019.03.27.11.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:00:02 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:00:00 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
Message-ID: <20190327175957.GA9309@gmail.com>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-17-dima@arista.com>
 <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
 <alpine.DEB.2.21.1902081051410.1645@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1902081051410.1645@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the generic vdso patchset is in development, we decided to think
about what other ways of generating two vdso libraries. In this
patchset, we use a linker script, but it looks too complicated, so we
decided to look at other options. Another obvious approach is the code
patching technique. The main idea was to reduce the amount of
arch-dependent code and Dmitry brought with the idea of three labels.
Let’s look at this pseudo-code:

Int vdso_clock_gettime(clockid_t clk, struct timespec *ts)
{
...
l_call:
               clk_to_ns(clk, ts)
l_return:
               return 0;
               annotate_reachable();
l_out:
               nop();
               return 0;
}

Here we can see three labels. Without patching this code, the function
will apply vdso offsets. But if we copy the code between the last two
labels to the first label, we will get a version which skips vdso
offsets. The patch which implements this idea will be in replies to this
email. It was tested on x86_64 and with gcc as a compiler, but we
suspect that there might be some issues on other architectures or with
other compilers. So we would like to ask the help of the community to
understand what we have to do to be sure that this code works always
correctly.

The second patch implements static_branch for the vdso code.
Here are only a few lines of arch-dependent code:

+static __always_inline bool timens_static_branch(void)
+{
+       asm_volatile_goto("1:\n\t"
+               ".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+                ".pushsection __retcall_table,  \"aw\"\n\t"
+                "2: .word 1b - 2b, %l[l_yes] - 2b\n\t"
+                ".popsection\n\t"
+                : :  :  : l_yes);
+
+       return false;
+l_yes:
+       return true;
+}

This is a slightly modified version of the arch_static_branch()
function. The timens code in vdso looks like this:

           if (timens_static_branch()) {
                   clk_to_ns(clk, ts);
           }

The version of vdso which is compiled from sources will never execute
clk_to_ns(). And then we can patch the 'no-op' in the straight-line
codepath with a 'jump' instruction to the out-of-line true branch and
get the timens version of the vdso library.

Now we can compare these three versions. Our opinion is that the version
with three labels looks cleaner and if it will work with all compilers
on all architectures, we probably have to choose it. Otherwise, we would
prefer the version with static_branches, because it is simpler than the
version with the linker script.

Thanks,
Andrei

On Fri, Feb 08, 2019 at 10:57:57AM +0100, Thomas Gleixner wrote:
> On Thu, 7 Feb 2019, Rasmus Villemoes wrote:
>
> Cc: + Vincenzo, Will
>
> > On 06/02/2019 01.10, Dmitry Safonov wrote:
> > > As it has been discussed on timens RFC, adding a new conditional branch
> > > `if (inside_time_ns)` on VDSO for all processes is undesirable.
> > > It will add a penalty for everybody as branch predictor may mispredict
> > > the jump. Also there are instruction cache lines wasted on cmp/jmp.
> > >
> > > Those effects of introducing time namespace are very much unwanted
> > > having in mind how much work have been spent on micro-optimisation
> > > vdso code.
> > >
> > > Addressing those problems, there are two versions of VDSO's .so:
> > > for host tasks (without any penalty) and for processes inside of time
> > > namespace with clk_to_ns() that subtracts offsets from host's time.
> > >
> > > Unfortunately, to allow changing VDSO VMA on a running process,
> > > the entry points to VDSO should have the same offsets (addresses).
> > > That's needed as i.e. application that calls setns() may have already
> > > resolved VDSO symbols in GOT/PLT.
> >
> > These (14-19, if I'm reading them right) seems to add quite a lot of
> > complexity and fragility to the build, and other architectures would
> > probably have to add something similar to their vdso builds.
>
> Yes and we really want to avoid that. The VDSO implementations are
> pointlessly different accross the architectures and there is effort on the
> way to consolidate them:
>
>   https://lkml.kernel.org/r/20190115135539.24762-1-vincenzo.frascino@arm.com
>
> I talked to Vincenzo earlier this week and he's working on a new version of
> that. The timens stuff wants to go on top of the consolidation otherwise we
> end up with another set of pointlessly different and differently broken
> VDSO variants.
>
> Thanks,
>
> 	tglx
