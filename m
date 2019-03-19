Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rXV8vIqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfCSR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:27:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42110 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:27:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JHRHBh030867;
        Tue, 19 Mar 2019 12:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553016437;
        bh=/eXXnbyeXFctQ7VxAcrpv2Z0MSDXtIQMGy69zq2cvxc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rXV8vIqMgyILN2ZlNYEzWfg4eNqywgHoybwA80lhoO5rOQyGvEdBmWRjMUE6HiCRR
         zSwD3Ec+trrqcMe2sEmfiv5Qdc8QMtQeu686UUdkJ0HD8HOtZqi5Wf86v1INf+Yr6I
         2dPgLu08ad0UQ/oOiQWwriW62kl3eXrNvdlD4w8Q=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JHRHHk080028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 12:27:17 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 12:27:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 12:27:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JHRG4i008318;
        Tue, 19 Mar 2019 12:27:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v11 5/5] can: m_can: Fix checkpatch issues on existing code
Date:   Tue, 19 Mar 2019 12:26:51 -0500
Message-ID: <20190319172651.10012-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190319172651.10012-1-dmurphy@ti.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issues found during the m_can framework creation.
The code the issues were in, was in untouched code and these
changes should be done separately as to not be confused with the
framework changes.

Fix these 3 check issues:
CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_WARNING'
	if (psr & PSR_EW &&
	    (cdev->can.state != CAN_STATE_ERROR_WARNING)) {

CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_PASSIVE'
	if ((psr & PSR_EP) &&
	    (cdev->can.state != CAN_STATE_ERROR_PASSIVE)) {

CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_BUS_OFF'
	if ((psr & PSR_BO) &&
	    (cdev->can.state != CAN_STATE_BUS_OFF)) {

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v11 - New change to clean up last remaining checkpatch issues on original code.

 drivers/net/can/m_can/m_can.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0759c61a7e5a..1245da6f79ff 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -750,22 +750,19 @@ static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int work_done = 0;
 
-	if ((psr & PSR_EW) &&
-	    (cdev->can.state != CAN_STATE_ERROR_WARNING)) {
+	if (psr & PSR_EW && cdev->can.state != CAN_STATE_ERROR_WARNING) {
 		netdev_dbg(dev, "entered error warning state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_WARNING);
 	}
 
-	if ((psr & PSR_EP) &&
-	    (cdev->can.state != CAN_STATE_ERROR_PASSIVE)) {
+	if (psr & PSR_EP && cdev->can.state != CAN_STATE_ERROR_PASSIVE) {
 		netdev_dbg(dev, "entered error passive state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_PASSIVE);
 	}
 
-	if ((psr & PSR_BO) &&
-	    (cdev->can.state != CAN_STATE_BUS_OFF)) {
+	if (psr & PSR_BO && cdev->can.state != CAN_STATE_BUS_OFF) {
 		netdev_dbg(dev, "entered error bus off state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_BUS_OFF);
-- 
2.20.1.390.gb5101f9297

