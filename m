Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B51CC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0121872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfNDPj5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGTGQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:16:57 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:57065 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfGTGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:16:56 -0400
Received: by mail-pg1-f201.google.com with SMTP id h5so19948166pgq.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ix0OFdDAy+PKeD1G3w5tyzwxeeMj3ANV8l3DdrszkYw=;
        b=mfNDPj5Nvf2w78TVydj1ro7xvNs+5fVUwAYjlJoC+epjPXQcB3oOvuGPNl76OnzN4C
         SSjecnQbIOKNDnfp44WejYatHrD2xXsaKzAxuzDUz7KUtLBLiJdrMYM3HInbkzdruOFT
         2zhjmyM3UsZ2W/S6TcJ23Q57wCPc8cg0ERnD6MjytYDJcmCjHMHzsx6/PJjxriaA0iTz
         lF8/5juzBPk7B7lEuHzeNonolcsfxjbgrBGhlICD+B39DUYhCjSDnNOlXSq8i9Gp8Ji6
         Z+8d+eGWkhqy0qgxF3JpI02advwzZM0LCJozSVfOfVEeAOHRDncc8nUihlZJsGB61PO3
         /IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ix0OFdDAy+PKeD1G3w5tyzwxeeMj3ANV8l3DdrszkYw=;
        b=I9yWbHR0XZfwmC8WNTYG0/ltNITA48iLsSoHjOd3K1mn2GAHTPdgTiF16ZFhgkiWRe
         Q5hlgP32BtHWkmh6iQFbNzeuMQzAnsODV5Chtwcr1eCuuspSVlIxphPF7qlhEWki76bm
         noIDRGfmNNja8eEw+8awEWxUwYvB0tdIKVnZP+iIGGSoum/aUBsmyBP9jl4oxpkIPRET
         WOIXQ2FjvrDsVqLYMKbpxFAPNZyU9BE2q5Yfgz0eZhueRFQg6IQcSQ7tKdidIgCJfSuf
         W/+G474pGBB68Dh+7eNCEEU5QKI63YAPa5+QFlEl2hhIgnVALgoro6KDVkwf7ENgbfpq
         5Xqg==
X-Gm-Message-State: APjAAAUsdouuP+n0kxCHSIe/KpHkYjJyO2B7GENIqyPJkXa2ffIllXWv
        +ZHHpowBSSdkCEa9PDqNyd101xo7GWHqRz0=
X-Google-Smtp-Source: APXvYqz41pmamoZ+APky4U5DJ1JTrgyo9lzO0O0y4SngPN8nulYMCF2E9hPAwTTE7I9jXbGqf6MWAuO5fJAMsAA=
X-Received: by 2002:a65:4045:: with SMTP id h5mr59972449pgp.247.1563603414696;
 Fri, 19 Jul 2019 23:16:54 -0700 (PDT)
Date:   Fri, 19 Jul 2019 23:16:39 -0700
Message-Id: <20190720061647.234852-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v6 0/7] Solve postboot supplier cleanup and optimize probe ordering
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-links to track functional dependencies between devices
after they are created (but before they are probed) by looking at
their common DT bindings like clocks, interconnects, etc.

Having functional dependencies automatically added before the devices
are probed, provides the following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just
  one consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, interconnect providers, etc
  need to keep the resources they provide active and at a particular
  state(s) during boot up even if their current set of consumers don't
  request the resource to be active. This is because the rest of the
  consumers might not have probed yet and turning off the resource
  before all the consumers have probed could lead to a hang or
  undesired user experience.

  Some frameworks (Eg: regulator) handle this today by turning off
  "unused" resources at late_initcall_sync and hoping all the devices
  have probed by then. This is not a valid assumption for systems with
  loadable modules. Other frameworks (Eg: clock) just don't handle
  this due to the lack of a clear signal for when they can turn off
  resources. This leads to downstream hacks to handle cases like this
  that can easily be solved in the upstream kernel.

  By linking devices before they are probed, we give suppliers a clear
  count of the number of dependent consumers. Once all of the
  consumers are active, the suppliers can turn off the unused
  resources without making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier
devices to change the link when they probe.

v1 -> v2:
- Drop patch to speed up of_find_device_by_node()
- Drop depends-on property and use existing bindings

v2 -> v3:
- Refactor the code to have driver core initiate the linking of devs
- Have driver core link consumers to supplier before it's probed
- Add support for drivers to edit the device links before probing

v3 -> v4:
- Tested edit_links() on system with cyclic dependency. Works.
- Added some checks to make sure device link isn't attempted from
  parent device node to child device node.
- Added way to pause/resume sync_state callbacks across
  of_platform_populate().
- Recursively parse DT node to create device links from parent to
  suppliers of parent and all child nodes.

v4 -> v5:
- Fixed copy-pasta bugs with linked list handling
- Walk up the phandle reference till I find an actual device (needed
  for regulators to work)
- Added support for linking devices from regulator DT bindings
- Tested the whole series again to make sure cyclic dependencies are
  broken with edit_links() and regulator links are created properly.

v5 -> v6:
- Split, squashed and reordered some of the patches.
- Refactored the device linking code to follow the same code pattern for
  any property.

I've also not updated this patch series to handle the new patch [1] from
Rafael. Will do that once this patch series is close to being Acked.

[1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/

-Saravana


Saravana Kannan (7):
  driver core: Add support for linking devices during device addition
  driver core: Add edit_links() callback for drivers
  of/platform: Add functional dependency link from DT bindings
  driver core: Add sync_state driver/bus callback
  of/platform: Pause/resume sync state during init and
    of_platform_populate()
  of/platform: Create device links for all child-supplier depencencies
  of/platform: Don't create device links for default busses

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/base/core.c                           | 168 ++++++++++++++++
 drivers/base/dd.c                             |  29 +++
 drivers/of/platform.c                         | 182 ++++++++++++++++++
 include/linux/device.h                        |  47 +++++
 5 files changed, 431 insertions(+)

-- 
2.22.0.657.g960e92d24f-goog

