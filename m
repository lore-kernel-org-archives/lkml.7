Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89C02173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfC1Mld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:41:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:35002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfC1Mgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126619131"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 05:36:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F011E63D; Thu, 28 Mar 2019 14:36:33 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 04/36] thunderbolt: Block reads and writes if switch is unplugged
Date:   Thu, 28 Mar 2019 15:36:01 +0300
Message-Id: <20190328123633.42882-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If switch is already disconnected there is no point sending it commands
and waiting for timeout. Instead in that case return error immediately.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index aea668c40d27..496dcd03ede1 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -277,6 +277,8 @@ static inline struct tb_port *tb_port_at(u64 route, struct tb_switch *sw)
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
+	if (sw->is_unplugged)
+		return -ENODEV;
 	return tb_cfg_read(sw->tb->ctl,
 			   buffer,
 			   tb_route(sw),
@@ -289,6 +291,8 @@ static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 static inline int tb_sw_write(struct tb_switch *sw, void *buffer,
 			      enum tb_cfg_space space, u32 offset, u32 length)
 {
+	if (sw->is_unplugged)
+		return -ENODEV;
 	return tb_cfg_write(sw->tb->ctl,
 			    buffer,
 			    tb_route(sw),
@@ -301,6 +305,8 @@ static inline int tb_sw_write(struct tb_switch *sw, void *buffer,
 static inline int tb_port_read(struct tb_port *port, void *buffer,
 			       enum tb_cfg_space space, u32 offset, u32 length)
 {
+	if (port->sw->is_unplugged)
+		return -ENODEV;
 	return tb_cfg_read(port->sw->tb->ctl,
 			   buffer,
 			   tb_route(port->sw),
@@ -313,6 +319,8 @@ static inline int tb_port_read(struct tb_port *port, void *buffer,
 static inline int tb_port_write(struct tb_port *port, const void *buffer,
 				enum tb_cfg_space space, u32 offset, u32 length)
 {
+	if (port->sw->is_unplugged)
+		return -ENODEV;
 	return tb_cfg_write(port->sw->tb->ctl,
 			    buffer,
 			    tb_route(port->sw),
-- 
2.20.1

