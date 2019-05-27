Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4942C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558521670
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfE0MOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:14:12 -0400
Received: from muru.com ([72.249.23.125]:51144 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfE0MOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:14:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5AD878123;
        Mon, 27 May 2019 12:14:29 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 01/12] bus: ti-sysc: Support 16-bit writes too
Date:   Mon, 27 May 2019 05:13:37 -0700
Message-Id: <20190527121348.45251-2-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to also support 16-bit writes for i2c in addition to the reads
when we start configuring the sysconfig register for reset and idle modes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -100,6 +100,13 @@ static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
 
 static void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
+	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
+		writew_relaxed(value & 0xffff, ddata->module_va + offset);
+		writew_relaxed(value >> 16, ddata->module_va + offset + 4);
+
+		return;
+	}
+
 	writel_relaxed(value, ddata->module_va + offset);
 }
 
-- 
2.21.0
