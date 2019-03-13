Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861F62173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJXFiMgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCMIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:46:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCMIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:46:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id s22so889483pfh.4;
        Wed, 13 Mar 2019 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F37euZXKmVBi9fZUuOI5uoJgp4MuxAaBS48or3lcYaE=;
        b=mJXFiMgsxshukjkUfi8LtIdHvjGedheWm24Cn6wVgeQy1arTLMk83RWnI9xM2yIJIQ
         NlABeuhEFWPgynqWq53q1bh93OXa0JinNGquFRddEh7MQ5RrgAvLIq9Rd0cilz4gJROH
         ZetB37wFy/QudfwJKqeBYWADy+vNddT3vA/A+5zmPGONYV58Aad6Aia5G+d1JQ7CnblU
         bNlmdj3SCDZUZZRzRrjMUeWG5NXalhF3IvEed8bVjnpH2XEIiaXuI+darUIFO239ywat
         XhDdru99j9D0DkSv/bSna0G8aJIQWzHzppsNj6BF2HON15SQQobg8wTx7DI+SEf3XWQ8
         aRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F37euZXKmVBi9fZUuOI5uoJgp4MuxAaBS48or3lcYaE=;
        b=hAxFCfUvfCT7JHDFwVwcL7W8H30RPwx3FApYPjBIguReBWPGexCmb+3P4+E/itSuhv
         1EbrfjjcDzB78x6zTi/8UJchEonMeOkezkdbMm6NhRHXdgLHmxPDkyk6DNa5mS08qOLw
         MS5lSqk68zG+dueGMzogz3+HBB9yNc1iHFAKYg47lwGjH8pPLmcZM2rigLWb3m38kfY6
         klSWH1nAgciE24+C+icap6ceU/BqK33Ydh/X08nbRkuQ2A44aCKhX5dPuVMQ8J0c8cPp
         VihCMIqaUwSSeiPUC9JuT1wUMhh+tzhrpRT14FR9fi5dqpWTrjI+U/+JfiZilXDcEsvj
         hq9A==
X-Gm-Message-State: APjAAAUaa67vJ8HvtehCxxykNe2DHGVz4Ge5RM25L65W85GBvScG3e4Q
        jbX+vy736IZQFk15J5rxOFQ=
X-Google-Smtp-Source: APXvYqzXHaUEfpnJviO5bj7tmm38VamCtMCRvxDg9cJg/65iEJBFMhIKfJHq+ExJXL1e1NkFMgWpqQ==
X-Received: by 2002:a63:470a:: with SMTP id u10mr39816429pga.17.1552466764703;
        Wed, 13 Mar 2019 01:46:04 -0700 (PDT)
Received: from localhost ([110.70.15.13])
        by smtp.gmail.com with ESMTPSA id f87sm16631508pff.38.2019.03.13.01.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 01:46:03 -0700 (PDT)
Date:   Wed, 13 Mar 2019 17:46:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190313084600.GA1748@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0mv9off.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/13/19 09:19), John Ogness wrote:
> >> Yes. I will post a series that only implements the ringbuffer using
> >> your simplified API. That will be enough to remove printk_safe and
> >> actually does most of the work of updating devkmsg, kmsg_dump, and
> >> syslog.
> >
> > This may _not_ be enough to remove printk_safe. One of the reasons
> > printk_safe "condom" came into existence was console_sem (which
> > is a bit too important to ignore it):
> >
> > 	printk()
> > 	 console_trylock()
> > 	  console_unlock()
> > 	   up()
> > 	    raw_spin_lock_irqsave(&sem->lock, flags)
> > 	     __up()
> > 	      wake_up_process()
> > 	       WARN/etc
> > 	        printk()
> > 		 console_trylock()
> > 		  down_trylock()
> > 		   raw_spin_lock_irqsave(&sem->lock, flags)  << deadlock
> >
> > Back then we were looking at
> >
> > 	printk->console_sem->lock->printk->console_sem->lock
> >
> > deadlock report from LG, if I'm not mistaken.
> 
> The main drawback of printk_safe is the safe buffers, which, aside from
> bogus timestamping, may never make it back to the printk log buffer.
>
> With the new ring buffer the safe buffers are not needed, even in the
> recursive situation. As you are pointing out, the notification/wake
> component of printk_safe will still be needed. I will leave that (small)
> part in printk_safe.c.

Yeah, all I'm saying is that as it stands new printk() is missing a huge
and necessary part - console semaphore. And things can get very different
once you add that missing part. It brings a lot of stuff back to printk.

logbuf and logbuf_lock are not really huge printk problems. scheduler,
timekeeping locks, etc. are much bigger ones. Those dependencies don't
come from logbuf/logbuf_lock.

	-ss
