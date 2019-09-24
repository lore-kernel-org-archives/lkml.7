Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18247C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C9C2190F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QFv1USPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbfIXRF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:05:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34215 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfIXRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:05:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so2000865lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaeMc0t03cIGJW3QCybDKTEg7Rhlae4QY/t/oXRSyF0=;
        b=QFv1USPh0kNsLjLCn6KDhZ6GOehlhwbx8pj60BxT28JgW2JJ44jJTWI4aSbCVZ1+9x
         2hKmXsG3n0Nit+HSF3mYHiJrQFCZYU5Ve499Mh9JNJGgh8WI4FggQdw++ycae7dGiYA/
         NY8tdPd5Lelka6KQay8aA2D1A7cQqQGDeERsv9nP+/dTWoaDccrq879qpoyqKX6kZRRU
         L0YWSkYOjDI+c5Y+Gq4bpfqpw/XKcyFHOysPAHeawHOxw1TziWokzSMnObU86E5vKgxt
         76UQ/7F+YB0AlT1ZggGhdG/TnKNvgjCR+g940FQhBJI0WO/AKqsraEuFB9Lca3sGpxCk
         8EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaeMc0t03cIGJW3QCybDKTEg7Rhlae4QY/t/oXRSyF0=;
        b=Fl4CRX7spdjicyADyBM12SUr/R2RGAqWgjadsqnCS6C9skCUYptYzxng0+pm2NuEIl
         tGqiiYoFFQ8gtYf4ZurjNOyTveJdEjkm0W0nNulu+20My7UyXIDI2I84C7xAj2RuCSKz
         FYG0ztreBdk4Y/rgi1gWUyfYMpYzVdERaSk0wW4buM9KfNCQSBrss3QMLIMFEnFiH8R0
         nj+qn/J3Ej/WD0wAG+3Y6QVjuuDlWC8DZnSKrgCzzJx2odJQgt1pCi7RXK6UVCK7cBiL
         jw2OXAypwh/bCSCt2eEBv+GRSKeCEf14AvJHOMrtJK7m4tBWL2p32qWIWS9/IOliPN63
         ZJqw==
X-Gm-Message-State: APjAAAWasvzc/Owe3KuMX/tXN5lgL6s6vsbx8/mrxUMGH21JenGEEO4J
        i28z88CPUfXqGkgCR3VDhIJAR3jC0Gd74vjKycdZ
X-Google-Smtp-Source: APXvYqyN6rw64HRkgk116h9YMOpjw6jDzCAtHpygQSi32MgcWW+ZtK165buWD1NgGcFaWBKPKMI7oh+sxiUsfzQZgIo=
X-Received: by 2002:a19:6517:: with SMTP id z23mr2345791lfb.31.1569344725960;
 Tue, 24 Sep 2019 10:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923210021.5vfc2fo4wopennj5@madcap2.tricolour.ca> <CAHC9VhQPvS7mfmeomRLJ+SyXk=tZprSJQ9Ays3qr=+rqd=L16Q@mail.gmail.com>
 <20190924135046.kkt5hntbjpcampwr@madcap2.tricolour.ca>
In-Reply-To: <20190924135046.kkt5hntbjpcampwr@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Sep 2019 13:05:14 -0400
Message-ID: <CAHC9VhTJ53OSpNDLHMMrv65NFv7MK1XQt1zXPwd7nnAPo3rG0Q@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>, linux-audit@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:50 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-09-23 23:01, Paul Moore wrote:
> > On Mon, Sep 23, 2019 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2019-09-23 12:14, Paul Moore wrote:
> > > > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
> > > > >
> > > > > I have some hosts that are constantly spewing audit messages like so:
> > > > >
> > > > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
> > > > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
> > >
> > > Odd.  It appears these two above should have the same serial number and
> > > should be accompanied by a syscall record.  It appears that it has no
> > > context to update to connect the two records.  Is it possible it is not
> > > being called in a task context?  If that were the case though, I'd
> > > expect audit_dummy_context() to return 1...
> >
> > Yeah, I'm a little confused with these messages too.  As you pointed
> > out, the different serial numbers imply that the audit_context is NULL
> > and if the audit_context is NULL I would have expected it to fail the
> > audit_dummy_context() check in audit_ntp_log().  I'm looking at this
> > with tired eyes at the moment, so I'm likely missing something, but I
> > just don't see it right now ...
> >
> > What is even more confusing is that I don't see this issue on my test systems.
> >
> > > Checking audit_enabled should not be necessary but might fix the
> > > problem, but still not explain why we're getting these records.
> >
> > I'd like to understand why this is happening before we start changing the code.
>
> Absolutely.
>
> This looks like a similar issue to the AUDIT_NETFILTER_CFG issue where
> we get a lone record unconnected to a syscall when one of the netfilter
> table initialization (ipv4 filter) is linked into the kernel rather than
> compiled as a module, so it is run in kernel context at boot rather than
> in user context as a module load later.  This is why I ask if it is
> being run by a kernel thread rather than a user task, perhaps using a
> syscall function call internally.

I don't see where in the code that could happen, but I agree that it
looks like it; maybe I'm just missing a code path somewhere.

Is anyone else seeing these records?  Granted my audit test systems
are running chrony, not ntp, but the syscalls/behaviors should be
similar and I can't seem to recreate this.

-- 
paul moore
www.paul-moore.com
