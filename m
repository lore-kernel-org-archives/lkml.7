Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1EA26E4A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559335074;
	bh=7Z8b3ulgUG2hjwYgp+tfD2PLBiXl3+OabT5960Wi2Vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ppFedy1Rgjc36ONpOZVfc6O052Uc0+HTlKgTc5YVxe9u3B5PT8z4aFBZnLAkX2/xp
	 5WgWpiJ/6f2Ognw75JiUTXNr6vx0vSUQ+JHSCCrFXfbthxCeWWW8hBSYM36n2GVvzO
	 PCh8g1rIsr4kIH/LED57/FeraNxShTgnThFKvJfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEaUhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfEaUhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:37:53 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4DA26EAA
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559335071;
        bh=7Z8b3ulgUG2hjwYgp+tfD2PLBiXl3+OabT5960Wi2Vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WJqyQ7nEcKF4lBMX7Y+w5R90kNOc/zbpWXVyN/8NqYOdaBm+2iA8npdce4nneH/Xq
         Y97oxiyxNDxUiBKauDOtFDM2oeesKBIoxPxAdaNgINuOvaRKCJTIZfNQMwB4tMaqlT
         uO4T20bY5KExo2s409AXlhrHISWhgZLvT9bQUmJQ=
Received: by mail-wr1-f45.google.com with SMTP id n4so4254773wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:37:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXx4moBQQpBd8FMrinOh4XDTzdWD60Zml+o3VhYObx+1nEdTS3w
        ZJFl0NVAkgsKmzqbF4jLKTXuXq0BEQ6p/uM9/H+PvA==
X-Google-Smtp-Source: APXvYqwKFdNbqdHqanZ067WEP/gQBT/D13C8/wcy08PIHMLM+3nGbRJh8aaRDyhNNAaioQnYvA+ruDN9rlguZuCtclY=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr7730253wrr.221.1559335070012;
 Fri, 31 May 2019 13:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net> <16D8E001-98A0-4ABC-AFE8-0F230B869027@amacapital.net>
 <82DB7035-D7BE-4D79-BBC0-B271FB4BF740@vmware.com> <4e0ed5a5-0e5e-3481-e646-3f032f17ac60@intel.com>
In-Reply-To: <4e0ed5a5-0e5e-3481-e646-3f032f17ac60@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 May 2019 13:37:38 -0700
X-Gmail-Original-Message-ID: <CALCETrVf9dh4GxEXsHbP65x6YuzOBf+7HWqOgBBjUma+7nB6Nw@mail.gmail.com>
Message-ID: <CALCETrVf9dh4GxEXsHbP65x6YuzOBf+7HWqOgBBjUma+7nB6Nw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 1:13 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/31/19 12:31 PM, Nadav Amit wrote:
> >> On May 31, 2019, at 11:44 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >>
> >>
> >>> On May 31, 2019, at 3:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>>> On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
> >>>> When we flush userspace mappings, we can defer the TLB flushes, as long
> >>>> the following conditions are met:
> >>>>
> >>>> 1. No tables are freed, since otherwise speculative page walks might
> >>>>  cause machine-checks.
> >>>>
> >>>> 2. No one would access userspace before flush takes place. Specifically,
> >>>>  NMI handlers and kprobes would avoid accessing userspace.
> >>>>
> >>>> Use the new SMP support to execute remote function calls with inlined
> >>>> data for the matter. The function remote TLB flushing function would be
> >>>> executed asynchronously and the local CPU would continue execution as
> >>>> soon as the IPI was delivered, before the function was actually
> >>>> executed. Since tlb_flush_info is copied, there is no risk it would
> >>>> change before the TLB flush is actually executed.
> >>>>
> >>>> Change nmi_uaccess_okay() to check whether a remote TLB flush is
> >>>> currently in progress on this CPU by checking whether the asynchronously
> >>>> called function is the remote TLB flushing function. The current
> >>>> implementation disallows access in such cases, but it is also possible
> >>>> to flush the entire TLB in such case and allow access.
> >>>
> >>> ARGGH, brain hurt. I'm not sure I fully understand this one. How is it
> >>> different from today, where the NMI can hit in the middle of the TLB
> >>> invalidation?
> >>>
> >>> Also; since we're not waiting on the IPI, what prevents us from freeing
> >>> the user pages before the remote CPU is 'done' with them? Currently the
> >>> synchronous IPI is like a sync point where we *know* the remote CPU is
> >>> completely done accessing the page.
> >>>
> >>> Where getting an IPI stops speculation, speculation again restarts
> >>> inside the interrupt handler, and until we've passed the INVLPG/MOV CR3,
> >>> speculation can happen on that TLB entry, even though we've already
> >>> freed and re-used the user-page.
> >>>
> >>> Also, what happens if the TLB invalidation IPI is stuck behind another
> >>> smp_function_call IPI that is doing user-access?
> >>>
> >>> As said,.. brain hurts.
> >>
> >> Speculation aside, any code doing dirty tracking needs the flush to happen
> >> for real before it reads the dirty bit.
> >>
> >> How does this patch guarantee that the flush is really done before someone
> >> depends on it?
> >
> > I was always under the impression that the dirty-bit is pass-through - the
> > A/D-assist walks the tables and sets the dirty bit upon access. Otherwise,
> > what happens when you invalidate the PTE, and have already marked the PTE as
> > non-present? Would the CPU set the dirty-bit at this point?
>
> Modulo bugs^Werrata...  No.  What actually happens is that a
> try-to-set-dirty-bit page table walk acts just like a TLB miss.  The old
> contents of the TLB are discarded and only the in-memory contents matter
> for forward progress.  If Present=0 when the PTE is reached, you'll get
> a normal Present=0 page fault.

Wait, does that mean that you can do a lock cmpxchg or similar to
clear the dirty and writable bits together and, if the dirty bit was
clear, skip the TLB flush?  If so, nifty!  Modulo errata, of course.
And I seem to remember some exceptions relating to CET shadow stack
involving the dirty bit being set on not-present pages.

>
> > In this regard, I remember this thread of Dave Hansen [1], which also seems
> > to me as supporting the notion the dirty-bit is set on write and not on
> > INVLPG.
>
> ... and that's the erratum I was hoping you wouldn't mention. :)
>
> But, yeah, I don't think it's possible to set the Dirty bit on INVLPG.
> The bits are set on establishing TLB entries, not on evicting or
> flushing them.
>
> I hope that clears it up.
