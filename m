Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D747C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D54206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573582351;
	bh=Mv1cttr0wRuIR1Zt1r9gGIDi2R0BEk43g/XIXzOGrs8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kK+FZRlhyrHTn5dA+yPewRO5PSRdsnUHLEnkvTM2liEKmckS/NCLmSLJmDtrsnYHr
	 l1hEfQFs8+Ef8QBN5n1XhuV0yzB3i3U4DEPfeIUd2s61kTk4pil3AE5bU9dIlAlNCp
	 AAqaWBkOv6QHsb7pcQtIwt4qy2FdUNIGrf4orWrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKLSM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLSM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:12:29 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C62214E0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573582347;
        bh=Mv1cttr0wRuIR1Zt1r9gGIDi2R0BEk43g/XIXzOGrs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRJBQTZUiWZVLN/psD+qPEX3gAIjptUNfDR2sNywrB91S0N1PANp421IdE37uecYf
         i14w+vYiT810moFeamiOFu9NSosuVZD7rACI9XklBF/8VHkGbNCbIWaAE/ED5sG1hQ
         ZMjGSSJ0DK8LpZ4KjpwNw3PrE9WoZ6MymgwRbVIc=
Received: by mail-wr1-f52.google.com with SMTP id b3so19566015wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:12:27 -0800 (PST)
X-Gm-Message-State: APjAAAXEs9bMemhIRW20GULVUW8S70+C180X01Q+Pmn++UmLs+RrnFoP
        yz9K9x0wpakFWQDot+GTBVYEJA1T/S5Wa4KQbvA3Mg==
X-Google-Smtp-Source: APXvYqwuSLTv9UounWFr58Q0dxxgviQe3QuIYkS6jMdNptf6UM6a2GPvLSMcL+9AM5rphHdK0NQzoGA0wHCb+9wn6HE=
X-Received: by 2002:a5d:4412:: with SMTP id z18mr4845813wrq.149.1573582346134;
 Tue, 12 Nov 2019 10:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.603030685@linutronix.de>
In-Reply-To: <20191111223052.603030685@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 10:12:14 -0800
X-Gmail-Original-Message-ID: <CALCETrVXV61hN__tf-TakJCLnM6rVZ-5x7U2eeojadovhk6AJg@mail.gmail.com>
Message-ID: <CALCETrVXV61hN__tf-TakJCLnM6rVZ-5x7U2eeojadovhk6AJg@mail.gmail.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
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
> The I/O bitmap is duplicated on fork. That's wasting memory and slows down
> fork. There is no point to do so. As long as the bitmap is not modified it
> can be shared between threads and processes.
>
> Add a refcount and just share it on fork. If a task modifies the bitmap
> then it has to do the duplication if and only if it is shared.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/include/asm/iobitmap.h |    5 +++++
>  arch/x86/kernel/ioport.c        |   38 ++++++++++++++++++++++++++++++++------
>  arch/x86/kernel/process.c       |   39 ++++++---------------------------------
>  3 files changed, 43 insertions(+), 39 deletions(-)
>
> --- a/arch/x86/include/asm/iobitmap.h
> +++ b/arch/x86/include/asm/iobitmap.h
> @@ -2,10 +2,12 @@
>  #ifndef _ASM_X86_IOBITMAP_H
>  #define _ASM_X86_IOBITMAP_H
>
> +#include <linux/refcount.h>
>  #include <asm/processor.h>
>
>  struct io_bitmap {
>         u64                     sequence;
> +       refcount_t              refcnt;
>         unsigned int            io_bitmap_max;
>         union {
>                 unsigned long   bits[IO_BITMAP_LONGS];
> @@ -13,6 +15,9 @@ struct io_bitmap {
>         };
>  };
>
> +struct task_struct;
> +
> +void io_bitmap_share(struct task_struct *tsk);
>  void io_bitmap_exit(void);
>
>  void tss_update_io_bitmap(void);
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -16,6 +16,17 @@
>
>  static atomic64_t io_bitmap_sequence;
>
> +void io_bitmap_share(struct task_struct *tsk)
> + {
> +       /*
> +        * Take a refcount on current's bitmap. It can be used by
> +        * both tasks as long as none of them changes the bitmap.
> +        */
> +       refcount_inc(&current->thread.io_bitmap->refcnt);
> +       tsk->thread.io_bitmap = current->thread.io_bitmap;
> +       set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
> +}
> +
>  void io_bitmap_exit(void)
>  {
>         struct io_bitmap *iobm = current->thread.io_bitmap;
> @@ -25,7 +36,8 @@ void io_bitmap_exit(void)
>         clear_thread_flag(TIF_IO_BITMAP);
>         tss_update_io_bitmap();
>         preempt_enable();
> -       kfree(iobm);
> +       if (iobm && refcount_dec_and_test(&iobm->refcnt))
> +               kfree(iobm);
>  }
>
>  /*
> @@ -59,8 +71,26 @@ long ksys_ioperm(unsigned long from, uns
>                         return -ENOMEM;
>
>                 memset(iobm->bits, 0xff, sizeof(iobm->bits));
> +               refcount_set(&iobm->refcnt, 1);
> +       }
> +
> +       /*
> +        * If the bitmap is not shared, then nothing can take a refcount as
> +        * current can obviously not fork at the same time. If it's shared
> +        * duplicate it and drop the refcount on the original one.
> +        */
> +       if (refcount_read(&iobm->refcnt) > 1) {
> +               iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> +               if (!iobm)
> +                       return -ENOMEM;
> +               io_bitmap_exit();

And change the refcount to 1?

>         }
>

Otherwise:

Acked-by: Andy Lutomirski <luto@kernel.org>

(I'm about to send, and I see PeterZ beat me to the punch.  You can
still have the ack, though.)
