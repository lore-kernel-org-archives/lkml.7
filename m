Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D9C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123502085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561516224;
	bh=jjst7+utkoBGLKsDmgJ1xUuv/cwsPu8vF2R7ckspMco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cXf1OqyfUJGYboaL9/ge1p8SKmYHM6ZvPLq/sit/jEchWrmy4SU/KisbuZQGCIBLZ
	 ldTaQHGsBif9Y1U6kPC+xWDlMC+nyJv+J1oks3iXfUso8xjsXM+3291ztRb+AGkBOh
	 s9whraWfbSRxsfsW64ctUyf8rJbzf8aR5rW1Zfg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFZCaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZCaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:30:21 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E7220645;
        Wed, 26 Jun 2019 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561516220;
        bh=jjst7+utkoBGLKsDmgJ1xUuv/cwsPu8vF2R7ckspMco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mr4N8/NTP7A0+ZmhPEZ3mvwH8LzDjSyWcQJc71b1/FICvofmYFahd5d54dLUR79Uw
         PACgwccORrtpUq0qpjzkYV2x8A2oI8anqOGFt38gIf+8wqcRHOD1IxkccbwJSlhCMA
         JUay1iS8LDNIt+6QfdwvLEB2wkGTOkYmaBBFCp7A=
Date:   Wed, 26 Jun 2019 10:29:23 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190626022923.GA14595@kroah.com>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com>
 <20190626020220.GA22548@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626020220.GA22548@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
> Hi Greg,
> 
> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> > > On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> > > <pgriffais@valvesoftware.com> wrote:
> > > >
> > > > I applied Eric's path to the tip of the branch and ran that kernel and
> > > > the bug didn't occur through several logout / login cycles, so things
> > > > look good at first glance. I'll keep running that kernel and report back
> > > > if anything crops up in the future, but I believe we're good, beyond
> > > > getting distros to ship this additional fix.
> > > 
> > > Good. It's now in my tree, so we can get it quickly into stable and
> > > then quickly to distributions.
> > > 
> > > Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> > > tcp_fragment()"), and I'm building it right now and I'll push it out
> > > in a couple of minutes assuming nothing odd is going on.
> > 
> > This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> > a bit for them.
> > 
> > But for 4.14 and older, we don't have the "hint" to know this is an
> > outbound going packet and not to apply these checks at that point in
> > time, so this patch doesn't work.
> > 
> > I'll see if I can figure anything else later this afternoon for those
> > kernels...
> > 
> 
> I may have missed it, but I don't see a fix for the problem in
> older stable branches. Any news ?
> 
> One possibility might be be to apply the part of 75c119afe14f7 which
> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
> is acceptable.

That's what people have already discussed on the stable mailing list a
few hours ago, hopefully a patch shows up soon as I'm traveling at the
moment and can't do it myself...

thanks,

greg k-h
