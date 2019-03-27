Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B132075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfC0Qno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:43:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:62434 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfC0Qno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:43:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 09:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="158912680"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2019 09:43:38 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] device property: fwnode_is_compatible() helper
Date:   Wed, 27 Mar 2019 19:43:36 +0300
Message-Id: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Basically the helper is just a generic version of the function
of_device_is_compatible() that should work also with ACPI and
software nodes.

As the first user for the helper, I'm converting in this series the
USB role switch code to expect the "compatible" property to have the
value "usb-role-switch" instead of expecting a boolean property named
"usb-role-switch". I'm doing the same for the USB Type-C mux code.

thanks,

Heikki Krogerus (3):
  device property: Add fwnode_is_compatible() and device_is_compatible()
    helpers
  usb: roles: Use the "compatible" property instead of a boolean
    property
  usb: typec: mux: Use the "compatible" property instead of a boolean
    property

 drivers/base/property.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/usb/roles/class.c |  2 +-
 drivers/usb/typec/mux.c   |  8 ++------
 include/linux/property.h  |  3 +++
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.20.1

