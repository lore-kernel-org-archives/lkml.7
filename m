Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE57C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B714206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfFFOBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:01:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFFOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:01:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D318E28471A
Message-ID: <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
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
Date:   Thu, 06 Jun 2019 11:01:17 -0300
In-Reply-To: <20190604185953.GA2061@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
         <20190604152019.16100-4-enric.balletbo@collabora.com>
         <20190604155228.GB9981@kroah.com>
         <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
         <20190604183527.GA20098@kroah.com>
         <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
         <20190604185953.GA2061@kroah.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 20:59 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 11:39:21AM -0700, Guenter Roeck wrote:
> > On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > > > Hey Greg,
> > > > 
> > > > > > + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > > > > +          data->misc.name);
> > > > > 
> > > > > No need to be noisy, if all goes well, your code should be quiet.
> > > > > 
> > > > 
> > > > I sometimes wonder about this being noise or not, so I will slightly
> > > > hijack this thread for this discussion.
> > > > 
> > > > > From a kernel developer point-of-view, or even from a platform
> > > > developer or user with a debugging hat point-of-view, having
> > > > a "device created" or "device registered" message is often very useful.
> > > 
> > > For you, yes.  For someone with 30000 devices attached to their system,
> > > it is not, and causes booting to take longer than it should be.
> > > 
> > > > In fact, I wish people would do this more often, so I don't have to
> > > > deal with dynamic debug, or hack my way:
> > > > 
> > > > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > > > index 4589631798c9..473549b26bb2 100644
> > > > --- a/drivers/media/i2c/ov5647.c
> > > > +++ b/drivers/media/i2c/ov5647.c
> > > > @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
> > > >         if (ret < 0)
> > > >                 goto error;
> > > > 
> > > > -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
> > > > +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
> > > >         return 0;
> > > >  error:
> > > >         media_entity_cleanup(&sd->entity);
> > > > 
> > > > In some subsystems, it's even a behavior I'm more or less relying on:
> > > > 
> > > > $ git grep v4l2_info.*registered drivers/media/ | wc -l
> > > > 26
> > > > 
> > > > And on the downsides, I can't find much. It's just one little line,
> > > > that is not even noticed unless you have logging turned on.
> > > 
> > > Its better to be quiet, which is why the "default driver registration"
> > > macros do not have any printk messages in them.  When converting drivers
> > > over to it, we made the boot process much more sane, don't try to go and
> > > add messages for no good reason back in please.
> > > 
> > > dynamic debugging can be enabled on a module and line-by-line basis,
> > > even from the boot command line.  So if you need debugging, you can
> > > always ask someone to just reboot or unload/load the module and get the
> > > message that way.
> > > 
> > 
> > Can we by any chance make this an official policy ? I am kind of tired
> > having to argue about this over and over again.
> 
> Sure, but how does anyone make any "official policy" in the kernel?  :)
> 
> I could just go through and delete all "look ma, a new driver/device!"
> messages, but that might be annoying...
> 

Well, I really need to task.

If it's not an official policy (and won't be anytime soon?), then
what's preventing Enric from pushing this print on this driver,
given he is the one maintaining the code?

Thanks,
Eze

