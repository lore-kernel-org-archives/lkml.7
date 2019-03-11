Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE4F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334619;
	bh=cn+83GNjq6AbdEuFOaFITA5hUm4yTWgIqMi8OE0wapY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JMvoU1J5MAiC5eNPkn1UeL/Uo7HHsx8hz8sepnC253KQrSwL2rCTC+F4dxrD3+zlH
	 y9eM02p/qjsZR+RjNkzwlZed0LYCuAGLWehvZro9aT6pr4dEUqeq9svHyTB1JNd0r7
	 mrg27pMc9tc4kE+5pC3l77Pe/KiABEEfivbJ+As8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfCKUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbfCKT6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4812084F;
        Mon, 11 Mar 2019 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334326;
        bh=cn+83GNjq6AbdEuFOaFITA5hUm4yTWgIqMi8OE0wapY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsoIxNchWQL5It3uROESzKaasWbsB8+kLkOE/qIArFD6RLBncya+K9IUx1cf0d4lK
         tNls+r8KjCkLK69PcXT/Y+5zg/B74smg/+ZCmJxjC+CM+7etaasMItYP31cDNLYceI
         HJ2ynV+H4yupotLuLI4W8lkCPyXibpFYSVoIBXYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/27] Input: ps2-gpio - flush TX work when closing port
Date:   Mon, 11 Mar 2019 15:58:11 -0400
Message-Id: <20190311195824.139043-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 33a841ce5cef4ca6c18ad333248b6d273f54c839 ]

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index b50e3817f3c4..4a64ab30589c 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_delayed_work(&drvdata->tx_work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.19.1

