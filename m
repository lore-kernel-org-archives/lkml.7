Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DACC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144A20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="MKgtFSRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDGBqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:46:15 -0400
Received: from chill.innovation.ch ([216.218.245.220]:43878 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:46:14 -0400
Date:   Sat, 6 Apr 2019 18:46:13 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch DBF4B640194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1554601573;
        bh=9wof/FF2aLHD2jbpukM8qshm+KALttr6gkDgISFUo0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKgtFSRYF5ZRQTIH1WTmgIFs+qbFFMWC8UKCbSO/EQWlbYM0n1Do5Bv2S8x+2LmoF
         jl7Crj9gYMfJnfRjNO0YmmgoP5xggSDka5jg3Ct+lp7HIcTh4xmO5qAa7wvlze0Y4N
         O0Ej6XaK2hMjJUyWeEJlYRVAlR+vn6ch150L6rTXJfeZmeG588f2H0W+dl9bYVG/Wz
         rUi4Hc73/3PNskPDNgWmol0w7N96c6WfOkvKaz+cz0xdr5YzNJk6zinJ+QWA6gTRkj
         4UPOSlTzBhlf0DG1ZoBBoVeEAL10skIspH85wZ1Upw7zKg9S3t2OWu6cZyS1faFgAW
         1c+bDpAmvw+bg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20190407014613.GA14812@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
 <20190328102755.GA26446@innovation.ch>
 <20190328112952.GA2232@kroah.com>
 <20190402024714.GA14213@innovation.ch>
 <20190402063326.GB7218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402063326.GB7218@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Apr 01, 2019 at 07:47:14PM -0700, Life is hard, and then you die wrote:
> > 
> > On Thu, Mar 28, 2019 at 12:29:52PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 28, 2019 at 03:27:55AM -0700, Life is hard, and then you die wrote:
> > > > 
> > > > On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > > > > > 
> > > > > > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > > > > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > > > > > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > > > > > > instead of straight printk() to match other dev_xxx() logging functions.
> > > > > > > > ---
> > > > > > > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  include/linux/device.h | 15 +++++++++++++++
> > > > > > > >  2 files changed, 58 insertions(+)
> > [snip]
> > > > > > > Anyway, no, please do not do this.  Please do not dump large hex values
> > > > > > > like this to the kernel log, it does not help anyone.
> > > > > > > 
> > > > > > > You can do this while debugging, sure, but not for "real" kernel code.
> > > > > > 
> > > > > > As used by this driver, it is definitely called for debugging only and
> > > > > > must be explicitly enabled via a module param. But having the ability
> > > > > > for folks to easily generate and print out debugging info has proven
> > > > > > quite valuable.
> > > > > 
> > > > > We have dynamic debugging, no need for module parameters at all.  This
> > > > > isn't the 1990's anymore :)
> > > > 
> > > > I am aware of dynamic debugging, but there are several issues with it
> > > > from the perspective of the logging I'm doing here (I mentioned these
> > > > in response to an earlier review already):
> > > > 
> > > >   1. Dynamic debugging can't be enabled at a function or line level on
> > > >      the kernel command line, so this means that to debug issues
> > > >      during boot you have to enable everything, which can be way too
> > > >      verbose
> > > 
> > > You can, and should enable it at a function or line level by writing to
> > > the proper kernel file in debugfs.
> > > 
> > > You have read Documentation/admin-guide/dynamic-debug-howto.rst, right?
> > 
> > Yes, and I've played with the parameters quite a bit.
> > 
> > > No need to do anything on the command line, that's so old-school :)
> > 
> > Sorry if I'm being unduly dense, but then how to enable debugging
> > during early boot? The only other alternative I see is modifying the
> > initrd, and asking folks to do that is noticeably more complicated
> > than having them add something to the command line in grub. So from my
> > perspective I find kernel params far from old-school :-)
> 
> You can do dynamic debugging from the kernel command line, if your code
> is built into the kernel (but why would a tiny driver under testing like
> this, not be built into the kernel?) what specifically did not work for you?

This may be part of our disconnect: there's almost no reason (and
several downsides) to building it into the kernel instead of as a
module:

- When developing, being able to just reload the module instead of
  rebooting is just so much faster and more convenient.

- For other users, having them build the driver as a dkms managed
  module is also by far the simplest and least error-prone approach -
  explaning to users how to rebuild their kernel (something most of
  them have never done) takes a bunch of time and effort on both
  sides for essentially no gain.

- Once the driver is part of the regular kernel, practically all
  distro's will build it as a module (at least I'm fairly certain
  about this).

In the case where a problem happens during early boot, if I can
reproduce myself then of course I can build the driver into the kernel
and debug it; but if I need others to test/debug things, then this is
a much harder sell.

In my experience, every time you make something even a little harder
for a user to do, the chance of them doing it and you getting useful
feedback goes down exponentially and the amount of work you need to do
to handhold them goes up significantly. So I think it's absolutely
vital to try and keep things as simple as possible.

> > > >   2. The expressions to enable the individual logging statements are
> > > >      quite brittle (in particular the line-based ones) since they
> > > >      (may) change any time the code is changed - having stable
> > > >      commands to give to users and put in documentation (e.g.
> > > >      "echo 0x200 > /sys/module/applespi/parameters/debug") is
> > > >      quite valuable.
> > > > 
> > > >      One way to work around this would be to put every single logging
> > > >      statement in a function of its own, thereby ensuring a stable
> > > >      name is associated with each one.
> > > 
> > > Again, read the documentation, this works today as-is.
> > 
> > I have read it (we're talking about the dynamic debug docs here), but
> > I just don't see how it addresses this in any way.
> 
> You can enable/disable logging per-function, which is what you want,
> right?

Yes'ish: the problem is that if they are just part of regular
functions, A) the chances are higher that the function may get renamed
and hence any existing debug instructions broken, and B) this doesn't
work if there are multiple debug statements in a function. Hence my
assertion that for this work well (and yes, it can work well) you
basically need to create a separate function for each debug statement
(which that contains just that debug statement) (a sort of stable
labelling of each debug statement).


  Cheers,

  Ronald

