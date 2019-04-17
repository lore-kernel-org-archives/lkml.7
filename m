Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D619C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B73D2176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555483594;
	bh=oZ3WP7uQg7sRTTKdU7exhKEufd0mtIFEjulXJ42hmSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PoRwEpUOxcojp8co/42CErmYoueulgr/bHbtmg3f6R31UsBTxlTe7B9OVpDqJFHmg
	 r/fRlRtpRBAd+EG1l7nk/EM57uY5UFmRJ8Qadf+1e8f4C2mTlMqRbuo56S1r7Vp6hh
	 q28r8vf7CJsInTHcih/6eshUOCpmjTD4uVDvr64w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfDQGqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDQGqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:46:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A022176F;
        Wed, 17 Apr 2019 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555483591;
        bh=oZ3WP7uQg7sRTTKdU7exhKEufd0mtIFEjulXJ42hmSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0edzbW6sjOkTLvx1vi2sfhd735aV/+GAr1EGPQomSM8kg6fa41N1XMMEhv5Q2wrK
         NUr8BlwKlifRKnD0bRo7WsJTRVqgH8k41Cdx1ItZQqbg18/KgA9KexOIOyfQ0boYLm
         ixJhut4nh1MZcepgjuwIxF8STE0is0b9nOysHquU=
Date:   Wed, 17 Apr 2019 08:46:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: rocket: Remove the rp_ioctl
Message-ID: <20190417064629.GA19549@kroah.com>
References: <20190416145300.28212-1-huangfq.daxian@gmail.com>
 <06427d24-535b-e116-51e0-d98565a8fda1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06427d24-535b-e116-51e0-d98565a8fda1@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:27:41AM +0200, Jiri Slaby wrote:
> On 16. 04. 19, 16:53, Fuqian Huang wrote:
> > --- a/drivers/tty/rocket.c
> > +++ b/drivers/tty/rocket.c
> ...
> > -/*  IOCTL call handler into the driver */
> > -static int rp_ioctl(struct tty_struct *tty,
> > -		    unsigned int cmd, unsigned long arg)
> > -{
> > -	struct r_port *info = tty->driver_data;
> > -	void __user *argp = (void __user *)arg;
> > -	int ret = 0;
> > -
> > -	if (cmd != RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl"))
> > -		return -ENXIO;
> > -
> > -	switch (cmd) {
> > -	case RCKP_GET_STRUCT:
> > -		if (copy_to_user(argp, info, sizeof (struct r_port)))
> > -			ret = -EFAULT;
> > -		break;
> 
> I am not sure what Greg meant, but I had only this particular ioctl on
> mind when I was writing about removal. The other ones might be used _in
> theory_. Even though they are not exposed to userspace either. So if
> they are not source of potential issues, I would keep them:

I was just meaning that one specific ioctl, not the whole thing.

Although dropping all of these custom ioctls is probably the right thing
to do in the long-run, for now, let's just get rid of the problem one.

thanks,

greg k-h
