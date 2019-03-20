Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77632C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4728B218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CyexUELW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfCTVAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:00:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41867 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCTVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:00:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2655780pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f78UUbGKyvb5xNKeCqyg3vPseKw3OsSOSNFftW/LaHw=;
        b=CyexUELWWoWgec1zgL2vTSd4pY4s22vCR3NTrq/Mevz1UCHJbxeK1G1iUx6abPl0Vl
         EBAlKAZn5N8iNt4+sOarbiYEUZ979+rU81S1M7HW1hIXPpQ9ZDu9nZo2U1w3qH0QKu0t
         7SfUMsO8cfdXPt6aBnNhK0yC6mjfPyreKR3vVgX0U0KlxOa5PKndn5X57K6cNLoR5k6D
         Af/HFdiCQbCcL+8VUYjOL8ISDG6RPloSVCXiXsUgDNyU+1PNlPACjgTZDFUfTyowvoJf
         Bkj2Z0lBx2fiFilSNmIiccpYIa0m5O8m31tT4q2OWHcPgpLfUS+dfOYxCGp1mbgJmzMf
         iVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f78UUbGKyvb5xNKeCqyg3vPseKw3OsSOSNFftW/LaHw=;
        b=PMHdY687ATv4TiGmXqxCf6uhu97FFYMi3nwQQ7Hb6L4Y2qpE094zg1TtvuhgU1QUaQ
         Kh7qJxvCzAXnCSG70N0eDw/md3FryPSkjLrVsXT258jHviJChItjAHk4wVWbjKWZBEc6
         dKfhJyuoQkYB2tRiDCjnwTFiS+7v3AKX/Ss30ryVg1xkmB5kCpCDkwa7Hc6T/ektJHkY
         EBWNSCSWroHuLFU1kzP0wgZdGrGoskJsP0W3vF9XsjFXiGIZeBwkTUYNVIEraHXydZik
         gu6x/Hgz10h3joOcKBt87tnH4hFZodPlGfNmWEjJjO0fKZmnVitrjgTpmjUPn0QXUKBV
         92Rw==
X-Gm-Message-State: APjAAAXcailCfRquqFIkLPF9i3rRsgM5yYmw2LvzHSpIkq/Vaa1L7BRQ
        ew7ossSGGueDct9M/NmnLiAASw==
X-Google-Smtp-Source: APXvYqzeNmf44oYKbPScpcA+H3oOgKsQyRG38DGGzc5r6CPuEr5ngiYVq/uoM6gLf60aXN7idVfBEw==
X-Received: by 2002:a63:43:: with SMTP id 64mr35795pga.64.1553115613375;
        Wed, 20 Mar 2019 14:00:13 -0700 (PDT)
Received: from brauner.io ([12.25.160.29])
        by smtp.gmail.com with ESMTPSA id b8sm3255541pgq.33.2019.03.20.14.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:00:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 22:00:11 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: pidfd design
Message-ID: <20190320210009.hhgtcu4wkvsxg4sa@brauner.io>
References: <20190320200702.GA27111@avx2>
 <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
 <20190320203910.GA2842@avx2>
 <20190320204736.x4p5m7gxz6rbxlo3@brauner.io>
 <CAKOZueudv0fnOUPFyXHakgrqjiNz3zF+xckN1xGk93wTY7sjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueudv0fnOUPFyXHakgrqjiNz3zF+xckN1xGk93wTY7sjuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:50:43PM -0700, Daniel Colascione wrote:
> On Wed, Mar 20, 2019 at 1:47 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, Mar 20, 2019 at 11:39:10PM +0300, Alexey Dobriyan wrote:
> > > On Wed, Mar 20, 2019 at 01:14:01PM -0700, Daniel Colascione wrote:
> > > > On Wed, Mar 20, 2019 at 1:07 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > > > > What would be your opinion to having a
> > > > > > /proc/<pid>/handle
> > > > > > file instead of having a dirfd.
> > > > >
> > > > > This is even worse than depending on PROC_FS. Just for the dependency
> > > > > pidfd code should be backed out immediately. Forget about /proc.
> > > >
> > > > We already have pidfds, and we've had them since /proc was added ages
> > > > ago.
> > >
> > > New pidfd code (or whatever the name) should NOT depend on /proc and
> > > should not interact with VFS at all at any point (other than probably
> > > being a descriptor on a fake filesystem). The reason is that /proc is
> > > full of crap and you don't want to spill that into new and hopefully
> > > properly designed part of new code.
> >
> > Yes, I agree. That's why I was thinking that translate_pid() is a good
> > candidate to provide that decoupling.
> 
> Then again: how do you propose fetching process metadata? If you adopt
> a stance that nothing can use procfs and simultaneously adopt a stance
> that we don't want to duplicate all the decades of metadata interfaces
> in /proc/pid (which are useful, not "crap"), then the overall result
> is that we just won't make any progress at all. There's nothing wrong
> with taking a dependency on procfs: procfs is how we talk about
> processes. It's completely unreasonable to say "no, you can't use the
> old thing" and also "no, we can't add a new thing that would duplicate
> the old thing".

This style or arguing won't get us any further. Please, send in the code
that you think is right and you want to get reviewed. If you can get the
Acks from the people you need, good.
