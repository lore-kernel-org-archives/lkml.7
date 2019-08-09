Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED392089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565366428;
	bh=byqXegla2HVwRkU/YlZedvOvaHdsOygN1SRXIfsWjzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TkPNn7RNrN8aVNX6sqLvwQRAs/8CX7NHfp6V6tXDT1RyftFGEQV/4C7cAoFtzpY0e
	 fpDgc7L6KaFqxyAOFDHajmzegmbHf/MEartPOnUGq4NyoAQhicN4Uov0VJR/U4n/rT
	 0tPmk2fO/hNyg0fRrwASvzOrHdEyp/hXutx6qedk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436925AbfHIQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:00:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38300 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436681AbfHIQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:00:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so92532851ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82Cb8KU5pdOeKmjLeh4TKVu4zgRDfxjUZ199bGrU4aM=;
        b=EGzmlqYyEKP+GRNNIQtRf9/Zmf02DAJzgUCe61CjlwR0xDNa/vwL4PM82Q5u8nooip
         ntaH45KfblduWkM5AVyFbE65jmPaTx/MNM93KmbwWGzHbS9BQUULkFANWUhOT00yHDxX
         KZOwl99pcNie47caZ4/Mg9PKG0/A+riIIlEJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82Cb8KU5pdOeKmjLeh4TKVu4zgRDfxjUZ199bGrU4aM=;
        b=RZle8tT2PwDM+vnTCdU+dfQtR5dnLRA85S7rdD1Q4rqINL9VGEz3MpfrxlaMiHNrPQ
         FKcup1PP3qeV69aiRuqIRU7PtfFzV9Jig4xpdcVIem77fkPFWfrKd2sJl5jTcGv8h0nr
         J3K2306ULaxNE510nkyJNCvfBB9Xe5ya6l8ggGxZQAisnT770sX1YKnV5ul4taQhSwok
         qvkcALX349Syr5Up4ksjXX9nFc5ApLshyyZAFa0k1YTRH65XRMRXD/thQ3e3BJg4KAtx
         x5i+hs0+DVGZuNpfspSmFk6anvNBKZLYm0rMWkHBl97v7Tw5vpuVEmdqlMdPgSE5TZbn
         aP4w==
X-Gm-Message-State: APjAAAXHxe1IQhvAfmo48ML1FqqLFltaoNsf13vtZxcYnzADp5DHbOrK
        xFZluUlaWLPdQTOH2Yk4djUMDAyeHW0=
X-Google-Smtp-Source: APXvYqw5OMAOuRIanCQz2iFpJRif7dylp94A0O/dT6SHwiqKsaF9x+TAAaklb8PaQrW35jPWF38Qgg==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr11684793lji.188.1565366424135;
        Fri, 09 Aug 2019 09:00:24 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f23sm1179992lfc.25.2019.08.09.09.00.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:00:21 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x3so69985552lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:00:21 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr12874406lfb.29.1565366420690;
 Fri, 09 Aug 2019 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home> <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
 <20190808204841.5afcad46@gandalf.local.home> <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
 <alpine.DEB.2.21.1908091306520.21433@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908091306520.21433@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Aug 2019 09:00:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDzz+KU-ArqpnzjYkvDtKWjUqMfiiJXpXhgYU+Wd0r-w@mail.gmail.com>
Message-ID: <CAHk-=wiDzz+KU-ArqpnzjYkvDtKWjUqMfiiJXpXhgYU+Wd0r-w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 4:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> >
> > But I don't know what a power-off-in-laptop scenario really looks like..
>
> That's random behaviour. It's hardware & BIOS & value add. What do you
> expect?
>
> I tried on a few machines. My laptop does not retain any useful information
> and on some server box (which takes ages to boot) the memory is squeaky
> clean, i.e. the BIOS wiped it already. Some others worked with a two second
> delay between turning the remote power switch on and off.

You were there at the Intel meeting, weren't you?

This is all about the fact that "we're not getting sane and reliable
debug facilities for remote debugging". We haven't gotten them over
two decades, we're not seeing it in the future either.

So what if we _can_ get an ACPI update and in the next decade your
laptop _will_ have a memory area that doesn't get scribbled over?

Does it work today? Yes it does, but only for very special cases
(basically warm reboot with "fast boot" enabled).

But they are special cases that may be things that can be extended
upon without any actual hardware changes.

                  Linus
