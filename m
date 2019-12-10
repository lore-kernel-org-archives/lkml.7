Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B8F20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014228;
	bh=sQt0LJRwP8l7u0XzmMH3gzuiwAxNcY5FoECOg9RzGNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dyI51cnnN5YXnkX6qyhi81tVdU3Xgmn+hNAhZIa587GLQntKOKwwlUWuQkAy762nK
	 rdda56C4WDFM58NP8cPsAENTt8dDXzp8oT7WoDbTOwLJKJYhl0GuXJ2Pa5aUjyhoDN
	 14FYChqf6/wYLPfvjMPJLhbNE0LntjA8ZHNuIbuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfLJVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfLJVdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21CF20836;
        Tue, 10 Dec 2019 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013602;
        bh=sQt0LJRwP8l7u0XzmMH3gzuiwAxNcY5FoECOg9RzGNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXttTS0dO9PbsKFJxwxiUcZWmPbGZ23B5KbkBWCZG6dqQqGgAhyMaI31to8tFqYYV
         KN49y0GqnlLQMaBP3lILTU9tYRA36K2511Fu+1LhX8BhJTuL6UigfewIpkdNVdeFPC
         /M0ElkPFhrztTykyTmBWdpZ69BUjrz8qlwjyAjCs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 050/177] extcon: sm5502: Reset registers during initialization
Date:   Tue, 10 Dec 2019 16:30:14 -0500
Message-Id: <20191210213221.11921-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 6942635032cfd3e003e980d2dfa4e6323a3ce145 ]

On some devices (e.g. Samsung Galaxy A5 (2015)), the bootloader
seems to keep interrupts enabled for SM5502 when booting Linux.
Changing the cable state (i.e. plugging in a cable) - until the driver
is loaded - will therefore produce an interrupt that is never read.

In this situation, the cable state will be stuck forever on the
initial state because SM5502 stops sending interrupts.
This can be avoided by clearing those pending interrupts after
the driver has been loaded.

One way to do this is to reset all registers to default state
by writing to SM5502_REG_RESET. This ensures that we start from
a clean state, with all interrupts disabled.

Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-sm5502.c | 4 ++++
 drivers/extcon/extcon-sm5502.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 0cfb5a3efdf65..2efcd94f74fc6 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -69,6 +69,10 @@ struct sm5502_muic_info {
 /* Default value of SM5502 register to bring up MUIC device. */
 static struct reg_data sm5502_reg_data[] = {
 	{
+		.reg = SM5502_REG_RESET,
+		.val = SM5502_REG_RESET_MASK,
+		.invert = true,
+	}, {
 		.reg = SM5502_REG_CONTROL,
 		.val = SM5502_REG_CONTROL_MASK_INT_MASK,
 		.invert = false,
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index 974b53222f568..12f8b01e57538 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -241,6 +241,8 @@ enum sm5502_reg {
 #define DM_DP_SWITCH_UART			((DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DP_SHIFT) \
 						| (DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DM_SHIFT))
 
+#define SM5502_REG_RESET_MASK			(0x1)
+
 /* SM5502 Interrupts */
 enum sm5502_irq {
 	/* INT1 */
-- 
2.20.1

