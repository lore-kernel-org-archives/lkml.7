Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27716214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfaOoRgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCLJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:59:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39838 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:59:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so1420572pgp.6;
        Tue, 12 Mar 2019 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DrBMEo14gljPsBlnBZRcetvDKROEIzqhX7gkoad9ZWY=;
        b=ZfaOoRgxZe+wF5WNawiRqTsNbp0LudTUxFc+FWR0VSvwMV/jK+jI3FXI7YYQRP8ED5
         sdteQZZlIUPCBHjuVjd4/kFTCa2Ah6EEEFeMjdIA0D/+MCxEH8AZ+ozhP2hfyEoR6+SG
         WTbmaEj0hW+Uvahgq0kyrzSTWsI9tS6g6Cly4jGgVyN9r/WolSMUTC7tqY2pCyw+BvYf
         bRIm1LBz4kcrEkWaMF/g0VPabF/bnHfIKZuKtVq1ekls6M2D4qeQ/pCnoFkP3xmF1OIY
         6jIBOaQ7tY0hmuSysxjVI8gFLTKCptnyUgbFRw5xO1A16nwNiSC2YzChZk0DJHlpYBBE
         uZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrBMEo14gljPsBlnBZRcetvDKROEIzqhX7gkoad9ZWY=;
        b=rqJxxZcvVgVhrk2BMfdE6zVe1y2FbTsm4cgJ5Tc3HlFAWwvXjqBX8/PMyjBPB6DqzH
         vlT3RXPI0PVqUjQd9LGtmjL0VIHSNpeD646N918ZJrWTIzCgX6kTjBvjvC83jCiWw6Z8
         hlozC8P4UAjoxr1VN+vkpi0rgTHGdCvq5/AdPF0CFgzghXFkrczIdExb/bKG6Dpqwo4T
         sTgibkWpEQsaVkV0JBVw6tGMSxv6dAN8PSMOwPVeVXG1dAg38E6hPbnLPYTvXFbnQ5CE
         b2XMYHiooW2LjwLzUV9hY0vpO3XEuquK3ZaFHawHlbG6BMSRkqjSmVHvcMntrc6tKrC0
         v6QQ==
X-Gm-Message-State: APjAAAUMtkSU9oB70bpORR/Wa5lv8PzRvGc/UT4VfP42Uu+qdJQYzSdW
        D30yyCxTtubY8AtspypfZL0=
X-Google-Smtp-Source: APXvYqwu87CnRlaW7daYCn/Jqg97CU5ZzBo001aPjxk4Bhc1SWQzvnHRe+4eJZYfmTrNZ8Rd7o7c/g==
X-Received: by 2002:a17:902:9304:: with SMTP id bc4mr39575786plb.81.1552384740312;
        Tue, 12 Mar 2019 02:59:00 -0700 (PDT)
Received: from localhost ([175.223.49.170])
        by smtp.gmail.com with ESMTPSA id f3sm12160763pfn.100.2019.03.12.02.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:58:59 -0700 (PDT)
Date:   Tue, 12 Mar 2019 18:58:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
        Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190312095856.GA426@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190307051530.GC4893@jagdpanzerIV>
 <87va0pznsq.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va0pznsq.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/11/19 11:51), John Ogness wrote:
> > In new printk design the tasks are still affected by printing floods.
> > Tasks have to line up and (busy) wait for each other, regardless of
> > contexts.
> 
> They only line up and busy wait is to add the informational message to
> the ring buffer. The current printk implementation is the same in this
> respect. And as you've noted, the logbuf spinlock is not a source of
> latencies.

I was talking about prb_lock().

> > When I do ./a.out --loglevel=X  I have a clear understanding that
> > all messages which fall into [critical, X] range will be in the logs,
> > because I told that application that those messages are important to
> > me right now. And it used to be the same with the kernel loglevel.
> 
> The loglevel is not related to logging. It specifies the amount of
> console printing. But I will assume you are referring to creating log
> files by having an external device store the console printing.

Right. E.g. screenlog.0

> > But now the kernel will do its own thing:
> >
> >   - what the kernel considers important will go into the logs
> >   - what the kernel doesn't consider important _maybe_ will end up
> >     in the logs (preemptible printk kthread). And this is where
> >     loglevel now. After the _maybe_ part.
> 
> "what the kernel considers" is a configuration option of the
> administrator. The administrator can increase the verbocity of the
> console (loglevel) without having negative effects on the system
> itself. Also, if the system were to suddenly crash, those crash messages
> shouldn't be in jeopardy just because the verbocity of the console was
> turned up.

Right. I'm not very sure about yet another knob which everyone
should figure out. I guess I won't be surprised to find out that
people set it to loglevel value.

	-ss
