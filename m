Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B419020679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573574469;
	bh=p8zMhulkPTF3qGOvBM5JbkPItAB7I09ZwT1tBcj8erE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WeEgmWPgJ0J7wwuYU9YBrDMn0fHZhc2P+XJwoGyGVJ2ZZIc8KEXxAaaManxebYGTy
	 d8mAfly9Pb/IMsXYQttriNVjUfeeoJW9YTPB3ivb9gVh6ITAyhwd+QeDmwvUaA3txE
	 FmAr+RrMpMzwf1xm8bOnRMqUzJxHI1mHv5U2Ic3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKLQBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLQBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:01:08 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE7320679
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573574467;
        bh=p8zMhulkPTF3qGOvBM5JbkPItAB7I09ZwT1tBcj8erE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jz3tc2uqfpmicZq5sAb642xiopfDsAFeWviTqKZKnOiTkZNYxnj4cijk8D8d+gttN
         hgpEAXvRNecQHrW3AIaDcTC3xo2/VAgEB0HOW8aJ2Y5ff9O/kHlooCvhdqgUl8aKDT
         zPk0c17Mv47c372G4306IwyxyNNM6JmSmNIBLh/0=
Received: by mail-wm1-f54.google.com with SMTP id b17so3536685wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:01:06 -0800 (PST)
X-Gm-Message-State: APjAAAWk5ng4d89RPe4uuM0cYzwVDAif/+6tdsDnn2C+NYn627Q0ksO6
        HTcj1+u48B0NfGL/qRXQ7xmGFMQvOP872+boau/qIg==
X-Google-Smtp-Source: APXvYqz06E6Um4KUpYkaNf5d9VYxu0/9mMt8HMubseNGUX3kzIbnjLrnmLWZtCe4M7k4A6DyOKUqQWykoCSfCeyHgXk=
X-Received: by 2002:a05:600c:3cf:: with SMTP id z15mr4702320wmd.76.1573574465509;
 Tue, 12 Nov 2019 08:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.086299881@linutronix.de>
In-Reply-To: <20191111223052.086299881@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 08:00:54 -0800
X-Gmail-Original-Message-ID: <CALCETrUcY_DhZC8CH0NhoRp_r6mh4v1Z2dmhsdErV8wx6FsLaw@mail.gmail.com>
Message-ID: <CALCETrUcY_DhZC8CH0NhoRp_r6mh4v1Z2dmhsdErV8wx6FsLaw@mail.gmail.com>
Subject: Re: [patch V2 06/16] x86/io: Speedup schedule out of I/O bitmap user
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There is no requirement to update the TSS I/O bitmap when a thread using it is
> scheduled out and the incoming thread does not use it.
>
> For the permission check based on the TSS I/O bitmap the CPU calculates the memory
> location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
> of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
> offset to an address outside of the TSS limit.
>
> If an I/O instruction is issued from user space the TSS limit causes #GP to be
> raised in the same was as valid I/O bitmap with all bits set to 1 would do.
>
> This removes the extra work when an I/O bitmap using task is scheduled out
> and puts the burden on the rare I/O bitmap users when they are scheduled
> in.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>

> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c

I won't swear this is wrong, but I'm not convinced it's correct
either.  I see two issues:

> @@ -40,8 +40,6 @@ long ksys_ioperm(unsigned long from, uns
>                         return -ENOMEM;
>
>                 memset(bitmap, 0xff, IO_BITMAP_BYTES);
> -               t->io_bitmap_ptr = bitmap;
> -               set_thread_flag(TIF_IO_BITMAP);
>
>                 /*
>                  * Now that we have an IO bitmap, we need our TSS limit to be
> @@ -50,6 +48,11 @@ long ksys_ioperm(unsigned long from, uns
>                  * limit correct.
>                  */
>                 preempt_disable();
> +               t->io_bitmap_ptr = bitmap;
> +               set_thread_flag(TIF_IO_BITMAP);
> +               /* Make the bitmap base in the TSS valid */
> +               tss = this_cpu_ptr(&cpu_tss_rw);
> +               tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
>                 refresh_tss_limit();
>                 preempt_enable();
>         }

It's not shown in the diff, but the very next line of code turns
preemption back off.  This means that we might schedule right here
with TIF_IO_BITMAP set, the base set to VALID, but the wrong data in
the bitmap.  I *think* this will actually end up being okay, but it
certainly makes understanding the code harder.  Can you adjust the
code so that preemption stays off?

More importantly, the code below this modifies the TSS copy in place
instead of writing a whole new copy.  But now that you've added your
optimization, the TSS copy might be *someone else's* IO bitmap.  So I
think you might end up with more io ports allowed than you intended.
For example:

Task A uses ioperm() to enable all ports.
Switch to task B.  Now the TSS base is INVALID but all bitmap bits are still 0.
Task B calls ioperm().

The code will set the base to VALID and will correctly set up the
thread's copy of the bitmap, but I think the copy will only update the
bits 0 through whatever ioperm() touched and not the bits above that
in the TSS.

I would believe that this is fixed later in your patch set.  If so,
perhaps you should just memcpy() the whole thing without trying to
optimize in this patch and then let the changes later re-optimize it
as appropriate.  IOW change memcpy(tss->io_bitmap, t->io_bitmap_ptr,
bytes_updated); to memcpy(..., BYTES_PER_LONG * IO_BITMAP_LONGS) or
similar.

--Andy
