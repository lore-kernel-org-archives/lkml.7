Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26CAC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6764A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovMW03G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406802AbfFKU5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:57:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41301 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406712AbfFKU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:57:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so13305992otj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vbIY4qHqvyN4/tBREUMhzOh6FCY5/55fwz+55klQII=;
        b=ovMW03G+zCLOfnAhEGHYErVhlQwlzn5+9bgsLNpszqf6guNCs3YZTgiNNvL6PPlrBh
         eNQJg/t2FFy4OgnvHuFToKee/dz3VyUBmdKtv7EVcznV/VdjinHjyk9IcOHtsAUsvMo8
         hweYK3oTYURuQ7JJ0xxElMbvV4Gz2vN8SOBBLsUfJ5pDBHgA7+zkuepKGOtM56D6KIpF
         0ARsOPcLmFJyap1ckCi+W37dw/yhgkXRkbkiRmXakqpcfM5xQJGGA+jWwbVSABFbUzBP
         fURb0ChbTREG+iR5V/YSWxevoKOIdbJpDQn9hfVSyjvnMKDhPdDJD8djP2KU+4AV7Uic
         wc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vbIY4qHqvyN4/tBREUMhzOh6FCY5/55fwz+55klQII=;
        b=oQwQxNe4+A8uZceN0qaPEVl/qvdP8yF1I/tKAemR0GOahnfccuc5jtemUYUMRbcRMb
         P+N25kiS7zXzJ6ObVUy1S29gesHZR2YANljcW20bCrn3Z86b6AigBDTrqlJdgher8YOL
         847mwa3K+reIx4/WCQZCgnv6w8S/iyLC+B8HCv4pQP/DxyHi/9lIo+NdkqbHz1qzvF7t
         wIjSlU5bBza5y7Yqx1985WEk2K3tZ53yiTdIz6xlnrqgTSGotuyq/Dl8QFGA0CmzV5lR
         muHNDLcNJu9jNg18xmG8EQKya24M7Yo3nVPgBGkpy5dQbmWWWZqmRot49jorCfpMEmw0
         30Cg==
X-Gm-Message-State: APjAAAULJwy3taaGNEtEgw1HmwnKuCZqkcX4zJ9iM/jfxSe8nfxFp8if
        uT/b8ETxG+MxqwKYCgrESqG+b8tSSo36ho2jyoim5g==
X-Google-Smtp-Source: APXvYqxQYYn4atvG8al8XPSt0fLO+jvnyBEQlkbxEs6L+UgJnFwSvs13PAMxOcM4dB6whETBZex0WzwZ4+1Yn2i+GOc=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr35658633otp.225.1560286621268;
 Tue, 11 Jun 2019 13:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com> <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
In-Reply-To: <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 Jun 2019 13:56:25 -0700
Message-ID: <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saravana,
>
> On 6/10/19 10:36 AM, Rob Herring wrote:
> > Why are you resending this rather than replying to Frank's last
> > comments on the original?
>
> Adding on a different aspect...  The independent replies from three different
> maintainers (Rob, Mark, myself) pointed out architectural issues with the
> patch series.  There were also some implementation issues brought out.
> (Although I refrained from bringing up most of my implementation issues
> as they are not relevant until architecture issues are resolved.)

Right, I'm not too worried about the implementation issues before we
settle on the architectural issues. Those are easy to fix.

Honestly, the main points that the maintainers raised are:
1) This is a configuration property and not describing the device.
Just use the implicit dependencies coming from existing bindings.

I gave a bunch of reasons for why I think it isn't an OS configuration
property. But even if that's not something the maintainers can agree
to, I gave a concrete example (cyclic dependencies between clock
provider hardware) where the implicit dependencies would prevent one
of the devices from probing till the end of time. So even if the
maintainers don't agree we should always look at "depends-on" to
decide the dependencies, we still need some means to override the
implicit dependencies where they don't match the real dependency. Can
we use depends-on as an override when the implicit dependencies aren't
correct?

2) This doesn't need to be solved because this is just optimizing
probing or saving power ("we should get rid of this auto disabling"):

I explained why this patch series is not just about optimizing probe
ordering or saving power. And why we can't ignore auto disabling
(because it's more than just auto disabling). The kernel is currently
broken when trying to use modules in ARM SoCs (probably in other
systems/archs too, but I can't speak for those).

3) Concerns about backwards compatibility

I pointed out why the current scheme (depends-on being the only source
of dependency) doesn't break compatibility. And if we go with
"depends-on" as an override what we could do to keep backwards
compatibility. Happy to hear more thoughts or discuss options.

4) How the "sync_state" would work for a device that supplies multiple
functionalities but a limited driver.

I explained how it would work.

> When three maintainers say the architecture has issues, you should step
> back and think hard.  (Not to say maintainers are always correct...)

Yes, the 3 maintainers brought up their concerns and I replied to
explain my viewpoint on their concerns. So I'm waiting for a response
from them before I proceed further. Even if the response is going to
be "we still don't agree with this architecture", I'd prefer at least
some direction on what the maintainers think is the right
architecture. There are a million different ways to solve this. It's
not reasonable to expect people submitting patches to shoot in the
dark and hope it hits what the maintainers have in their mind as
"acceptable solutions". I even proposed some alternatives. So, it'd be
nice to hear the maintainers' thoughts on my responses, alternative
designs or some alternate proposals.

