Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F063DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97D620578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207700;
	bh=iEfU6ZPCt9MjIIlaMRwGa+rdr1IuXQoK3n05WICoS5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+KV4k4iJst78oA8YMa9sAUWW6dKxBtdaBbcC+sIp10Pw3Ex1AV4sRRqvw51bazrZ
	 1HGKDpBfIXvxOP3BKdIS0hip3sFOFYXbk/pJ7h03h7ZdvesYZDkoUxGTjJOd78bZD3
	 LA7sMzfDjSej5L86pYlMwrReIiETitsmJgqV0owg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfEGFlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfEGFlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:41:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3C620675;
        Tue,  7 May 2019 05:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207695;
        bh=iEfU6ZPCt9MjIIlaMRwGa+rdr1IuXQoK3n05WICoS5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRm3OC9tUGeJ9mj8IRiY7tkanxsy1Cl4lWhin6FmGLCppUoHmvcmjADZuLQzJCep/
         QM1zGJjW1BHRVTr+t0JcpkgVO+A0+TyM5QJIWKztA0V5leCjvau1Lu06UF4IwXdvXh
         OzrZBsDHelROfhy+49kD2JWuQV3m4Zbl8JjOKVEQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/25] Input: snvs_pwrkey - initialize necessary driver data before enabling IRQ
Date:   Tue,  7 May 2019 01:41:06 -0400
Message-Id: <20190507054123.32514-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054123.32514-1-sashal@kernel.org>
References: <20190507054123.32514-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit bf2a7ca39fd3ab47ef71c621a7ee69d1813b1f97 ]

SNVS IRQ is requested before necessary driver data initialized,
if there is a pending IRQ during driver probe phase, kernel
NULL pointer panic will occur in IRQ handler. To avoid such
scenario, just initialize necessary driver data before enabling
IRQ. This patch is inspired by NXP's internal kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 7544888c4749..b8dbde746b4e 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -156,6 +156,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	pdata->input = input;
+	platform_set_drvdata(pdev, pdata);
+
 	error = devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
@@ -171,9 +174,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	pdata->input = input;
-	platform_set_drvdata(pdev, pdata);
-
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
 	return 0;
-- 
2.20.1

