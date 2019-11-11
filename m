Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE495214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKKXEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:04:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:04:00 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIiw-0001Jb-94; Tue, 12 Nov 2019 00:03:54 +0100
Date:   Tue, 12 Nov 2019 00:03:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
In-Reply-To: <20191111223052.881699933@linutronix.de>
Message-ID: <alpine.DEB.2.21.1911120000560.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.881699933@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -27,15 +27,28 @@ void io_bitmap_share(struct task_struct
>  	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
>  }
>  
> +static void task_update_io_bitmap(void)
> +{
> +	struct thread_struct *t = &current->thread;
> +
> +	preempt_disable();
> +	if (t->iopl_emul == 3 || t->io_bitmap) {
> +		/* TSS update is handled on exit to user space */
> +		set_thread_flag(TIF_IO_BITMAP);
> +	} else {
> +		clear_thread_flag(TIF_IO_BITMAP);
> +		/* Invalidate TSS */
> +		tss_update_io_bitmap();
> +	}
> +	preempt_enable();
> +}
> +
>  void io_bitmap_exit(void)
>  {
>  	struct io_bitmap *iobm = current->thread.io_bitmap;
>  
> -	preempt_disable();
>  	current->thread.io_bitmap = NULL;
> -	clear_thread_flag(TIF_IO_BITMAP);
> -	tss_update_io_bitmap();
> -	preempt_enable();
> +	task_update_io_bitmap();
>  	if (iobm && refcount_dec_and_test(&iobm->refcnt))
>  		kfree(iobm);

This obviously needs the following delta to be folded in. Noticed too late
after fiddling with the test case some more. git tree is updated
accordingly.

Thanks,

	tglx
---
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -18,12 +18,15 @@ static atomic64_t io_bitmap_sequence;
 
 void io_bitmap_share(struct task_struct *tsk)
  {
-	/*
-	 * Take a refcount on current's bitmap. It can be used by
-	 * both tasks as long as none of them changes the bitmap.
-	 */
-	refcount_inc(&current->thread.io_bitmap->refcnt);
-	tsk->thread.io_bitmap = current->thread.io_bitmap;
+	 /* Can be NULL when current->thread.iopl_emul == 3 */
+	 if (current->thread.io_bitmap) {
+		 /*
+		  * Take a refcount on current's bitmap. It can be used by
+		  * both tasks as long as none of them changes the bitmap.
+		  */
+		 refcount_inc(&current->thread.io_bitmap->refcnt);
+		 tsk->thread.io_bitmap = current->thread.io_bitmap;
+	 }
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
