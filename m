Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE83215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHAapob+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH3EdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:33:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43341 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3EdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:33:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so4356736oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dckypzty3MXWBDTJpI2rCDfqM2cRZodYiUO2dmQlaCU=;
        b=sHAapob+H6miA+mQX2BYVpewzufVv5Y3FsO5WLoWbQmnWUzrZF3K7h2nU/aPZhOcHM
         l1tsF1fCipcFwY5jGWnzgW0IY7CF+gEYDQelZBODttt5Hq1ITiJgV8jsB/KZFVFA5AKh
         kzdEGdI2OA/voVvEmjd2+5zj3j3KnQcZzEc9/pC+d/4m3sMG9XhJXFPHDCc5SZ6DbFJ/
         dQhuoP/YICeX4pe1w0avEbbBV5MzNWP+ChlcVNSwDVpM2M3CA4G1RHsP7wGtgEePpEQI
         xgZYtn6Iiwgli4XRRlcD2XLUkN/nFRs704vOV8FzICvXFitzppTFRPPOLoaINjm9IxQp
         xmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dckypzty3MXWBDTJpI2rCDfqM2cRZodYiUO2dmQlaCU=;
        b=XlipqxbXIW45uw2Vf4AkGK1w6y+/TXUBk9ygPFuJOaicyyKZwQll3tPXQLqd38dhyh
         VatiixmsZ9sSN5PiCmNCSoIx5c4CrEjsMhYgZBMR2gflripW/nXe1JpYagZwkCq5ch/v
         DTZNkloawcmZTaL0w8Hti7pzEFoRkL1+J4uqFzBxD9QvmQbc0OjBNo64fB0vGov+rSal
         hJcVqALTtGAgf6dqu5BBbux6MxfiEaFHpCE0cefuaS8Gg7u5rA5l70/x92plvDCQt6Qk
         kpi1PgJ5tITl9jFKSLxm74SaiNxPfID75LQ7hy/zYmI17fWoFHmEnlW0vQNrWEwTTlXZ
         t9+Q==
X-Gm-Message-State: APjAAAX6tsj0Il6drQ1q1a7RVox1G0oyX9B2KaywnFk9+KYw/Qdn7Fq2
        XFGxQ0oVqjhGOnhDgnddswgaNLWpvs+xtEKb9hqxrw==
X-Google-Smtp-Source: APXvYqz+dnW0egNjofi/hbg61kqJwdkaAieyvb4VrFqONk/EHwkfUQ2t1veZKRT/Mr49JwMorSR7uXbSuHFt543L/vw=
X-Received: by 2002:aca:cc81:: with SMTP id c123mr9117245oig.30.1567139582896;
 Thu, 29 Aug 2019 21:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190829074603.70424-1-saravanak@google.com> <CAL_Jsq+2vR75ofq=aKOt1bb1T-JfhiGSR9dnHWQf7VLmgJP4eA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2vR75ofq=aKOt1bb1T-JfhiGSR9dnHWQf7VLmgJP4eA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 29 Aug 2019 21:32:26 -0700
Message-ID: <CAGETcx_8AS8AVB-95vSzXXC=Rs0+0sp3OnJvFWXWtwEn-wH-ew@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Solve postboot supplier cleanup and optimize
 probe ordering
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:43 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 2:46 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add device-links to track functional dependencies between devices
> > after they are created (but before they are probed) by looking at
> > their common DT bindings like clocks, interconnects, etc.
> >
> > Having functional dependencies automatically added before the devices
> > are probed, provides the following benefits:
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
> > - Supplier devices like clock providers, interconnect providers, etc
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
> >
> > v1 -> v2:
> > - Drop patch to speed up of_find_device_by_node()
> > - Drop depends-on property and use existing bindings
> >
> > v2 -> v3:
> > - Refactor the code to have driver core initiate the linking of devs
> > - Have driver core link consumers to supplier before it's probed
> > - Add support for drivers to edit the device links before probing
> >
> > v3 -> v4:
> > - Tested edit_links() on system with cyclic dependency. Works.
> > - Added some checks to make sure device link isn't attempted from
> >   parent device node to child device node.
> > - Added way to pause/resume sync_state callbacks across
> >   of_platform_populate().
> > - Recursively parse DT node to create device links from parent to
> >   suppliers of parent and all child nodes.
> >
> > v4 -> v5:
> > - Fixed copy-pasta bugs with linked list handling
> > - Walk up the phandle reference till I find an actual device (needed
> >   for regulators to work)
> > - Added support for linking devices from regulator DT bindings
> > - Tested the whole series again to make sure cyclic dependencies are
> >   broken with edit_links() and regulator links are created properly.
> >
> > v5 -> v6:
> > - Split, squashed and reordered some of the patches.
> > - Refactored the device linking code to follow the same code pattern for
> >   any property.
> >
> > v6 -> v7:
> > - No functional changes.
> > - Renamed i to index
> > - Added comment to clarify not having to check property name for every
> >   index
> > - Added "matched" variable to clarify code. No functional change.
> > - Added comments to include/linux/device.h for add_links()
> >
> > v7 -> v8:
> > - Rebased on top of linux-next to handle device link changes in [1]
> >
> > v8 -> v9:
> > - Fixed kbuild test bot reported errors (docs and const)
> >
> > v9->v10:
> > - Changes made based on reviews on LKML [2] and discussions at ELC [3]
> > - Dropped the edit_links() patch
> > - Dropped the patch that skips linking for default bus nodes
> > - 1/7: Changed from bus.add_links() to fwnode.ops.add_links()
> > - 1/7: Update device link doc
> > - 1/7: Lots of comments/fn doc updates
> > - 1/7: Renamed device_link_check_waiting_consumers() to
> >   device_link_add_missing_supplier_links()
> > - 2/7: Moved DT parsing/linking code from of/platform.c to of/property.c
>
> Why? You'll notice that of/property.c doesn't know anything about
> platform_device (and struct device):
>
> $ git grep platform_device -- drivers/of/property.c
> $
>
> Everything related to platform_device goes in of/platform.c.
> Everything related to struct device only goes in of/device.c. I'd be
> okay with a new file for this too.

The only platform_device related code in what got moved to
of/property.c is the call to of_find_device_by_node(). And that's
because I forgot that function returns a platform_device --- it should
really have been called of_find_plat_device_by_node() or something
similar. Outside of that, of/property.c makes sense because that's
where the fwnode ops are implemented.

As you mentioned in the other email, just searching platform_bus is
not sufficient. So I'll have to figure something out for that. Once I
do, I think the code will be fine in of/property.c as it shouldn't
have any reference to platform_device.

Thanks for catching what I missed.

-Saravana
