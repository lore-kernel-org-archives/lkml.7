Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974142054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208519;
	bh=tuyRjUUl8DBu3Q6Ha5GE30FMDm2OuqzGt43sChtgKHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWeN0p0fnTNa4TgKX7X2/MB3WtSdY1niW1lKNCI8zOSJrWbjuPOcpzUTSmWto4VkA
	 UOq0cTzpAnl0xc/mZzThhe6CnrjC/+2saFkDBPw0j52bxw6uRKvxZzKPGk979esnHA
	 G++F2ZJSPgUOq8qK0myv+W19baFeABZOPOGvml9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfEGFzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfEGFiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:38:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5441C214AE;
        Tue,  7 May 2019 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207495;
        bh=tuyRjUUl8DBu3Q6Ha5GE30FMDm2OuqzGt43sChtgKHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrLjiNZ185uCITSV+7jFw8IQ7AWu8TKtklsIAkVssAUYAg/PL8HO++QoH89AMgBjE
         d34tpXrFsrGXiEFNsKJe90m3yABySgbkd8yVKFjnGM6numfFgRw/RFq4b7g1RLbkIj
         xwhEeEQFsQ5ccpc1YOPl6dU5TQNa3m0BXW6hCkZc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 77/81] net/tls: fix the IV leaks
Date:   Tue,  7 May 2019 01:35:48 -0400
Message-Id: <20190507053554.30848-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 5a03bc73abed6ae196c15e9950afde19d48be12c ]

Commit f66de3ee2c16 ("net/tls: Split conf to rx + tx") made
freeing of IV and record sequence number conditional to SW
path only, but commit e8f69799810c ("net/tls: Add generic NIC
offload infrastructure") also allocates that state for the
device offload configuration.  Remember to free it.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tls/tls_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c9588b682db4..6fab4340fd77 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -52,8 +52,11 @@ static DEFINE_SPINLOCK(tls_device_lock);
 
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
-	if (ctx->tx_conf == TLS_HW)
+	if (ctx->tx_conf == TLS_HW) {
 		kfree(tls_offload_ctx_tx(ctx));
+		kfree(ctx->tx.rec_seq);
+		kfree(ctx->tx.iv);
+	}
 
 	if (ctx->rx_conf == TLS_HW)
 		kfree(tls_offload_ctx_rx(ctx));
-- 
2.20.1

