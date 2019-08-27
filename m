Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D143920828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfH0GaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:30:04 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:47224 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0GaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:30:03 -0400
IronPort-SDR: ZxfpUv83UhlQYahbqqwG8bIRLyM/GYbjs6hjwrEj6NLU+TGDzwIht4UXxfR6SX1tqXYDK5xt0j
 SZAFCQcry9j3vwu5RsgZTISeXxekADDbOJDKSyRo0L+c2MXnxJ6dRyMVoJ2blBmq/jNAioGchw
 3X3ucoviIF81cRybFOCBNOPkmyaCfGZ+p8hbWOYciILNm7dL5c2sTNivtjODH7VHVrBRHwZSS8
 Pt9Rmbo0lQSCi5SfLoYNAWWfW7HIeVdo8Nc6eTjucOE/roCWsMUnVWmbS+ZBrQxcR3tfTOu5xS
 z7c=
X-IronPort-AV: E=Sophos;i="5.64,436,1559548800"; 
   d="scan'208";a="40754981"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 26 Aug 2019 22:29:41 -0800
IronPort-SDR: 9dn4dml8aS7kU8rlj6A2Tglc9v7H3EAykMRBbOBb2ibjT1F2kWHi64GtUFDGHNrvbK1pzZq/+O
 EnJjL+bLFMI0X1M6hD6qIl1i6wq0t5KP35Sva6E2PJ95uTD+AWBpMpn6D9UbjikuaMSe0tTHRg
 8j3l3RlUw2f1RO5cGjBUX75rGrOnuA4aOE3ivOAuteFzDpVcAM71VDluea1Z0GNSqn+GHn8hEQ
 Md63QsOPOl6t2hPtBR39cHW0qIE0Dsy6s7wthBrd55MhwvOrWAZtht4bSQBZbjb/6XOS+9sTQP
 8qc=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v2 28/49] Input: atmel_mxt_ts - orientation is not present in hover
Date:   Tue, 27 Aug 2019 15:29:22 +0900
Message-ID: <20190827062943.20698-4-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190827062943.20698-1-jiada_wang@mentor.com>
References: <20190827062943.20698-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

When in hover, the orientation information is not sent

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit 0c885d5bd276bd9240c43aa046fc407cbe2ae864)
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 5b7ab798f27d..2d2e8ea30547 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1029,10 +1029,6 @@ static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
 			distance = MXT_DISTANCE_HOVERING;
 			hover = true;
 			active = true;
-
-			if (data->t100_aux_vect)
-				orientation = message[data->t100_aux_vect];
-
 			break;
 
 		case MXT_T100_TYPE_FINGER:
-- 
2.19.2

