Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE68C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F07421738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565017203;
	bh=r9lV4e8Z+n3GWTf5zhy31KoHsNfQ21GGJlnhjuDo8as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z3wRIzd8DG6MJpDFs7QhPd6C6P1upU2J4V1ZBwPMuAdxhOqUJTEXJntEhYM1skCNx
	 ty97jlVJKLZOtI/rrv2nkIuBCQzPG/wh6AQIxXaHagQ/JHURPvJL8xBsyEoQ8uQhss
	 9IWhHWmbQDH8KaxKCqQ8zSbcyvcO8A+mPfG80RqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfHEPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEPAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:00:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726A8206C1;
        Mon,  5 Aug 2019 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017200;
        bh=r9lV4e8Z+n3GWTf5zhy31KoHsNfQ21GGJlnhjuDo8as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuX4YO14sEnig5n1ekJ9HYL6FHx3iFydPy3ShNcr67D6Uc+HTiZaJUYPnwMNhkUNQ
         5QKFuVBjoi3MeD10acf2eo/dZl9Qk1jIkBCE3B0qsTW6XFkqjGC3oUkTrt8sJS3rLW
         xILB+P9JmH82nE2O6uR8tCNNplU9fRpdeIJLj2I0=
Date:   Mon, 5 Aug 2019 16:59:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190805145958.GA32726@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
 <87blx3n0a2.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blx3n0a2.fsf@xmission.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:40:21AM -0500, Eric W. Biederman wrote:
> 
> I skimmed this and a couple things jumped out at me.
> 
> 1) PGP and S/MIME because of their use of long term keys do not provide
>    forward secrecy.  Which can makes it worth while to cryptographically
>    factor a key or to obtain knowledge of a private key without the key
>    holders knowledge.  As the keys will be used again and again over a
>    long period of time.

Secrecy over a "long period of time" is not what is needed here.  6
months max is what I have seen, why would you need longer?

>    More recent protocol's such as Signal's Double Ratchet Protocol
>    enable forward secrecy for store and foward communications, and
>    remove the problem of long term keys.

And how does that work with email?  We need something that actually
works with a tool that everyone can use for development (i.e. email)

> 2) The existence of such a process with encrypted communications to
>    ensure long term confidentiality is going to make our contact people
>    the targets of people who want access to knolwedge about hardware
>    bugs like meltdown, before they become public.

Why are those same people not "targets" today?

And again, it's not long-term.

> I am just mentioning these things in case they are not immediately
> obvious to everyone else involved, so that people can be certain
> they are comfortable with the tradeoffs being made.

I know of no other thing that actually works (and lots of people can't
even get PGP to work as they use foolish email clients.)  Do you?

thanks,

greg k-h
