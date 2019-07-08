Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54786C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36820659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfGHEz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:55:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGHEz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:55:58 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hkLgw-000317-8W; Mon, 08 Jul 2019 04:55:54 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     sasha.neftin@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] e1000e: disable force K1-off feature
Date:   Mon,  8 Jul 2019 12:55:46 +0800
Message-Id: <20190708045546.30160-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708045546.30160-1-kai.heng.feng@canonical.com>
References: <20190708045546.30160-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwardport from http://mails.dpdk.org/archives/dev/2016-November/050658.html

MAC-PHY desync may occur causing misdetection of link up event.
Disabling K1-off feature can work around the problem.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204057

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h      | 1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index eff75bd8a8f0..e3c71fd093ee 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -662,6 +662,7 @@ struct e1000_dev_spec_ich8lan {
 	bool kmrn_lock_loss_workaround_enabled;
 	struct e1000_shadow_ram shadow_ram[E1000_ICH8_SHADOW_RAM_WORDS];
 	bool nvm_k1_enabled;
+	bool disable_k1_off;
 	bool eee_disable;
 	u16 eee_lp_ability;
 	enum e1000_ulp_state ulp_state;
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 56f88a4e538c..c1e0e03dc5cb 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1538,6 +1538,9 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 				fextnvm6 &= ~E1000_FEXTNVM6_K1_OFF_ENABLE;
 		}
 
+		if (hw->dev_spec.ich8lan.disable_k1_off == true)
+			fextnvm6 &= ~E1000_FEXTNVM6_K1_OFF_ENABLE;
+
 		ew32(FEXTNVM6, fextnvm6);
 	}
 
-- 
2.17.1

