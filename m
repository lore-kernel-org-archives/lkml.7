Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14AFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9818720659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996637;
	bh=zYbnSIlh1CYPwa/rYl08boDxb02DeloIueOXb7BDvdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/OjTtm750jTVLoYQ9otn7L92sh16cuOKv2dCgXBkadhdbBLlwvEuiFz9nEvUpDwx
	 J24CWtkVKw+x/d2asNU4WOjsFH8z/T+oY5RSvwHNOmsamxRMFMqKHqlVpII3BJVVi3
	 8dvXEpCWiTmaSp50bZ8i9TguSy/YjdecGYsbnI1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfGXTag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388118AbfGXTad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:30:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDDC22ADC;
        Wed, 24 Jul 2019 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996633;
        bh=zYbnSIlh1CYPwa/rYl08boDxb02DeloIueOXb7BDvdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0BF4vCP/s+WrRiKoNZTUeezvEjqo0LgwC7R3svXYIACZwKk5pt07MZovs850l2bK
         kmu9Se/Bo50LlNA2hFcjAGLGsD3znyYiAYSjNwtcLvCfrrzbs8/hec4uC6cpFb5U1I
         w2HIJGIXFABNCkLrru5cjIX1vSqKMga+jGX8godk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 162/413] ath10k: fix PCIE device wake up failed
Date:   Wed, 24 Jul 2019 21:17:33 +0200
Message-Id: <20190724191746.666996998@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
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
index ad082b7d7643..b242085c3c16 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -158,7 +158,7 @@ const struct ath10k_hw_values qca6174_values = {
 };
 
 const struct ath10k_hw_values qca99x0_values = {
-	.rtc_state_val_on		= 5,
+	.rtc_state_val_on		= 7,
 	.ce_count			= 12,
 	.msi_assign_ce_max		= 12,
 	.num_target_ce_config_wlan	= 10,
-- 
2.20.1



