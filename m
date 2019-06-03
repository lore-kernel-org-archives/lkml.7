Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D23C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C20627FEF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfFCJYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbfFCJYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096381"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:20 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 6/7] mei: docs: add hdcp documentation
Date:   Mon,  3 Jun 2019 12:14:05 +0300
Message-Id: <20190603091406.28915-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add a short ducumentation for MEI HDCP driver,
and fix DOC comments in drivers/misc/mei/hdcp/mei_hdcp.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/hdcp.rst         | 32 +++++++++++++++++++
 .../driver-api/mei/mei-client-bus.rst         |  1 +
 drivers/misc/mei/hdcp/mei_hdcp.c              | 11 +++----
 3 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/driver-api/mei/hdcp.rst

diff --git a/Documentation/driver-api/mei/hdcp.rst b/Documentation/driver-api/mei/hdcp.rst
new file mode 100644
index 000000000000..e85a065b1cdc
--- /dev/null
+++ b/Documentation/driver-api/mei/hdcp.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+HDCP:
+=====
+
+ME FW as a security engine provides the capability for setting up
+HDCP2.2 protocol negotiation between the Intel graphics device and
+an HDC2.2 sink.
+
+ME FW prepares HDCP2.2 negotiation parameters, signs and encrypts them
+according the HDCP 2.2 spec. The Intel graphics sends the created blob
+to the HDCP2.2 sink.
+
+Similarly, the HDCP2.2 sink's response is transferred to ME FW
+for decryption and verification.
+
+Once all the steps of HDCP2.2 negotiation are completed,
+upon request ME FW will configure the port as authenticated and supply
+the HDCP encryption keys to Intel graphics hardware.
+
+
+mei_hdcp driver
+---------------
+.. kernel-doc:: drivers/misc/mei/hdcp/mei_hdcp.c
+    :doc: MEI_HDCP Client Driver
+
+mei_hdcp api
+------------
+
+.. kernel-doc:: drivers/misc/mei/hdcp/mei_hdcp.c
+    :functions:
+
diff --git a/Documentation/driver-api/mei/mei-client-bus.rst b/Documentation/driver-api/mei/mei-client-bus.rst
index bfe28ebc3ca8..f242b3f8d6aa 100644
--- a/Documentation/driver-api/mei/mei-client-bus.rst
+++ b/Documentation/driver-api/mei/mei-client-bus.rst
@@ -164,4 +164,5 @@ MEI Client Bus Drivers
 .. toctree::
    :maxdepth: 2
 
+   hdcp
    nfc
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index b07000202d4a..ed816939fb32 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -2,7 +2,7 @@
 /*
  * Copyright © 2019 Intel Corporation
  *
- * Mei_hdcp.c: HDCP client driver for mei bus
+ * mei_hdcp.c: HDCP client driver for mei bus
  *
  * Author:
  * Ramalingam C <ramalingam.c@intel.com>
@@ -11,12 +11,9 @@
 /**
  * DOC: MEI_HDCP Client Driver
  *
- * This is a client driver to the mei_bus to make the HDCP2.2 services of
- * ME FW available for the interested consumers like I915.
- *
- * This module will act as a translation layer between HDCP protocol
- * implementor(I915) and ME FW by translating HDCP2.2 authentication
- * messages to ME FW command payloads and vice versa.
+ * The mei_hdcp driver acts as a translation layer between HDCP 2.2
+ * protocol  implementer (I915) and ME FW by translating HDCP2.2
+ * negotiation messages to ME FW command payloads and vice versa.
  */
 
 #include <linux/module.h>
-- 
2.20.1

