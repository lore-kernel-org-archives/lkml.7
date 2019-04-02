Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED585C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE315206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554186814;
	bh=9Jauwe6LBIRbSkyaJXI1HzD8l3RvN+3eXZbv3mUd/i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mr1FtaOKsRoI4mHeNeZqON/78L19KkjannGD6jnUt1fk/M0lV0+vfROFXTsuBFYlZ
	 YcyX10ewFPJCQCdsLUcK5+3GI9p22n/LnseDRSvYn63ozUXsAIQ1wSP4s4Bc60wgEF
	 NywTBDrkISGpS81dasCf2MyzTYpnSxPoG2c9G/BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDBGdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbfDBGdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:33:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFD62084C;
        Tue,  2 Apr 2019 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554186811;
        bh=9Jauwe6LBIRbSkyaJXI1HzD8l3RvN+3eXZbv3mUd/i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdRh4+IFNGmQbYxC+RB/68QGt9ycKEfcUhqUa9Zs8lTN5tsZ/Vs5EJ+G1ad9MpwUH
         FBB6Axa+Y2o34JHqxJ1WcTmBn0wgLJO2a7MCt3W1pj2Ybv83UNqpE+BD6w6K5fBO76
         7b3xoRN/OLxkzoUjpKmm4KPPfoyp3Aub56AUfF64=
Date:   Tue, 2 Apr 2019 08:33:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190402063326.GB7218@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
 <20190328102755.GA26446@innovation.ch>
 <20190328112952.GA2232@kroah.com>
 <20190402024714.GA14213@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402024714.GA14213@innovation.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:47:14PM -0700, Life is hard, and then you die wrote:
> 
> On Thu, Mar 28, 2019 at 12:29:52PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 28, 2019 at 03:27:55AM -0700, Life is hard, and then you die wrote:
> > > 
> > > On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > > > > 
> > > > > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > > > > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > > > > > instead of straight printk() to match other dev_xxx() logging functions.
> > > > > > > ---
> > > > > > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  include/linux/device.h | 15 +++++++++++++++
> > > > > > >  2 files changed, 58 insertions(+)
> [snip]
> > > > > > Anyway, no, please do not do this.  Please do not dump large hex values
> > > > > > like this to the kernel log, it does not help anyone.
> > > > > > 
> > > > > > You can do this while debugging, sure, but not for "real" kernel code.
> > > > > 
> > > > > As used by this driver, it is definitely called for debugging only and
> > > > > must be explicitly enabled via a module param. But having the ability
> > > > > for folks to easily generate and print out debugging info has proven
> > > > > quite valuable.
> > > > 
> > > > We have dynamic debugging, no need for module parameters at all.  This
> > > > isn't the 1990's anymore :)
> > > 
> > > I am aware of dynamic debugging, but there are several issues with it
> > > from the perspective of the logging I'm doing here (I mentioned these
> > > in response to an earlier review already):
> > > 
> > >   1. Dynamic debugging can't be enabled at a function or line level on
> > >      the kernel command line, so this means that to debug issues
> > >      during boot you have to enable everything, which can be way too
> > >      verbose
> > 
> > You can, and should enable it at a function or line level by writing to
> > the proper kernel file in debugfs.
> > 
> > You have read Documentation/admin-guide/dynamic-debug-howto.rst, right?
> 
> Yes, and I've played with the parameters quite a bit.
> 
> > No need to do anything on the command line, that's so old-school :)
> 
> Sorry if I'm being unduly dense, but then how to enable debugging
> during early boot? The only other alternative I see is modifying the
> initrd, and asking folks to do that is noticeably more complicated
> than having them add something to the command line in grub. So from my
> perspective I find kernel params far from old-school :-)

You can do dynamic debugging from the kernel command line, if your code
is built into the kernel (but why would a tiny driver under testing like
this, not be built into the kernel?) what specifically did not work for you?

> > >   2. The expressions to enable the individual logging statements are
> > >      quite brittle (in particular the line-based ones) since they
> > >      (may) change any time the code is changed - having stable
> > >      commands to give to users and put in documentation (e.g.
> > >      "echo 0x200 > /sys/module/applespi/parameters/debug") is
> > >      quite valuable.
> > > 
> > >      One way to work around this would be to put every single logging
> > >      statement in a function of its own, thereby ensuring a stable
> > >      name is associated with each one.
> > 
> > Again, read the documentation, this works today as-is.
> 
> I have read it (we're talking about the dynamic debug docs here), but
> I just don't see how it addresses this in any way.

You can enable/disable logging per-function, which is what you want,
right?


Anyway, I'm glad tracepoints work for you, that should be all that is
now needed.

good luck with your driver!

greg k-h
