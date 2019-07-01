Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE526C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C31205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXaJfoYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGAWJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:09:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42430 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGAWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:09:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so11295862oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbR5Q7Rsjr5miu2k4pfRshqc5qKQ4Xv/jCcOFpyIWLY=;
        b=gXaJfoYA37nRGHtzF2TG5HBQXfWSPJL8KdLZ1AooZC+HQ7bcYvyxk1gA/4XYKB36Zu
         iXgs+Rs1GyPbvePlt3hWagC1uvot1XzlxKvVmWY4njbm+E5+rIQX0vqVYjxqmy+DERXe
         MfDRn5BBA7dH5sBOU4agHOYIdFxokS+/yvckxmA3Chh7YO0XkiMyluCg2TMcM8LtoDtG
         b0HkrdCGqngkzh0EBR10fScd2mHCZHdL5irkv5d5KegTjUVxjty38k9OOvOlkpwzkZBg
         B405TzbTWmN9fZ0hIrEaE76rYAZI+CLpY8mobk1KWnXH5KgHP9nF3jTyMSLc0lFmktr+
         liXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbR5Q7Rsjr5miu2k4pfRshqc5qKQ4Xv/jCcOFpyIWLY=;
        b=Mm0ZSbcjA+dKili13b7J+VF8Os+1eTLIob6JUIgy6TxosmeTW5MKn6nzfDW+97a+nl
         31qS0OCx5IEvc6B8MNlQKlUFdgsOd1k+5k2wGNJDClER+n63kJUi2IT9gjn/0PMXdV/V
         9AXN9Qxxlx8KJDUWJMlJtQSKEDzmH90TwygdjWXQze6rt5B9hNN6XzS1rrG3V3QyFv/U
         uESsYEeTAdLyudNZjvUbDNvO6sQotkpem7n/Vsk7Tl4gFA8FD6SsECDvGjGjm/w3Qwxk
         3qCCwIlTmimLSNj3xSbZLyvQk48hskUsX/i4LRxHT8WlzKzc54QSKFWY3KEpTX7r3fYb
         l8MA==
X-Gm-Message-State: APjAAAWyiPwpk/Vh8Jt6/INnfcc6O448Akgj9gk0en+akFG+W3XngXDc
        sd423v6cyOhG/yHwjiMNdmATmhgy8gzqH03+N46Kag==
X-Google-Smtp-Source: APXvYqzAS9pXuqX9dUKUDnX2FvoV0aG9rENyxS21YcP2HLjSnGQ4sTLsyoXYXN3Siybnfemi7DF2IttmXl4i+vyBLR0=
X-Received: by 2002:aca:51d3:: with SMTP id f202mr1048845oib.69.1562018986423;
 Mon, 01 Jul 2019 15:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190628022202.118166-1-saravanak@google.com> <20190628022202.118166-3-saravanak@google.com>
 <d97de5ef-68a3-795f-2532-24da8cd2d130@codeaurora.org>
In-Reply-To: <d97de5ef-68a3-795f-2532-24da8cd2d130@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Jul 2019 15:09:10 -0700
Message-ID: <CAGETcx9+tSq-24bok16Ry_YPRXC0AQDpnxZ5w8HLCaUyBsSOfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] of/platform: Add functional dependency link from
 DT bindings
To:     David Collins <collinsd@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:55 PM David Collins <collinsd@codeaurora.org> wrote:
>
> Hello Saravana,
>
> On 6/27/19 7:22 PM, Saravana Kannan wrote:
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 04ad312fd85b..8d690fa0f47c 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -61,6 +61,72 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
> >  EXPORT_SYMBOL(of_find_device_by_node);
> >
> >  #ifdef CONFIG_OF_ADDRESS
> > +static int of_link_binding(struct device *dev, char *binding, char *cell)
> > +{
> > +     struct of_phandle_args sup_args;
> > +     struct platform_device *sup_dev;
> > +     unsigned int i = 0, links = 0;
> > +     u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > +
> > +     while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
> > +                                        &sup_args)) {
> > +             i++;
> > +             sup_dev = of_find_device_by_node(sup_args.np);
> > +             if (!sup_dev)
> > +                     continue;
>
> This check means that a required dependency link between a consumer and
> supplier will not be added in the case that the consumer device is created
> before the supply device.  If the supplier device is created and
> immediately bound to its driver after late_initcall_sync(), then it is
> possible for the sync_state() callback of the supplier to be called before
> the consumer gets a chance to probe since its link was never captured.

Yeah, I was aware of this but wasn't sure how likely this case was. I
didn't want to go down the rabbit hole of handling every corner case
perfectly before seeing how the general idea was received by the
maintainers. Also, was waiting to see if someone complained about it
before trying to fix it.

> of_platform_default_populate() below will only create devices for the
> first level DT nodes directly under "/".  Suppliers DT nodes can exist as
> second level nodes under a first level bus node (e.g. I2C, SPMI, RPMh,
> etc).  Thus, it is quite likely that not all supplier devices will have
> been created when device_link_check_waiting_consumers() is called.

Yeah, those are all good example of when this could be an issue.

> As far as I can tell, this effectively breaks the sync_state()
> functionality (and thus proxy un-voting built on top of it) when using
> kernel modules for both the supplier and consumer drivers which are probed
> after late_initcall_sync().  I'm not sure how this can be avoided given
> that the linking is done between devices in the process of sequentially
> adding devices.  Perhaps linking between device nodes instead of devices
> might be able to overcome this issue.

I'm not sure linking struct device_node would be useful here. There
are different and simpler ways of fixing it. Working on them right now
(v3 patch series). Thanks for bringing up the good examples.

>
>
> > +             if (device_link_add(dev, &sup_dev->dev, dl_flags))
> > +                     links++;
> > +             put_device(&sup_dev->dev);
> > +     }
> > +     if (links < i)
> > +             return -ENODEV;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * List of bindings and their cell names (use NULL if no cell names) from which
> > + * device links need to be created.
> > + */
> > +static char *link_bindings[] = {
> > +#ifdef CONFIG_OF_DEVLINKS
> > +     "clocks", "#clock-cells",
> > +     "interconnects", "#interconnect-cells",
> > +#endif
> > +};
>
> This list and helper function above are missing support for regulator
> <arbitrary-consumer-name>-supply properties.  We require this support on
> QTI boards in order to handle regulator proxy un-voting when booting with
> kernel modules.  Are you planning to add this support in a follow-on
> version of this patch or in an additional patch?

