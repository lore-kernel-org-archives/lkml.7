Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0862205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431290;
	bh=LXM8VJBQi1iN73pSbp6UozmuKSPd1Mh6D0Wfx/2GxcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HiCuhbgs+Vxp3+p6HhCgsFpLbTHbFBvybW6tgjFLnUg3nxaL4+ROwDh8nd31op54U
	 lUzg6x86hMBz1l6+58DN/Tqgb0WwULjkknrE9jOI4pgMMzlLDS4GMt7+FX0rSw6jx7
	 KWBtliKLLcCJSHT0+ZpbgJhGJExUyjUC5+Crhh7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfG2T13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfG2T1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:27:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3DA21655;
        Mon, 29 Jul 2019 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428443;
        bh=LXM8VJBQi1iN73pSbp6UozmuKSPd1Mh6D0Wfx/2GxcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf6oueWBiDvaqetG/7sw/QiELbRPOuD6sFuE6WagrFCXUbsioqNG45q0D2ktsso4I
         KZiKIXMgvvmfMPlH/xCi1KmRMcY4NY7HcrqFI9wsihDE0trywseIH7eQZgZn8j8VnN
         02XR2eFtMZob2/HqQQfMRa9mObXhbENhOESpP+do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/293] ath10k: fix PCIE device wake up failed
Date:   Mon, 29 Jul 2019 21:19:29 +0200
Message-Id: <20190729190830.601225249@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 011d4111c8c602ea829fa4917af1818eb0500a90 ]

Observed PCIE device wake up failed after ~120 iterations of
soft-reboot test. The error message is
"ath10k_pci 0000:01:00.0: failed to wake up device : -110"

The call trace as below:
ath10k_pci_probe -> ath10k_pci_force_wake -> ath10k_pci_wake_wait ->
ath10k_pci_is_awake

Once trigger the device to wake up, we will continuously check the RTC
state until it returns RTC_STATE_V_ON or timeout.

But for QCA99x0 chips, we use wrong value for RTC_STATE_V_ON.
Occasionally, we get 0x7 on the fist read, we thought as a failure
case, but actually is the right value, also verified with the spec.
So fix the issue by changing RTC_STATE_V_ON from 0x5 to 0x7, passed
~2000 iterations.

Tested HW: QCA9984

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index a860691d635d..e96534cd3d8b 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -168,7 +168,7 @@ const struct ath10k_hw_values qca6174_values = {
 };
 
 const struct ath10k_hw_values qca99x0_values = {
-	.rtc_state_val_on		= 5,
+	.rtc_state_val_on		= 7,
 	.ce_count			= 12,
 	.msi_assign_ce_max		= 12,
 	.num_target_ce_config_wlan	= 10,
-- 
2.20.1



