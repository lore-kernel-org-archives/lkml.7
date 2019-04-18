Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3776AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26362184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555570311;
	bh=o6LIY6vTs/6i7DC083ZG9ubmbx647t5RSiTUOMQj2hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CTsC+R5kDPQ6BqwNjieumkHVjG3NxdjtwZYFAch0YsOJLZ3Gh1MG4cHUXZwwzsn8u
	 y3Dp3QVHQ7VV3MuBuYVl0UrOHqVOEaWouIOSooO1UKhZJztw8IPinyn45hRIwNxMyu
	 Se3c/iInw92YdrcevC7yv6SXfF5NpuJzZDwsKAQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfDRGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfDRGvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:51:49 -0400
Received: from localhost (ip-213-127-62-114.ip.prioritytelecom.net [213.127.62.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EC420821;
        Thu, 18 Apr 2019 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555570308;
        bh=o6LIY6vTs/6i7DC083ZG9ubmbx647t5RSiTUOMQj2hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMw25KgGfciF0hakANf+3JC6mZgdQz2r5hwzh+6/7khvTVTvCrxoW+jYUyX8qPfQq
         0JYA7C0MT1jl7ADDyhJAkL47SLlYu/NB8cQ7ZhAO090/XL47ooMMU8S/FEma0C0j1/
         O1LYUtEqXuwDROKZStLwPkL1pGXjws69L0Q9NhMM=
Date:   Thu, 18 Apr 2019 08:51:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
Message-ID: <20190418065141.GB12503@kroah.com>
References: <20190417202017.GA204974@google.com>
 <Pine.LNX.4.44L0.1904171635460.1400-100000@iolanthe.rowland.org>
 <CAHQZ30B3+gzuw0=tofwW3yUwJ_MkN6GWPgVg0Qq_6S2tJHkcFQ@mail.gmail.com>
 <CABXOdTcjr6zw9sceC-i_Za3uOaOVmKGFaJsyMxhLUPEhtKn_Jg@mail.gmail.com>
 <20190417224129.GA255388@google.com>
 <CABXOdTeR_91AnhmRoEvVQWMb7_ibWeSuLb=Hwsrnj-swCr7G_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeR_91AnhmRoEvVQWMb7_ibWeSuLb=Hwsrnj-swCr7G_w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:20:09PM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 3:41 PM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Wed, Apr 17, 2019 at 03:23:52PM -0700, Guenter Roeck wrote:
> > > On Wed, Apr 17, 2019 at 3:11 PM Raul Rangel <rrangel@chromium.org> wrote:
> > > >
> > > > On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
> > > > >
> > > > > This sounds like a golden opportunity!  Submit a separate patch making
> > > > > the parameter to kobject_uevent_env be const (actually const char *
> > > > > const []), then submit this patch on top of that one.
> > > > So there are other parts of the code base that dynamically create their
> > > > array values. So by making the function take const, it breaks :(
> > >
> > > Confused. The calling code can still be non-const. I don't see the
> > > parameter modified in kobject_uevent_env(), so declaring it const
> > > should be possible. Can you give an example of code that no longer
> > > works ?
> > static int notify_user_space(struct thermal_zone_device *tz, int trip)
> > {
> >         char *thermal_prop[5];
> >         int i;
> >
> >         mutex_lock(&tz->lock);
> >         thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
> >         thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
> >         thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
> >         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
> >         thermal_prop[4] = NULL;
> >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> >         for (i = 0; i < 4; ++i)
> >                 kfree(thermal_prop[i]);
> >         mutex_unlock(&tz->lock);
> >         return 0;
> > }
> >
> > drivers/thermal/user_space.c:48:52: error: passing 'char *[5]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> >                                                           ^~~~~~~~~~~~
> > include/linux/kobject.h:238:22: note: passing argument to parameter 'envp' here
> >                         const char *const envp[]);
> >                                           ^
> >
> > http://c-faq.com/ansi/constmismatch.html explains why it fails.
> >
> Interesting. One never stops learning. So the best you could do would
> be char * const envp[], but I guess that doesn't help much.

Yeah, I went down this path a year or so ago and had to give it up as
well :(