There's a real problem that needs to be solved. Just saying "I don't
like this solution" without suggesting alternatives isn't a
constructive way to improve the kernel.

> My suggestion at this point is that you need to go back to the drawing board
> and re-think how to address the use case.

I'd be happy to and I've been thinking about other ways, but I'd like
some direction from the maintainers before writing a lot of code
that's just going to be completely rejected.

To summarize the options:
1) Use depends-on as the only source of dependency (this patch series)
- Easy to keep backward compatible
- Handles all cases
- Arguable that this is OS configuration

2) Use existing bindings for dependencies, but use "depends-on" for
overriding cases that are incorrect.
- New kernel not backward compatible with old DT. So devices will stop
booting or won't have full functionality.
- Needs some scheme to disabling all dependency tracking to be
backward compatible.
  a) Can have the dependency linking code under CONFIG_XXXXX
  b) Can have a kernel commandline
  c) NEW alternative to CONFIG_XXXX or commandline. Can have an
additional "implicit-dependencies-are-explicit-too" DT property that
can be added to the "choosen" DT node to tell the OS that the implicit
dependencies are valid real dependencies too. Then if they need
overrides, depends-on can be used. So old DT blobs would effectively
have this feature disabled.
- Handles all cases
- Only (c) above could be argued as OS configuration. But I'd argue
that it's clarifying the DT dependencies to be more explicit.

Thanks,
Saravana

> -Frank
>
> >
> > On Mon, Jun 3, 2019 at 6:32 PM Saravana Kannan <saravanak@google.com> wrote:
> >>
> >> Add a pointer from device tree node to the device created from it.
> >> This allows us to find the device corresponding to a device tree node
> >> without having to loop through all the platform devices.
> >>
> >> However, fallback to looping through the platform devices to handle
> >> any devices that might set their own of_node.
> >>
> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> ---
> >>  drivers/of/platform.c | 20 +++++++++++++++++++-
> >>  include/linux/of.h    |  3 +++
> >>  2 files changed, 22 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >> index 04ad312fd85b..1115a8d80a33 100644
> >> --- a/drivers/of/platform.c
> >> +++ b/drivers/of/platform.c
> >> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
> >>         return dev->of_node == data;
> >>  }
> >>
> >> +static DEFINE_SPINLOCK(of_dev_lock);
> >> +
> >>  /**
> >>   * of_find_device_by_node - Find the platform_device associated with a node
> >>   * @np: Pointer to device tree node
> >> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
> >>  {
> >>         struct device *dev;
> >>
> >> -       dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
> >> +       /*
> >> +        * Spinlock needed to make sure np->dev doesn't get freed between NULL
> >> +        * check inside and kref count increment inside get_device(). This is
> >> +        * achieved by grabbing the spinlock before setting np->dev = NULL in
> >> +        * of_platform_device_destroy().
> >> +        */
> >> +       spin_lock(&of_dev_lock);
> >> +       dev = get_device(np->dev);
> >> +       spin_unlock(&of_dev_lock);
> >> +       if (!dev)
> >> +               dev = bus_find_device(&platform_bus_type, NULL, np,
> >> +                                     of_dev_node_match);
> >>         return dev ? to_platform_device(dev) : NULL;
> >>  }
> >>  EXPORT_SYMBOL(of_find_device_by_node);
> >> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
> >>                 platform_device_put(dev);
> >>                 goto err_clear_flag;
> >>         }
> >> +       np->dev = &dev->dev;
> >>
> >>         return dev;
> >>
> >> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
> >>         if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
> >>                 device_for_each_child(dev, NULL, of_platform_device_destroy);
> >>
> >> +       /* Spinlock is needed for of_find_device_by_node() to work */
> >> +       spin_lock(&of_dev_lock);
> >> +       dev->of_node->dev = NULL;
> >> +       spin_unlock(&of_dev_lock);
> >>         of_node_clear_flag(dev->of_node, OF_POPULATED);
> >>         of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
> >>
> >> diff --git a/include/linux/of.h b/include/linux/of.h
> >> index 0cf857012f11..f2b4912cbca1 100644
> >> --- a/include/linux/of.h
> >> +++ b/include/linux/of.h
> >> @@ -48,6 +48,8 @@ struct property {
> >>  struct of_irq_controller;
> >>  #endif
> >>
> >> +struct device;
> >> +
> >>  struct device_node {
> >>         const char *name;
> >>         phandle phandle;
> >> @@ -68,6 +70,7 @@ struct device_node {
> >>         unsigned int unique_id;
> >>         struct of_irq_controller *irq_trans;
> >>  #endif
> >> +       struct device *dev;             /* Device created from this node */
> >>  };
> >>
> >>  #define MAX_PHANDLE_ARGS 16
> >> --
> >> 2.22.0.rc1.257.g3120a18244-goog
> >>
> > .
> >
>
