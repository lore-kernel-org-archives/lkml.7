Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69CC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FCB2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHSKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:07:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:8477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHSKH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:07:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 03:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195506062"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 03:07:25 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] software node: Introduce software_node_find_by_name()
Date:   Mon, 19 Aug 2019 13:07:21 +0300
Message-Id: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was still one bug spotted by Andy in v2. The role switch node
was not removed in case of an error (patch 2/3). It is now fixed.


The cover letter from v2:

This is the second version of this series where I'm introducing that
helper.

Hans and Andy! Because of the changes I made to patch 2/3, I'm not
carrying your reviewed-by tags in it. I would appreciate if you
could take another look at that patch.

I added a note to the kernel-doc comment in patch 1/3 that the caller
of the helper function needs to release the ref count after use as
proposed by Andy.

In patch 2/3, since we have to now modify the role switch descriptor,
I'm filling the structure in stack memory and removing the constant
static version. The content of the descriptor is copied during switch
registration in any case, so we don't need to store it in the driver.

I also noticed a bug in 2/3. I never properly destroyed the software
node when the mux was removed. That leak is now also fixed.

thanks,

Heikki Krogerus (3):
  software node: Add software_node_find_by_name()
  usb: roles: intel_xhci: Supplying software node for the role mux
  platform/x86: intel_cht_int33fe: Use new API to gain access to the
    role switch

 drivers/base/swnode.c                         | 37 ++++++++++++
 drivers/platform/x86/intel_cht_int33fe.c      | 57 ++++---------------
 .../usb/roles/intel-xhci-usb-role-switch.c    | 27 ++++++---
 include/linux/property.h                      |  4 ++
 4 files changed, 71 insertions(+), 54 deletions(-)

-- 
2.23.0.rc1

