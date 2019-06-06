Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EBC20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFFNK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:10:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:10:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hYsAP-0007iC-RR; Thu, 06 Jun 2019 13:10:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ixgbe: fix potential u32 overflow on shift
Date:   Thu,  6 Jun 2019 14:10:53 +0100
Message-Id: <20190606131053.25103-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The u32 variable rem is being shifted using u32 arithmetic however
it is being passed to div_u64 that expects the expression to be a u64.
The 32 bit shift may potentially overflow, so cast rem to a u64 before
shifting to avoid this.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: cd4583206990 ("ixgbe: implement support for SDP/PPS output on X550 hardware")
Fixes: 68d9676fc04e ("ixgbe: fix PTP SDP pin setup on X540 hardware")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 2c4d327fcc2e..ff229d0e9146 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -209,7 +209,7 @@ static void ixgbe_ptp_setup_sdp_X540(struct ixgbe_adapter *adapter)
 	 * assumes that the cycle counter shift is small enough to avoid
 	 * overflowing when shifting the remainder.
 	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 	trgttiml = (u32)clock_edge;
 	trgttimh = (u32)(clock_edge >> 32);
 
@@ -295,7 +295,7 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
 	 * assumes that the cycle counter shift is small enough to avoid
 	 * overflowing when shifting the remainder.
 	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 
 	/* X550 hardware stores the time in 32bits of 'billions of cycles' and
 	 * 32bits of 'cycles'. There's no guarantee that cycles represents
-- 
2.20.1

