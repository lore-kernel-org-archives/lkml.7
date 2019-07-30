Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094FCC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236F208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfG3Lr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:47:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfG3Lr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:47:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hsQbg-0002D7-Ms; Tue, 30 Jul 2019 11:47:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next][V2] mlxsw: spectrum_ptp: fix duplicated check on orig_egr_types
Date:   Tue, 30 Jul 2019 12:47:52 +0100
Message-Id: <20190730114752.24133-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently are duplicated checks on orig_egr_types which are
redundant, I believe this is a typo and should actually be
orig_ing_types || orig_egr_types instead of the expression
orig_egr_types || orig_egr_types.  Fix these.

Addresses-Coverity: ("Same on both sides")
Fixes: c6b36bdd04b5 ("mlxsw: spectrum_ptp: Increase parsing depth when PTP is enabled")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 98c5ba3200bc..63b07edd9d81 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -999,14 +999,14 @@ static int mlxsw_sp1_ptp_mtpppc_update(struct mlxsw_sp_port *mlxsw_sp_port,
 		}
 	}
 
-	if ((ing_types || egr_types) && !(orig_egr_types || orig_egr_types)) {
+	if ((ing_types || egr_types) && !(orig_ing_types || orig_egr_types)) {
 		err = mlxsw_sp_nve_inc_parsing_depth_get(mlxsw_sp);
 		if (err) {
 			netdev_err(mlxsw_sp_port->dev, "Failed to increase parsing depth");
 			return err;
 		}
 	}
-	if (!(ing_types || egr_types) && (orig_egr_types || orig_egr_types))
+	if (!(ing_types || egr_types) && (orig_ing_types || orig_egr_types))
 		mlxsw_sp_nve_inc_parsing_depth_put(mlxsw_sp);
 
 	return mlxsw_sp1_ptp_mtpppc_set(mlxsw_sp_port->mlxsw_sp,

--

V2: fix both occurances of this typo. Thanks to Petr Machata for spotting
    the 2nd occurrance
-- 
2.20.1

