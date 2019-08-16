Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F91C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C368721655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHPIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:39:22 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:42057 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfHPIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:39:19 -0400
IronPort-SDR: rhV3hDnFVIIdujUjvqAJwMio7Pm8J+A+zBP5ZzHTkclgeOhVTcZBScl+O65hKDquz8pRmeZbd+
 zDZkLt1P33LcTWn5qHJU9tvf9gRXGwX7DKLdOmicI8dmdrKq8R8u81Uc6OjXmQ/bLfip4hfuC3
 YwZSjCasU+lpUwRoKhhO/FtzZPCZFVZI9SIi9Jnf4nPvxikOcHZXCdgy8x0NWiQCrnfhKTdjGP
 D52mlNNBPxpGQlR2xRD0mA5zgGLXAqm2Qaz+tNXf55Opcq9zPXgcVn5AP20jz7n70cG+oQwCe8
 /RU=
X-IronPort-AV: E=Sophos;i="5.64,391,1559548800"; 
   d="scan'208";a="40507262"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 16 Aug 2019 00:39:03 -0800
IronPort-SDR: KpBfaGbIc1jMikhxq9noTnNdCkmy+laTPt8mVUXnd6C6GRF4wdScsNBESmhWsdNZXF+K40wNLQ
 j62f7E2gpZ4LH+rF57AL8mKwNimNZWPyFGjCPgYCelyRaD4hNr2cDRBnE7J7tbwiX7UX1FE0Fh
 QQe0Ydp4qE+hif1YrDENQAi/dZKxo6zKNiMIqGmONZLUE2cu9ter4R3RQku1WWsVETxC9hWyvB
 cJrwUx2jdzrq3V0mc3fZogODPfImWPjJ8u+AYNGLNa4eRPIytDNRP2snNuuETW1knj23SBLkVU
 fbo=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v1 63/63] Input: atmel_mxt_ts - Fix compilation warning
Date:   Fri, 16 Aug 2019 17:39:02 +0900
Message-ID: <20190816083902.19659-4-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190816083902.19659-1-jiada_wang@mentor.com>
References: <20190816083902.19659-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix "make W=1" compilation warnings from Atmel driver
as per the compilation logs.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6e5fad91c379..063565511ae1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2056,7 +2056,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 
 			byte_offset = reg + i - cfg->start_ofs;
 
-			if (byte_offset >= 0 && byte_offset < cfg->mem_size) {
+			if (byte_offset < cfg->mem_size) {
 				*(cfg->mem + byte_offset) = val;
 			} else {
 				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
-- 
2.19.2

