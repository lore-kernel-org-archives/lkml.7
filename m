Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97141C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C7E20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6gcpxU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGRLHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:07:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36841 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRLHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:07:32 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so50830815iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7FC7XwlYl6RQGfalPlfGNpAUBYGPQKgbX3nww64Y9w=;
        b=i6gcpxU8ZYmHtNxLwGxFffbFI5O1D+I/lq8Dh/E2wO8OvMurAhpIHuCrcePTQDlaHw
         XT2fqRPDjkCpYR47yzU5yXHMdFEs1OUjS1DaGcypDsFrrrKrv3lZOO3B+uMxmafy3VGJ
         o8GtPGSB6lA1j7efaVRA/vhmEmLtgRTx1b8RJy3Qmpkqb0kNINTX3VED2SvjYZGxNlJ5
         Wg+RHZx9xMKsi6m+iKBpcTYHsFfX5bNnEE+ZpvUPbRKzpAaRiYw/vOz0sJCGCjpIZh+1
         tRVBBIS7TCe85rGQkiQgVkJsY4sBi0MATL67AZcYgNUYqYUDyLuIAr1M79wR9dVMyeyZ
         QruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7FC7XwlYl6RQGfalPlfGNpAUBYGPQKgbX3nww64Y9w=;
        b=Dy1/CHm2iSX8cTDIwglCGd4TxxAUfuZwgKT06fOHhFExfhF6xtzkRsntZAn+nDn/sW
         JsPDZIsaiuxj8cOKmhTCq88JjN56SwIBNayIeYE1QvYGkxjeS3n9rCuX0E8ukM6ZohQl
         Tl7QKV3F9KYausRYdAz3GR5kAg4l2dx1KPGG/FbnQCOPG7HyEnRx2Lba3jL7GyDuhd3y
         14DCg3PgBO5/5cHLs1sownbLTOF0nTZiJX2Wv4Jr6kyiEAL2RzAoFDcI35CFFmUV6LWj
         4YyxLg3FZLyC8ixX8zIi4SkbSZd548tJTOSAhfhl9KJQWAfX28LJg41XYLD42/LDMnX1
         KdnA==
X-Gm-Message-State: APjAAAXSdHj0GQFC4pdWPy/gUz3lAc6LLPlO8PL3GfekcArtix3djYq8
        5ArinXI+HDEs8PN1J+kbNgNPQsmqikY7clFz5Ts=
X-Google-Smtp-Source: APXvYqxMt0pfpdL1v3ZiA05raxMlScFxpa2O+JAe1ixVfBfblUC2oHbn4D5e9vLiAs+77EeaxNCLN9n8EMJ5lkUePKM=
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr42462765iob.178.1563448051792;
 Thu, 18 Jul 2019 04:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190716072805.22445-1-pmladek@suse.com> <20190716072805.22445-3-pmladek@suse.com>
 <20190718104756.GA22851@jagdpanzerIV>
In-Reply-To: <20190718104756.GA22851@jagdpanzerIV>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Thu, 18 Jul 2019 14:07:20 +0300
Message-ID: <CALYGNiMnqUKxKsY1JRi075xs-P_QzfA4Pg3XANiW0mFYkp_RQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] printk/panic/x86: Allow to access printk log buffer
 after crash_smp_send_stop()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 1:48 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (07/16/19 09:28), Petr Mladek wrote:
> [..]
> > +int printk_bust_lock_safe(bool kdump_smp_stop)
> >  {
> >       if (!raw_spin_is_locked(&logbuf_lock))
> >               return 0;
> >
> > -     if (num_online_cpus() == 1) {
> > +     if (num_online_cpus() == 1 || kdump_smp_stop)  {
> >               debug_locks_off();
> >               raw_spin_lock_init(&logbuf_lock);
> >               return 0;
>
> Let me test the waters. Criticize the following idea:
>
> Can we, sort of, disconnect "supposed to be dead" CPUs from printk()
> so then we can unconditionally re-init printk() from panic-CPU?
>
> We have per-CPU printk_state; so panic-CPU can set, let's say,
> DEAD_CPUS_TELL_NO_TALES bit on all CPUs but self, and vprintk_func()
> will do nothing if DEAD_CPUS_TELL_NO_TALES bit set on particular
> CPU. Foreign CPUs are not even supposed to be alive, and smp_send_stop()
> waits for IPI acks from secondary CPUs long enough on average (need
> to check that) so if one of the CPUs is misbehaving and doesn't want
> to die (geez...) we will just "disconnect" it from printk() to minimize
> possible logbuf/console drivers interventions and then proceed with
> panic; assuming that misbehaving CPUs are actually up to something
> sane. Sometimes, you know, in some cases, those CPUs are already dead:
> either accidentally powered off, or went completely nuts and do nothing,
> etc. etc. but we still can kdump() and console_flush_on_panic().

Good idea.
Panic-CPU could just increment state to reroute printk into 'safe'
per-cpu buffer.

>
>         -ss
