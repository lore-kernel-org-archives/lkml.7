Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4C233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCcz6yYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfH2SPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38625 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfH2SPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id q8so3305160oij.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EU1ws418Vc4Zys0H3+cXP7S7nl66dSX59rq7bwwsB9E=;
        b=uCcz6yYxLJGBv9xsUU025u9c/HplwdEBy5W1hfzlyXJvM7CobJHv/bePeJHJg5tpDI
         4XXsMVqENr+uALDs29HLEtazP3lmRr8p+CHIPcyg5qVhomGS7eiJZGZrPhA4Ehysoa9L
         llqD5RrrJhubFSpf4RxldkVUhM1izBTZPpRTM3nGZDUmHWut/oFDNwX/iq5AXvLLrWux
         lIgZq47OqAQhqDihMmR03Dm92IoriZNzk2GG8bnqz1yMOhnd2ljgPIuea/GO4f6dYQCG
         qOxqbi9v4b4B2gRI7T2T2lXV+fWBVUz7hCpQi0PSj8tgTefw2MIE+LAOJMuQ/Hnt4DGp
         HWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=EU1ws418Vc4Zys0H3+cXP7S7nl66dSX59rq7bwwsB9E=;
        b=RwCpScrwdypml7tzFel9XgbGEtkskptmfQsYg3aaHTY++DIzR1xks3CzLd/g0gj4RN
         MHA3AFmE0A29mFfD/5ecuVI0n1n5WFEz43y0rZ+S8oO8E6pnWOF0bzh9gzn1rod0no0a
         b/Tu0mlUSw+zTQe+rtrIEOlFqtNIGqnebzVfBuJx392CdpNjNShKZUyjaD86uZHXF5zi
         5SWSMG+NhLUfton2H2F7JWMS8M9b7KBJJAfbtz/BMXO41cGtHF+613L0oixNXDdB8FmW
         1Ug79pNYgv3t6mvALYmoEl7orFhov5jb2ZihvjOQbaikQ1cwrUBp+ySP3OeHaNT7wRn/
         BDVQ==
X-Gm-Message-State: APjAAAWrRq/gMmwsfps7aaewc831F8jFDkQU7eJ99EV5F/wCp7Ms83IT
        UkTRn+uLT2tWEYLpMhBH+w==
X-Google-Smtp-Source: APXvYqx/dFackw5CizdKplQqChsLhoBrm8Y7UFCg7Cn8vkFBIAWv9ktdMr/OCEOPrJ61xX4IzzHIJQ==
X-Received: by 2002:aca:6044:: with SMTP id u65mr7792941oib.16.1567102541630;
        Thu, 29 Aug 2019 11:15:41 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id m6sm167909ote.74.2019.08.29.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:15:40 -0700 (PDT)
Received: from t560 (unknown [156.39.10.47])
        by serve.minyard.net (Postfix) with ESMTPSA id 9475E1800D0;
        Thu, 29 Aug 2019 18:15:39 +0000 (UTC)
Date:   Thu, 29 Aug 2019 13:15:36 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, kernel-team@fb.com
Subject: Re: [PATCH 0/1] Fix race in ipmi timer cleanup
Message-ID: <20190829181536.GC3294@t560>
Reply-To: minyard@acm.org
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
 <20190828223238.GB3294@t560>
 <15517bfc-3022-509d-15ea-c2b8e7a91e0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15517bfc-3022-509d-15ea-c2b8e7a91e0a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:53:47PM -0400, Jes Sorensen wrote:
> On 8/28/19 6:32 PM, Corey Minyard wrote:
> > On Wed, Aug 28, 2019 at 04:36:24PM -0400, Jes Sorensen wrote:
> >> From: Jes Sorensen <jsorensen@fb.com>
> >>
> >> I came across this in 4.16, but I believe the bug is still present
> >> in current 5.x, even if it is less likely to trigger.
> >>
> >> Basially stop_timer_and_thread() only calls del_timer_sync() if
> >> timer_running == true. However smi_mod_timer enables the timer before
> >> setting timer_running = true.
> > 
> > All the modifications/checks for timer_running should be done under
> > the si_lock.  It looks like a lock is missing in shutdown_smi(),
> > probably starting before setting interrupt_disabled to true and
> > after stop_timer_and_thread.  I think that is the right fix for
> > this problem.
> 
> Hi Corey,
> 
> I agree a spin lock could deal with this specific issue too, but calling
> del_timer_sync() is safe to call on an already disabled timer. The whole
> flagging of timer_running really doesn't make much sense in the first
> place either.
> 
> As for interrupt_disabled that is even worse. There's multiple places in
> the code where interrupt_disabled is checked, some of them are not
> protected by a spin lock, including shutdown_smi() where you have this
> sequence:
> 
>         while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)){
>                 poll(smi_info);
>                 schedule_timeout_uninterruptible(1);
>         }
>         if (smi_info->handlers)
>                 disable_si_irq(smi_info);
>         while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)){
>                 poll(smi_info);
>                 schedule_timeout_uninterruptible(1);
>         }

This one doesn't matter.  At this point the driver is single-threaded,
no interrupts, timeouts, or calls from the upper layer can happen.

> 
> In this case you'll have to drop and retake the long several times.
> 
> You also have this call sequence which leads to disable_si_irq() which
> checks interrupt_disabled:
> 
>   flush_messages()
>     smi_event_handler()
>       handle_transaction_done()
>         handle_flags()
>           alloc_msg_handle_irq()
>             disable_si_irq()

This one only happens in run-to-completion mode.  Which is strange,
but a number of people had issues with getting into a new kernel before
the watchdog timeout went off, so the run-to-completion mode runs at
panic time so the driver can run without scheduling so it can extend
the watchdog and store panic information in the IPMI log.

So you actually *don't* want a lock here, since the panic may have
occurred when the IPMI driver was holding the lock.

> 
> {disable,enable}_si_irq() themselves are racy:
> 
> static inline bool disable_si_irq(struct smi_info *smi_info)
> {
>         if ((smi_info->io.irq) && (!smi_info->interrupt_disabled)) {
>                 smi_info->interrupt_disabled = true;
> 
> Basically interrupt_disabled need to be atomic here to have any value,
> unless you ensure to have a spin lock around every access to it.

It needs to be atomic, yes, but I think just adding the spinlock like
I suggested will work.  You are right, the check for timer_running is
not necessary here, and I'm fine with removing it, but there are other
issues with interrupt_disabled (as you said) and with memory ordering
in the timer case.  So even if you remove the timer running check, the
lock is still required here.

It also might be a good idea to add a WARN_ON() to smi_mod_timer() and
alloc_msg_handle_irq() if the lock is not held, just to be sure.

Thanks,

-corey

> 
> Cheers,
> Jes
