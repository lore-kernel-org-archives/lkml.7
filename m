Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AC820679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573574954;
	bh=qTvO89OmeGVCdEbsPsJv2sAxHRmVtCMRjAR39lkJFYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W+PC9e6nLk0vSibhl/PLzCX6iG7N2ADffdDXPsOtFA7++cHm/jX4GzjB7LibyORPS
	 FUAzar/pj1jv+MnBinagN1gk8LaFUq4R4lopDsmgtAU/WMjGrfMZ5Fz/f2kYQ+E3u4
	 WG2malzLsC/yHWuLmZiHJn8gJlA7if+uvwa8qUKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKLQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKLQJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:09:12 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6692A20679
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573574950;
        bh=qTvO89OmeGVCdEbsPsJv2sAxHRmVtCMRjAR39lkJFYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ihR+drOhpL3QLzNNdbSg/2dslPY2kxLxRKQdBq26mjH0TzZBs/bF0pkJM7tqZBYaq
         jE9TWCuuUJ2cQFfcTHWvOJh5IzaCYmTtCDHKRvRMt/2BMFWAFPl0eyRRjrM+jyUJCT
         Dzg3PvD8OsJJlmyjG6gY16Sh03xDPy7DEhxHYH8w=
Received: by mail-wm1-f47.google.com with SMTP id l1so3832656wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:09:10 -0800 (PST)
X-Gm-Message-State: APjAAAVZYoHGjF0R4eLLAymbN2jsOV4gRpcw/AAOcHBDTeP0snxDEkO4
        jgGW+VQO08DnvAuSabc9TlWmE4NGLS1x4H3ym109pw==
X-Google-Smtp-Source: APXvYqwyjTEhLJWUWzTnFEZV/SglhFr/WARMpbYd925kH6Bt67zRQy3Y1nBMaxeKySSvm9W8k27xAhq+0TWRoDgJQwY=
X-Received: by 2002:a05:600c:1002:: with SMTP id c2mr4644883wmc.79.1573574948854;
 Tue, 12 Nov 2019 08:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.292300453@linutronix.de>
