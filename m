Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156EC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2633720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYpuhAds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfGOCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:33:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33578 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGOCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:33:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so6705197pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 19:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjOgtmjAShvysCpnJPF+GHktVC67BkBC8WbgBwfjF9A=;
        b=vYpuhAdsW6W+p45fSG94mKzFXf1BQLw9uNlLvr5fhEzMg5PPydZpFKzl1QwxIaayMF
         yO5wntR7n78E6Ug4UnuR+rE6LCNUk9P5+A9kiUcYSSWml1haJ7IQUkrWNDkcPHEasdmW
         bAwvu0pp+llO5zrDwYpHW2z3kHOfBZRGQSQ0FRVNVSk+wkGmbnd72nGMLzPeJ3tYrkvf
         Oz3YdeYig6J3VRdep2Pn9jAc3OOaHEOG2v/Y8UtI6IMQLIjFzdQP2Xlr7N6e2Y97tHpo
         z7iGUbonZdrLS8UsYl/LuheMCDDRqZL53UzDrfAY9Q3plb7sN29SwLb4dIYysYohw4uT
         Vnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjOgtmjAShvysCpnJPF+GHktVC67BkBC8WbgBwfjF9A=;
        b=d7Dko1QW345+j/eUonDqpd/3D/9hs4yx8/f7GwCRN5rfycDU4HHrblcSvSjoG+2K8o
         Mk/MlcQK4cxAzEb6A20gKdeAmut2/0ke4GIfDz7vBTUET9yaNvGinAp1se3oXhsSCWr/
         4vcC6bdA+7c1brFklL0qt31yTmKNCwfmZfqceV40Csij/Knji9b/iAecYiBqhnnjkZ57
         fNB+juhEorc8/lSiHjoM2z58itarxOIkQ/To5JASRRBM8gCj5yowoDEFRb+Jsx0Vi5aF
         Grc58JV8kH2HPMzflwLqS8+FPwr2TdLG7RSeDHnjegEuLxapy3DcSq6gxKu4CQrXqs6H
         ZmDg==
X-Gm-Message-State: APjAAAWM/nwUdlMknkSwtE1sFWTXb4mqV/f50IByGUTNK+plu3oViQhV
        Cm63o1fnH6FaZjwb9uFwZ6Y=
X-Google-Smtp-Source: APXvYqz3nVnYpZn7aGyfcOtT67ia8899EWaxY+MCycp7jxkqNSVbDSJvuqTtwiMYtfVCusiba0IpgA==
X-Received: by 2002:a63:e24c:: with SMTP id y12mr23736283pgj.81.1563158022541;
        Sun, 14 Jul 2019 19:33:42 -0700 (PDT)
Received: from localhost ([39.7.59.60])
        by smtp.gmail.com with ESMTPSA id d17sm1148446pgl.66.2019.07.14.19.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 19:33:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 11:33:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump
 from NMI context
Message-ID: <20190715023338.GB3653@jagdpanzerIV>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
 <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/13/19 17:03), Konstantin Khlebnikov wrote:
> > We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop() and after
> > printk_safe_flush_on_panic(). printk_safe_flush_on_panic() resets
> > the state of logbuf_lock, so logbuf_lock, in general case, should
> > be unlocked by the time we call kmsg_dump(KMSG_DUMP_PANIC).
> > Even for nested contexts.
> >
> >         CPU0
> >         printk()
> >          logbuf_lock_irqsave(flags)
> >           -> NMI
> >            panic()
> >             smp_send_stop()
> >              printk_safe_flush_on_panic()
> >               raw_spin_lock_init(&logbuf_lock) << reinit >>
> >             kmsg_dump(KMSG_DUMP_PANIC)
> >              logbuf_lock_irqsave(flags)        << expected to be OK >>
> >
> > So do we have strong reasons to disable NMI->panic->kmsg_dump(DUMP_PANIC)?
> >
> > Other kmsg_dump(), maybe, can experience some troubles sometimes,
> > need to check that.
> 
> Indeed, panic is especially handled and looks fine.
> 
> Sanity check in my patch could be relaxed:
> 
>        if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
>                return;

How critical kmsg_dump() is? We deadlock only if NMI->kmsg_dump()
happens on the CPU which already holds the logbuf_lock; in any
other case logbuf_lock is owned by another CPU which is expected
to unlock it eventually. So it doesn't look like disabling all
NMI->kmsg_dump() is the only way to fix it.

When we lock logbuf_lock we increment per-CPU printk_context
(PRINTK_SAFE_CONTEXT_MASK bits); when we unlock logbuf_lock
we decrement printk_context. Thus we always can tell if the
logbuf_lock was locked on the very same CPU - this_cpu printk_context
has PRINTK_SAFE_CONTEXT_MASK bits sets - and we are about to deadlock
in a nested context (NMI), or the lock was locked on another CPU and
it's "safe" to spin on logbuf_lock and wait for logbuf_lock to become
available.

	-ss
