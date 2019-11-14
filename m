Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEE0206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JAEX+gBm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d6rd8ElG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKNSfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:35:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55686 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:35:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 56296613BE; Thu, 14 Nov 2019 18:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573756539;
        bh=XquyuQfB91e7bn6lPpm0Lbdv5e0EOYKYUsj1XyHNfvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAEX+gBmfI2kLBD7BaLvoY5Et8AbB1BrksNtJOjmKgVLv6cSY53WLfNetVsAYnsT/
         TS/q/e3kF2F5jxGZTNwfsI/QxKkulbuTGKnszQBVrk0ZFrAA6XxdHyb7+kK2JZIkbu
         eNqtzSCmmYpV5qCZ+o272N6RN9RGExOcuxs+PKWY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CB0D60FBB;
        Thu, 14 Nov 2019 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573756535;
        bh=XquyuQfB91e7bn6lPpm0Lbdv5e0EOYKYUsj1XyHNfvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6rd8ElGstGfxVny9JyYXujWx4iS+aDN70IVuiIhJ0MZa/Sc6rkg9ToV9vWvFTxDC
         6oOUKjwwe8CxISPNwM4W9ykY924tdf6z80/Rns8NUDAaYY9/CNpZXNPr5+vSBf6gjg
         Le8j1wCHe2LqrprQx+85AfzF2s8lY3IcXEoQyXJ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CB0D60FBB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, maz@kernel.org, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 01/12] irqdomain: add bus token DOMAIN_BUS_WAKEUP
Date:   Thu, 14 Nov 2019 11:35:10 -0700
Message-Id: <1573756521-27373-2-git-send-email-ilina@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573756521-27373-1-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org>
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
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 583e7ab..3c340db 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -83,6 +83,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
+	DOMAIN_BUS_WAKEUP,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

