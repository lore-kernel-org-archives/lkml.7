Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294CB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qebbgh0D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A1cKHuMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCMVTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:19:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfCMVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:19:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BD2960F3E; Wed, 13 Mar 2019 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511940;
        bh=NdyWw51FdCiasrhn8aoVze0c7SrIXnQvQ7iSa1pp9Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qebbgh0DDj2+NrRl9AKvvUZ3pZz8ktwQ+N0DE9gNzxPaPNvrxQVH9j9iNeu0NSDFa
         3Hsv96w306DPP/g1pl5v2QQaEq+/QN7fQZcY5wp4up8iZKmIyJq6/eRwFFjql6n+f9
         1tM3m+tV+Q5B/x2H1t8SjbYLmm9qF/MyI6caB3xM=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A15760A05;
        Wed, 13 Mar 2019 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511937;
        bh=NdyWw51FdCiasrhn8aoVze0c7SrIXnQvQ7iSa1pp9Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1cKHuMYShHBz/WLyE+7NuzV6iFFKD9b7HjlYZ5MK8QGhxBj0ScCWCNHwDDH3dCkd
         3NOXpCzQ2njtC8wxpnl5nCX6dfF8lcFBGsCrTqqdsv9vQKjKcieGEpXYk3likNb3RX
         FBxaomoi9Cu8nQn8RHOAILSjHc/IpOXLqWTtt5L8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A15760A05
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 02/10] irqdomain: add bus token DOMAIN_BUS_WAKEUP
Date:   Wed, 13 Mar 2019 15:18:36 -0600
Message-Id: <20190313211844.29416-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313211844.29416-1-ilina@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single controller can handle normal interrupts and wake-up interrupts
independently, with a different numbering space. It is thus crucial to
allow the driver for such a controller discriminate between the two.

A simple way to do so is to tag the wake-up irqdomain with a "bus token"
that indicates the wake-up domain. This slightly abuses the notion of
bus, but also radically simplifies the design of such a driver. Between
two evils, we choose the least damaging.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v4:
	- Update commit text
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..05055bc992ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,6 +82,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_WAKEUP,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

