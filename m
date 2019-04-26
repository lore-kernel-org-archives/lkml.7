Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0875C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEC821479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tn0wk2r3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfDZRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36518 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfDZRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHD8Um107986;
        Fri, 26 Apr 2019 12:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298788;
        bh=1Bi9NTMZwvV89o9GVjlvO1ukK8Mxk10lz7MG59f4nfA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tn0wk2r3GFQagrIqNxwvX1mM6g1Zmg0BBSa/Rx5S/gYyYCkvSeIAPyD3p7ztlgZpU
         tUqUngLRdNtgE7d5wc1BTOsJ9wlmzdgVf3J20ZNzwOAmcli2UYhXuTspm7OOwOmgs+
         ZF/xfsw1Zl/WpRzJAmVBsGVeNDbY8WsmXtEFdIfE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHD8Ii030423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:13:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:13:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:13:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHD79l020259;
        Fri, 26 Apr 2019 12:13:07 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 12/20] net: ethernet: ti: ale: do not auto delete mcast super entries
Date:   Fri, 26 Apr 2019 20:12:34 +0300
Message-ID: <1556298762-8632-13-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not delete multicast supervisory packet's (SUPER) entries while flushing
multicast addresses from ALE table cpsw_ale_flush_multicast(). Those
entries have to be added/removed only explicitly.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index f77b5884c8db..84025dcc78d5 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -280,6 +280,9 @@ int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid)
 		if (cpsw_ale_get_mcast(ale_entry)) {
 			u8 addr[6];
 
+			if (cpsw_ale_get_super(ale_entry))
+				continue;
+
 			cpsw_ale_get_addr(ale_entry, addr);
 			if (!is_broadcast_ether_addr(addr))
 				cpsw_ale_flush_mcast(ale, ale_entry, port_mask);
-- 
2.17.1

