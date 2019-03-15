Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB00C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD72218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfCOQ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:58:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:39353 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfCOQ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:58:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155397152"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 09:58:00 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [RFC PATCH 00/12] platform/x86: intel_cht_int33fe: Real DisplayPort reference
Date:   Fri, 15 Mar 2019 19:57:48 +0300
Message-Id: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

This is RFC, so not CCing everybody who should be CCd yet.

I spend a bit of time on thinking how could we use real fwnode
references instead of that string you proposed in order to hook up the
USB Type-C connector with the DisplayPort connector. This is what I
came up with. I was planning on introducing the references to software
nodes in any case like I mentioned before.

I'm not yet adding any sub-nodes for the DP alt mode. I'm just
assigning references to all the relevant components (nodes) for the
USB Type-C connector node. I think that the reference to the
DisplayPort should be assigned to the USB Type-C connector and not
to the alt mode sub-node.

Using these you should be able to add that notifier, and in it just
get the reference to the correct DisplayPort node from the USB Type-C
connector, and then you can simply walk through the drm_connectors and
match using the fwnode.


thanks,


Heikki Krogerus (12):
  software node: Prevent potential NULL Pointer Dereference
  software node: Increment parent node's ref count
  software node: Add support for references
  software node: Implement .get_reference_args fwnode operation
  ACPI / property: Don't limit named child node matching to data nodes
  device connection: Find connections also by checking the references
  platform/x86: intel_cht_int33fe: Provide software node for all
    components
  platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
  platform/x86: intel_cht_int33fe: Link with external dependencies using
    fwnodes
  platform/x86: intel_cht_int33fe: Replacing the old connections with
    references
  drm: Add fwnode member to the struct drm_connector
  drm/i915: Associate the ACPI connector nodes with connector entries

 drivers/acpi/property.c                  |  26 +-
 drivers/base/devcon.c                    |  28 ++
 drivers/base/swnode.c                    | 165 ++++++++++-
 drivers/gpu/drm/drm_sysfs.c              |  49 +++-
 drivers/gpu/drm/i915/intel_display.c     |  41 +++
 drivers/platform/x86/intel_cht_int33fe.c | 349 ++++++++++++++++++++---
 include/drm/drm_connector.h              |   2 +
 include/linux/property.h                 |   8 +
 8 files changed, 599 insertions(+), 69 deletions(-)

-- 
2.20.1

