Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBE4214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNr5fPgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfIRCg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:36:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45273 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfIRCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:36:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so3066413pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wpxxTUuGVsmgpbrkwQXSwnsj5db54LEf/di0DULFjk=;
        b=ZNr5fPgNdzS2J5NPV+kZEQC//guguQKQWma09goV6KF6vw4ujTy8073g/95XHe9Tn3
         xXb1hL8xhE2To2tJiN+GryhRq2jfs8Kv0+crhnIgNAT7nk5sWvypSgAuItdPTEY5skuc
         S9328xDog+2IWzO+1rkLqsRfvn3P9rglGId9hW3ym8vp9uvVG0D/+E1D7ZmQZHtcTWSC
         fDCcqSCDZTPXBLafEgjoFeIpWPaTLnsvhPEE1gU5UuPtTWS66ccZ4QJm10gzk+VZomUM
         QKFZZrP7IZymuwu/72T31zIXPJ6d6mZ23fTg2NvDK+Yr2lNeIEJDapnw2dN1sCW8RBdu
         SPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wpxxTUuGVsmgpbrkwQXSwnsj5db54LEf/di0DULFjk=;
        b=Bl78vCfgeYKbTjpmfIC4zTKmDGvTzVH0PyD7nnJpE8UFYe0uMbLCJbC6d0PaSIL04c
         PJM5lqyJ3kEyKuBV/AtVPEWKAQKw2u/Nou1EoSFdC+tIBZUnz+BMZdWlDa5I7hDzeaQ6
         /5Lkpr/b/HcDdUY4eGjxamWF9/xGXIOIqJ6zpXtjGJ9hE8rHp3iPqHzm81+pUuq9Idu8
         eO+utLmHFAlz7/2RjKsIhTeM9wQLkJ5SuCGqWEyqkq045xM6kEWVK7hEddvAsGUrJSFK
         EehHuxoRqAKJ68G/R9nzA+CwxEBByO3LG44nVJ4ZjAPop87eAF5WJWlZrjRytBjIPOav
         MzxQ==
X-Gm-Message-State: APjAAAVnwOD3jpo0RMVwU2eC804OFWFUpAtVGuCDFwSdfQgY7tvvK/me
        ZXfAktV1+7HGM9cKKLKnjiE=
X-Google-Smtp-Source: APXvYqywr4IpH4ZAVXbIkbRu4Xaau9yiGf1J8MNrnWB6W4W3NbOInOZ850iu8om7wPMrvsoNFZvKhw==
X-Received: by 2002:a62:83cb:: with SMTP id h194mr1676102pfe.66.1568774218716;
        Tue, 17 Sep 2019 19:36:58 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id a29sm6437181pfr.152.2019.09.17.19.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 19:36:57 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:36:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918023654.GB15380@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917220849.17a1226a@oasis.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/17/19 22:08), Steven Rostedt wrote:
> > On (09/13/19 15:26), John Ogness wrote:
> > > 2. A kernel thread will be created for each registered console, each
> > > responsible for being the sole printers to their respective
> > > consoles. With this, console printing is _fully_ decoupled from printk()
> > > callers.  
> > 
> > sysrq over serial?
> > 
> > What we currently have is hacky, but, as usual, is a "best effort":
> > 
> > 	>> serial driver IRQ  
> > 
> > 	serial_handle_irq()		[console driver]
> > 	 uart_handle_sysrq_char()
> > 	  handle_sysrq()
> > 	   printk()
> > 	    call_console_drivers()
> > 	     serial_write()		[re-enter console driver]
> > 
> > offloading this to kthread may be unreliable.
> 
> But we also talked about an "emergency flush" which will not wait for
> the kthreads to finish and just output everything it can find in the
> printk buffers (expecting that the consoles have an "emergency"
> handler. We can add a sysrq to do an emergency flush.

I'm sorry, I wasn't there, so I'm surely is missing on some details.

I agree that when consoles have ->atomic_write then it surely makes sense
to switch to emergency mode. I like the emergency state approach, but I'm
not sure how it can be completely invisible to the rest of the system.
Quoting John:

    : Unlike oops_in_progress, this state will not be visible to
    : anything outside of the printk infrastructure.

For instance, tty/sysrq must be able to switch printk emergency on/off.
That already means that printk emergency knob should be visible to the
rest of the kernel. A long time ago, we had printk_emergency_begin_sync()
and printk_emergency_end_sync(), which would define reentrable
printk_emergency blocks [1]:

	printk_emergency_begin_sync();
	handle_sysrq();
	printk_emergency_end_sync();

We also figured out that some PM (hibernation/suspend/etc.) stages (very
early and/or very late ones) [2] also should have printk in emergency mode,
plus some other parts of the kernel [3].

[1] https://lore.kernel.org/lkml/20170815025625.1977-4-sergey.senozhatsky@gmail.com/
[2] https://lore.kernel.org/lkml/20170815025625.1977-7-sergey.senozhatsky@gmail.com/
[3] https://lore.kernel.org/lkml/20170815025625.1977-8-sergey.senozhatsky@gmail.com/

	-ss
