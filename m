Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F7E21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfDJNhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:37:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:15448 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732412AbfDJNhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="335521016"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2019 06:37:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F2654BA0; Wed, 10 Apr 2019 16:36:55 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com, Joe Perches <joe@perches.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v4 33/36] thunderbolt: Make __TB_[SW|PORT]_PRINT take const parameters
Date:   Wed, 10 Apr 2019 16:36:50 +0300
Message-Id: <20190410133653.88061-34-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printing macros do not modify the passed object so make them
const. While there make tb_route() to take const parameter as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 119a00837992..15d225dcb403 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -320,7 +320,7 @@ static inline bool tb_is_upstream_port(const struct tb_port *port)
 	return port == upstream_port || port->dual_link_port == upstream_port;
 }
 
-static inline u64 tb_route(struct tb_switch *sw)
+static inline u64 tb_route(const struct tb_switch *sw)
 {
 	return ((u64) sw->config.route_hi) << 32 | sw->config.route_lo;
 }
@@ -442,7 +442,7 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 
 #define __TB_SW_PRINT(level, sw, fmt, arg...)           \
 	do {                                            \
-		struct tb_switch *__sw = (sw);          \
+		const struct tb_switch *__sw = (sw);    \
 		level(__sw->tb, "%llx: " fmt,           \
 		      tb_route(__sw), ## arg);          \
 	} while (0)
@@ -453,7 +453,7 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 
 #define __TB_PORT_PRINT(level, _port, fmt, arg...)                      \
 	do {                                                            \
-		struct tb_port *__port = (_port);                       \
+		const struct tb_port *__port = (_port);                 \
 		level(__port->sw->tb, "%llx:%x: " fmt,                  \
 		      tb_route(__port->sw), __port->port, ## arg);      \
 	} while (0)
-- 
2.20.1

