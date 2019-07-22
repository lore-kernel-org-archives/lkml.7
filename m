Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E08DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB0C2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSrDP0k+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfGVXrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:47:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45944 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfGVXrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:47:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so3695810otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezUTQcxWaNEMctu/WrThORHFyr5A9yxp6lNSMDh1t/w=;
        b=FSrDP0k+ApVeqUbXOrsC6ZZewwi5kfyxz5zNEVEP+0ZEsSwIkmwNLONlkCeSgkl5wo
         gSPZPtSMUAGS4bvHBrY+UUDKLk2PRbk+gvGc3CP1jnlOU6H9SzxesUPgD9b41rakxkzF
         9221m+qOc2IllOk8cSlLlxSK+1Qp8oBcoyiHBMGKkhgA6FCL15+rKrAENStZXmCzBf8g
         G+Wl/79jKjvYm3Rl+RwW41s6lokTH/MuU7N6HQGcj1a4L275MrQrXfkSPOo1cHjKY6qx
         iIFdrDLUYgAkT7xjD8sfvfqDhXFMSCNWnHphsfNo5TnZ6FgrRxHvVxtvGk4g27BRICfK
         70ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezUTQcxWaNEMctu/WrThORHFyr5A9yxp6lNSMDh1t/w=;
        b=iXMSV/LU/xPjvc2CGz73+N1KXMWjwljFep3XkVeQa5+G+ltaoE7UUVjHnYfI+xOccq
         z/PBgLX2lVozsY65kBtAfh5eRQM7ITnDlDtv3xeGM66/SssUe2B16dMVx2geCVL/Hhc8
         M7Suv9RzCBvANrAmuUvfobi7J9HCq/uk62QivU+L7wW0rGOgc5wEOCe1z4bWu0Y7PzmK
         FJXjptIWYRRFqxVV2SHOoAo7fPCwrje5g8acNq4Jy4/uVclQfeh/QBnDW3Rm3ySMsASj
         PZG1pMaisNonh/YOyR4Eyffy7isf7KhsLIIQQwW1cumn/C9u0A/jUPCGO0QtX00JXEbC
         leZw==
X-Gm-Message-State: APjAAAUpZ+crB5GCkI9XpgnDwxhrOtqg4nZua+UyHOW9Fj/yuOCCxO1y
        7NqQbfkjrE7iQOV21BhIqvtNzNUUqduWq8ylhI5I7A==
X-Google-Smtp-Source: APXvYqwh/Kq2TD4k37U9oU8MKp9SSQGgVZ+B0WGSNY0ozl/ONS8huqU9oJWQ0jLXhXRxfuftmSHpEfd1Pu46pr6k/yQ=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr18026255otr.231.1563839271203;
 Mon, 22 Jul 2019 16:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com>
In-Reply-To: <20190720061647.234852-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 22 Jul 2019 16:47:15 -0700
Message-ID: <CAGETcx91q5MMxL+T8WxQjfygnYmwQQcRG1puRVO8qTO61Eb=7A@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Solve postboot supplier cleanup and optimize probe ordering
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:16 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add device-links to track functional dependencies between devices
> after they are created (but before they are probed) by looking at
> their common DT bindings like clocks, interconnects, etc.
>
> Having functional dependencies automatically added before the devices
> are probed, provides the following benefits:
>
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
>
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
>
> - Supplier devices like clock providers, interconnect providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
>
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
>
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
>
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
>
> v1 -> v2:
> - Drop patch to speed up of_find_device_by_node()
> - Drop depends-on property and use existing bindings
>
> v2 -> v3:
> - Refactor the code to have driver core initiate the linking of devs
> - Have driver core link consumers to supplier before it's probed
> - Add support for drivers to edit the device links before probing
>
> v3 -> v4:
> - Tested edit_links() on system with cyclic dependency. Works.
> - Added some checks to make sure device link isn't attempted from
>   parent device node to child device node.
> - Added way to pause/resume sync_state callbacks across
>   of_platform_populate().
> - Recursively parse DT node to create device links from parent to
>   suppliers of parent and all child nodes.
>
> v4 -> v5:
> - Fixed copy-pasta bugs with linked list handling
> - Walk up the phandle reference till I find an actual device (needed
>   for regulators to work)
> - Added support for linking devices from regulator DT bindings
> - Tested the whole series again to make sure cyclic dependencies are
>   broken with edit_links() and regulator links are created properly.
>
> v5 -> v6:
> - Split, squashed and reordered some of the patches.
> - Refactored the device linking code to follow the same code pattern for
>   any property.
>
> I've also not updated this patch series to handle the new patch [1] from
> Rafael. Will do that once this patch series is close to being Acked.
>
> [1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/
>
> -Saravana
>
>
> Saravana Kannan (7):
>   driver core: Add support for linking devices during device addition
>   driver core: Add edit_links() callback for drivers
>   of/platform: Add functional dependency link from DT bindings
>   driver core: Add sync_state driver/bus callback
>   of/platform: Pause/resume sync state during init and
>     of_platform_populate()
>   of/platform: Create device links for all child-supplier depencencies
>   of/platform: Don't create device links for default busses
>
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/base/core.c                           | 168 ++++++++++++++++
>  drivers/base/dd.c                             |  29 +++
>  drivers/of/platform.c                         | 182 ++++++++++++++++++
>  include/linux/device.h                        |  47 +++++
>  5 files changed, 431 insertions(+)

Update: Tested this refactor on hardware by backporting to a 4.14
kernel. Works just as it did before the refactor.

Also, nudge to make sure this series isn't lost over the weekend email snooze.

-Saravana
