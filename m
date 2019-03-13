Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6572C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AF02173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEQCLdDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfCMJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:28:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:28:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so946745pfh.10;
        Wed, 13 Mar 2019 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2SU/HcyKOo1yTWZv2CFgrz5XJlYH5b//sg9V29TkLI=;
        b=FEQCLdDCIBXTalZGa5dDpBDTBaBTiSP9EVwRPgWowFnoqZgpeL2Nxr/Uws8KMmEwdK
         Nms+sE8Jpy28nspwdPPAhLOKGDJ7joTgWVWS2ZKJ5bqoWr4GUr/jUH6YebcphfGOjqpW
         9HrH9fOP26C0COpV7nNxVC+7YUIFnKlh5tjvA+bfRkMH+s7ETN8viUczJtqaiBT7sLAj
         oZtXSsTyEODcMmOs6gOlVBEY1ATxWV4zZn5PHUjAFsmtFG7HNbyWMP1T1svl60qB80Pa
         NNKrNWub0jcU3NFZD+RAA8x72LyPYaA8+hTZtpAT4sbt1HQk62RT8lnPWszd5gjWWNPn
         ZIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2SU/HcyKOo1yTWZv2CFgrz5XJlYH5b//sg9V29TkLI=;
        b=p7BfHhtDzJB3zmNAxNFj35xctew1UZ287hnZgCgqRdsrNDvB/6uzT3mQV6J/wKrnRz
         x91dhuLr//qhxz/SLQh8Oo4PIiNj3dvtLAn5Marc7y8sDMT7l8i+wz/Own3BA8jB12hX
         y+tX30ZIXjcDLxMpWkdHp2Ns2tkeVlwEZfuxtNdwdy9EHI9Lks/1rzPCw3I6xAX66Rcs
         0qIhnRT1x2hReTW0xlXtSrhOWNx9ASxRXr6kXTZ7DZjLR7o2TNs5hk6KqG3KgXPy9nzj
         XCZr8juWlWD0wHe9wcm1dfD4hif82xkqPzhaGLlQf2Pd3puOD2A81CGRmr3zgm8QMv2b
         sOqA==
X-Gm-Message-State: APjAAAWquasBLFzzyk+y2dxcRC/azBmDEwcSJAIjMXzXv4ssSz1OuyVa
        RaIaWDdTv5AjBG8oSYDlWLo=
X-Google-Smtp-Source: APXvYqzlINvbJfGI0A2aI7uJXMmAZW7rB48AMnlIYAcWxdnMaMuqb4Lnc32e3vqyjVoF+JKq9FjSUg==
X-Received: by 2002:a62:e80f:: with SMTP id c15mr43076554pfi.33.1552469283660;
        Wed, 13 Mar 2019 02:28:03 -0700 (PDT)
Received: from localhost ([110.70.15.13])
        by smtp.gmail.com with ESMTPSA id a4sm13471791pga.52.2019.03.13.02.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 02:28:02 -0700 (PDT)
Date:   Wed, 13 Mar 2019 18:27:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190313092759.GA10060@jagdpanzerIV>
References: <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
 <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/13/19 09:40), Sebastian Siewior wrote:
> On 2019-03-13 09:19:32 [+0100], John Ogness wrote:
> > recursive situation. As you are pointing out, the notification/wake
> > component of printk_safe will still be needed. I will leave that (small)
> > part in printk_safe.c.
> 
> Does this mean we keep irq_work part or we bury it and solve it by other
> means?

That's a very good question. Because if we add console_trylock()
to printk(), then we can't invoke ->atomic() consoles when console_sem
is already locked, because one of the registered drivers is currently
being modified by a 3rd party and printk(), thus, must stay away.
Once that modification will be done console_unlock() will print all
pending messages. This is current design. And this conflicts with the
whole idea of ->atomic() consoles.

So may be we need a whole new scheme in this department as well.

For instance [*and this is completely untested idea* !!!]

*May be* we can take a closer look and find cases when ->atomic
consoles don't really depend on console_sem. And *may be* we can
split the console drivers list and somehow forbid removal and
modification (ioctl) of ->atomic consoles under us. Assuming that
this is doable we then can start iterating ->atomic consoles list
with unlocked console_sem.
Non->atomic consoles or consoles which depend on console_sem (VT,
fbcon and so on) will stay in another list, and we will take
console_sem before we iterate that list and invoke those drivers.

One more time - a completely random thought.

	-ss
