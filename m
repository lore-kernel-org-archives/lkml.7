Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55189C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198042087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553646665;
	bh=lvbpiVadMMGfp841TVRoGE3PHgwepkXr5pCRZmPS6ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HwPnwm/m87xw2i7lJ+qrcYFE7Z24WPFr4PwmUl4Ufk0HdK1rzGRFNllk1sYdjKKtG
	 02Q9PmQy6tVaZaXTBZRSGimnngPcEwr8qpik2eCr7PJm5EW87BKE17bgttFp0yJGku
	 yaSq6+1IOoqjZXPYA0bXEcp8vx1Z7YUZ7INg5WgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfC0AbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfC0AbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:31:03 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB862075E;
        Wed, 27 Mar 2019 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553646662;
        bh=lvbpiVadMMGfp841TVRoGE3PHgwepkXr5pCRZmPS6ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu6t7+m+h5MEb7AX2zRKWB5DFDFG8S75IbkFD+cC6PJ8y1OTZphAI83I/nr3NXcUq
         SIh8nwFEJEiVwiwrmgzz485/1tXwCJfmN0ng1qSHx9u3ZMBSUV52nYdT4omvD2MCX2
         Hb9BvCm8BvWUvh8mHeYEk0Nvr8XNmGNAeJs9H3AM=
Date:   Wed, 27 Mar 2019 09:30:57 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327003057.GA27311@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
 <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > From: Matthew Garrett <mjg59@google.com>
> >
> > debugfs has not been meaningfully audited in terms of ensuring that
> > userland cannot trample over the kernel. At Greg's request, disable
> > access to it entirely when the kernel is locked down. This is done at
> > open() time rather than init time as the kernel lockdown status may be
> > made stricter at runtime.
> 
> Ugh.  Some of those files are very useful.  Could this perhaps still
> allow O_RDONLY if we're in INTEGRITY mode?

Useful for what?  Debugging, sure, but for "normal operation", no kernel
functionality should ever require debugfs.  If it does, that's a bug and
should be fixed.

thanks,

greg k-h
