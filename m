Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F071C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC1216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PxOfkjT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfGaSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:41:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36018 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfGaSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:41:39 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so34922394iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AsLIdRn1/s/ajhZAFGpfmDm8iyB8h5HN7OzbntAvwU=;
        b=PxOfkjT7L+Hwdws3JZ6LI7RIiZnSFD26K9lcMVVxc7bdsCSr6UJeCFlxR2ViMJRVgZ
         kKcCXB97d79J4mBEjnLyj18g9tQyLOnRgxTkJ1nN/qkHZ8DkRWoinzBu16Zow0FHmIpz
         HVoScJTEr7/TuqQu0dTMDxJariUa7FqrVwyGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AsLIdRn1/s/ajhZAFGpfmDm8iyB8h5HN7OzbntAvwU=;
        b=BNw6EOeZ4Gkzne2vKTH7h11jHBD7M6oGOrehkrBsgTPP9J9QCdMrejWu4h9paFPmVE
         aiDJu4Pxt1TVUe6OzjDSJk69U+fOAt3tsf3gFmB63A+quEiz/eswd6U3i5jY7Q7Wr+TO
         ePq3IaYB+40VPmklXR/49ReF/SP50r9x6BpPNrXUTzINrmFsgA4QZF4jqSKBRNss86mg
         NGrI49AJOoaR8JdBefc7i0BWDIyfHfNWA8v58Kr6am0aiVq+zaI0yEh7hEWcdxd2kZlY
         PNQo0GnPrXboOmR76SlGIjRaiKQ+nTkKDV/tNGtcQc8JewR4/hvdg6inp/KH0BwfKLMs
         eung==
X-Gm-Message-State: APjAAAVBOLIuhCLziF/IgRUQgH4GgF65GQTlyirc8S74SLzYlwiS9fFP
        /TBKhi2fRsMgFPrJh2hPSam8B7v2/Aw=
X-Google-Smtp-Source: APXvYqys2GnpWE8mEW9IgCuaPM00AlQgk7/rG5aiX1rdXNQWeAgSkNdHmJSbA/zqXcfRljAGrw0WsQ==
X-Received: by 2002:a5d:9448:: with SMTP id x8mr57153615ior.102.1564598498102;
        Wed, 31 Jul 2019 11:41:38 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id t4sm52164033iop.0.2019.07.31.11.41.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:41:37 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id f4so138553177ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:41:37 -0700 (PDT)
X-Received: by 2002:a02:a1c7:: with SMTP id o7mr131531038jah.26.1564598496739;
 Wed, 31 Jul 2019 11:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190730221800.28326-1-dianders@chromium.org> <20190731125733.op3y5j5psuj6pet3@willie-the-truck>
In-Reply-To: <20190731125733.op3y5j5psuj6pet3@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Jul 2019 11:41:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYC4x7MCfkHbB=Mm-6NJywbXs4zAGfz0t+5OdXFOmE7g@mail.gmail.com>
Message-ID: <CAD=FV=WYC4x7MCfkHbB=Mm-6NJywbXs4zAGfz0t+5OdXFOmE7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: debug: Make 'btc' and similar work in kdb
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 31, 2019 at 5:57 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Doug,
>
> On Tue, Jul 30, 2019 at 03:18:00PM -0700, Douglas Anderson wrote:
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index 43119922341f..b666210fbc75 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -148,6 +148,45 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
> >       gdb_regs[32] = cpu_context->pc;
> >  }
> >
> > +void kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     struct pt_regs *regs;
> > +
> > +     /*
> > +      * NOTE: get_irq_regs() is supposed to get the registers from
> > +      * before the IPI interrupt happened and so is supposed to
> > +      * show where the processor was.  In some situations it's
> > +      * possible we might be called without an IPI, so it might be
> > +      * safer to figure out how to make kgdb_breakpoint() work
> > +      * properly here.
> > +      */
> > +     regs = get_irq_regs();
> > +
> > +     /*
> > +      * Some commands (like 'btc') assume that they can find info about
> > +      * a task in the 'cpu_context'.  Unfortunately that's only valid
> > +      * for sleeping tasks.  ...but let's make it work anyway by just
> > +      * writing the registers to the right place.  This is safe because
> > +      * nobody else is using the 'cpu_context' for a running task.
> > +      */
> > +     current->thread.cpu_context.x19 = regs->regs[19];
> > +     current->thread.cpu_context.x20 = regs->regs[20];
> > +     current->thread.cpu_context.x21 = regs->regs[21];
> > +     current->thread.cpu_context.x22 = regs->regs[22];
> > +     current->thread.cpu_context.x23 = regs->regs[23];
> > +     current->thread.cpu_context.x24 = regs->regs[24];
> > +     current->thread.cpu_context.x25 = regs->regs[25];
> > +     current->thread.cpu_context.x26 = regs->regs[26];
> > +     current->thread.cpu_context.x27 = regs->regs[27];
> > +     current->thread.cpu_context.x28 = regs->regs[28];
> > +     current->thread.cpu_context.fp = regs->regs[29];
> > +
> > +     current->thread.cpu_context.sp = regs->sp;
> > +     current->thread.cpu_context.pc = regs->pc;
> > +
> > +     kgdb_nmicallback(raw_smp_processor_id(), regs);
> > +}
>
> This is really gross... :/

Well, sort of.  At first I definitely thought of it as a hack.  ...but
then I realized that it's actually not so terrible.  Although the
other processors (the ones that are not the kgdb master) are
technically "running" as far as Linux is concerned, you can also think
of them as "stopped" in the debugger.  It's convenient to think of
them the same way you'd think of sleeping tasks.

