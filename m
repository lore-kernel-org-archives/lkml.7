Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19735C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F4D2767D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396472;
	bh=82S1Qqa4eAW0+cSX+eHPI4DSwXmWn7CYa0kAFadQiNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NH/pKhdf4qMZKaKlRXNn/3pO9lhLdclHpn7Hyz6VvVMCTjndYLOxbrKl8tTiWcscs
	 LqWlawgiW30jRTCdpqQl0W6Ff38VZqbVNg0tExxr21lLOqj5BkGgGqg1nwsZRFNdq1
	 KY4FAhE1EbgcyRA9nnieeLdBTFbG7nfUWnkdStmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfFANTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfFANTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:19:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C7127280;
        Sat,  1 Jun 2019 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395153;
        bh=82S1Qqa4eAW0+cSX+eHPI4DSwXmWn7CYa0kAFadQiNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0YN4p4UCq7pHmLso+uGE0m3J3XUwOgAgYFtgJs2KbkHxbUJnmFkI9+PLUiAjXvgRP
         gppA/7RtRzBpMLPX1NuLd9M4HY2dSefNZFwuV3UEHiYXJWp0UMTUgvyuEyjDlNx13a
         B9qFpWbfDOXdItc1FPvCZ/oC7aeyM0JWwEJ+reH4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 068/186] mmc: mmci: Prevent polling for busy detection in IRQ context
Date:   Sat,  1 Jun 2019 09:14:44 -0400
Message-Id: <20190601131653.24205-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

[ Upstream commit 8520ce1e17799b220ff421d4f39438c9c572ade3 ]

The IRQ handler, mmci_irq(), loops until all status bits have been cleared.
However, the status bit signaling busy in variant->busy_detect_flag, may be
set even if busy detection isn't monitored for the current request.

This may be the case for the CMD11 when switching the I/O voltage, which
leads to that mmci_irq() busy loops in IRQ context. Fix this problem, by
clearing the status bit for busy, before continuing to validate the
condition for the loop. This is safe, because the busy status detection has
already been taken care of by mmci_cmd_irq().

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14587b87..e27978c47db7d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1550,9 +1550,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Busy detection has been handled by mmci_cmd_irq() above.
+		 * Clear the status bit to prevent polling in IRQ context.
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.20.1

