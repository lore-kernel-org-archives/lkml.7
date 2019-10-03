Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24327C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF51220673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122646;
	bh=g187vndwyMzQFiDGPL8Bhd9t6/8cXzXzq/6xcOQIgj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUb5gR66h8foLroKd5lGt7cy9Yd+ik692X1t6xedqqPXUkh/W5iaMmn4tsuUfzuiL
	 qFpuq1ZNhlRARsLRXTHlQKB/hjZLOWR73Jl8KqggSJBe/n8PdsT5P80vjTM3B0meKf
	 huU+8VBMPMhb+9H9tq+vtqUQWaTTw33X8cTypXlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393441AbfJCRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403963AbfJCQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:32:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7789821783;
        Thu,  3 Oct 2019 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120360;
        bh=g187vndwyMzQFiDGPL8Bhd9t6/8cXzXzq/6xcOQIgj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM53Q1+plmpAjz1vYRMkPOqSL52DxqptPRvp9XmP4hSazY1l7q+Ee4G5Gt61NsX8G
         3HkccfH6KwWIEuRgygcguX7pDDHXwvp0rLWdGRUS8qKZz5IvVXrJsMwmuwxmWTqtfE
         m8uYrZG+u0lGA9yBn6sOvsV6HGHnGmJHIpWf4e3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 192/313] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Thu,  3 Oct 2019 17:52:50 +0200
Message-Id: <20191003154551.890683592@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
index 7ac3755444d3d..56a8ad506072c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
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



