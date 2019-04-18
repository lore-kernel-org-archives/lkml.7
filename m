Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FEB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbfDROVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:21:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50270 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2389183AbfDROVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:21:33 -0400
Received: (qmail 2927 invoked by uid 2102); 18 Apr 2019 10:21:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2019 10:21:32 -0400
Date:   Thu, 18 Apr 2019 10:21:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Guenter Roeck <groeck@google.com>,
        Raul Rangel <rrangel@chromium.org>,
        <linux-usb@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>, <zwisler@chromium.org>,
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
In-Reply-To: <20190418065141.GB12503@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1904181011020.1513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Greg Kroah-Hartman wrote:

> On Wed, Apr 17, 2019 at 04:20:09PM -0700, Guenter Roeck wrote:
> > On Wed, Apr 17, 2019 at 3:41 PM Raul Rangel <rrangel@chromium.org> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 03:23:52PM -0700, Guenter Roeck wrote:
> > > > On Wed, Apr 17, 2019 at 3:11 PM Raul Rangel <rrangel@chromium.org> wrote:
> > > > >
> > > > > On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
> > > > > >
> > > > > > This sounds like a golden opportunity!  Submit a separate patch making
> > > > > > the parameter to kobject_uevent_env be const (actually const char *
> > > > > > const []), then submit this patch on top of that one.
> > > > > So there are other parts of the code base that dynamically create their
> > > > > array values. So by making the function take const, it breaks :(
> > > >
> > > > Confused. The calling code can still be non-const. I don't see the
> > > > parameter modified in kobject_uevent_env(), so declaring it const
> > > > should be possible. Can you give an example of code that no longer
> > > > works ?
> > > static int notify_user_space(struct thermal_zone_device *tz, int trip)
> > > {
> > >         char *thermal_prop[5];
> > >         int i;
> > >
> > >         mutex_lock(&tz->lock);
> > >         thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
> > >         thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
> > >         thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
> > >         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
> > >         thermal_prop[4] = NULL;
> > >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> > >         for (i = 0; i < 4; ++i)
> > >                 kfree(thermal_prop[i]);
> > >         mutex_unlock(&tz->lock);
> > >         return 0;
> > > }
> > >
> > > drivers/thermal/user_space.c:48:52: error: passing 'char *[5]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > >         kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
> > >                                                           ^~~~~~~~~~~~
> > > include/linux/kobject.h:238:22: note: passing argument to parameter 'envp' here
> > >                         const char *const envp[]);
> > >                                           ^
> > >
> > > http://c-faq.com/ansi/constmismatch.html explains why it fails.
> > >
> > Interesting. One never stops learning. So the best you could do would
> > be char * const envp[], but I guess that doesn't help much.
> 
> Yeah, I went down this path a year or so ago and had to give it up as
> well :(

Well, the signature could still be changed as Guenter suggests.

And the array being added in the new code could still be static.  
After all, there isn't really any danger that the contents of those
strings will be modified, right?  It's just that the const modifiers
weren't put in until it was too late and there were too many existing
callers.  Perhaps a comment about this could be included in the 
kerneldoc for kobject_uevent_env.

Alan Stern

