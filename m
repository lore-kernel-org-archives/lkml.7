Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B415C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6583320863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfCYNQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:16:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:14700 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbfCYNQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:16:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="158179271"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2019 06:16:41 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm: connector firmware nodes
Date:   Mon, 25 Mar 2019 16:16:39 +0300
Message-Id: <20190325131641.71076-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If the system firmware supplies device nodes representing the
display connectors on integrated video hardware, those nodes should
probable always be associated with the display connector entries
(struct drm_connector).

With the USB Type-C DisplayPort alt mode, we will need a way to inform
the correct drm connector entry about HPD IRQ, lane counts and other
details. In ACPI (and most likely in DT too) the device node
representing a DisplayPort behind USB Type-C connector should have a
reference to the device node representing the USB Type-C connector (or
vise versa). Once we have associated the DP connector device nodes
with the drm connector entries, we can use those references to find
the correct drm connector that the information the USB Type-C drivers
are sending is meant for.

Because I think the connector firmware nodes should be associated with
the connector entries in any case (those nodes do seem to be supplying
the connectors all kinds of resources, not only references to other
components), I'm proposing this now instead of waiting for the USB
Type-C patches.

thanks,

Heikki Krogerus (2):
  drm: Add fwnode member to the struct drm_connector
  drm/i915: Associate ACPI connector nodes with connector entries

 drivers/gpu/drm/drm_sysfs.c          | 49 +++++++++++++++++++---------
 drivers/gpu/drm/i915/intel_display.c | 40 +++++++++++++++++++++++
 include/drm/drm_connector.h          |  2 ++
 3 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.20.1

