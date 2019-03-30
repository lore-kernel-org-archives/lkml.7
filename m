Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFE2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfC3PZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:25:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54798 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfC3PZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:25:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hAFqx-0003tT-FY; Sat, 30 Mar 2019 15:25:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: clean up redundant break statements
Date:   Sat, 30 Mar 2019 15:25:03 +0000
Message-Id: <20190330152503.9923-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several places where a break statement occurs before
a following break statement; these are unnecessary and can be
removed to clean up the code a little.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/dvb-frontends/drxd_hard.c | 30 +++++--------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index 0a5b15bee1d7..c597d6fc3046 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -2263,61 +2263,41 @@ static int DRX_Start(struct drxd_state *state, s32 off)
 		case DRX_CHANNEL_LOW:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_PRIO_LO;
 			status = Write16(state, EC_SB_REG_PRIOR__A, EC_SB_REG_PRIOR_LO, 0x0000);
-			if (status < 0)
-				break;
 			break;
 		case DRX_CHANNEL_HIGH:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_PRIO_HI;
 			status = Write16(state, EC_SB_REG_PRIOR__A, EC_SB_REG_PRIOR_HI, 0x0000);
-			if (status < 0)
-				break;
 			break;
-
 		}
 
 		switch (p->code_rate_HP) {
 		case FEC_1_2:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_1_2;
-			if (state->type_A) {
+			if (state->type_A)
 				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C1_2, 0x0000);
-				if (status < 0)
-					break;
-			}
 			break;
 		default:
 			operationMode |= SC_RA_RAM_OP_AUTO_RATE__M;
 			/* fall through */
 		case FEC_2_3:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_2_3;
-			if (state->type_A) {
+			if (state->type_A)
 				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C2_3, 0x0000);
-				if (status < 0)
-					break;
-			}
 			break;
 		case FEC_3_4:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_3_4;
-			if (state->type_A) {
+			if (state->type_A)
 				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C3_4, 0x0000);
-				if (status < 0)
-					break;
-			}
 			break;
 		case FEC_5_6:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_5_6;
-			if (state->type_A) {
+			if (state->type_A)
 				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C5_6, 0x0000);
-				if (status < 0)
-					break;
-			}
 			break;
 		case FEC_7_8:
 			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_7_8;
-			if (state->type_A) {
+			if (state->type_A)
 				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C7_8, 0x0000);
-				if (status < 0)
-					break;
-			}
 			break;
 		}
 		if (status < 0)
-- 
2.20.1

