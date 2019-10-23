Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138832064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404932AbfJWLWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:21010 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404882AbfJWLWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="349365445"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2019 04:22:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 18A978B2; Wed, 23 Oct 2019 14:21:56 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] thunderbolt: Update documentation with the USB4 information
Date:   Wed, 23 Oct 2019 14:21:54 +0300
Message-Id: <20191023112154.64235-26-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update user's and administrator's guide to mention USB4, how it relates
to Thunderbolt (it is public spec of Thunderbolt 3) and and how it is
supported in Linux.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/admin-guide/thunderbolt.rst | 25 ++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-guide/thunderbolt.rst
index 898ad78f3cc7..f44c77860870 100644
--- a/Documentation/admin-guide/thunderbolt.rst
+++ b/Documentation/admin-guide/thunderbolt.rst
@@ -1,6 +1,23 @@
-=============
- Thunderbolt
-=============
+======================
+ Thunderbolt and USB4
+======================
+USB4 is a public spec based on Thunderbolt 3 with some differences at the
+register level among other things. There are two different implementations
+available: firmware connection manager and software connection manager.
+Typically PCs come with a firmware connection manager for Thunderbolt 3 and
+early USB4 capable systems. Apple systems on the other hand use software
+connection manager and the later USB4 compliant devices follow the suit.
+
+The Linux Thunderbolt driver supports both and can detect at runtime which
+connection manager implementation is to be used. To be on the safe side the
+software connection manager in Linux also advertises security level
+``user`` which means PCIe tunneling is disabled by default. The
+documentation below applies to both implementations with the exception that
+the software connection manager only supports ``user`` security level and
+is expected to be accompanied with an IOMMU based DMA protection.
+
+Security levels and how to use them
+-----------------------------------
 The interface presented here is not meant for end users. Instead there
 should be a userspace tool that handles all the low-level details, keeps
 a database of the authorized devices and prompts users for new connections.
@@ -18,8 +35,6 @@ This will authorize all devices automatically when they appear. However,
 keep in mind that this bypasses the security levels and makes the system
 vulnerable to DMA attacks.
 
-Security levels and how to use them
------------------------------------
 Starting with Intel Falcon Ridge Thunderbolt controller there are 4
 security levels available. Intel Titan Ridge added one more security level
 (usbonly). The reason for these is the fact that the connected devices can
-- 
2.23.0

