Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DE420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnh7wUaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCKKyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:54:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40363 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:54:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id h1so3409977pfo.7;
        Mon, 11 Mar 2019 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9GUBLzPM6PHpJSqSDnCR+4kzjT/7SfvFLCfRMnAwXw=;
        b=jnh7wUaV5Q0iZ5qFLqFJL4KdSKIQ8fxLnK2EP9Ivio0fDiy2WMZ/9ew2ktBG3XeVs9
         PLd2H1xu/fcVOerxa1UXgWdjF1YJxBUBqneA5RbWfIaBA8ao/csL7eabPrA3TBP5BnZH
         FhM86O4gzSYVsXijSHZZFyCDBhOfinWCI1wk1fqunqoNMCa3zwpAbMUSPLETSozkGSw6
         Qk6eyaLmmrXj9PIyQTdZzNMgAgcUXWiBhIaohnw6ohnngwTSr2VeN9M1S666KEL7Tn2b
         uxaPAS23H1u0zzNN3Zz5m8vxrwmLDxxREzige5XpGsp8bOxSHr3igqLINGkJXF+QGkrD
         Yw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9GUBLzPM6PHpJSqSDnCR+4kzjT/7SfvFLCfRMnAwXw=;
        b=Pjwm0FJIucBsbpOsWh2896sdICIQ6UoWx/mS9HkxyC2Hm+l18zc+7m4WdnCagURRDp
         YdW/FwHUP04HaIzls3h0vsqOzd0xOOFk1pRuMXghxokarpNxShJS1grTNH8eaSkV7U9S
         ulLN5qWeeLvgU4s9/7Y3jfyvTq+vIGlEpnhrgCapmsEjZ+BK67owPFWoK4GKjZNa11Xp
         KvpiWsIZUyR2yHaK19FT+h/3gdTaRhHt8YRQDT8kCFwZ4Rm0o5RT/Hi25WB/iKWQefIn
         vkHEvUHdbufKeJMfC5f0ShgNHZjcS2vfYwPtxKCTLxowJgANay5+4MSCA/8245MKeNUL
         +brQ==
X-Gm-Message-State: APjAAAWKmgP7498DqC2I2HYRyXmwK+TyjtN9C6cQ5A8VFUxe2EHl5+vX
        GPPjOEkjZtECobFv47k/b6Y=
X-Google-Smtp-Source: APXvYqzAgfWs+mVLjJ6b9ZMUKnNB7Bu0CPMw1Oj9yrwnbhs0lsjiJnW0tUjqFonrhkbLpYQCNLEoTw==
X-Received: by 2002:a62:ea0f:: with SMTP id t15mr32823425pfh.124.1552301655756;
        Mon, 11 Mar 2019 03:54:15 -0700 (PDT)
Received: from localhost ([175.223.26.132])
        by smtp.gmail.com with ESMTPSA id p2sm7583221pgs.7.2019.03.11.03.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 03:54:14 -0700 (PDT)
Date:   Mon, 11 Mar 2019 19:54:11 +0900
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
Message-ID: <20190311105411.GA368@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg1rggcz.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/19 10:53), John Ogness wrote:
[..]
> 
> No, I am not sure if we can convert all console drivers to atomic
> consoles. But I think if we don't have to fear disturbing the system,
> the possibilities for such an implementation are greater.

> > If there are setups which can be fully !atomic (in terms of console
> > output) then we, essentially, have a fully preemptible kthread printk
> > implementation.
> 
> Correct. I've mentioned in another response[0] some ideas about what
> could be done to aid this.
> 
> I understand that fully preemptible kthread printing is unacceptable for
> you.

Well, it's not like it's unacceptable for me. It's just we've been
there, we had preemptible printk(); and people were not happy with
it. Just to demonstrate that I'm not making this up:

> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>:
> > [..]
> >
> > Using a reproducer [..] you will find that calling cond_resched()
> > (from console_unlock() from printk()) can cause a delay of nearly
> > one minute, and it can cause a delay of nearly 5 minutes to complete
> > one out_of_memory() call.

preemptible printk() and printk() do opposite things.

I can't really say that I care for fbcon; but fully preemptible
netcon is going to hurt.

> Since all current console drivers are already irq safe, I'm
> wondering if using irq_work to handle the emergency printing for console
> drivers without write_atomic() would help. (If the printk caller is in a
> context that write() supports, then write() could be called directly.)
> This would also demand that the irq-safe requirements for write() are
> not relaxed. The printk-kthread might still be faster than irq_work, but
> it might increase reliability if an irq_work is triggered as an extra
> precaution.

Hmm. OK. So one of the things with printk is that it's fully sequential.
We call console drivers one by one. Slow consoles can affect what appears
on the fast consoles; fast console have no impact on slow ones.

	call_console_drivers()
		for_each_console(c)
			c->write(c, text, text_len);

So a list of (slow_serial serial netcon) console drivers is a camel train;
fast netcon is not fast anymore, and slow consoles sometimes are the reason
we have dropped messages. And if we drop messages we drop them for all
consoles, including fast netcon. Turning that sequential pipline into a
bunch of per-console kthreads/irq and letting fast consoles to be fast is
not a completely bad thing. Let's think more about this, I'd like to read
more opinions.

	-ss
