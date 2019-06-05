Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A54C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3202086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559724498;
	bh=HyxdwhePu475mlk6ZfWQFJ1e0/vC/dpndsU7nAlUZkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtP1qJDaqCkb9GteNl1jypIlGe7NMVFcCnPWJkR9mCpWdCtciCMvk3CnymGTdEdIn
	 380Lr9MHd8doYKGiCa4dX3yw3w2fxTxnCtkdsSSlp3jTDlGVOPckknAX/ngVLBXLjL
	 DAFHWVNhTavYwmKCDHaYG3hltiAqwEFIKnbC4xM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFEIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEIsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:48:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F55E20717;
        Wed,  5 Jun 2019 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559724495;
        bh=HyxdwhePu475mlk6ZfWQFJ1e0/vC/dpndsU7nAlUZkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zo1x6OLHg7ET5lmotN15Plt/iC3RZc8twLZ78TLkoAHz8E0RHd81au12XeM2b4ar/
         0zaMcRqecxtqZrAUbTAd/xRBdX0LTZzvuVWi3gj5Z4efttBdlC/wr8OO5FctuOXcMb
         heeLtgj+9SHL6/1/MFwMO5Ii0OrKq6ASMKgUOALc=
Date:   Wed, 5 Jun 2019 10:48:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
Message-ID: <20190605084813.GA26984@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com>
 <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
 <20190604183527.GA20098@kroah.com>
 <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
 <20190604185953.GA2061@kroah.com>
 <20190605064839.GH4797@dell>
 <20190605080241.GC9693@kroah.com>
 <20190605084002.GP4797@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605084002.GP4797@dell>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 09:40:02AM +0100, Lee Jones wrote:
> On Wed, 05 Jun 2019, Greg Kroah-Hartman wrote:
> 
> > On Wed, Jun 05, 2019 at 07:48:39AM +0100, Lee Jones wrote:
> > > On Tue, 04 Jun 2019, Greg Kroah-Hartman wrote:
> > > > On Tue, Jun 04, 2019 at 11:39:21AM -0700, Guenter Roeck wrote:
> > > > > On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > > > > > > Hey Greg,
> > > > > > >
> > > > > > > > > + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > > > > > > > +          data->misc.name);
> > > > > > > >
> > > > > > > > No need to be noisy, if all goes well, your code should be quiet.
> > > > > > > >
> > > > > > >
> > > > > > > I sometimes wonder about this being noise or not, so I will slightly
> > > > > > > hijack this thread for this discussion.
> > > > > > >
> > > > > > > >From a kernel developer point-of-view, or even from a platform
> > > > > > > developer or user with a debugging hat point-of-view, having
> > > > > > > a "device created" or "device registered" message is often very useful.
> > > > > >
> > > > > > For you, yes.  For someone with 30000 devices attached to their system,
> > > > > > it is not, and causes booting to take longer than it should be.
> > > 
> > > Who has 30,000 devices attached to their systems?
> > 
> > More than you might imagine.
> > 
> > > I would argue that
> > > in these special corner-cases, they should knock the log-level *down*
> > > a notch.  For the rest of us who run normal platforms, an extra second
> > > of boot time renders a more forthcoming/useful system than if each of
> > > our devices initialised silently.
> > > 
> > > Personally I like to know what devices I have on my system, and the
> > > kernel log is the first place I look.  As far as I'm concerned, for
> > > the most part, if it's not in the kernel log, I don't have it.
> > 
> > Then you "do not have" lots of devices, as we have been removing these
> > messages for a number of years now :)
> > 
> > >  "Oh wow, I didn't know I had XXX functionality on this platform."
> > > 
> > > In my real job, I am currently enabling some newly released AArch64
> > > based laptops for booting with ACPI.  I must have wasted a day whilst
> > > enabling some of the devices the system relies upon, just to find
> > > out that 90% of them were actually probing semi-fine (at least probe()
> > > was succeeding), just silently. *grumble*
> > 
> > Yup, that's normal.  If you want to see what devices are in the system,
> > look in /sys/devices/ as that is what it is for, not the kernel log.
> 
> My guess is that less than 1% of Linux users use /sys/devices in this
> way.  It's a very unfriendly interface.  Besides, when enabling a new
> platform, access to sysfs comes too far down the line to be useful in
> the majority of cases.

`lshw` is your friend :)

