Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0957C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C046214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfE0MPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:15:00 -0400
Received: from muru.com ([72.249.23.125]:51174 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfE0MOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:14:17 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E09048123;
        Mon, 27 May 2019 12:14:35 +0000 (UTC)
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
Subject: [PATCH 04/12] bus: ti-sysc: Enable interconnect target module autoidle bit on enable
Date:   Mon, 27 May 2019 05:13:40 -0700
Message-Id: <20190527121348.45251-5-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For interconnect target modules with autoidle bit wired, we need to manage
it for enable and disable.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -879,7 +879,7 @@ static int sysc_enable_module(struct device *dev)
 	/* Set MIDLE mode */
 	idlemodes = ddata->cfg.midlemodes;
 	if (!idlemodes || regbits->midle_shift < 0)
-		return 0;
+		goto set_autoidle;
 
 	best_mode = fls(ddata->cfg.midlemodes) - 1;
 	if (best_mode > SYSC_IDLE_MASK) {
@@ -891,6 +891,14 @@ static int sysc_enable_module(struct device *dev)
 	reg |= best_mode << regbits->midle_shift;
 	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 
+set_autoidle:
+	/* Autoidle bit must enabled separately if available */
+	if (regbits->autoidle_shift >= 0 &&
+	    ddata->cfg.sysc_val & BIT(regbits->autoidle_shift)) {
+		reg |= 1 << regbits->autoidle_shift;
+		sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+	}
+
 	return 0;
 }
 
@@ -952,6 +960,9 @@ static int sysc_disable_module(struct device *dev)
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
+	if (regbits->autoidle_shift >= 0 &&
+	    ddata->cfg.sysc_val & BIT(regbits->autoidle_shift))
+		reg |= 1 << regbits->autoidle_shift;
 	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 
 	return 0;
-- 
2.21.0
