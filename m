Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A297CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233342067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZ2LgbFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfJUXuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:50:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44769 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfJUXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:50:04 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so18121552iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 16:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPUo1XVWAywCr31L1MGbFZJLJCSfIVIJxFTYC9L2BdM=;
        b=TZ2LgbFLjIjAWm1kGDLg1IgpMauhujV5kdUAPmE0JTcwvq+Rjp1LBg7+M6xGrZZCo4
         WEwdCnKYnkDYXbn53d7NfDsWEUltwXo/KrXyvf5cjpXu3EbHlvZx1IKJQI+X7N+tAicc
         WPnyUoACckM7AlMck/B3UXwi+aW3BxQAFH5Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPUo1XVWAywCr31L1MGbFZJLJCSfIVIJxFTYC9L2BdM=;
        b=dr5tdqY4i92Wm7XxOY/BfUDvWTbiGnD9t95pJ4seZcZb2D9oqqjv9LlzW0H95yyeb6
         eoHiU284R0JKF/Lao0sknDLKwoqooVNvghWIRHMtLwLJMTk9mI9dATKPZMMb/i8TjCbQ
         o5owpMdooFh/nZ9yCRivp9SKHwC9blzQ5xIV3Ba7RfcaQ4Zcv2m0etelgIT5ClVPJ6zg
         IojP/kNQbzOxuRa6LKpz3Gfln7Wji7tmbyrIeYeM0OxEBLB82UR5Q1zZg2mr8sPREveD
         u0eEQ8Mi4acJO3bxF6krkoSwHqMD2J6UuIyyTsJvp6+k0ltNbhqJ0oOGer7Mpj8fU87O
         /Q+A==
X-Gm-Message-State: APjAAAVKOOQDyBgU1hCcXVZD6O47P07Ye3eTw5F0TyyT8vqUFDmsxEoe
        6+C6Mt1tD3MyvKrqkLQcnnb+fmLru1A=
X-Google-Smtp-Source: APXvYqwMxFB1ol6BEZCJyLydlz06QoDANnFKx1nFCBXDNmsUdFLZCagBcBMB2HpQ6tbiJnrjAZVW2A==
X-Received: by 2002:a5e:8219:: with SMTP id l25mr933414iom.292.1571701803163;
        Mon, 21 Oct 2019 16:50:03 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id b18sm1561697ilo.70.2019.10.21.16.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 16:50:02 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id w12so18121476iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 16:50:02 -0700 (PDT)
X-Received: by 2002:a6b:b714:: with SMTP id h20mr977545iof.168.1571701801703;
 Mon, 21 Oct 2019 16:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191021184658.GE20212@google.com>
In-Reply-To: <20191021184658.GE20212@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Oct 2019 16:49:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6AzjET0ZRz-faUM0uqqQpfjt-g=0nX=L0LJg-+cjZtw@mail.gmail.com>
Message-ID: <CAD=FV=X6AzjET0ZRz-faUM0uqqQpfjt-g=0nX=L0LJg-+cjZtw@mail.gmail.com>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>,
        Kazuhiro Inaba <kinaba@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 21, 2019 at 11:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> > This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> > watchpoint addresses") but ported to arm32, which has the same
