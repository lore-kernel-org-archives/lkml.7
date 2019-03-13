Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DFF217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6EuGMPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCMCPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:15:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33921 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfCMCPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 22:15:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id v64so273004pfb.1;
        Tue, 12 Mar 2019 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ddHuCc5raQ90r/bsCgad0VSKP/YEFC4aYtxhp/GMEXc=;
        b=V6EuGMPdh2uCj7aEfwnXwkDvag2HMTh3nTeQ+EYKaa3/4TvGRFjDGNmpBEYG4f2+L8
         7/3UjUnx8hyNOG/aFjVNZtvDzkZ8EAxwxA4z4XFKwz9OEHDC3rYG10iLixoyXF019EnN
         k7ooDlkNnqxqNxzCvmrEVrMLjgnRT/rwfga0UyGRfLfYRsXsudFJqq7EX6XqUlTHOAHc
         OHPXivkrepUTwPLoSiJfQUz0MVZzzD5rIt4ljKcFKzipi9rZ9DvzzPbv+N8Ljayak7Y1
         Dj7npnFLy6Tbvmwl+Z3eq44Xzj7VcGCbykmkUuliAaeSppFyv38nxhhFZK+w537YC3HY
         iEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ddHuCc5raQ90r/bsCgad0VSKP/YEFC4aYtxhp/GMEXc=;
        b=io46H/+pCb2kdX9mNM5ecBnP4Tilz8rgJxmIiBGEtnx6LpMKoegk3pWpArLnas6hVX
         lFeKtSAgJmraewZfsQ4K+ArHPGKcpCMx5ISli/lr+OnZkJi10IohTOLrHkCZHVZ7XH7E
         cmzRpvkOiGmT6ZAIAh8JdNoKZ4+rTeWZNnJs27s1E86j8Ho9a0dmNmdhOrRGG/EDd7df
         g62goCWbY2N12n9s9cmOV0TVIQKLj9wX+iBU5sQA18NRMbNgdQ9zsyxiyX7dWdLsUiyg
         N1jNi8JEjMPTtxUbX4zH/n2pMV1E7VtCgm8+z7X6kfwAYFdGcPGvu/I5oJwTzbgcPlm3
         Aarw==
X-Gm-Message-State: APjAAAWz/g9grNqwO9mhL4KrrAjxiP5nqGu/uDAaNI/JB2Y/33LT8k3t
        YNvcwfBSzwgZ4TgLgpMFsV+2FCzc
X-Google-Smtp-Source: APXvYqy0l21xROQJQ+6JQW0LzJsYHQE1TrbvjvcWDGyOWyCWBYwepJkE666KJ1UNlJXHCKZR97Nt+g==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr42727912plp.118.1552443338143;
        Tue, 12 Mar 2019 19:15:38 -0700 (PDT)
Received: from localhost ([110.70.15.13])
        by smtp.gmail.com with ESMTPSA id o5sm6221809pgc.16.2019.03.12.19.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:15:37 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:15:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20190313021534.GB783@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l8815uc.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/12/19 16:15), John Ogness wrote:
> > I suggest the following way forward (separate patchsets):
> >
> >     1. Replace log buffer (least controversial thing)
> 
> Yes. I will post a series that only implements the ringbuffer using your
> simplified API. That will be enough to remove printk_safe and actually
> does most of the work of updating devkmsg, kmsg_dump, and syslog.

This may _not_ be enough to remove printk_safe. One of the reasons
printk_safe "condom" came into existence was console_sem (which
is a bit too important to ignore it):

	printk()
	 console_trylock()
	  console_unlock()
	   up()
	    raw_spin_lock_irqsave(&sem->lock, flags)
	     __up()
	      wake_up_process()
	       WARN/etc
	        printk()
		 console_trylock()
		  down_trylock()
		   raw_spin_lock_irqsave(&sem->lock, flags)  << deadlock

Back then we were looking at

	printk->console_sem->lock->printk->console_sem->lock

deadlock report from LG, if I'm not mistaken.

	-ss
