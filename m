Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5DC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA6F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZfogWVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfGLXwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:52:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48597 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfGLXwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:52:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id k20so6610101pgg.15
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kubhLUQUEQ+MMlDaxxhREyfqUccCsBdmf65YIfZuyiU=;
        b=sZfogWVpl0WupSgXxobwPVgtqFYb8RoRRma3OwBoaxhRXn57Dp+oMlhhpkTesNxiqu
         rh5btlSMmGgrlpXdS8vINrZ+PoA++Y8u9UQu9GHf/Vh+5LBb6Se5KSzMPFB3hFAdZhVh
         zDN/3cU7eFXUd/Wlnl4VSbBF4Dbr++txX+9q56pXTPHHMo1PlG0bxbxWLsxZmt1eMPgK
         C15UAqLlhU22gPHx+YSnnhR8rbEmoEEgu34+Wf30ejxvtU2G6wUw/62xOqQUW2m17qz4
         RffQtmoHceXFzW2yPwRn8SPk1UiP3uiUlWYiZ5fuTuV+oDY1vS/YHiRRFJYh73zAzxx8
         lgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kubhLUQUEQ+MMlDaxxhREyfqUccCsBdmf65YIfZuyiU=;
        b=ivBVEIu/A7nBN5j1yfsMNosm+rodNZ6/EgrrVJc0mYRg3a158nxNS3vfR69++YrY2A
         ecoGQsxGfctVN6jVrGBS84z+Ye5gr1nHHjqPmUqDFI0ymssEG1rZosZMU6xHLgPDDF2Z
         AckIuRU/KxVUCh8MXSm5dQTdiP11rROOqso09ft6Lv2tbeNb+ujOH73WrVtqgqjYCOMb
         3wNp2fOnlnYvrcpKWQBeiMz1myoq9yChtYe29Bir9aWIcbJ3N2sbvx0YgekvZ88au9ff
         ABeTOXqIuEvkU91nbYBxlvERp8N01PS+t3TvkxiYx/GTeib2Q/LuRQw9EUWm450sg7KC
         5aLQ==
X-Gm-Message-State: APjAAAVaTiXdyZGMSviQKwNmnJG5J/nasHvcMXiPXNn++pJBjVR+a6A1
        9KunCSs0RtufO/1QfYY5RkgV5t8g/8+ZskY=
X-Google-Smtp-Source: APXvYqyLvGuZNnM67TcwOHOvl29k6lf0GENmWIwfnemtAT0jfPDGWFKhSQwbTQ0RHkdaGTQE2XWNaazjxmOyKkg=
X-Received: by 2002:a63:e213:: with SMTP id q19mr13928383pgh.180.1562975569235;
 Fri, 12 Jul 2019 16:52:49 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:33 -0700
Message-Id: <20190712235245.202558-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 00/11] Solve postboot supplier cleanup and optimize probe ordering
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
v3 -> v4
- Tested edit_links() on system with cyclic dependency. Works.
- Added some checks to make sure device link isn't attempted from
  parent device node to child device node.
- Added way to pause/resume sync_state callbacks across
  of_platform_populate().
- Recursively parse DT node to create device links from parent to
  suppliers of parent and all child nodes.
v4 -> v5
- Fixed copy-pasta bugs with linked list handling
- Walk up the phandle reference till I find an actual device (needed
  for regulators to work)
- Added support for linking devices from regulator DT bindings
- Tested the whole series again to make sure cyclic dependencies are
  broken with edit_links() and regulator links are created properly.

I could probably squash some of the patches, but leaving them like this
because I think it's easier to understand this way.

I've also not updated this patch series to handle the new patch [1] from
Rafael. Will do that once this patch series is close to being Acked.

[1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/

-Saravana


Saravana Kannan (11):
  driver core: Add support for linking devices during device addition
  of/platform: Add functional dependency link from DT bindings
  driver core: Add sync_state driver/bus callback
  driver core: Add edit_links() callback for drivers
  driver core: Add APIs to pause/resume sync state callbacks
  of/platform: Pause/resume sync state in of_platform_populate()
  of/platform: Sanity check DT bindings before creating device links
  of/platform: Make sure supplier DT node is device when creating device
    links
  of/platform: Create device links for all child-supplier depencencies
  of/platform: Add functional dependency link from DT regulator bindings
  of/platform: Don't create device links default busses

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/base/core.c                           | 168 ++++++++++++++++++
 drivers/base/dd.c                             |  29 +++
 drivers/of/platform.c                         | 132 ++++++++++++++
 include/linux/device.h                        |  47 +++++
 5 files changed, 381 insertions(+)

-- 
2.22.0.510.g264f2c817a-goog

