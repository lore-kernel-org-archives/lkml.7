Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB62AC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD8208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561189078;
	bh=4z2vmEU/QsMGr5ZEeJ2h7v3bjxQxll76H/iFChFi9XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qu+eDerFSQmK7d8Ar6YMUueET0lcV251Fe/vqSpYPD8niRhvNisCJaOiXYbfiURe4
	 zetjNrqXakGVghJEOmxPpubqQt0x4CQVsMb0XTNsoZ4exSDEW+eev87aDJWrnJogMg
	 EWVEOZPdf/KRdizPHOb5gQT6afnuvK+RlIaJ/orM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfFVHh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 03:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfFVHh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 03:37:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B372089E;
        Sat, 22 Jun 2019 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561189076;
        bh=4z2vmEU/QsMGr5ZEeJ2h7v3bjxQxll76H/iFChFi9XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHsWVZpFw+9zFNKYyXETdCbkd/p+Djn3qDTdcs3t3sfs+S22ZrFqy4CNBDcN7cSL7
         04mC14jNitcyUc0sgjmqFXNGXofvP9Cxdm5Jjx+ytM1aQBHTpLwtrBHr65iiqIvUae
         TLAMuPxl3NCXhYp1I+/1j+kFwkpOeLwKWatfjhag=
Date:   Sat, 22 Jun 2019 09:37:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190622073753.GA10516@kroah.com>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> <pgriffais@valvesoftware.com> wrote:
> >
> > I applied Eric's path to the tip of the branch and ran that kernel and
> > the bug didn't occur through several logout / login cycles, so things
> > look good at first glance. I'll keep running that kernel and report back
> > if anything crops up in the future, but I believe we're good, beyond
> > getting distros to ship this additional fix.
> 
> Good. It's now in my tree, so we can get it quickly into stable and
> then quickly to distributions.
> 
> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> tcp_fragment()"), and I'm building it right now and I'll push it out
> in a couple of minutes assuming nothing odd is going on.

This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
a bit for them.

But for 4.14 and older, we don't have the "hint" to know this is an
outbound going packet and not to apply these checks at that point in
time, so this patch doesn't work.

I'll see if I can figure anything else later this afternoon for those
kernels...

thanks,

greg k-h
