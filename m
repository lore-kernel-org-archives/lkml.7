Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9024C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90C820715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRASm3Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNPJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:09:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36991 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:09:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so5118330otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIZW0Esa7rqGtB6CSWRu4KOQZWOLmeyw5FeK9CvEfA4=;
        b=TRASm3BggwuJeevcb/vtQgsYoy8+/r/OSQhVDCZuQAiZnRARScWROeyc4OlZdblYa1
         ki+7izxAdJeD0n1bahv0tQPRSKMI7Sm97AqNaY4lzDf0+ElCE0+McGOSErSG/H7r1WO8
         k2R5cFtJxHUdfjdSGdJdhFUFkPCUa0vsQ7rMZBe3UIC1mSZbbUp2htHsxp3xhVIMq3Ho
         /WHcZba0pTMgyi0QlHpmEMj2KDCarQquuZNv0J751OuUOT6kDy3kgUWAfh2f7SyGRRqf
         axNBnaIGdr/W2YXKi0lz4xFtJuZPdDgGH0s6KD5eVICeh2SlP5aAykq20tRt9DlEQ/dr
         yE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIZW0Esa7rqGtB6CSWRu4KOQZWOLmeyw5FeK9CvEfA4=;
        b=ggDZv643OWf7war03NXU7EpHrbkl0f7QVkt6u9c2RmP5BOStLkIn8dxd6kVdDnL63l
         NxZIGOKSdnbMyk9bRYEk4w+kL/tkruQdNZFNovctSATPka01y0POUjlkGb7r/Y0vZUsE
         LNCH7FE5VLCWAhpvmUkuutxHphkUqcXUZtCiFu16rJRzGp0/wx2selaYZ2AYOn/SECLb
         tajgHQdNy21voriabQdFBbmCm0tF4IXUCi+c5gHrfi2rljUooAuF6AeJg6THR0wNJLth
         gRb4B3EIwbDGKX9FDswJQT71JOXLar0Zp0+GRbnTfb0bPtbGrfKbfS7ooUlV1GPmkMlU
         kfig==
X-Gm-Message-State: APjAAAXzTu61Bh/qWtqpMIyoO/Utf8D8az8IfT5VUyHH7IH9ypoMYbr4
        9ToRIu4v+YMWQ8WSfeUMuJL3GDaITAqLj5IzRDJZcw==
X-Google-Smtp-Source: APXvYqytglgsbxJvsvkunntFXpXa75nV5VN0ZKbQ66UUQcd6A+CDP4d4RpgnTOYVhjL1ieiGSkb43T0JdxIDN1CxfSo=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr8205287otb.183.1573744187224;
 Thu, 14 Nov 2019 07:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-3-jannh@google.com>
 <CACT4Y+aojSsss3+Y2FB9Rw=OPxXgsFrGF0YiAJ9eo2wJM0ruWg@mail.gmail.com>
In-Reply-To: <CACT4Y+aojSsss3+Y2FB9Rw=OPxXgsFrGF0YiAJ9eo2wJM0ruWg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Nov 2019 16:09:20 +0100
Message-ID: <CAG48ez11Bhd+76T2L9xF64TZQOeezJ9+9GApG2A7eA1hVfG3eA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/kasan: Print original address on #GP
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Nov 12, 2019 at 10:10 PM 'Jann Horn' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
> > to understand by computing the address of the original access and
> > printing that. More details are in the comments in the patch.
[...]
> +Andrey, do you see any issues for TAGS mode? Or, Jann, did you test
> it by any chance?

No, I didn't - I don't have anything set up for upstream arm64 testing here.

> > +void kasan_general_protection_hook(unsigned long addr)
> >  {
> > -       if (val == DIE_GPF) {
> > -               pr_emerg("CONFIG_KASAN_INLINE enabled\n");
> > -               pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
> > -       }
> > -       return NOTIFY_OK;
> > -}
> > +       unsigned long orig_addr;
> > +       const char *addr_type;
> > +
> > +       if (addr < KASAN_SHADOW_OFFSET)
> > +               return;
>
> Thinking how much sense it makes to compare addr with KASAN_SHADOW_END...
> If the addr is > KASAN_SHADOW_END, we know it's not a KASAN access,
> but do we ever get GP on canonical addresses?

#GP can occur for various reasons, but on x86-64, if it occurs because
of an invalid address, as far as I know it's always non-canonical. The
#GP handler I wrote will check the address and only call the KASAN
hook if the address is noncanonical (because otherwise the #GP
occurred for some other reason).

> > -static struct notifier_block kasan_die_notifier = {
> > -       .notifier_call = kasan_die_handler,
> > -};
> > +       orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
> > +       /*
> > +        * For faults near the shadow address for NULL, we can be fairly certain
> > +        * that this is a KASAN shadow memory access.
> > +        * For faults that correspond to shadow for low canonical addresses, we
> > +        * can still be pretty sure - that shadow region is a fairly narrow
> > +        * chunk of the non-canonical address space.
> > +        * But faults that look like shadow for non-canonical addresses are a
> > +        * really large chunk of the address space. In that case, we still
> > +        * print the decoded address, but make it clear that this is not
> > +        * necessarily what's actually going on.
> > +        */
> > +       if (orig_addr < PAGE_SIZE)
> > +               addr_type = "dereferencing kernel NULL pointer";
> > +       else if (orig_addr < TASK_SIZE_MAX)
> > +               addr_type = "probably dereferencing invalid pointer";
>
> This is access to user memory, right? In outline mode we call it
> "user-memory-access". We could say about "user" part here as well.

Okay, I'll copy that naming.

> > +       else
> > +               addr_type = "maybe dereferencing invalid pointer";
> > +       pr_alert("%s in range [0x%016lx-0x%016lx]\n", addr_type,
> > +                orig_addr, orig_addr + (1 << KASAN_SHADOW_SCALE_SHIFT) - 1);
>
> "(1 << KASAN_SHADOW_SCALE_SHIFT) - 1)" part may be replaced with
> KASAN_SHADOW_MASK.
> Overall it can make sense to move this mm/kasan/report.c b/c we are
> open-coding a number of things here (e.g. reverse address mapping). If
> another arch will do the same, it will need all of this code too (?).

Alright, I'll try to move it over.
