Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF51C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7835020665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2iG8Mgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfF1CWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:22:10 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:45948 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF1CWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:22:09 -0400
Received: by mail-ua1-f73.google.com with SMTP id m2so713875uap.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GWBYfi+4kaeX+pxeYZLOX/nq74RbII8e1s+QsB5vZTo=;
        b=K2iG8MgqGhuqzVg+3ltK4dW4JrSBN1Uh2l+FSrdbnEeZyBMtxujDSAilkObl8eZi3C
         5v8RjCxl9FZlSGJjUzs11qqIeA0BiEDC0+gbNI89D9eHNvuINk+4uwYVhfBeQvrd/xX0
         i4M39MkayP5RIzt7BwfT+39LUVUdqy+j4qYMSb+nQN7EZsEqCrDKSdwi5QThVvaMBgF2
         TFGFDqd7oGf9kccxyngfdLrcz8sfdCX6E81qwySi4Xbjr8oRRtH45k546nzb9PiFCq9a
         xmlrr3I4SlcFId3b2mCMej0ZMyqzas/GIPtZWV6SyOyOSkOjdwAcKDlZsCGmaUkKlJ4N
         AOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GWBYfi+4kaeX+pxeYZLOX/nq74RbII8e1s+QsB5vZTo=;
        b=N1H8xWeOCjo0/vtFfvOnrJNXKz9b1llu13H0L5qEE/RbBIVXTUHu/3eT7HCzeZcLdP
         UDf3An6aMYJRA/CqQIMj2+Ur5QqftM/wyGWyNkc3ELCGz1DuzW/hK4D05O/bSainn+Zw
         nB/bp+wfrg9p8i9cRvPFhdOZFEQJQMRG2l3ASQyLnaQBfEbSFaiCTvt6iEkpmfD1qkH/
         Vs2rcGfHc3rTG6FUnUvZCfP7hCmw5iyY7w590CSwk06qDrrolDJYMwhZCOqNyitSL6v7
         N8NDUNGrkFqhjd5OIb971HPw6B8YCtIvCS8nISz6L30hEm8Mm6yewVb+MFbRBDDkgG+s
         hOew==
X-Gm-Message-State: APjAAAU7MCIexglmcA7vos5/vbJ0w4VOQ04fQrqqkrFCw6kc7JLP7soo
        DwGv8o55AXMUVTF7xAHRs+Av4ckNFxj1NTM=
X-Google-Smtp-Source: APXvYqxvSsqtFu4EcAEAJwClU/t6GqLTEJm3b6m1FHOlV7oGRiE/yskmnGEOsMgRRAZ3pRjVHJk1AzT9jY0BrL8=
X-Received: by 2002:a67:13c3:: with SMTP id 186mr4705285vst.8.1561688528346;
 Thu, 27 Jun 2019 19:22:08 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:21:59 -0700
Message-Id: <20190628022202.118166-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/3] Solve postboot supplier cleanup and optimize probe ordering
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

Saravana Kannan (3):
  driver core: Add device links support for pending links to suppliers
  of/platform: Add functional dependency link from DT bindings
  driver core: Add sync_state driver/bus callback

 drivers/base/core.c    | 106 +++++++++++++++++++++++++++++++++++++++++
 drivers/of/Kconfig     |   9 ++++
 drivers/of/platform.c  |  82 +++++++++++++++++++++++++++++++
 include/linux/device.h |  24 ++++++++++
 4 files changed, 221 insertions(+)

-- 
v1 -> v2
- Drop patch to speed up of_find_device_by_node()
- Drop depends-on property and use existing bindings

2.22.0.410.gd8fdbe21b5-goog

