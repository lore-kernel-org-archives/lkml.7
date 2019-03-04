Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4552082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To6dHLSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfCDFXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:23:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44819 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCDFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:23:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so2119922pff.11;
        Sun, 03 Mar 2019 21:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OkuYknFFpL7AivetNE74ZYxUSsGQqIr+KvlrxvIEYA8=;
        b=To6dHLSmguVJcQ7IsXObQSRRFzwddSNq/YFhB6emj4W1bPOcuEpuqmGucj3Mdl1/R7
         mH5Gl5fUW4A3v0C+Ov37k/6CuGYA4+9ByvjrNF2o3044WxP0aKuYCqMbprvRhLUr6aHs
         9CvkVfuHWODgtP1vXMunysAWjLhzhJ6X0ls56e15XMQWfllv+S6SsKEMTn4i8yw4OHHd
         ZmoaVmwXiGsncvRKO4da8D0KUNphMrYlAFgcNy9RmSn0hSypnCEjFvyxFGcA9U7Tqslv
         wzG1TWvHrEsuKQN79enZnV/B4FEb7anUWuB6MNRw9EFiCsS32IUL2ESSZ6Cd0H1hhGND
         fxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OkuYknFFpL7AivetNE74ZYxUSsGQqIr+KvlrxvIEYA8=;
        b=ExEKYJiIp9rzCAWqgVNTkThfOPkVhUsD2Y6YcIPEVJKr+WVFE0UnRmFaAXPtN/Nnrb
         PLKyx1J/4tGTEAJpEVzJGJHH7V7ybqg7LzcPrXra0tSOaHzf6898JLpRO6m0U+/eizod
         P6sdWW/nKK5JPA5iKI1gF2sCZQYjJiwz04RbZg1tJEeEwXpxs32x5V/YPJAY+0U2bTtC
         XDUTwng51qzMwDTku34wgB1znCBbEL/yEFImDiMwfUwjHmeABmfcgrLWXGDHqbqLj/CQ
         n639USSiFqUwmrNvwLJlufAN3yV/J2TKzZ0SoKQGEBjPJVISj5RBIYnoabw9PwZ73Voz
         Ylgw==
X-Gm-Message-State: APjAAAWf+SKDmSm8q/qwNILqkhLLZgNtBNE2CJplEWQm9nCTpJ9Wr3gz
        /7hmF+kRvyVMDB4vt4u/L/su3WCX
X-Google-Smtp-Source: APXvYqxsee3m4H4yWkTIl37aOYTYGLEfztr3R1ZBuolHsVD5ah/D9FsgcmmIqah257xqDp0anipcbQ==
X-Received: by 2002:a63:5a5e:: with SMTP id k30mr16926317pgm.345.1551677019633;
        Sun, 03 Mar 2019 21:23:39 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id o76sm8731578pfa.156.2019.03.03.21.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 21:23:38 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:23:35 +0900
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
Message-ID: <20190304052335.GA6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l9721hf.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 15:43), John Ogness wrote:
> On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> - A dedicated kernel thread is created for printing to all consoles in
> >>   a fully preemptible context.
> >
> > How do you handle sysrq-<foo> printouts on systems which can't
> > schedule printk-kthread?
> 
> If those sysrq printouts are at the emergency loglevel (which most are),
> then they are printed immediately to the emergency consoles. This has
> already proved useful for our own kernel debugging work. For example,
> currently sysrq-z for very large traces result in messages being dropped
> because of printk buffer overflows. But with the emergency console we
> always see the full trace buffer.

Are we sure that all systems will always have ->atomic console(-s)
enabled? Is it possible to convert all console drivers to ->atomic?
fbcon, for instance (with scrolling and font scaling, etc)? If there
are setups which can be fully !atomic (in terms of console output)
then we, essentially, have a fully preemptible kthread printk
implementation.

> Because you have already done so much work and experimentation with
> printk-kthreads, I feel like many of your comments are related to your
> kthread work in this area. Really the big design change I make with my
> printk-kthread is that it is only for non-critical messages. For
> anything critical, users should rely on an emergency console.

Fair point. Well maybe my printk-kthread comments are not utterly
unreasonable, but who knows :)

	-ss
