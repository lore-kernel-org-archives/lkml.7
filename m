Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F40C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838AF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004546;
	bh=fJ1V+VPyiiP3wYtPYmOrA2PYPLrQfGblkjGMH92NRT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqVliN7M0/m3yxUc8m/Bwchand/csx9wF9yUDrq+tt4tZMAHIhs8013wI0rGbPY+C
	 JFo1pHOc7/4aCWxS0RccDeVL9/unmJwiPmH3wrod9K8BtWGWbl0IdF/Z3GV7xDtKRa
	 RiH2zwF3yCV3VASYJ/VTFz9B55pypuoYPS2T88Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgABWfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbgABWfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B3C22314;
        Thu,  2 Jan 2020 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004540;
        bh=fJ1V+VPyiiP3wYtPYmOrA2PYPLrQfGblkjGMH92NRT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcKeugpw1sdc4jRywCFRcw8CsvrigATe4phALFhyfpg1S5hAQJ3OffLhN9BY42KfH
         fOphDS46mLSGpwJo7+z/dtveBIoUYRxP5gE6TZYYjuG5zkxFADNw/7j0SOBQlTimz2
         7zYW4sA5siSY5yuBAeTWNGglpa5337UYIIJtEPk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Bao Hou <houbao@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 049/137] ath10k: fix get invalid tx rate for Mesh metric
Date:   Thu,  2 Jan 2020 23:07:02 +0100
Message-Id: <20200102220553.192012345@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
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
index 6d1105ab4592..f9d0f8372e3f 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -96,6 +96,8 @@ void ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
+	info->status.rates[0].idx = -1;
+
 	trace_ath10k_txrx_tx_unref(ar, tx_done->msdu_id);
 
 	if (tx_done->discard) {
-- 
2.20.1