In-Reply-To: <20191111223052.292300453@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 08:08:57 -0800
X-Gmail-Original-Message-ID: <CALCETrXcBpxwvoPtqa1-c+SF+4K9oeebUA_JFNaN2Yn2USwVNA@mail.gmail.com>
Message-ID: <CALCETrXcBpxwvoPtqa1-c+SF+4K9oeebUA_JFNaN2Yn2USwVNA@mail.gmail.com>
Subject: Re: [patch V2 08/16] x86/ioperm: Add bitmap sequence number
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Add a globally unique sequence number which is incremented when ioperm() is
> changing the I/O bitmap of a task. Store the new sequence number in the
> io_bitmap structure and compare it along with the actual struct pointer
> with the one which was last loaded on a CPU. Only update the bitmap if
> either of the two changes. That should further reduce the overhead of I/O
> bitmap scheduling when there are only a few I/O bitmap users on the system.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/include/asm/iobitmap.h  |    1
>  arch/x86/include/asm/processor.h |    8 +++++++
>  arch/x86/kernel/cpu/common.c     |    1
>  arch/x86/kernel/ioport.c         |    9 +++++---
>  arch/x86/kernel/process.c        |   40 +++++++++++++++++++++++++++++----------
>  5 files changed, 46 insertions(+), 13 deletions(-)
>
> --- a/arch/x86/include/asm/iobitmap.h
> +++ b/arch/x86/include/asm/iobitmap.h
> @@ -5,6 +5,7 @@
>  #include <asm/processor.h>
>
>  struct io_bitmap {
> +       u64                     sequence;
>         unsigned int            io_bitmap_max;
>         union {
>                 unsigned long   bits[IO_BITMAP_LONGS];
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -366,6 +366,14 @@ struct tss_struct {
>         struct x86_hw_tss       x86_tss;
>
>         /*
> +        * The bitmap pointer and the sequence number of the last active
> +        * bitmap. last_bitmap cannot be dereferenced. It's solely for
> +        * comparison.
> +        */
> +       struct io_bitmap        *last_bitmap;
> +       u64                     last_sequence;
> +
> +       /*
>          * Store the dirty size of the last io bitmap offender. The next
>          * one will have to do the cleanup as the switch out to a non io
>          * bitmap user will just set x86_tss.io_bitmap_base to a value

Why is all this stuff in the TSS?  Would it make more sense in a
percpu variable tss_state?  By putting it in the TSS, you're putting
it in cpu_entry_area, which is at least a bit odd if not an actual
security problem.

And why do you need a last_bitmap pointer?  I thin that comparing just
last_sequence should be enough.  Keeping last_bitmap around at all is
asking for trouble, since it might point to freed memory.

> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1861,6 +1861,7 @@ void cpu_init(void)
>         /* Initialize the TSS. */
>         tss_setup_ist(tss);
>         tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
> +       tss->last_bitmap = NULL;
>         tss->io_bitmap_prev_max = 0;
>         memset(tss->io_bitmap_bytes, 0xff, sizeof(tss->io_bitmap_bytes));
>         set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -14,6 +14,8 @@
>  #include <asm/iobitmap.h>
>  #include <asm/desc.h>
>
> +static atomic64_t io_bitmap_sequence;
> +
>  /*
>   * this changes the io permissions bitmap in the current task.
>   */
> @@ -76,14 +78,15 @@ long ksys_ioperm(unsigned long from, uns
>
>         iobm->io_bitmap_max = bytes;
>
> -       /* Update the TSS: */
> -       memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
> -
> +       /* Update the sequence number to force an update in switch_to() */
> +       iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
>         /* Set the tasks io_bitmap pointer (might be the same) */
>         t->io_bitmap = iobm;
>         /* Mark it active for context switching */
>         set_thread_flag(TIF_IO_BITMAP);
>
> +       /* Update the TSS: */
> +       memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
>         /* Make the bitmap base in the TSS valid */
>         tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
>
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -354,6 +354,29 @@ void arch_setup_new_exec(void)
>         }
>  }
>
> +static void switch_to_update_io_bitmap(struct tss_struct *tss,
> +                                      struct io_bitmap *iobm)
> +{
> +       /*
> +        * Copy at least the byte range of the incoming tasks bitmap which
> +        * covers the permitted I/O ports.
> +        *
> +        * If the previous task which used an I/O bitmap had more bits
> +        * permitted, then the copy needs to cover those as well so they
> +        * get turned off.
> +        */
> +       memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
> +              max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
> +
> +       /*
> +        * Store the new max and the sequence number of this bitmap
> +        * and a pointer to the bitmap itself.
> +        */
> +       tss->io_bitmap_prev_max = iobm->io_bitmap_max;
> +       tss->last_sequence = iobm->sequence;
> +       tss->last_bitmap = iobm;
> +}
> +
>  static inline void switch_to_bitmap(struct thread_struct *next,
>                                     unsigned long tifp, unsigned long tifn)
>  {
> @@ -363,18 +386,15 @@ static inline void switch_to_bitmap(stru
>                 struct io_bitmap *iobm = next->io_bitmap;
>
>                 /*
> -                * Copy at least the size of the incoming tasks bitmap
> -                * which covers the last permitted I/O port.
> -                *
> -                * If the previous task which used an io bitmap had more
> -                * bits permitted, then the copy needs to cover those as
> -                * well so they get turned off.
> +                * Only copy bitmap data when the bitmap or the sequence
> +                * number differs. The update time is accounted to the
> +                * incoming task.
>                  */
> -               memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
> -                      max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
> +               if (tss->last_bitmap != iobm ||
> +                   tss->last_sequence != iobm->sequence)

As above, I think this could just be if (tss->last_sequence !=
iobm->sequence) or even if (this_cpu_read(cpu_tss_state.iobm_sequence)
!= iobm->sequence).

--Andy
