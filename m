Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F67CC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A77D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZG+BXl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfGaWRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47487 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfGaWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:27 -0400
Received: by mail-qk1-f201.google.com with SMTP id x17so59382833qkf.14
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8xCKbe4+SbEpflCZXnlVd2DD5MlWqrkpd7IK3sU8Kak=;
        b=BZG+BXl0HRJnAWor1fWDAb3te4N+3JEeudwqdxZumR5nQKbZWyzBP82yF7aDDm/ryP
         XYIEC0N5AzhgUY2kppAdv6Lavvl013cijyRnp/vvmhDo2VDxnDyaM6M+H6Z04vVxdqns
         5ZWK7aA9w6ojRZfOs0cfmFG19kZr3CuDsjQW5GLagOanxY+/i2dDRLLY1beE2k5KOhCo
         OaHShoncfKPMfhwbNzcvUYiLWtja/yn03P/Me+dgxfC8mY4/vE1/+Gj5LLs2sIpk2dgk
         M8xGixaEZtWe1nRFg9f8PfgEfT+l0rPYzROiDPgGxta2stWsRWSOoeJo9g1bpsam2rfF
         gf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8xCKbe4+SbEpflCZXnlVd2DD5MlWqrkpd7IK3sU8Kak=;
        b=bCbMMMIGUXa2LI2NTEw7Uf0LmjxLNg/rWjVUN6sYzGiZbK12IWD5PTCsd7c1OJBSxo
         kgYecoaIASKn0AWkiD/AggctcMIAeEPEMA7putxPfYvmFLC9tSETfxu0ttK8S1DdLbX9
         JKXO2fowd0RRseBRayUfNBcPL83Z5iza8oJrz0dsD+YZYOR7jWS4LJTO/LnVnD8FU99/
         63Q0yeqf0lW2adcyyFM9bKhzUA8lz6vol4QzIu1IK3skXZQz+8GiTsVg+1jLoCXODuat
         F3NjI+1sveaCnKPslVBJUUASG2AUxRbJoV9JWSTG2cxP4kOfYyIuH3gAzDJKJxgwt2/h
         Ksfg==
X-Gm-Message-State: APjAAAWAm9+cCDo7/dBfQUG2GxUczzSmw5o6WmFvp79eX/9PVvbRfr0O
        1sd4mAZEe66nRxFwMUFJ2fd2iISRIpQpLHU=
X-Google-Smtp-Source: APXvYqzQkikXOmdHnzLceN0ILgumdC0UgR3Gd4v74UNOhJcnLW9nKL7EtkA5UsucmUgtEVaCWWmO3w2jUnspYvI=
X-Received: by 2002:a0c:b998:: with SMTP id v24mr90216699qvf.132.1564611446084;
 Wed, 31 Jul 2019 15:17:26 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:17:13 -0700
Message-Id: <20190731221721.187713-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe ordering
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

v6 -> v7:
- No functional changes.
- Renamed i to index
- Added comment to clarify not having to check property name for every
  index
- Added "matched" variable to clarify code. No functional change.
- Added comments to include/linux/device.h for add_links()

v7 -> v8:
- Rebased on top of linux-next to handle device link changes in [1]

v8 -> v9:
- Fixed kbuild test bot reported errors (docs and const)

[1] - https://lore.kernel.org/lkml/2305283.AStDPdUUnE@kreacher/

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
 drivers/of/platform.c                         | 189 ++++++++++++++++++
 include/linux/device.h                        |  60 ++++++
 5 files changed, 451 insertions(+)

-- 
2.22.0.709.g102302147b-goog

