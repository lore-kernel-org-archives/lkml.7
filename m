Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4511CC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E659208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmiFv7V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHJFB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:01:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43191 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJFB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:01:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so40270246otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0zVoEOHWPMFosbH6oHrG9O8bjJrFo4rqHy8Qx2QfP8=;
        b=GmiFv7V+0Nt/u1XK0bnAr8sqFWQDr5zeXHuejgh+gSJ63xO3g84Im4O8cDORSqALoV
         1zKXqXR8hrsLH00F6Fe1Hgi46OAJEuyWCwvyRoYTBN4UKeGxEvN2In4Y4gQcQCZMBWBf
         tMEUGglqsv+jXUJq8eyHWCxm3adNSwmmQGdje4jk2gWn7yZt67IkWommdtM/shGHvVXZ
         EjGqhE1narY/UG57eObhS9utiJoTzRtOJbzecWcOTSEdr2aU+VGJzpApxPQAsIOI7G/z
         0y9wetYXVma858avEGVvr4+hqQOrFrswnsKpMy4cAHHYTq72sNf3wzDKGElhi2sLtrrG
         hLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0zVoEOHWPMFosbH6oHrG9O8bjJrFo4rqHy8Qx2QfP8=;
        b=kiems8ucfXqy9IUyKWuMynHwwWEbDvMUcguNX7LFMWQG7M7G1uVjkooU7y+lP1osBw
         3rXi2sBIuuTAHBYb7+0INdr3CJrrJ/B+jy7Whb+vGY2XoRtoIuYOIwGzKWY1kcmZHWFB
         8BNyss93n8O8Nm+G/B/aZWVBKklALTL/udBQkpqPKr8gji0UsOMsGg1v+quy5ZQVV2ms
         3H/Yrycy236xong94rihgEwryJdXagdvqHoUZQKSMY8/po28VnyNC2ZcwiMFYDYA5uK5
         KV32azNi8EDIhhnPhzjX9uz6+OeTfO/2bZvi1Ji5YmifaUJcq3Jmrhin1c9Hhsvu/xdC
         9rOg==
X-Gm-Message-State: APjAAAUX8HynitsgWosZKZhZxW/loMn29G7YmMwg6kDN3+ZDXe44dUT2
        9d7Ma5bs241IMMRhgZIm6SYTqOoUgmhitRnyrzFm4g==
X-Google-Smtp-Source: APXvYqxxQ4xRwLFW3IgTe6cM53OyzYdMJjoyWNlI3iNINkJD27bh28cfKeKSlvaBPbaUdR4rwmUPI3XyD/8se1oLKRI=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr17704237otp.225.1565413285694;
 Fri, 09 Aug 2019 22:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221721.187713-1-saravanak@google.com> <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
In-Reply-To: <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 9 Aug 2019 22:00:49 -0700
Message-ID: <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe ordering
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 7:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saravana,
>
> On 7/31/19 3:17 PM, Saravana Kannan wrote:
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
>
>
> > v8 -> v9:
> > - Fixed kbuild test bot reported errors (docs and const)
>
> Some maintainers have strong opinions about whether change logs should be:
>
>   (1) only in patch 0
>   (2) only in the specific patches that are changed
>   (3) both in patch 0 and in the specific patches that are changed.
>
> I can adapt to any of the three styles.  But for style "(1)" please
> list which specific patch has changed for each item in the change list.
>

Thanks for the context Frank. I'm okay with (1) or (2) but I'll stick
with (1) for this series. Didn't realize there were options (2) and
(3). Since you started reviewing from v7, I'll do that in the future
updates? Also, I haven't forgotten your emails. Just tied up with
something else for a few days. I'll get to your emails next week.

Thanks,
Saravana
