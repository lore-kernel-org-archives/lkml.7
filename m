Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902E2C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AB621783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119637;
	bh=DWNzfLJ61MFerPbmG0E1WG/O8uncf6ZwntcksS8TIQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwN4rmLaFsNetFvmA4Tu/w6UtwAxvjYeEPIY0xOe1kGRU4S13tSYfurf630v/3+Bd
	 mRLrthiko0QTrUOoYJgRa/2XJz78Bp/wg+pIIGzUHrNtaSZuYWV0My4HEpxFzJv6MD
	 6dzFqjo9OHbdAGZYkoPIlgAJ7zCjJEha0MP7Vqv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbfJCQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732597AbfJCQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:20:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E6720865;
        Thu,  3 Oct 2019 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119630;
        bh=DWNzfLJ61MFerPbmG0E1WG/O8uncf6ZwntcksS8TIQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRMzGFRN5mYsANSMvD3kQr2jiOK/uNlSlrT9HrsjDYLM4kdvnQm9XpXSEk9QhX1bP
         8/qceJmtVZqm+tdYyJUUeBUJYA8zDbXtLy9CvW9RkZylY7eZAXShNdT0zi4R3rXWex
         Hk7Q9kE/2jFlOcYmH7E6OZfqUBCs2NHwNkBEy2Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 135/211] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Thu,  3 Oct 2019 17:53:21 +0200
Message-Id: <20191003154517.961917276@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit bd880b00697befb73eff7220ee20bdae4fdd487b ]

To avoid each host driver supporting SDIO IRQs, from keeping track
internally about if SDIO IRQs has been claimed, let's introduce a common
helper function, sdio_irq_claimed().

The function returns true if SDIO IRQs are claimed, via using the
information about the number of claimed irqs. This is safe, even without
any locks, as long as the helper function is called only from
runtime/system suspend callbacks of the host driver.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmc/host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2ff52de1c2b89..840462ed1ec7e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -488,6 +488,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
 
+/*
+ * May be called from host driver's system/runtime suspend/resume callbacks,
+ * to know if SDIO IRQs has been claimed.
+ */
+static inline bool sdio_irq_claimed(struct mmc_host *host)
+{
+	return host->sdio_irqs > 0;
+}
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
2.20.1



