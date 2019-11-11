Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C98C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7020659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rcaBkwKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKKCJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:09:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKKCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:09:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id y24so7125124plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mLqAkz70hewUh0ervFoHBTqLrYQB2WZOJWKpk5nNfrg=;
        b=rcaBkwKYAToxzArAvww28gCqGZfidxO3QYt/jFAvGWn9MhImb4AYSzfp4Lir8kmOsV
         BYduc0ZgPbJ3cKOHemco5N9ZqWrvgiQPNu0T/hT4Ya8e+EbGFGfiI2u0JSKmaS47Rz33
         Dl8JSsg3Cv0Mys0jSJEWhqHzZ5aW3RN0AsN8HZTOdIr3hHN4xUBeQ3X+i4pIbrT7uu4N
         NaZErLNWNhd7VqZBhpyS2KAf80A4i26UMsd4eEIOEE8Vk7PGhNVYJaFF7YgkF913Bvwe
         ar+5Q71+2B2FDPvkhVp9O7kNw97mBRzQfVBPDV5/r4jJLdroZoOfXHbS2hYEoX7fNOgz
         nqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mLqAkz70hewUh0ervFoHBTqLrYQB2WZOJWKpk5nNfrg=;
        b=inlo6kuBBtHRTGmUDiyT48nlIoZPJ0y/+mWsU3c6S0EYCx8Ux5PsMibMtOFQKTKoCF
         AP2y/YDW+Btp8Ua/4lcSl6FIo3j6m3BOSuH2HRTlWtAbH2+OHmT36D3EYrbOcVLN5fin
         ShXlDC1ydmj3/eFKZNATAF4aiG4RizCuv0y7WDsNpmntKSN+PokCi8tDRug/X/bTsyuQ
         iWKavzw5dyB9Om7Qk3hTqKN02LVJyomRLWuk9/Se5Los5JPdAypZ7+9RDzBYI1x5XelM
         /ECQpFPzJPgQGEk3MpPMjU63DkSTcS2gA1DgV5haLTpckmCxOxjhSc1voqnCgmRmiykE
         iHxg==
X-Gm-Message-State: APjAAAUM24vfypDppWGVdxXqrjpVPmDfBDt29zYcbKecFhIzbGrk7lJ0
        YWcu0IircUBQbbuI1h4xe+arMw==
X-Google-Smtp-Source: APXvYqy1Gbi2C9sE9lGCIgrduKYGTVAUAbVWlNnfR0ZEknVJKpcThAN3ZMmYQAyqjwKeTHEmlIzVBQ==
X-Received: by 2002:a17:902:8345:: with SMTP id z5mr14689283pln.113.1573438145806;
        Sun, 10 Nov 2019 18:09:05 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 83sm12166618pgh.86.2019.11.10.18.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 18:09:04 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] net: bnxt_en: Fix array overrun in bnxt_fill_l2_rewrite_fields()
Date:   Sun, 10 Nov 2019 18:08:55 -0800
Message-Id: <20191111020855.20775-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is caused by what seems to be a fragile typing approach by
the Broadcom firmware/driver:

/* FW expects smac to be in u16 array format */

So the driver uses eth_addr and eth_addr_mask as u16[6] instead of u8[12],
so the math in bnxt_fill_l2_rewrite_fields does a [6] deref of the u16
pointer, it goes out of bounds on the array.

Just a few lines below, they use ETH_ALEN/2, so this must have been
overlooked. I'm surprised original developers didn't notice the compiler
warnings?!

Fixes: 90f906243bf6 ("bnxt_en: Add support for L2 rewrite")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 174412a55e53c..cde2b81f6fe54 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -149,29 +149,32 @@ static void bnxt_set_l2_key_mask(u32 part_key, u32 part_mask,
 
 static int
 bnxt_fill_l2_rewrite_fields(struct bnxt_tc_actions *actions,
-			    u16 *eth_addr, u16 *eth_addr_mask)
+			    u8 *eth_addr, u8 *eth_addr_mask)
 {
 	u16 *p;
+	u8 *am;
 	int j;
 
 	if (unlikely(bnxt_eth_addr_key_mask_invalid(eth_addr, eth_addr_mask)))
 		return -EINVAL;
 
-	if (!is_wildcard(&eth_addr_mask[0], ETH_ALEN)) {
-		if (!is_exactmatch(&eth_addr_mask[0], ETH_ALEN))
+	am = eth_addr_mask;
+	if (!is_wildcard(am, ETH_ALEN)) {
+		if (!is_exactmatch(am, ETH_ALEN))
 			return -EINVAL;
 		/* FW expects dmac to be in u16 array format */
-		p = eth_addr;
-		for (j = 0; j < 3; j++)
+		p = (u16 *)am;
+		for (j = 0; j < ETH_ALEN / 2; j++)
 			actions->l2_rewrite_dmac[j] = cpu_to_be16(*(p + j));
 	}
 
-	if (!is_wildcard(&eth_addr_mask[ETH_ALEN], ETH_ALEN)) {
-		if (!is_exactmatch(&eth_addr_mask[ETH_ALEN], ETH_ALEN))
+	am = eth_addr_mask + ETH_ALEN;
+	if (!is_wildcard(am, ETH_ALEN)) {
+		if (!is_exactmatch(am, ETH_ALEN))
 			return -EINVAL;
 		/* FW expects smac to be in u16 array format */
-		p = &eth_addr[ETH_ALEN / 2];
-		for (j = 0; j < 3; j++)
+		p = (u16 *)am;
+		for (j = 0; j < ETH_ALEN / 2; j++)
 			actions->l2_rewrite_smac[j] = cpu_to_be16(*(p + j));
 	}
 
@@ -285,12 +288,12 @@ static int bnxt_tc_parse_actions(struct bnxt *bp,
 	 * smac (6 bytes) if rewrite of both is specified, otherwise either
 	 * dmac or smac
 	 */
-	u16 eth_addr_mask[ETH_ALEN] = { 0 };
+	u8 eth_addr_mask[ETH_ALEN * 2] = { 0 };
 	/* Used to store the L2 rewrite key for dmac (6 bytes) followed by
 	 * smac (6 bytes) if rewrite of both is specified, otherwise either
 	 * dmac or smac
 	 */
-	u16 eth_addr[ETH_ALEN] = { 0 };
+	u8 eth_addr[ETH_ALEN * 2] = { 0 };
 	struct flow_action_entry *act;
 	int i, rc;
 
-- 
2.11.0