> > problem.
> >
> > This problem was found by Android CTS tests, notably the
> > "watchpoint_imprecise" test [1].  I tested locally against a copycat
> > (simplified) version of the test though.
> >
> > [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
> >  1 file changed, 70 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> > index b0c195e3a06d..d394878409db 100644
> > --- a/arch/arm/kernel/hw_breakpoint.c
> > +++ b/arch/arm/kernel/hw_breakpoint.c
> > @@ -680,26 +680,62 @@ static void disable_single_step(struct perf_event *bp)
> >       arch_install_hw_breakpoint(bp);
> >  }
> >
> > +/*
> > + * Arm32 hardware does not always report a watchpoint hit address that matches
> > + * one of the watchpoints set. It can also report an address "near" the
> > + * watchpoint if a single instruction access both watched and unwatched
> > + * addresses. There is no straight-forward way, short of disassembling the
> > + * offending instruction, to map that address back to the watchpoint. This
> > + * function computes the distance of the memory access from the watchpoint as a
> > + * heuristic for the likelyhood that a given access triggered the watchpoint.
> > + *
> > + * See this same function in the arm64 platform code, which has the same
> > + * problem.
> > + *
> > + * The function returns the distance of the address from the bytes watched by
> > + * the watchpoint. In case of an exact match, it returns 0.
> > + */
> > +static u32 get_distance_from_watchpoint(unsigned long addr, u32 val,
> > +                                     struct arch_hw_breakpoint_ctrl *ctrl)
> > +{
> > +     u32 wp_low, wp_high;
> > +     u32 lens, lene;
> > +
> > +     lens = __ffs(ctrl->len);
>
> Doesn't this always end up with 'lens == 0'? IIUC ctrl->len can have
> the values ARM_BREAKPOINT_LEN_{1,2,4,8}:
>
> #define ARM_BREAKPOINT_LEN_1    0x1
> #define ARM_BREAKPOINT_LEN_2    0x3
> #define ARM_BREAKPOINT_LEN_4    0xf
> #define ARM_BREAKPOINT_LEN_8    0xff

Yes, but my best guess without digging into the ARM ARM is that the
underlying hardware is more flexible.  I don't think it hurts to
support the flexibility here even if the code creating the breakpoint
never creates one line that.  ...especially since it makes the arm32
and arm64 code match in this way.


> > +     lene = __fls(ctrl->len);
> > +
> > +     wp_low = val + lens;
> > +     wp_high = val + lene;
>
> First I thought these values are off by one, but in difference to
> ffs() from glibc the kernel functions start with index 0, instead
> of using zero as 'no bit set'.

Yes, this took me a while.  If you look at the original commit
fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact watchpoint
addresses") this was clearly done on purpose though.  Specifically
note the part of the commit message:

[will: use __ffs instead of ffs - 1]


> > +     if (addr < wp_low)
> > +             return wp_low - addr;
> > +     else if (addr > wp_high)
> > +             return addr - wp_high;
> > +     else
> > +             return 0;
> > +}
> > +
> >  static void watchpoint_handler(unsigned long addr, unsigned int fsr,
> >                              struct pt_regs *regs)
> >  {
> > -     int i, access;
> > -     u32 val, ctrl_reg, alignment_mask;
> > +     int i, access, closest_match = 0;
> > +     u32 min_dist = -1, dist;
> > +     u32 val, ctrl_reg;
> >       struct perf_event *wp, **slots;
> >       struct arch_hw_breakpoint *info;
> >       struct arch_hw_breakpoint_ctrl ctrl;
> >
> >       slots = this_cpu_ptr(wp_on_reg);
> >
> > +     /*
> > +      * Find all watchpoints that match the reported address. If no exact
> > +      * match is found. Attribute the hit to the closest watchpoint.
> > +      */
> > +     rcu_read_lock();
> >       for (i = 0; i < core_num_wrps; ++i) {
> > -             rcu_read_lock();
> > -
> >               wp = slots[i];
> > -
> >               if (wp == NULL)
> > -                     goto unlock;
> > +                     continue;
> >
> > -             info = counter_arch_bp(wp);
> >               /*
> >                * The DFAR is an unknown value on debug architectures prior
> >                * to 7.1. Since we only allow a single watchpoint on these
> > @@ -708,33 +744,31 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
> >                */
> >               if (debug_arch < ARM_DEBUG_ARCH_V7_1) {
> >                       BUG_ON(i > 0);
> > +                     info = counter_arch_bp(wp);
> >                       info->trigger = wp->attr.bp_addr;
> >               } else {
> > -                     if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
> > -                             alignment_mask = 0x7;
> > -                     else
> > -                             alignment_mask = 0x3;
> > -
> > -                     /* Check if the watchpoint value matches. */
> > -                     val = read_wb_reg(ARM_BASE_WVR + i);
> > -                     if (val != (addr & ~alignment_mask))
> > -                             goto unlock;
> > -
> > -                     /* Possible match, check the byte address select. */
> > -                     ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
> > -                     decode_ctrl_reg(ctrl_reg, &ctrl);
> > -                     if (!((1 << (addr & alignment_mask)) & ctrl.len))
> > -                             goto unlock;
> > -
> >                       /* Check that the access type matches. */
> >                       if (debug_exception_updates_fsr()) {
> >                               access = (fsr & ARM_FSR_ACCESS_MASK) ?
> >                                         HW_BREAKPOINT_W : HW_BREAKPOINT_R;
> >                               if (!(access & hw_breakpoint_type(wp)))
> > -                                     goto unlock;
> > +                                     continue;
> >                       }
> >
> > +                     val = read_wb_reg(ARM_BASE_WVR + i);
> > +                     ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
> > +                     decode_ctrl_reg(ctrl_reg, &ctrl);
> > +                     dist = get_distance_from_watchpoint(addr, val, &ctrl);
> > +                     if (dist < min_dist) {
> > +                             min_dist = dist;
> > +                             closest_match = i;
> > +                     }
> > +                     /* Is this an exact match? */
> > +                     if (dist != 0)
> > +                             continue;
> > +
> >                       /* We have a winner. */
> > +                     info = counter_arch_bp(wp);
> >                       info->trigger = addr;
>
> Unless we care about using the 'last' watchpoint in case multiple WPs have
> the same address I think it would be clearer to change the above to:
>
>                         if (dist == 0) {
>                                 /* We have a winner. */
>                                 info = counter_arch_bp(wp);
>                                 info->trigger = addr;
>                                 break;
>                         }

Without being an expert on the Hardware Breakpoint API, my
understanding (based on how the old arm32 code worked and how the
existing arm64 code works) is that the API accounts for the fact that
more than one watchpoint can trigger and that we should report on all
of them.

Specifically if you do:

watch 1 byte at 0x1000
watch 1 byte at 0x1003

...and then someone does a single 4-byte write at 0x1000 then both
watchpoints should trigger.  If we do a "break" here then they won't
both trigger.  Also note that the triggering happens below in the
"perf_bp_event(wp, regs)" so with your break I think you'll miss it,
no?

That being said, with my patch we still won't do exactly the right
thing that for an "imprecise" watchpoint.  Specifically if you do:

watch 1 byte at 0x1008
watch 1 byte at 0x100b
write 16 bytes at 0x1000

...then we will _only_ trigger the 0x1008 watchpoint.  ...but that's
the limitation in how the breakpoints work.  You can see this is what
happens because the imprecise stuff is outside the for loop and only
triggers when nothing else did.


-Doug
