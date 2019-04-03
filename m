Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABC7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4850F20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDCQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:45:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:21215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfDCQpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:45:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 09:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="161077256"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2019 09:45:37 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/11] Software fwnode references
Date:   Wed,  3 Apr 2019 19:45:26 +0300
Message-Id: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for software fwnode reference handling. In
practice it means making fwnode_property_get_reference_args() function
usable in the drivers also with software nodes. I send the series
originally as RFC [1].

As the first user for the software node references, I'm converting
intel_cht_int33fe.c to use them as part of the series.

[1] https://lkml.org/lkml/2019/3/15/457

thanks,

Heikki Krogerus (11):
  software node: Allow node creation without properties
  software node: Simplify software_node_release() function
  software node: Add support for references
  software node: Implement .get_reference_args fwnode operation
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
 drivers/base/devcon.c                    |  28 ++
 drivers/base/swnode.c                    | 180 +++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c | 346 ++++++++++++++++++++---
 drivers/usb/typec/bus.h                  |  15 +
 drivers/usb/typec/class.c                |  17 +-
 drivers/usb/typec/mux.c                  | 221 ++++++++++-----
 drivers/usb/typec/mux/pi3usb30532.c      |  46 +--
 include/linux/property.h                 |   8 +
 include/linux/usb/typec_mux.h            |  62 ++--
 10 files changed, 765 insertions(+), 184 deletions(-)

-- 
2.20.1

