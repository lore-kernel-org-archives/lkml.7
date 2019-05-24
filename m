Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08E82175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VT1xGEAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfEXSWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:22:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43541 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEXSWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:22:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id t187so7707698oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzsUvNhNmYGXh2gveKRsBtTMYNDsbt9ziXNPjdB7M3w=;
        b=VT1xGEAc/iHBTFQl7pGVdO6yQIUBfThvbSMqKAyp4s+0paXIeVbLzTs0Cnq+ntzjKF
         KIF0eEmk7HwUm7QdOseVndHUZ2oZKT6xA+V0utgk8fFOxTIgg5NyAQCQM2IGihJ6gQh7
         iWMKuBsgxfmDMMp5TI5GyOAO8YnTTSTK2+w7IuFFWB4GnZBGPeb0DAf8Qk06NNJpjWl1
         vUczYe1W68fyBvNxXfEefjptaOXRaKpbBoEDDBWT6wzxVc0mJ3qDCb+RTqc1PZGwWmgQ
         SlvD+zna1fvUolanJK7g4rs9Uq5FQJbRJsBP2+5HTww8zr+L9TN7ACgOzTqH7h5lMrD9
         C0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzsUvNhNmYGXh2gveKRsBtTMYNDsbt9ziXNPjdB7M3w=;
        b=IVmVI6zElTMDrgR3yfqWA+EEzjOXzFvzo+qoAW8EeXhKUYC2vs6wW/uaDe6NSxO5rl
         72jwNLorRGVKri16mmjAL0CeZnnrjzE0/JLhmkCCA1k88x9lpj8nL29HaJnGT5HbQS34
         yynX42DlGlvIcdw3efhORNPEF5Zm9oISyNX46oBiFRtGmaTbHHKL/ktqa6wDKTVFLYKs
         lro+AUxbnAUdI9ff+eUqnYW1y00BS0OYIYvqgez5WjO3WImx3lePVJ+VIC/QYUVlK/Sp
         ACtAYf2eZ3JRAawTYeUP8m53UZABLnlZ96lgD8sGisBgyzRaC40OniSPIWjcONvS7kQu
         WR9w==
X-Gm-Message-State: APjAAAXtuf+q3WwqvdRLdOQvpx9OzvrTN1st7Uk1nkH1S0zScURP1xdm
        bAGSycLZfVCsLkBxOhIywOBCapEgngqWbF7y+pwnEg==
X-Google-Smtp-Source: APXvYqzkQClO4XvpXZ50ceCMrYCltgGccwvH2j5Q3vXCGfEu+lWclzI1rD7nuR63YZMKN0fre4w/3W8l5M4GQOFqSw4=
X-Received: by 2002:aca:da45:: with SMTP id r66mr561054oig.24.1558722129326;
 Fri, 24 May 2019 11:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <20190524010117.225219-2-saravanak@google.com>
 <6f4ca588-106f-93d1-8579-9e8d32c8031d@gmail.com>
In-Reply-To: <6f4ca588-106f-93d1-8579-9e8d32c8031d@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 May 2019 11:21:33 -0700
Message-ID: <CAGETcx9zgMs5ne3jPa+6xR+EHR=+QuF7XfRb1gpenh-3ZQwV+w@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Sarvana,
>
> I'm not reviewing patches 1-5 in any detail, given my reply to patch 0.
>
> But I had already skimmed through this patch before I received the
> email for patch 0, so I want to make one generic comment below,
> to give some feedback as you continue thinking through possible
> implementations to solve the underlying problems.

Appreciate the feedback Frank!

>
>
> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> > Add a pointer from device tree node to the device created from it.
> > This allows us to find the device corresponding to a device tree node
> > without having to loop through all the platform devices.
> >
> > However, fallback to looping through the platform devices to handle
> > any devices that might set their own of_node.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/platform.c | 20 +++++++++++++++++++-
> >  include/linux/of.h    |  3 +++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 04ad312fd85b..1115a8d80a33 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
> >       return dev->of_node == data;
> >  }
> >
> > +static DEFINE_SPINLOCK(of_dev_lock);
> > +
> >  /**
> >   * of_find_device_by_node - Find the platform_device associated with a node
> >   * @np: Pointer to device tree node
> > @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
> >  {
> >       struct device *dev;
> >
> > -     dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
> > +     /*
> > +      * Spinlock needed to make sure np->dev doesn't get freed between NULL
> > +      * check inside and kref count increment inside get_device(). This is
> > +      * achieved by grabbing the spinlock before setting np->dev = NULL in
> > +      * of_platform_device_destroy().
> > +      */
> > +     spin_lock(&of_dev_lock);
> > +     dev = get_device(np->dev);
> > +     spin_unlock(&of_dev_lock);
> > +     if (!dev)
> > +             dev = bus_find_device(&platform_bus_type, NULL, np,
> > +                                   of_dev_node_match);
> >       return dev ? to_platform_device(dev) : NULL;
> >  }
> >  EXPORT_SYMBOL(of_find_device_by_node);
> > @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
> >               platform_device_put(dev);
> >               goto err_clear_flag;
> >       }
> > +     np->dev = &dev->dev;
> >
> >       return dev;
> >
> > @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
> >       if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
> >               device_for_each_child(dev, NULL, of_platform_device_destroy);
> >
> > +     /* Spinlock is needed for of_find_device_by_node() to work */
> > +     spin_lock(&of_dev_lock);
> > +     dev->of_node->dev = NULL;
> > +     spin_unlock(&of_dev_lock);
> >       of_node_clear_flag(dev->of_node, OF_POPULATED);
> >       of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 0cf857012f11..f2b4912cbca1 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -48,6 +48,8 @@ struct property {
> >  struct of_irq_controller;
> >  #endif
> >
> > +struct device;
> > +
> >  struct device_node {
> >       const char *name;
> >       phandle phandle;
> > @@ -68,6 +70,7 @@ struct device_node {
> >       unsigned int unique_id;
> >       struct of_irq_controller *irq_trans;
> >  #endif
> > +     struct device *dev;             /* Device created from this node */
>
> We have actively been working on shrinking the size of struct device_node,
> as part of reducing the devicetree memory usage.  As such, we need strong
> justification for adding anything to this struct.  For example, proof that
> there is a performance problem that can only be solved by increasing the
> memory usage.

I didn't mean for people to focus on the deferred probe optimization.
In reality that was just a added side benefit of this series. The main
problem to solve is that of suppliers having to know when all their
consumers are up and managing the resources actively, especially in a
system with loadable modules where we can't depend on the driver to
notify the supplier because the consumer driver module might not be
available or loaded until much later.

Having said that, I'm not saying we should go around and waste space
willy-nilly. But, isn't the memory usage going to increase based on
the number of DT nodes present in DT? I'd think as the number of DT
nodes increase it's more likely for those devices have more memory? So
at least in this specific case I think adding the field is justified.

Also, right now the look up is O(n) complexity and if we are trying to
add device links to most of the devices, that whole process becomes
O(n^2). Having this field makes the look up a O(1) and the entire
linking process a O(n) process. I think the memory usage increase is
worth the efficiency improvement.

And if people are still strongly against it, we could make this a config option.

-Saravana
