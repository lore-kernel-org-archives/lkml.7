Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693872086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="czIxVLvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfENPpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:45:43 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:36290 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfENPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:45:41 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A30CC00DA;
        Tue, 14 May 2019 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557848745; bh=rTO3jYQQfgYc76eeKdZOIoPwkE+L6QFDgaMJpWlGQbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=czIxVLvoEUvEjen11EzK641m2Pi9oTFVBgRIPZQo2sXTAqZqSHvIFiB3cSoaw6vcb
         417MoIutfC/oZ1Kej+PMy0yvtABkdE8NliYmGJTad4BKMywZIpc+mZVLh3i5b4WUf8
         S3D/XZ/dyXzcQRAgCr3SxaWybCjVX6hp4TjdPSoh0SuNj+Iy6hF1IzSKQ9eMqD1cMn
         K6plJSmiVjZlYSoaPWZHq3um2qWHtiOltW88EuFA3utfMjP4WlEza8XHJmFdWYjLlG
         uAt5qvsuzGzeG+XJc3Vdk+QpJb00eXIscXxSzqViB8i3HFaWDGZCVaCp8MT4GmhF8J
         iq2NIBzKK7uiw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 11093A0245;
        Tue, 14 May 2019 15:45:39 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 20B543EA0D;
        Tue, 14 May 2019 17:45:39 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [RFC net-next v2 01/14] net: stmmac: Add MAC loopback callback to HWIF
Date:   Tue, 14 May 2019 17:45:23 +0200
Message-Id: <25320f72f6ddcd63a0eaf46824cd2aafb54b0050.1557848472.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557848472.git.joabreu@synopsys.com>
References: <cover.1557848472.git.joabreu@synopsys.com>
In-Reply-To: <cover.1557848472.git.joabreu@synopsys.com>
References: <cover.1557848472.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the addition of selftests support for stmmac we add a
new callback to HWIF that can be used to set the controller in loopback
mode.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 5bb00234d961..9a000dc31d9e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -324,6 +324,8 @@ struct stmmac_ops {
 	int (*flex_pps_config)(void __iomem *ioaddr, int index,
 			       struct stmmac_pps_cfg *cfg, bool enable,
 			       u32 sub_second_inc, u32 systime_flags);
+	/* Loopback for selftests */
+	void (*set_mac_loopback)(void __iomem *ioaddr, bool enable);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -392,6 +394,8 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, rxp_config, __args)
 #define stmmac_flex_pps_config(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, flex_pps_config, __args)
+#define stmmac_set_mac_loopback(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, set_mac_loopback, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
-- 
2.7.4

