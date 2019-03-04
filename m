Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC08C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FB521019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbVeXM+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfCDGkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:40:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39980 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:40:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so2261179pfo.7;
        Sun, 03 Mar 2019 22:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uq1bGwpHAh1MRIMEpTw9BZatcsUSAFnua0mccOXG7mQ=;
        b=vbVeXM+exN1MW+hyH4w2O1Vq+FLSspw91SUMd35iSmmbZw352mg0tQj8CHgkmZzHx7
         Z36Y7H5+j4qBgXsWhZSGNPfVpS28PwS/D8afvaDLSLyDEHXBe81EgbVes19zjYIJfCEP
         79LoJO6VLe+lWGZtq6xlHymG9kcujF8Vn3/7LHV38z1JPgAbrjaNxG+hAqfcobpN0dl0
         fvEp8wFr9mQ9HFFeSedqm2eLmixV4G1l+Z4a3QYYEyfFiPTQBpOJ69DwuDsANmfc4zFr
         bZlMAVoory+vrTaY6ZupAZ0frxT0JZ5uTyUD5NqMSwRJfAVXBp1aQ3pKaH1vogeUzkqv
         HtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uq1bGwpHAh1MRIMEpTw9BZatcsUSAFnua0mccOXG7mQ=;
        b=PqySzUp5umP2bsa1Be07qR8BLjBwV4VZCxtvcZNCc7yrVTrVD4uDZWMt+wYOOqZ41a
         u692AadHGW8877NSP3oSx8JxGd32d4w9rCGyRPCfURrkQI2FPAC9rP7qXUweNgsvD+xa
         jSi8n/wRhIp6EBhHWvvEa745bpH0ZEl9NYidI1npGY0uUt4hpOauZPUch2pYyJ2mr/tg
         ON7KT047mEycYq7wLvRWMOqiVklmmC95uLpY2TCqa78Ftf6LujgAGPbS5b6/XkfSRIKV
         +I8Tu+XAYYBqsENeKxRL1DfetnPVnE9iTIehwwDZXADd4eOqv7MFENXk2vDckgsKhs/x
         fdOw==
X-Gm-Message-State: APjAAAUBC7wZMkAjn/Iu/ht65fjy6+38mYvNIWICXvVNqBu2ufXO6rlp
        wiFpOWmgWXVkbFgJ94lkPUY=
X-Google-Smtp-Source: APXvYqzXf1I9vNSiZAAzcCZ6T6ik3zR9JlTENhNEmsfBVfrvFoWje36A4mfXehgLKNVa9j9b9JEvJg==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr18852636plc.211.1551681600373;
        Sun, 03 Mar 2019 22:40:00 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id q7sm9808825pfa.119.2019.03.03.22.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 22:39:59 -0800 (PST)
Date:   Mon, 4 Mar 2019 15:39:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190304063956.GC6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213013101.GA8097@jagdpanzerIV>
 <87d0nv248b.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0nv248b.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On (02/13/19 14:43), John Ogness wrote:
> Hi Sergey,
> 
> I am glad to see that you are getting involved here. Your previous
> talks, work, and discussions were a large part of my research when
> preparing for this work.

YAYY! Thanks!

That's a pretty massive research and a patch set!

[..]
> If we are talking about an SMP system where logbuf_lock is locked, the
> call chain is actually:
> 
>     panic()
>       crash_smp_send_stop()
>         ... wait for "num_online_cpus() == 1" ...
>       printk_safe_flush_on_panic();
>       console_flush_on_panic();
> 
> Is it guaranteed that the kernel will successfully stop the other CPUs
> so that it can print to the console?

Right. By the way, this reminds that I sort of wanted to send a patch
which would unconditionally raw_spin_lock_init(&logbuf_lock) (without
the num_online_cpus() check) in printk_safe_flush_on_panic().

> And then there is console_flush_on_panic(), which will ignore locks and
> write to the consoles, expecting them to check "oops_in_progress" and
> ignore their own internal locks.
>
> Is it guaranteed that locks can just be ignored and backtraces will be
> seen and legible to the user?

That's a tricky question. In the same way we may have no guarantees that
all consoles can sport ->atomic() write API. And then have no guarantees
that every system will have ->atomic consoles.

> > Do you see large latencies because of logbuf spinlock?
>
[..]
>
> For slow consoles, this can cause large latencies for some misfortunate
> tasks.

Yes, makes sense.

> > One thing that I have learned is that preemptible printk does not work
> > as expected; it wants to be 'atomic' and just stay busy as long as it
> > can.
> > We tried preemptible printk at Samsung and the result was just bad:
> >    preempted printk kthread + slow serial console = lots of lost
> > messages
> 
> As long as all critical messages are print directly and immediately to
> an emergency console, why is it is problem if the informational messages
> to consoles are sometimes delayed or lost? And if those informational
> messages _are_ so important, there are things the user can do. For
> example, create a realtime userspace task to read /dev/kmsg.
> 
> > We also had preemptile printk in the upstream kernel and reverted the
> > patch (see fd5f7cde1b85d4c8e09); same reasons - we had reports that
> > preemptible printk could "stall" for minutes.
> 
> But in this case the preemptible task was used for printing critical
> tasks as well. Then the stall really is a problem. I am proposing to
> rely on emergency consoles for critical messages. By changing printk to
> support 2 different channels (emergency and non-emergency), we can focus
> on making each of those channels optimal.

Right. Assuming that we always have at least one ->atomic channel
we can prioritize (and sacrifice !atomic channels, etc.). People,
sort of, already can prioritize some channels; IIRC, netcon can be
configured to print messages only when oops_in_progress and to drop
messages otherwise.

Things can get different if ->atomic channel is not available.

	-ss