Yes, I intentionally left out regulators here because it's a huge can
of worms. But keep in mind, that even without adding regulator DT
binding handling here, you could still switch to sync_state callback
and be no worse than you are today. Once regulator supplier-consumer
linking is added/improved, the QTI boards would start working with
modules.

As for how regulators supplier-consumer linking is handled, I think
that's the one we need to discuss and figure out. But I don't think
the regulator binding necessarily has to be handled in this patch
series. I'm sure in general the number of bindings we support could be
improved over time.

>
> Note that handling regulator supply properties will be very challenging
> for at least these reasons:
>
> 1. There is not a consistent DT property name used for regulator supplies.

Yup. Maybe we can add a new regulator binding format with a more
consistent name (like clocks and interconnects) and deprecate the
older ones? Seems like a need binding clean up in general.

> 2. The device node referenced in a regulator supply phandle is usually not
> the device node which correspond to the device pointer for the supplier.
> This is because a single regulator supplier device node (which will have
> an associated device pointer) typically has a subnode for each of the
> regulators it supports.  Consumers then use phandles for the subnodes.

If I'm not mistaken, looks like this can be multiple sub-nodes deep
too. One option is to walk up the phandle till we find a compatible
string and then find the device for that node?

> 3. The specification of parent supplies for regulators frequently results
> in *-supply properties in a node pointing to child subnodes of that node.
>  See [1] for an example.  Special care would need to be taken to avoid
> trying to mark a regulator supplier as a supplier to itself as well as to
> avoid blocking its own probing due to an unlinked supply dependency.

Sigh... as if it's not already complicated enough. Anyway,
device_link_add() already has a bunch of check to avoid creating
cyclic dependencies, etc. So, I'd expect this to be handled already.
At worst case, we might need to add a few more checks there. But that
hopefully shouldn't be an issue.

> 4. Not all DT properties of the form "*-supply" are regulator supplies.
> (Note, this case has been discussed, but I was not able to locate an
> example of it.)

Yup and I hate this part. Not sure what to say.

> Clocks also have a problem.  A recent patch [2] allows clock provider
> parent clocks to be specified via DT.  This could lead to cases of
> circular "clocks" property dependencies where there are two clock supplier
> devices A and B with A having some clocks with B clock parents along with
> B having some clocks with A clock parents.  If "clocks" properties are
> followed, then neither device would ever be able to probe.

Interconnects have a similar problem too because every interconnect
lists all the other interconnects it's connected to. Even if that's
magically addressed correctly, interconnect consumers still have a
problem because "interconnect" DT binding only lists phandles of the
source and destination interconnect and not all the interconnect along
the way. So they will be missing dependencies.

In general I agree with your points about clocks. I've brought this up
multiple times, but the maintainers insists I first implement parsing
existing DT bindings. So, I've done that. Lets see what they have to
say now.

But I have a few more ideas for handling circular dependencies without
adding new DT bindings that might work (will send out as part of v3
patch series) but interconnects are still an issue.

> This does not present a problem without this patch series because the
> clock framework supports late binding of parents specifically to avoid
> issues with clocks not registering in perfectly topological order of
> parent dependencies.

That's why I added the OF_DEVLINKS config. As of v2, you simply can't
use it for SoC/boards with cyclic clock dependencies. But again,
sync_state is no worse that what's there today. And it'll only improve
over time.

-Saravana

> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc0c209c147f35ed2648adda09db39fcad89e334
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
