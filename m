Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA63C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9407224655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576603267;
	bh=M03ToXVlhxaSn1s14N+p+KZe5B0/dADmOYgSMKETlNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sO57GjicxrV3riwrGss66fT8la1N9mSfzafdN6h8GAiojToBEas8wzhdBmypbEtoy
	 I25brSLFBWLhs3rr8Zrwol2NMEwaGj89POh6aXHowXgEMnfPxusew+jB1F5yF/YPNw
	 Xpa9R3bEXZO0pvpUi7mKXfJEjPk0tjbccV01aUsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLQRVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQRVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:21:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6490F21582;
        Tue, 17 Dec 2019 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576603265;
        bh=M03ToXVlhxaSn1s14N+p+KZe5B0/dADmOYgSMKETlNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkHRnpSBunkxmidMGP8NjEIv8AikT24N46ZYxcKbI4BtwHE2DzWKFve1hoVg3Wv/b
         vsDrp9eWvubSOm7EOKqAcUc3RPmDSRKRz30qa6fOxYorMrW5N3969gi2Nl+FVi/bZk
         +mxUJFk5EMHhzhywXR7RMzyAtUP5HQH1xTQgJjPM=
Date:   Tue, 17 Dec 2019 18:21:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Jiri Slaby <jslaby@suse.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] leds: trigger: implement a tty trigger
Message-ID: <20191217172102.GB3829986@kroah.com>
References: <20191217150736.1479-1-u.kleine-koenig@pengutronix.de>
 <20191217150736.1479-4-u.kleine-koenig@pengutronix.de>
 <20191217152724.GA3667595@kroah.com>
 <20191217162313.5n3v7va5nw5lxloh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217162313.5n3v7va5nw5lxloh@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:23:13PM +0100, Uwe Kleine-König wrote:
> On Tue, Dec 17, 2019 at 04:27:24PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 17, 2019 at 04:07:36PM +0100, Uwe Kleine-König wrote:
> > > Usage is as follows:
> > > 
> > > 	myled=ledname
> > > 	tty=ttyS0
> > > 
> > > 	echo tty > /sys/class/leds/$myled/trigger
> > > 	cat /sys/class/tty/$tty/dev > /sys/class/leds/$myled/dev
> > 
> > Is this the correct instructions?  Aren't you looking for a major/minor
> > number instead in your sysfs file?
> 
> This is correct, yes, at least it works as intended on my machine.
> 
> /sys/class/tty/$tty/dev produces $major:$minor and that's what the
> led-trigger consumes.

Ugh, nevermind, I totally read that wrong, I was thinking "echo" instead
of cat.  My fault, what you wrote is correct.  Should that be documented
somewhere in a Documentation/ABI/ file so that people know how to use
this new sysfs file?  How are led triggers documented?

thanks,

greg k-h
