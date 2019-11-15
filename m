Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E355620729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdyazIcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKOF3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:29:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33693 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfKOF3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:29:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so5875862pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 21:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9I5FqW0z8fenw97nfBVEeoAsOoFr9Mv0e0uFaFX9H0=;
        b=KdyazIcVt/KrZ4Q4dPukr55+0f+LWN3FdURkiejEjDxeIaipIHVsXos1gZ7NOv5oAC
         nBCU6ZcNEllQVcTxPM68PAW4OKdhuUVgvhoaKG9dWWFK2T3anLrxqjrWgpudcjZfD4Mh
         ArgbCrLslQ6DK1H1FpXuVXtZvw6Lu0L2HKHTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9I5FqW0z8fenw97nfBVEeoAsOoFr9Mv0e0uFaFX9H0=;
        b=h7v8wIp+0xpkQhrL5ZbyuIrvZWzDYBLz4h//AWOVexlbvpQxoDmDNhMD0mAg4pMmH8
         v8TAv0OG8raZnpIkHhuhPfygQeJ6m6T7yVSGgqcLZ77eauwgCj5bFEuvtPfkmTFLq5fk
         9zpumRmemVdgqXqddCs+2XPjgNWp0hwmyFPd4VkN4zOPQ0E/JbsiOJUXCHjN6eq7tuLx
         W2LFxdUotrWlwL7adX9oOk7EHyVw53rQyA6GI5KM+7wVwy1iag0GKRbDjVrfvpRO9R4C
         L/d5DlCXH5tmX3TGJSAMXw/JbHPKZOoUvNwMVP0yNniIKvuR+wTHvAX+RaczF560+xcP
         2LXg==
X-Gm-Message-State: APjAAAU0BCsUepg5LX/5ilfc0I82hYZ0QAnWuoxX7gJ3nOam40LINwQq
        xcnka7CDzALa5RPxXQYL4LavvFF8+9U=
X-Google-Smtp-Source: APXvYqwc5nrGGxexFGky4nRCM5cHAELptoH7k4Z94evZphJre2euyv6XPNoAvpYGEjuz34jD3TFjNQ==
X-Received: by 2002:a63:535c:: with SMTP id t28mr1441537pgl.173.1573795786355;
        Thu, 14 Nov 2019 21:29:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r33sm8438101pjb.5.2019.11.14.21.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 21:29:42 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        Sami Tolvanen <samitolvanen@google.com>,
        netdev@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] bnx2x: Remove hw_reset_t function casts
Date:   Thu, 14 Nov 2019 21:07:15 -0800
Message-Id: <20191115050715.6247-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115050715.6247-1-keescook@chromium.org>
References: <20191115050715.6247-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All .rw_reset callbacks except bnx2x_84833_hw_reset_phy() use a
void return type. No callers of .hw_reset check a return value and
bnx2x_84833_hw_reset_phy() unconditionally returns 0. Remove all
hw_reset_t casts and fix the return type to void.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 7dd35aa75925..9638d65d8261 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -10201,8 +10201,8 @@ static u8 bnx2x_84833_get_reset_gpios(struct bnx2x *bp,
 	return reset_gpios;
 }
 
-static int bnx2x_84833_hw_reset_phy(struct bnx2x_phy *phy,
-				struct link_params *params)
+static void bnx2x_84833_hw_reset_phy(struct bnx2x_phy *phy,
+				     struct link_params *params)
 {
 	struct bnx2x *bp = params->bp;
 	u8 reset_gpios;
@@ -10230,8 +10230,6 @@ static int bnx2x_84833_hw_reset_phy(struct bnx2x_phy *phy,
 	udelay(10);
 	DP(NETIF_MSG_LINK, "84833 hw reset on pin values 0x%x\n",
 		reset_gpios);
-
-	return 0;
 }
 
 static int bnx2x_8483x_disable_eee(struct bnx2x_phy *phy,
@@ -11737,7 +11735,7 @@ static const struct bnx2x_phy phy_warpcore = {
 	.link_reset	= bnx2x_warpcore_link_reset,
 	.config_loopback = bnx2x_set_warpcore_loopback,
 	.format_fw_ver	= NULL,
-	.hw_reset	= (hw_reset_t)bnx2x_warpcore_hw_reset,
+	.hw_reset	= bnx2x_warpcore_hw_reset,
 	.set_link_led	= NULL,
 	.phy_specific_func = NULL
 };
@@ -11768,7 +11766,7 @@ static const struct bnx2x_phy phy_7101 = {
 	.link_reset	= bnx2x_common_ext_link_reset,
 	.config_loopback = bnx2x_7101_config_loopback,
 	.format_fw_ver	= bnx2x_7101_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_7101_hw_reset,
+	.hw_reset	= bnx2x_7101_hw_reset,
 	.set_link_led	= bnx2x_7101_set_link_led,
 	.phy_specific_func = NULL
 };
@@ -11919,7 +11917,7 @@ static const struct bnx2x_phy phy_8727 = {
 	.link_reset	= bnx2x_8727_link_reset,
 	.config_loopback = NULL,
 	.format_fw_ver	= bnx2x_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_8727_hw_reset,
+	.hw_reset	= bnx2x_8727_hw_reset,
 	.set_link_led	= bnx2x_8727_set_link_led,
 	.phy_specific_func = bnx2x_8727_specific_func
 };
@@ -11954,7 +11952,7 @@ static const struct bnx2x_phy phy_8481 = {
 	.link_reset	= bnx2x_8481_link_reset,
 	.config_loopback = NULL,
 	.format_fw_ver	= bnx2x_848xx_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_8481_hw_reset,
+	.hw_reset	= bnx2x_8481_hw_reset,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = NULL
 };
@@ -12026,7 +12024,7 @@ static const struct bnx2x_phy phy_84833 = {
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
 	.format_fw_ver	= bnx2x_848xx_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
+	.hw_reset	= bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
 };
@@ -12060,7 +12058,7 @@ static const struct bnx2x_phy phy_84834 = {
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
 	.format_fw_ver	= bnx2x_848xx_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
+	.hw_reset	= bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
 };
@@ -12094,7 +12092,7 @@ static const struct bnx2x_phy phy_84858 = {
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
 	.format_fw_ver	= bnx2x_8485x_format_ver,
-	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
+	.hw_reset	= bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
 };
-- 
2.17.1

