Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA8920854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCRK57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:57:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCRK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:57:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5pxm-0004Sy-0g; Mon, 18 Mar 2019 10:57:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: remove redundant auth_type check
Date:   Mon, 18 Mar 2019 10:57:49 +0000
Message-Id: <20190318105749.20098-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The range check on auth_type is redundant as there is a prior
check on the auth_type values and the only way the block is entered
is if auth_type is one of TYPE_PMK1, TYPE_GMK1 and TYPE_GMK1. Hence
the auth_type check can be removed.

Detected by static analysis with cppcheck.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/ks7010/ks_hostif.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 06ebea0be118..31a536791d5c 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -362,6 +362,8 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	     (auth_type == TYPE_GMK2 &&
 	      priv->wpa.group_suite == IW_AUTH_CIPHER_TKIP)) &&
 	    key->key_len) {
+		int ret;
+
 		netdev_dbg(priv->net_dev, "TKIP: protocol=%04X: size=%u\n",
 			   eth_proto, priv->rx_size);
 		/* MIC save */
@@ -369,15 +371,11 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 		       (priv->rxp) + ((priv->rx_size) - sizeof(recv_mic)),
 		       sizeof(recv_mic));
 		priv->rx_size = priv->rx_size - sizeof(recv_mic);
-		if (auth_type > 0 && auth_type < 4) {	/* auth_type check */
-			int ret;
-
-			ret = michael_mic(key->rx_mic_key,
-					  priv->rxp, priv->rx_size,
-					  0, mic);
-			if (ret < 0)
-				return ret;
-		}
+
+		ret = michael_mic(key->rx_mic_key, priv->rxp, priv->rx_size,
+				  0, mic);
+		if (ret < 0)
+			return ret;
 		if (memcmp(mic, recv_mic, sizeof(mic)) != 0) {
 			now = jiffies;
 			mic_failure = &priv->wpa.mic_failure;
-- 
2.20.1

