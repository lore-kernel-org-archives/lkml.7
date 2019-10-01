Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2FAC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2062190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jpWIlxsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfJAQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:03:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:45491 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569945779; x=1601481779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1x20pvEAbSH4iTumgzjsb0J4TyV5LJq/B4ERmMGoxXQ=;
  b=jpWIlxsVBSkFkHyA013sfr5nojeX22gQUvZpporVrsuegBEItMcUdJ4G
   cS6ei5UcjUmwibg/rVJh6e1UHGFfyNNCN94ttNAgb3dMicirpQ50DhJph
   lUQMnlOoOsF1Maknq/4K0ELnUmAFggkdOO+zdgp5TEXQX8W+XefITyb5l
   I=;
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="705908353"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Oct 2019 16:00:50 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 7FCB1A1DBF;
        Tue,  1 Oct 2019 16:00:31 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 1 Oct 2019 16:00:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 1 Oct 2019 16:00:30 +0000
Received: from 8c859006a84e.ant.amazon.com (172.26.203.30) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 1 Oct 2019 16:00:29 +0000
From:   Patrick Williams <alpawi@amazon.com>
CC:     Patrick Williams <alpawi@amazon.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH 2/2] i2c: pxa: remove unused i2c-slave APIs
Date:   Tue, 1 Oct 2019 11:00:00 -0500
Message-ID: <20191001160001.2388-3-alpawi@amazon.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191001160001.2388-1-alpawi@amazon.com>
References: <20191001160001.2388-1-alpawi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the i2c-pxa driver migrated to the standard i2c-slave
APIs, the custom APIs and structures are no longer needed
or used.  Remove them.

Signed-off-by: Patrick Williams <alpawi@amazon.com>
---
 drivers/i2c/busses/i2c-pxa.c          |  1 -
 include/linux/i2c-pxa.h               | 18 ------------------
 include/linux/platform_data/i2c-pxa.h |  4 ----
 3 files changed, 23 deletions(-)
 delete mode 100644 include/linux/i2c-pxa.h

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index c811646e809f..466e4f681d7a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/i2c-pxa.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/i2c-pxa.h b/include/linux/i2c-pxa.h
deleted file mode 100644
index a897e2b507b6..000000000000
--- a/include/linux/i2c-pxa.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_I2C_ALGO_PXA_H
-#define _LINUX_I2C_ALGO_PXA_H
-
-typedef enum i2c_slave_event_e {
-	I2C_SLAVE_EVENT_START_READ,
-	I2C_SLAVE_EVENT_START_WRITE,
-	I2C_SLAVE_EVENT_STOP
-} i2c_slave_event_t;
-
-struct i2c_slave_client {
-	void *data;
-	void (*event)(void *ptr, i2c_slave_event_t event);
-	int  (*read) (void *ptr);
-	void (*write)(void *ptr, unsigned int val);
-};
-
-#endif /* _LINUX_I2C_ALGO_PXA_H */
diff --git a/include/linux/platform_data/i2c-pxa.h b/include/linux/platform_data/i2c-pxa.h
index cb290092599c..6a9b28399b39 100644
--- a/include/linux/platform_data/i2c-pxa.h
+++ b/include/linux/platform_data/i2c-pxa.h
@@ -55,11 +55,7 @@
  */
 #define I2C_ISR_INIT	0x7FF  /* status register init */
 
-struct i2c_slave_client;
-
 struct i2c_pxa_platform_data {
-	unsigned int		slave_addr;
-	struct i2c_slave_client	*slave;
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
-- 
2.17.2 (Apple Git-113)

