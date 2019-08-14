Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8788C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE28214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565817617;
	bh=2E2JMCEsGfJgUZSIcsEX9gpK1QWJbGLg/k/y//c7LnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sNjy05loeMlRA46bwDnwcywww+Gd+CzqYOKwNsxAFcJEg2A5IzSu3rs1fAudjzbvT
	 ewvQrn1U0yly8L4LIZObG57hBlWEcwJvrXapERgJQKn2eVyWV/Hpu5x29agr6xdWiT
	 CgcYikWVmGLyVEIyHjWVoH8tRmiDP2Lg1m8hfCgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfHNVUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHNVUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:20:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF2A2133F;
        Wed, 14 Aug 2019 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565817615;
        bh=2E2JMCEsGfJgUZSIcsEX9gpK1QWJbGLg/k/y//c7LnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgLKdYEea1VQuEuz1Gv3VbFrCYN2PEZ4jEbCkHoJwkSePk2JWz6kFI/uZ+uK+7dMF
         b0JQUzgonM4/XQ+1OafG24te3op3Ut/QA4FsqW9o6Qw+mMQu+ERyz3OqmgUD4GFDH3
         KpH/YdphbCyf+VobkIuFmnck9Dpp+wIQGoT3wL5U=
Date:   Wed, 14 Aug 2019 23:20:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Subject: Re: Policy to keep USB ports powered in low-power states
Message-ID: <20190814212012.GB22618@kroah.com>
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com>
 <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:12:07PM -0600, Nick Crews wrote:
> Thanks for the fast response!
> 
> On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> > > Hi Greg!
> >
> > Hi!
> >
> > First off, please fix your email client to not send html so that vger
> > does not reject your messages :)
> 
> Thanks, should be good now.
> 
> >
> > > I am working on a Chrome OS device that supports a policy called "USB Power
> > > Share," which allows users to turn the laptop into a charge pack for their
> > > phone. When the policy is enabled, power will be supplied to the USB ports
> > > even when the system is in low power states such as S3 and S5. When
> > > disabled, then no power will be supplied in S3 and S5. I wrote a driver
> > > <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> > > of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> > > had the reasonable suggestion of trying to move this into the USB subsystem.
> >
> > Correct suggestion.
> >
> > > Has anything like this been done before? Do you have any preliminary
> > > thoughts on this before I start writing code? A few things that I haven't
> > > figured out yet:
> > > - How to make this feature only available on certain devices. Using device
> > > tree? Kconfig? Making a separate driver just for this device that plugs
> > > into the USB core?
> > > - The feature is only supported on some USB ports, so we need a way of
> > > filtering on a per-port basis.
> >
> > Look at the drivers/usb/typec/ code, I think that should do everything
> > you need here as this is a typec standard functionality, right?
> 
> Unfortunately this is for USB 2.0 ports, so it's not type-C.
> Is the type-C code still worth looking at?

If this is for USB 2, does it use the "non-standard" hub commands to
turn on and off power?  If so, why not just use the usbreset userspace
program for that?

And how are you turning a USB 2 port into a power source?  That feels
really odd given the spec.  Is this part of the standard somewhere or
just a firmware/hardware hack that you are adding to a device?

Is there some port information in the firmware that describes this
functionality?  If so, can you expose it through sysfs to the port that
way?

thanks,

greg k-h
