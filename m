Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30902C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08412206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfDJPZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:25:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:15566 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfDJPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:25:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="163102910"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 08:25:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/12] Software fwnode references
Date:   Wed, 10 Apr 2019 18:24:53 +0300
Message-Id: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of this series. In this version I'm
introducing a new helper device_find_child_by_name() as proposed
by Andy. Andy requested also another helper that could be used for
chaining the fwnodes, but I decided not to add that now. I would like
to still think about how we should handle exceptions like if there
already is a secondary node assigned for a node.

The v1 commit message:

This series adds support for software fwnode reference handling. In
practice it means making fwnode_property_get_reference_args() function
usable in the drivers also with software nodes. I send the series
originally as RFC [1].

As the first user for the software node references, I'm converting
intel_cht_int33fe.c to use them as part of the series.

[1] https://lkml.org/lkml/2019/3/15/457

thanks,

Heikki Krogerus (12):
  software node: Allow node creation without properties
  software node: Simplify software_node_release() function
  software node: Add support for references
  software node: Implement .get_reference_args fwnode operation
  driver core: Add helper device_find_child_by_name()
  ACPI / property: Don't limit named child node matching to data nodes
  device connection: Find connections also by checking the references
  usb: typec: Registering real device entries for the muxes
  platform/x86: intel_cht_int33fe: Provide software nodes for the
    devices
  platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
  platform/x86: intel_cht_int33fe: Link with external dependencies using
    fwnodes
  platform/x86: intel_cht_int33fe: Replacing the old connections with
    references

 drivers/acpi/property.c                  |  26 +-
 drivers/base/core.c                      |  31 +++
 drivers/base/devcon.c                    |  28 ++
 drivers/base/swnode.c                    | 180 +++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c | 339 +++++++++++++++++++----
 drivers/usb/typec/bus.h                  |  15 +
 drivers/usb/typec/class.c                |  17 +-
 drivers/usb/typec/mux.c                  | 221 ++++++++++-----
 drivers/usb/typec/mux/pi3usb30532.c      |  46 +--
 include/linux/device.h                   |   2 +
 include/linux/property.h                 |   8 +
 include/linux/usb/typec_mux.h            |  62 ++---
 12 files changed, 791 insertions(+), 184 deletions(-)

-- 
2.20.1