Said another way: normally for a "running" task you couldn't put
anything in the "cpu_context" because it'd be wrong the moment you put
it there.  ...but when a CPU is stopped in kgdb then there's actually
something quite sane to put there.

So with just a small shift in the concept of what "cpu_context" is for
then it becomes not so gross.


> Can you IPI the other CPUs instead and have them backtrace locally, like we
> do for things like magic sysrq (sysrq_handle_showallcpus())?

No, unfortunately.  All the other CPUs are in a tight loop (with
interrupts off) waiting to be released by the kgdb master.  Amusingly,
it's possible to simulate this.  You can run a sysrq from the kdb
prompt.  When I do "sr l" from kdb:

A) The CPU running the kgdb master provides a stack crawl but it's not
really what you want.  Presumably this doesn't matter (we wouldn't
want to send the IPI to the calling CPU), but it's interesting to look
at.  We end up in the fallback workqueue case in
sysrq_handle_showallcpus().  Then we will backtrace based on the regs
returned by "get_irq_regs()".  Thus instead of:

[0]kdb> bt
Stack traceback for pid 0
0xffffff801101a9c0        0        0  1    0   R  0xffffff801101b3b0 *swapper/0
Call trace:
 dump_backtrace+0x0/0x138
 show_stack+0x20/0x2c
 kdb_show_stack+0x60/0x84
 kdb_bt1+0xb8/0x100
 kdb_bt+0x24c/0x408
 kdb_parse+0x53c/0x664
 kdb_main_loop+0x7fc/0x888
 kdb_stub+0x2b0/0x3d0
 kgdb_cpu_enter+0x27c/0x5c4
 kgdb_handle_exception+0x198/0x1f4
 kgdb_compiled_brk_fn+0x34/0x44
 brk_handler+0x88/0xd0
 do_debug_exception+0xe0/0x128
 el1_dbg+0x18/0x8c
 kgdb_breakpoint+0x20/0x3c
 sysrq_handle_dbg+0x34/0x5c
 __handle_sysrq+0x14c/0x170
 handle_sysrq+0x38/0x44
 serial8250_handle_irq+0xe8/0xfc
 dw8250_handle_irq+0x94/0xd0
 serial8250_interrupt+0x48/0xa4
 __handle_irq_event_percpu+0x134/0x25c
 handle_irq_event_percpu+0x34/0x8c
 handle_irq_event+0x48/0x78
 handle_fasteoi_irq+0xd0/0x1a0
 __handle_domain_irq+0x84/0xc4
 gic_handle_irq+0x10c/0x180
 el1_irq+0xb8/0x180
 cpuidle_enter_state+0x284/0x428
 cpuidle_enter+0x38/0x4c
 do_idle+0x168/0x29c
 cpu_startup_entry+0x24/0x28
 rest_init+0xd4/0xe0
 arch_call_rest_init+0x10/0x18
 start_kernel+0x320/0x3a4

I get:

[0]kdb> sr l
sysrq: Show backtrace of all active CPUs
sysrq: CPU0:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc2+ #28
Hardware name: Google Kevin (DT)
pstate: 20000005 (nzCv daif -PAN -UAO)
pc : cpuidle_enter_state+0x284/0x428
lr : cpuidle_enter_state+0x274/0x428
sp : ffffff8011003e60
x29: ffffff8011003eb0 x28: ffffff8010f366b8
x27: ffffff8011010000 x26: 0000000000000001
x25: ffffff80110eb000 x24: 0000000000000000
x23: 00000024232e8f0a x22: 0000002420501a35
x21: 0000000000000002 x20: ffffffc0ee86e080
x19: ffffffc0f65426c0 x18: 0000000000000000
x17: 000000000000003e x16: 000000000000003f
x15: 0000000000000000 x14: ffffff801101a9c0
x13: 0000000000013320 x12: 0000000000000020
x11: 000000000624dd2f x10: 00000000ffffffff
x9 : 0000000100000001 x8 : 00000000000000c0
x7 : 00000032b5593519 x6 : 0000000000300000
x5 : 0000000000000000 x4 : 0000000000000101
x3 : 00000000ffffffff x2 : 0000000000000001
x1 : ffffffc0f6548d80 x0 : 0000000000000000
Call trace:
 cpuidle_enter_state+0x284/0x428
 cpuidle_enter+0x38/0x4c
 do_idle+0x168/0x29c
 cpu_startup_entry+0x24/0x28
 rest_init+0xd4/0xe0
 arch_call_rest_init+0x10/0x18
 start_kernel+0x320/0x3a4


B) All the other CPUs don't respond.  ...until you exit the debugger
and then they all print their stacks, a little too late.

---

The weird crawl for the master CPU made me think that maybe I could
use "show_regs()" to show the stacks of the other CPUs, but that
didn't work.  The arm64 stack crawling code really only works for a
sleeping task or for the current running task.

...this again gets back to the fact that we can really think of those
other CPUs stopped in the debugger as "sleeping".

=====

OK, so I think I managed to get something that maybe you're happy with:

https://lkml.kernel.org/r/20190731183732.178134-1-dianders@chromium.org

...I still think it's not such a hack to stash the state in the
"cpu_context" and I could imagine it might have other benefits when
debugging, but my new patch does have the advantage that it's more
platform agnostic.  ;-)  Let me know what you think...

-Doug
