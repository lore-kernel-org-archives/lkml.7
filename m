Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C9C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F0620820
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565366255;
	bh=tGXBosOEI75zUIy1lNXDq4isTMQMBgLQn2qGtcEVSzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VTGrhpCeEOH0SZsk1sEkk8fuich3d5AqAkViQqYjZTBVqPttZKn6TpJZIIz69vyoI
	 IOWKXQXos92dMGplFGFGLpF0d6WpXGgqhiDIvbSlwy1NwgZLn6+vGB1nMFj4hv3yS1
	 o5tBrTKE9PqhKVh+/zPqJ11xpoND6JGlrru0x2aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436880AbfHIP5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:57:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42910 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436646AbfHIP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:57:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id 15so757046ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hw1EThF49ZVmrirHVx3xJ+/yLizCNcME8lhFdH15rA=;
        b=fUOyGvI4q2c8ONcDTRYdSI8Lfs0koNFtJ6XNM6ynnDLQmyJJ5RijaOpKAZ+CkfMBaY
         urrQafwrX1Y6QXbkzIN5h/x1UFafvL53kTh/L8fzKf9xl806tUsXeNdKwlvBANh9JrZK
         2c0QpqfS73+EoY+EnbEHKWZqwtNvvfMyIR+UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hw1EThF49ZVmrirHVx3xJ+/yLizCNcME8lhFdH15rA=;
        b=tuG8YaLs2ev9K++oYVrXRmbGx8Uxpa2a/KJ+9mrUrYFfbYmyf/xb/amwFi51tj8xWf
         aqSTOEa83LS41p672cIi+z5EMtCh0QwVA6nlb10W+AwNr1X4B4vY01or0Om3wcWBXIBu
         oHI03jfxNhg1QCutt1YcigDd3yUz+zj78QrvqriPHcDBakIPGz8bE+lUUOUdKnrF/7eU
         taioKh0SShT8FqHur81c1GED6kSfv96zra9raAfX6gIo2CO5jlOhb7jDKtW43dPiu7HD
         mtEz4+n82ASiCFXXJ9/b10afQqMwKY0+ajHlLyTt+R4C9z19sYQ/g8urMM3MbxqsIuJR
         7VuA==
X-Gm-Message-State: APjAAAWRZFTrXA1WU/FM1jj1qa7H+dX2lPID6GJLZti5cypdvQCIExZM
        cJE8b16wYShUHuHgC6x3b7fTQqKlyY4=
X-Google-Smtp-Source: APXvYqwPs2nF4BcTAeUr5Q6Jqyjv7Vew4Cb7I251Ztv5md1Gc2WTJgTbWf5pN2/4EWLeB6fWy+wc8A==
X-Received: by 2002:a2e:970a:: with SMTP id r10mr11135587lji.115.1565366251201;
        Fri, 09 Aug 2019 08:57:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p21sm17587646lfc.41.2019.08.09.08.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:57:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p197so69831666lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 08:57:30 -0700 (PDT)
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr11368785lfg.170.1565366249804;
 Fri, 09 Aug 2019 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <20190809061437.GE2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190809061437.GE2332@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Aug 2019 08:57:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiG55kT0MRprt+Opbpcc=ebugC_rz4d6-whtAGXri3TwQ@mail.gmail.com>
Message-ID: <CAHk-=wiG55kT0MRprt+Opbpcc=ebugC_rz4d6-whtAGXri3TwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
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

On Thu, Aug 8, 2019 at 11:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Note that you can hook this into printk as a fake early serial device;
> just have the serial device write to the DRAM buffer.

No, you really really can't.

Look, the whole point of that reboot buffer is that it works WHEN
NOTHING ELSE DOES.

Very much including things like "oh, we're doing a suspend/resume, so
the console lock is held to make sure we don't touch any devices that
are likely dead right now".

The poweroff buffer is not a console. Don't even try to think of it as
one. It's for when consoles don't work. Trying to make it be an
early-console would completely defeat the whole point.

Even the "early console" stuff tries to honor serialization by
console_lock and console_suspended etc. Or things like the "I'm in the
middle of the scheduler, so I won't be doing any real logging".

If the system works, and you get console output or you have a working
syslogd that saves messages to disk, all of this is entirely
irrelevant. Really.

Don't think of it as a console. If you do, you're doing it wrong.

                     Linus
