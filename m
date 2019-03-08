Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E48C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405F320675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenz2Prg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCHBbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:31:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36227 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:31:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so12863507pfa.3;
        Thu, 07 Mar 2019 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2iv8wo/lp5LJ5Zsdyp9yEMO45Sw/Axr36FzK7/FsLqs=;
        b=fenz2PrgXfUZF+sjvWv3l6FpEpl45KOCgKOudy+lassB9q8pTei5bOtsy8ajGf+Agj
         RUeE66dUEVU0Kon6tMu6shAst8Qhm+PzoON0BcdJOCUbBlM1JlCL/JotmbxUyFXNe5QF
         /d7gd2dZR6+VbUePv2xM1fDo5M2jq91EbwytD22+7X45eFkEr6/m7XoMH82B5aswFxcK
         HnwY+TlMTN/GIwiti52DTLf0u71F8RC4VashvKqmogV1pFqpqk8vUDZZ2S5hvhQpPcod
         lw9PDxrBdvGdKIEuNLS+kzHUTSTA9KouodH+ZD1dwbnrKEVo5dHZBcFml6J9UNea3kKJ
         XWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iv8wo/lp5LJ5Zsdyp9yEMO45Sw/Axr36FzK7/FsLqs=;
        b=VjtsoceE+/ScOx3TaCIQ9s7JNRww5eNyUDVCptgxKAzSy0joo5JE65t1fZ3znrx4pS
         bKBgrGqdkQ7lijt4EAnp79G3wcAtWP9iqTSEMdKZc0hNiADhXPOVXzx8Tg81lQZRGy5C
         tXog9VDGKlNcQ0noWNe/AHsKvdB3BQZ+r3elPEIxWqvNKIDuji3EvFdIJ2shiwYVCQyP
         WjvQING01zPl+zNDL1Exiue6WMnDTbGaOAFz7rl5xqrECXKjKO/wGTsN0/w7nF2y3icu
         OdM6pAdR9pnNjdu3JLWut+rLfF+Oc+UIDY7WdezWRaNlos/u2YowdhKzVvuVIM4izMf+
         Jvew==
X-Gm-Message-State: APjAAAUMcuPnLjXeXrkJsRRWYCl0VeNfMAgePN1lma1MuWHUT8qZ6EMd
        a5uxR94f7R/iTlCR13UNNnw=
X-Google-Smtp-Source: APXvYqyq8YKQt1Ir4BrQISE5801S5dmSmDC+EjHzTQyy5Bptm1fk/todzvmQZAb9IEynBDdf4Zui4g==
X-Received: by 2002:a63:4d4f:: with SMTP id n15mr14284750pgl.327.1552008698671;
        Thu, 07 Mar 2019 17:31:38 -0800 (PST)
Received: from localhost ([175.223.36.163])
        by smtp.gmail.com with ESMTPSA id u11sm7919113pfh.23.2019.03.07.17.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 17:31:37 -0800 (PST)
Date:   Fri, 8 Mar 2019 10:31:34 +0900
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
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190308013134.GB4063@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <87va0uopmd.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va0uopmd.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/19 13:06), John Ogness wrote:
> On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> +	/* the printk kthread never exits */
> >> +	for (;;) {
> >> +		ret = prb_iter_wait_next(&iter, buf,
> >> +					 PRINTK_RECORD_MAX, &master_seq);
> >> +		if (ret == -ERESTARTSYS) {
> >> +			continue;
> >> +		} else if (ret < 0) {
> >> +			/* iterator invalid, start over */
> >> +			prb_iter_init(&iter, &printk_rb, NULL);
> >> +			continue;
> >> +		}
> >> +
> >> +		msg = (struct printk_log *)buf;
> >> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> >> +			    &len, printk_time);
> >> +
> >> +		console_lock();
> >> +		if (len > 0 || ext_len > 0) {
> >> +			call_console_drivers(ext_text, ext_len, text, len);
> >> +			boot_delay_msec(msg->level);
> >> +			printk_delay();
> >> +		}
> >> +		console_unlock();
> >> +	}
> >
> > This, theoretically, creates a whole new world of possibilities for
> > console drivers. Now they can do GFP_KERNEL allocations and stall
> > printk_kthread during OOM; or they can explicitly reschedule from
> > ->write() callback (via console_conditional_schedule()) because
> > console_lock() sets console_may_schedule.
> 
> This was the intention.

This can stall the entire printing pipeline

OOM -> printk_kthread() -> console_lock() -> con_foo() -> kmalloc(GFP_KERNEL) -> OOM

> Although, as I mentioned in a previous response[0], perhaps we should
> not loosen the requirements on write().

Right. Console drivers better stay restricted; very restricted.

> It is exactly that disable_preempt() that is so harmful for realtime tasks.

I'll reply in another email (later today, or tomorrow).

	-ss
