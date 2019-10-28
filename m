Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AAFCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6321479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXoSAjS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390584AbfJ1WAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:00:32 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45788 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfJ1WAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:00:32 -0400
Received: by mail-pf1-f201.google.com with SMTP id a14so9614946pfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jIuu6R7JqiUCw2kjSSA8CnIOEEW6a2IyYtMd95CVXac=;
        b=HXoSAjS2qQZRsUkK8bfldDkvPAGpaTwuwhXT8UKIiEc0nDa5ZoZsQBrrbUy9R+Y5Cv
         /Qwfkv4k2iNObcXCI437XkMKsCBLBCbFx3bbSKhEXjenXnT8C9SomsIUL1lOcOlkU5D8
         jTHg/d5xnM/N5JgCUTVsKKT27bLCSsxuDltqLn7Z2vC7ri953etetMvnCEoY+w8e/vXL
         sgq4GgyqxQNoglbOfh2Fpiv/1NnVGETYWZBpoAq6A3tS9v2axJftzKs87MihS/oy2JnJ
         AeNM09v3Z2X25ZwKS8ZRNNhgpNcONMJypor98WsPSc0eWotJ3N18ZVWQ5EnTEgVuF1pZ
         A+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jIuu6R7JqiUCw2kjSSA8CnIOEEW6a2IyYtMd95CVXac=;
        b=dHPnxf8vzWv/JgpfAMnf5nRM7NUdmoqulO1AsKRGGZelCiOUTKug55GceDqu/qnXAj
         MfBj5W8zWtwYu2z5uAK0/0rGrkxDsS5HPD08H8CtkjiwHBbDWdvXBCR8W/E1q4S2ffLm
         SSbIJc9yjk92acrs02SqwREtC3UxR7UA4i7OOCgVwpoiPrYtQxRZ1D9FQPNYw4BkEHl9
         1Zp+FVZzBvtNfp4Yr1CsIW61UBbbWAMfKx9szvq8dP64TA7rkTO/aDXZglc39V5t9Ked
         QbP+FcGxVtP5WA26pP5oESRbWwI4j7Z9Tm3bw7OWTCh3m0OdpSzpYriGNTUXIS+tiHKy
         jIAA==
X-Gm-Message-State: APjAAAUi9gX4YppP9eWlx/X7kusPhHUindR/NX+CuLJEBPK/sUE4nROI
        K+kWPSTxIfP5AHKxvKNDSFmTlSaY6v3XJnQ=
X-Google-Smtp-Source: APXvYqzkseXx1MyZvyDQU/LZFs1P9ym7JWcGqHxStdYWFmUWKuUL1GImx0jwD8gYFOVQQEIKE2FlsBZN9DmSy4Q=
X-Received: by 2002:a65:4189:: with SMTP id a9mr22938579pgq.380.1572300031062;
 Mon, 28 Oct 2019 15:00:31 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:21 -0700
Message-Id: <20191028220027.251605-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 0/5] Improve of_devlink to handle "proxy cycles"
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in [1], parent devices needed to create device links to
suppliers of their child devices to make sure the suppliers of the child
devices don't get a sync_state() before the child devices are added and
probed.

In these illustrations, -> denotes DT references and indentation
represents child status.

Example 1:
==========
Device node A
	Device node B -> C

Device node C

In this example, everything works as intended.
1. Device A is added
   a. Device A is added to wait_for_suppliers list
2. Device C is added
   a. Device link is created from A to C
   b. Device A is removed from wait_for_suppliers list
3. Device C probes
4. During late_initcall_sync() Device C doesn't get sync_state() call
   because Device A hasn't probed yet
4. Device A's driver is loaded as a module
5. Device A probes
   a. Device B is added
      i. Device link is created from B to C
6. Device B probes
7. Device C get sync_state() call since A and B have probed

Example 2:
==========
Device node A
	Device node B -> C

Device node C
	Device node D -> A

In this example, none of the devices probe:
1. Device A is added
   a. Device A is added to wait_for_suppliers list
