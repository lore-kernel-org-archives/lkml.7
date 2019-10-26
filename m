Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44353CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113422070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096805;
	bh=p+9wNeaaJK3tknslsI7clvC4d7cRfeQbeiKGM+dfB7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1YTEUQmu1n+sVifNuVRJgqZmEiYYiwVG9YHbE+oqG2ggDHedC4DeqCBxYVI3G5P+w
	 knXZo42j240v3DiU+x3raa9j/7Bi0VYnH1XocVHx4jmjtkSC05FkbkaxC23vgvK+3W
	 TxnAmS+Tz2HsurTCkRRut47uKqXwczLghkGLesAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfJZNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfJZNSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:18:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 277E1214DA;
        Sat, 26 Oct 2019 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095884;
        bh=p+9wNeaaJK3tknslsI7clvC4d7cRfeQbeiKGM+dfB7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7LfC5x53NG5ar47z87+9TWYj0pLh9nX82H9PnIpeP3PkL4fVQkjTUKIfLTSKpn20
         GZWZvTmCBvNqn2xnz7AVDFfDRcL/5ZkZqb8B2CC3Pd58VwhRv9yUUAwoJGllHTgbPV
         wt/Y9+ZNO0MHgeofAJ8+OhxRk2VRgOKn1pXF6a7k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 70/99] net: aquantia: do not pass lro session with invalid tcp checksum
Date:   Sat, 26 Oct 2019 09:15:31 -0400
Message-Id: <20191026131600.2507-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit d08b9a0a3ebdf71b0aabe576c7dd48e57e80e0f0 ]

Individual descriptors on LRO TCP session should be checked
for CRC errors. It was discovered that HW recalculates
L4 checksums on LRO session and does not break it up on bad L4
csum.

Thus, driver should aggregate HW LRO L4 statuses from all individual
buffers of LRO session and drop packet if one of the buffers has bad
L4 checksum.

Fixes: f38f1ee8aeb2 ("net: aquantia: check rx csum for all packets in LRO session")
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 3901d7994ca15..76bdbe1596d62 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -313,6 +313,7 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 					break;
 
 				buff->is_error |= buff_->is_error;
+				buff->is_cso_err |= buff_->is_cso_err;
 
 			} while (!buff_->is_eop);
 
@@ -320,7 +321,7 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 				err = 0;
 				goto err_exit;
 			}
-			if (buff->is_error) {
+			if (buff->is_error || buff->is_cso_err) {
 				buff_ = buff;
 				do {
 					next_ = buff_->next,
-- 
2.20.1

