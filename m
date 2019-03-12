Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF959C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EDB2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410828;
	bh=dYrWIEYR/niLd3sQ82V4o8NDoT0CbW0kCsjACAnLics=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x03hliSy5gkJ1NGOwCvZziHfnqc2PBzk35UGExFr7RnEDnAHvcTCvyN4wv9hKUR8+
	 tRc55sOZHZt/dUcd3e1biCj7JOlcxjPbKgNIqSvrFIJ/ewrUWzF0IkWDFbQ3avAFV4
	 KaMbVTqWTnM99ENZsCj5S8HS9ge2eeFRnYG9hcWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCLRNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfCLRNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:08 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3D4217D8;
        Tue, 12 Mar 2019 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410787;
        bh=dYrWIEYR/niLd3sQ82V4o8NDoT0CbW0kCsjACAnLics=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw7L8szGnslh+aHgtwftxeaQ2+CfoB9bQy+aq6mltb9prZhyO9Lgliete0icr+2DV
         Y2lCyFJQqADD6lZAQBXY1pmxFsY1ZY4WqaLUk8Rfpqqdke6UHIZCjUf9VCiRb3pwve
         z117Mvl4aQN3yGOJ9++uq+PWNUjsZeGW1x60vghM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 109/171] ath10k: correct bus type for WCN3990
Date:   Tue, 12 Mar 2019 10:08:09 -0700
Message-Id: <20190312170357.367178274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2c2008a63e482654ab137c84d3c61c03b75e7df6 ]

WCN3990 is SNOC, not PCI. This prevents probing WCN3990.

Fixes: 367c899f622c ("ath10k: add bus type check in ath10k_init_hw_params")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 59fdda67f89f..0a3b2c45549e 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -548,7 +548,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
 		.dev_id = 0,
-		.bus = ATH10K_BUS_PCI,
+		.bus = ATH10K_BUS_SNOC,
 		.name = "wcn3990 hw1.0",
 		.continuous_frag_desc = true,
 		.tx_chain_mask = 0x7,
-- 
2.19.1



