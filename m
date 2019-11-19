Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CE9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966821823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141334;
	bh=cE+XnpIA2UlQ3+nHh+xT7kPEuciIqH7gZf5c/sPtmCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8xFud79Ez9OJksM2kB9zXhMrm6k5XOxsrAiNgTs6jPVSkYC/+GBJcDkmsjqxReg0
	 16AtuBy93WtIj7yBZrlfuPgdOei8zqfmAgLFPOcmD0dPWP3lyO6mLOGSuAMljKio8s
	 iTCMJ00nLOlmFYcOclFpmUXlnwN97Xg1IlaI6EWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfKSF2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfKSF2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:28:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0D6208C3;
        Tue, 19 Nov 2019 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141330;
        bh=cE+XnpIA2UlQ3+nHh+xT7kPEuciIqH7gZf5c/sPtmCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRpYnNcHvoa3KK0R9hkS9V0RU1c4s1MlTLq3zD4eZVoGsRRVjtrpoaVL3DRZDldkx
         XYg8/85VzslNk3vUXSL64fEnG8IiAZVqV5jT9vUJR0GQu6eGxTZ+q/iU3j5sBUBCHa
         AiNYtrHGK1fOzCa/VVhBSEPbqSv0YO0VVTJdeZXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vidya Dharmaraju <vidyad@marvell.com>,
        Cathy Luo <cluo@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/422] mwifiex: do no submit URB in suspended state
Date:   Tue, 19 Nov 2019 06:14:54 +0100
Message-Id: <20191119051405.574997628@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapathi Bhat <gbhat@marvell.com>

[ Upstream commit 7bd4628c2f31c51254aa39628ecae521d00d0b90 ]

There is a possible race between USB suspend and main thread:

1. After processing the command response, main thread will submit
rx_cmd URB back so as to process next command response, by
calling mwifiex_usb_submit_rx_urb.

2. During USB suspend, the suspend handler will check if rx_cmd
URB is pending(submitted) and if true, kill this URB.

There is a possible race between #1 and #2, where rx_cmd URB will
be submitted by main thread(#1) after the suspend handler check
in #2.

To fix this, check if device is already suspended in
mwifiex_usb_submit_rx_urb, in which case do not submit the URB.

Signed-off-by: Vidya Dharmaraju <vidyad@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 433c6a16870b6..76d80fd545236 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -298,6 +298,13 @@ static int mwifiex_usb_submit_rx_urb(struct urb_context *ctx, int size)
 	struct mwifiex_adapter *adapter = ctx->adapter;
 	struct usb_card_rec *card = (struct usb_card_rec *)adapter->card;
 
+	if (test_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: card removed/suspended, EP %d rx_cmd URB submit skipped\n",
+			    __func__, ctx->ep);
+		return -1;
+	}
+
 	if (card->rx_cmd_ep != ctx->ep) {
 		ctx->skb = dev_alloc_skb(size);
 		if (!ctx->skb) {
-- 
2.20.1



