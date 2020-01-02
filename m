Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342F20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005261;
	bh=mtzmqGg3QZ/YgGmPmq8BQn51XP27MECATe9X3l1cymk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyjb7ch+ZvF3qE1+wtxv9twetIXVEcEUeBcVMOlQyNfg1E6/fykmawEmKxHL4Z8zB
	 uAFeTjgL5GFQCVl1drYtjXSLO4SRZF8Q8uksCeWpgmtyTQRurDKtVfFvd+DcMUiLE+
	 Px4JVq0IWAclZEoMQXCyZQfjfUjBDz00ir+KAGPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgABWrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgABW3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B16C20866;
        Thu,  2 Jan 2020 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004159;
        bh=mtzmqGg3QZ/YgGmPmq8BQn51XP27MECATe9X3l1cymk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/iFHEDyoh712Vq2qS19TTEjRrwiBry+xbNcu/oEkJBg9lxwgRuQ/VbhjWyG9EuUk
         NKmF/dpqf8+xUfdapvaRtoz4btdoyePxAJdU7PWofbm1DDh7ag0egrmGucRbDNIrOy
         2U7mgUh4qbLYGWJPUb20s9RSKtCp0LdlJnBw0sI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Bao Hou <houbao@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 062/171] ath10k: fix get invalid tx rate for Mesh metric
Date:   Thu,  2 Jan 2020 23:06:33 +0100
Message-Id: <20200102220555.498918634@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqing Pan <miaoqing@codeaurora.org>

[ Upstream commit 05a11003a56507023f18d3249a4d4d119c0a3e9c ]

ath10k does not provide transmit rate info per MSDU
in tx completion, mark that as -1 so mac80211
will ignore the rates. This fixes mac80211 update Mesh
link metric with invalid transmit rate info.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Hou Bao Hou <houbao@codeaurora.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 9852c5d51139..beeb6be06939 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -99,6 +99,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
+	info->status.rates[0].idx = -1;
+
 	trace_ath10k_txrx_tx_unref(ar, tx_done->msdu_id);
 
 	if (tx_done->status == HTT_TX_COMPL_STATE_DISCARD) {
-- 
2.20.1



