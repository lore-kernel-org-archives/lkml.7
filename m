Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D22C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EE520684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfLBRmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:42:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfLBRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:42:51 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ibpih-00046M-4m; Mon, 02 Dec 2019 17:42:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inaky Perez-Gonzalez <inaky@linux.intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2400m/USB: fix error return when rx_size is too large
Date:   Mon,  2 Dec 2019 17:42:46 +0000
Message-Id: <20191202174246.77305-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the rx_size is too large the intended error
-EINVAL is not being returned as this is being assigned to
result rather than rx_skb. Fix this be setting rx_skb
to ERR_PTR(-EINVAL) so that the error is returned in rx_skb
as originally intended.

Addresses-Coverity: ("Unused value")
Fixes: a8ebf98f5414 ("i2400m/USB: TX and RX path backends")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wimax/i2400m/usb-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/usb-rx.c b/drivers/net/wimax/i2400m/usb-rx.c
index 5b64bda7d9e7..1a5e2178bb27 100644
--- a/drivers/net/wimax/i2400m/usb-rx.c
+++ b/drivers/net/wimax/i2400m/usb-rx.c
@@ -256,7 +256,7 @@ struct sk_buff *i2400mu_rx(struct i2400mu *i2400mu, struct sk_buff *rx_skb)
 			i2400mu->rx_size = rx_size;
 		else if (printk_ratelimit()) {
 			dev_err(dev, "BUG? rx_size up to %d\n", rx_size);
-			result = -EINVAL;
+			rx_skb = ERR_PTR(-EINVAL);
 			goto out;
 		}
 		skb_put(rx_skb, read_size);
-- 
2.24.0

