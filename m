Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FC020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azRqFbE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:31:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:31:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so2137474pfi.9;
        Sun, 03 Mar 2019 21:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dcw+pYVDabq+pJjV4TQ/WHaj/xJ4FSQRvERVdgBPt0g=;
        b=azRqFbE0CBnghVCFfGa5xvTBPBaQvzwfGLSDEGP1JGVTznUich5r7FPPNRfeTXkhEB
         I9oMBDHizV6vV6du7QeecfIiRx3UfrkeJTy3/v88BxWQjU/ZY2JaSqGNOBBwIAdFwvZK
         2pBTaZ5FIlShGIq7setwsvtaYypVuT/K1d+w7u/wQW82CHBL//fNMn4sviXejRiaI1Hv
         4GBQMcpMkr7/11ygLEXuGyMvlUSr9G/d0oIhN8LrW/riBEdycTIt0rJp4Q2Q9Y4ljXU9
         CIdQnUukkHTCk8wVA7JMuRkeGKhA7AdNistPLwVgH6uRcrNAyoPe4pk2UJ/bMmhcswT4
         ID2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dcw+pYVDabq+pJjV4TQ/WHaj/xJ4FSQRvERVdgBPt0g=;
        b=K0P//tLeORzJZN+N+6RXfJ1EFL45HTvNkFS4bx8XUodtvzm7/65U5k74cQSatc3XRm
         2r3fjY0hFhUn64PARpfrKUM880FsYGz3OZiHU0K/hm/BxQL1bkD/dPJTQG8qSz3FIJAA
         R0qRWsAHaDbz9gosfHrBvw8WAJifPwnnM42hTrVpG8vZn90MLZwRojtZ9c1H/cCyCj+Y
         6pkcvorsOFh0V2W9oT2lbV+7T9kVBA9aH/rkMQ3yp3yfF3IfmjQn2X7jHxTkLE5FMwdl
         VE8CmVSnBpqXMvFK9TkrjjdwNXRJLyQVMKfFzQqNWf5zvfl/b4NrEzTpqyxfBsgzWew0
         dCyw==
X-Gm-Message-State: APjAAAXr2t7fI17xqJNTPhHRyozvGReHP96T3cvcvQ14N5B73SzOKlvr
        qbalISvtfh2HZun1BoVEbYQ=
X-Google-Smtp-Source: APXvYqzaNRO6LEijLiAOY6y1+B9VKU4mx3I516bQGSFoBO6mE4tcSyHu/A67YVWEumvBKvJKmYsHcg==
X-Received: by 2002:a63:8d42:: with SMTP id z63mr17146639pgd.414.1551677494631;
        Sun, 03 Mar 2019 21:31:34 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id w23sm7033664pfn.60.2019.03.03.21.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 21:31:33 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:31:30 +0900
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
Message-ID: <20190304053130.GB6648@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213014141.GB8097@jagdpanzerIV>
 <878syj22r5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878syj22r5.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 15:15), John Ogness wrote:
> I don't like bust_spinlocks() because drivers end up implementing
> oops_in_progress with exactly that... ignoring their own locks. I prefer
> consoles are provided with a locking mechanism that they can use to
> support a separate NMI-safe write function. My series introduces
> console_atomic_lock() for exactly this purpose.
> 
> But this doesn't help here. Here we are talking about a crashing system
> that does _not_ have an emergency console. And in this case I would say
> messages would be lost (just like they are now if all you have is a vt
> console and it was busy).
> 
> I suppose we could keep the current bust_spinlocks() stuff for the
> special case that there are no emergency consoles available. It's better
> than nothing, but also not really reliable. Preferrably we figure out
> how to implement write_atomic for all console drivers.

Right. We set console loglevel to verbose before the final panic flush,
so flush of all unseen messages (regardless of importance) does look quite
reasonable (and this is what panic() has been doing for many years).

	-ss
