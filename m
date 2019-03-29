Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EED2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfC2ACs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:02:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45591 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC2ACr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:02:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h9eyq-0005sZ-Vt; Fri, 29 Mar 2019 00:02:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix incorrect mask for EEPROMTxPowerLevelCCK setting
Date:   Fri, 29 Mar 2019 00:02:44 +0000
Message-Id: <20190329000244.16528-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the lower 8 bits of ret are being masked and left
shifted by 8 bits always leaving a result of zero. The mask
appears to be incorrect and should probably be 0xff00 instead
of 0xff.  Fix this.  (Note: not tested).

Fixes: 16feab644fd1 ("staging: rtl8192u: check return value eprom_read")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f1eaab337dca..a173884d31c8 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2454,7 +2454,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_CCK >> 1));
 				if (ret < 0)
 					return ret;
-				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff) >> 8;
+				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff00) >> 8;
 			} else
 				priv->EEPROMTxPowerLevelCCK = 0x10;
 			RT_TRACE(COMP_EPROM, "CCK Tx Power Levl: 0x%02x\n", priv->EEPROMTxPowerLevelCCK);
-- 
2.20.1

