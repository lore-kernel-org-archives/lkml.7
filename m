Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0AEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF392085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfHLJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:54:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36369 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfHLJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:54:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so24472491otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyiRhF0oinF8VO6s9qv0dM4M43aUQYZRqosoyuIx644=;
        b=ZsKW2jrZlwh2kk1yo0kkLyyGPJVrvNwYmazurnMymJ6hjspqXuZWopLNxH1KUUgdvz
         ckylzaaWGvqau11OrclR6L2aHxkHmt5+chQRJmkpYz6Nh30immnGkXDofnB+YWXxGcHT
         CGM459vsh2ciG1xG9ALDoQGvOXFp58yxJd2V8scVvZLexYrzH/fybkPPrqlzBTChGG0H
         MZv2SfcVhOT/j3rR8PHy2eilAo8E0E5wi0h272aXMu+cw7oCadaPaRQAXpT5EY7gzsE0
         yDPEoKbEBUgEd1/cOZ3TkS3PlHLj1gw1Vel9gF5a6f3Safhr8SaQ3vOy7pLBnTw0akwo
         TA/w==
X-Gm-Message-State: APjAAAUqgnFWB01qXed2nQ2LsYF8PnjmB1AA09RpEDWFdOABKck77UUG
        ZpAC6prGzRjCpqdJ2qWAsifE1jIbJ/xHQ9/Rz9g=
X-Google-Smtp-Source: APXvYqy4/3qfWFCotcCvfD+aImzJfyZcI/ZMONMECXObdEfxWJ4QT2tP3uLmfssmXIg+UcQ7TAec0T2NQtfBZg+1XQg=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr6213903oie.102.1565603652537;
 Mon, 12 Aug 2019 02:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <20190809061437.GE2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190809061437.GE2332@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Aug 2019 11:54:00 +0200
Message-ID: <CAMuHMdUNq+X9ORzZodJZbsZRJ9=a-tiLKv=nhyojVYTNwt6Aeg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Aug 08, 2019 at 12:07:28PM -0700, Linus Torvalds wrote:
> > End result: a DRAM buffer can work, but is not "reliable".
> > Particularly if you turn power on and off, data retention of DRAM is
> > iffy. But it's possible, at least in theory.
> >
> > So I have a patch that implements a "stupid ring buffer" for thisa
> > case, with absolutely zero data structures (because in the presense of
> > DRAM corruption, all you can get is "hopefully only slightly garbled
> > ASCII".
>
> Note that you can hook this into printk as a fake early serial device;
> just have the serial device write to the DRAM buffer.

Yep. Amiga had debug=mem for years, to write kernel messages to Chip
RAM, and retrieve them after a reboot. Cfr. amiga_console_driver and
arch/m68k/tools/amiga/dmesg.c.

BTW, with those old machines, it was not uncommon for DRAM retention
time to be 30s or so.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
