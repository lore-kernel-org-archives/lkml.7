Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4BB2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbwBBogW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDSje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:39:34 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34164 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:39:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id x32so5795337ybh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEYFHkQ0mazxlXM0U85DazJ5Q/aJSXrrU//QANYnijI=;
        b=tbwBBogWv+4rI4JsFgo28vMCfZalzhmDVZs0LDLiSBLk6pw11drlmm4rBeaXPYEyOn
         4LGg3mq/GYNCRN8TRQAfeBf/tLlcWG2fgZqMqGPbd1QsdCSnQkL8xgeA2bU8clXBtRO4
         YnTE3TM6f+HsZtulx4owmzsm3Tf+z1tqKY4uVlvRSdb6oDKj0vTZMVVRXfxVzk988Jzq
         J9uYSNpYt1nGwuIGXkRSudBotMF5J5reVGWpvB/I4kXWVZRMBADfe9KLAbkZ40H1HNhF
         nA8Al2vhwp3TD0rcRExjMGOq7hXFGNdgENIe7DQvK0nRQH/h7Nt9RykvEjIKYFUBimUk
         dnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEYFHkQ0mazxlXM0U85DazJ5Q/aJSXrrU//QANYnijI=;
        b=rPCmh7wM3alm0MGL3g1MM1K2vvV4XmgtEby5ubXr4vVyJeLg4KJEfC/gGENBJWjvQL
         YTsCzDJxe7YCJ+2njlJNT6Cw4gfQPU+Oi/LVFdmut+oDv+GPjsk4ybHqhSsabBDTyHm5
         NIIx8ItlskiZwh5wRCOy6uMgYPLo5Xc6EokwXUtVBfYrwyiRgM30LNfbgKqkPm0LytGc
         vimjuzKwgWbwMgq5XNwNuy0FapKUKPKa5fHZgmO5UcNi2M0CmTAX4Hd4Nx1zDKr1puR9
         SGnC74t4LTsO1tbnxKNg0sQ3AwVOY1HaLQNORDKAMGP9lbLReCYA7HLo0y+ab6dDTg/P
         tUow==
X-Gm-Message-State: APjAAAWjnpJ0Uba98Lv1fnmQvXDQ98EP9imP8AmU4Y6TPCvWMsdgX/K6
        qkOq8JRrLkRbkqZbIyh4sGepYaIqQ0M8jbGW4zuqNQ==
X-Google-Smtp-Source: APXvYqzR6MhUaMTsP9QSNF2LgKsm8ly0cDW1u/W7ke3pXwdYq6TaZ1NByyiBJfUm88s+zklDeqLqOdVT3kCjdwmQyFM=
X-Received: by 2002:a25:a562:: with SMTP id h89mr4257101ybi.208.1559673572837;
 Tue, 04 Jun 2019 11:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com> <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com> <20190604183527.GA20098@kroah.com>
In-Reply-To: <20190604183527.GA20098@kroah.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 4 Jun 2019 11:39:21 -0700
Message-ID: <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > Hey Greg,
> >
> > > > + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > > +          data->misc.name);
> > >
> > > No need to be noisy, if all goes well, your code should be quiet.
> > >
> >
> > I sometimes wonder about this being noise or not, so I will slightly
> > hijack this thread for this discussion.
> >
> > >From a kernel developer point-of-view, or even from a platform
> > developer or user with a debugging hat point-of-view, having
> > a "device created" or "device registered" message is often very useful.
>
> For you, yes.  For someone with 30000 devices attached to their system,
> it is not, and causes booting to take longer than it should be.
>
> > In fact, I wish people would do this more often, so I don't have to
> > deal with dynamic debug, or hack my way:
> >
> > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > index 4589631798c9..473549b26bb2 100644
> > --- a/drivers/media/i2c/ov5647.c
> > +++ b/drivers/media/i2c/ov5647.c
> > @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
> >         if (ret < 0)
> >                 goto error;
> >
> > -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
> > +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
> >         return 0;
> >  error:
> >         media_entity_cleanup(&sd->entity);
> >
> > In some subsystems, it's even a behavior I'm more or less relying on:
> >
> > $ git grep v4l2_info.*registered drivers/media/ | wc -l
> > 26
> >
> > And on the downsides, I can't find much. It's just one little line,
> > that is not even noticed unless you have logging turned on.
>
> Its better to be quiet, which is why the "default driver registration"
> macros do not have any printk messages in them.  When converting drivers
> over to it, we made the boot process much more sane, don't try to go and
> add messages for no good reason back in please.
>
> dynamic debugging can be enabled on a module and line-by-line basis,
> even from the boot command line.  So if you need debugging, you can
> always ask someone to just reboot or unload/load the module and get the
> message that way.
>

Can we by any chance make this an official policy ? I am kind of tired
having to argue about this over and over again.

Thanks,
Guenter
