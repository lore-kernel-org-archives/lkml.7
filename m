Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58FC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8E2187F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbuyOE/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEYCSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 22:18:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35719 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEYCSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 22:18:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so10395913otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X68xijJ/mr9jTs/WXWrWSnVg+jtHvdoSuQi5V5CcSdU=;
        b=vbuyOE/0K7rOlSmMHWNMkmeUiLuEfAa8cY32gxEZs6Ebx8fhCzeZCOfqsvnd4tgqVB
         f6FdFr1Yr1GGs+qiX26pdaThsv2T8Dx7lZ8f0ZAqWZFkAXkPZnukOgH75Le7G5eufkB4
         SorJ0l/SpL2TTYcOc+H8KShWV94tEhJcit74OeqtNdK3Mbt3U5nuSy+Z4W+yRpMqMf6y
         QZZnjKPJc9DwAxcns5pSwBl9qeljdb+9Zhx330nqNwO0BauSuGeA7HhdIxBNS/FX2R0d
         F681P95Up6yM3silsDpVxItwKy1fKB4M7nRkN/qE0mDxxALK0VmAx82W91hak1sd8knG
         pCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X68xijJ/mr9jTs/WXWrWSnVg+jtHvdoSuQi5V5CcSdU=;
        b=fMRD/Pmhy+0hG9N1VnbIlBs+b9tRPXBDibQVCMC+XYQ2GSyH3m8qYQgeaWHXBCvwsy
         yg1mkpCR1rhUGtYnVYZI9X0rZxkSHqBIHRN94FoBRkM0ZZIFBaZmJZFBRGJsbuK3ElA6
         X55V+lyhAQZsRHS8ZEgYyECK1zGXH1QfEkajwQPbocXuipaagv9tE9x1+WY3pYF1VbTg
         xJaN/y5Xzpyb/tejxcXT/fEpigwwAUJ7L8m/Vy/vS97PhEwCCuFhDd+IBh38KteC8hLJ
         VUFWrA8cs1ed5yr8gJsVwrSLZrAGUz9xrZPbdJfIdh/CrUETNOzWtQ4LtCh6PwrLAPUt
         3i4A==
X-Gm-Message-State: APjAAAWFWu/e2899VamNfVKcOm/l+Gjsu9ahUAApcPsNeYaOiWwDMz2p
        mRAzSn6TyAdWX9lONtKiw6ypIJ5wrab5HEPfSisiGQ==
X-Google-Smtp-Source: APXvYqzdN31VJOJtTGf2vNgXlxO2SlAU1/CU/AhpSqTiKos6ghMoDgzFE5JLNCSlR9sTee4KK3ZWd7IucJTlduoYN2s=
X-Received: by 2002:a9d:4047:: with SMTP id o7mr30836834oti.231.1558750686391;
 Fri, 24 May 2019 19:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <20190524055217.GC31664@kroah.com>
In-Reply-To: <20190524055217.GC31664@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 May 2019 19:17:30 -0700
Message-ID: <CAGETcx9MS+B3M2uoeZrpBmnCDGNHk480=eu3iyvdixM5-+OiXg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 23, 2019 at 06:01:11PM -0700, Saravana Kannan wrote:
> > Add a generic "depends-on" property that allows specifying mandatory
> > functional dependencies between devices. Add device-links after the
> > devices are created (but before they are probed) by looking at this
> > "depends-on" property.
> >
> > This property is used instead of existing DT properties that specify
> > phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> > is because not all resources referred to by existing DT properties are
> > mandatory functional dependencies. Some devices/drivers might be able
> > to operate with reduced functionality when some of the resources
> > aren't available. For example, a device could operate in polling mode
> > if no IRQ is available, a device could skip doing power management if
> > clock or voltage control isn't available and they are left on, etc.
> >
> > So, adding mandatory functional dependency links between devices by
> > looking at referred phandles in DT properties won't work as it would
> > prevent probing devices that could be probed. By having an explicit
> > depends-on property, we can handle these cases correctly.
> >
> > Having functional dependencies explicitly called out in DT and
> > automatically added before the devices are probed, provides the
> > following benefits:
> >
> > - Optimizes device probe order and avoids the useless work of
> >   attempting probes of devices that will not probe successfully
> >   (because their suppliers aren't present or haven't probed yet).
> >
> >   For example, in a commonly available mobile SoC, registering just
> >   one consumer device's driver at an initcall level earlier than the
> >   supplier device's driver causes 11 failed probe attempts before the
> >   consumer device probes successfully. This was with a kernel with all
> >   the drivers statically compiled in. This problem gets a lot worse if
> >   all the drivers are loaded as modules without direct symbol
> >   dependencies.
> >
> > - Supplier devices like clock providers, regulators providers, etc
> >   need to keep the resources they provide active and at a particular
> >   state(s) during boot up even if their current set of consumers don't
> >   request the resource to be active. This is because the rest of the
> >   consumers might not have probed yet and turning off the resource
> >   before all the consumers have probed could lead to a hang or
> >   undesired user experience.
> >
> >   Some frameworks (Eg: regulator) handle this today by turning off
> >   "unused" resources at late_initcall_sync and hoping all the devices
> >   have probed by then. This is not a valid assumption for systems with
> >   loadable modules. Other frameworks (Eg: clock) just don't handle
> >   this due to the lack of a clear signal for when they can turn off
> >   resources. This leads to downstream hacks to handle cases like this
> >   that can easily be solved in the upstream kernel.
> >
> >   By linking devices before they are probed, we give suppliers a clear
> >   count of the number of dependent consumers. Once all of the
> >   consumers are active, the suppliers can turn off the unused
> >   resources without making assumptions about the number of consumers.
> >
> > By default we just add device-links to track "driver presence" (probe
> > succeeded) of the supplier device. If any other functionality provided
> > by device-links are needed, it is left to the consumer/supplier
> > devices to change the link when they probe.
>
> Somewhere in this wall of text you need to say:
>         MAKES DEVICES BOOT FASTER!
> right?  :)

I'm sure it will, but I can't easily test and measure this number
because I don't have a device with 100s of devices (common in mobile
SoCs) where I can load all the drivers as modules and are supported
upstream. And the current ones I have mostly workaround this in their
downstream tree by manually ordering with initcalls and link order.
But I see the avoidance of useless probes that'll fail as more of a
free side benefit and not the main goal of this patch series. Getting
modules to actually work and crash the system while booting is the
main goal.

> So in short, this solves the issue of deferred probing with systems with
> loads of modules for platform devices and device tree, in that now you
> have a chance to probe devices in the correct order saving loads of busy
> loops.

Yes, definitely saves loads of busy work.

> A good thing, I like this, very nice work, all of these are:
>         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

> but odds are I'll take this through my tree, so I'll add my s-o-b then.
> But only after the DT people agree on the new entry.

Yup! Trying to do that. :)

-Saravana