2. Device C is added
   a. Device link is created from A to C
   b. Device A is removed from wait_for_suppliers list
   c. Device link is attempted from C to A, but fails since it would
      create a cycle.
   d. Device C is added to wait_for_suppliers list
3. Device C doesn't probe because it's on wait_for_suppliers list
4. Device A's driver is loaded as a module
5. Device A doesn't probe because its supplier Device C hasn't probed

Cycles in device links aren't allowed because device links represent
functional dependency and cause the devices to be reordered in the
dpm_list to make sure the consumer suspends/goes idle before the
supplier. If there's a cycle in the supplier/consumer dependencies,
there's no logical way to sort them in the dpm_list.

This patch series addresses this problem.

Patch 1 adds a SYNC_STATE_ONLY device link flag that states that the
device link should only affect the sync_state() call behavior and
nothing else. Since a SYNC_STATE_ONLY device link doesn't affect
dpm_list or probing, we can allow cycles within SYNC_STATE_ONLY device
links. What this means is that, all the devices in the SYNC_STATE_ONLY
device link cycle will get their sync_state() calls only after all of
them have probed successfully.

Patch 2 improves wait_for_suppliers semantics by allowing a device on
the list to state (device.links.need_for_probe) if the suppliers it's
waiting on (to make a device link to) are needed for it to probe or not.
If the device is not waiting on suppliers that are needed for probing,
the device is no longer blocked from attempting to probe even if it's on
the wait_for_suppliers list.

Patch 3 allows fwnode_operations.add_links() return error codes to
differentiate between being unable to find mandatory suppliers (-ENODEV)
vs optional suppliers (-EAGAIN). If add_links() is only unable to find
optional suppliers, then the corresponding device is marked as waiting
on suppliers that are not needed for probing.

Patch 4 changes device tree fwnode add_links() implementation so that
all device links created from a device to the suppliers of its child
devices use the SYNC_STATE_ONLY flag. It is also changed to return
-ENODEV only for errors with the suppliers of the device and return
-EAGAIN when the errors are limited to the suppliers of its child
devices.

Patch 5 is an unrelated improvement that touches the same bit of code,
so I'm grouping it with this series to avoid rebases. That commit should
be self descriptive.

With these changes, Example 2 works as follows:
1. Device A is added
   a. Device A is added to wait_for_suppliers list
   b. Device A is marked as waiting for optional suppliers
2. Device C is added
   a. SYNC_STATE_ONLY device link is created from A to C
   b. Device A is removed from wait_for_suppliers list
   c. SYNC_STATE_ONLY device link is created from C to A
3. Device C probes
   a. Device D is added.
      i. Device link is created from D to A
4. During late_initcall_sync() Device C doesn't get sync_state() call
   because Device A hasn't probed yet
5. Device A's driver is loaded as a module
6. Device A probes
   a. Device B is added
      i. Device link is created from B to C
7. Device A doesn't get sync_stat() call because Device D hasn't probed
8. Device D probes
9. Device A get sync_state() call since C and D have probed
10.Device B probes
11.Device C get sync_state() call since A and B have probed

Thanks,
Saravana

[1] - commit d4387cd117414ba80230f27a514be5ca4a09cfcc
      ("of: property: Create device links for all child-supplier depencencies")
      or https://lore.kernel.org/linux-acpi/20190904211126.47518-7-saravanak@google.com/

Saravana Kannan (5):
  driver core: Add device link support for SYNC_STATE_ONLY flag
  driver core: Allow a device to wait on optional suppliers
  driver core: Allow fwnode_operations.add_links to differentiate errors
  of: property: Make sure child dependencies don't block probing of
    parent
  of: property: Skip adding device links to suppliers that aren't
    devices

 drivers/base/core.c    | 88 +++++++++++++++++++++++++++++++++++-------
 drivers/of/property.c  | 21 +++++++---
 include/linux/device.h |  5 +++
 include/linux/fwnode.h | 13 +++++--
 4 files changed, 102 insertions(+), 25 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

