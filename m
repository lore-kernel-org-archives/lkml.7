Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782795;
	bh=2N4Y9xksKY4hiMNzYExeA6o7SGmT7mrkpbxqZrLxnAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3mvTru3bwA6xEMWNHZQ3Ny2XE+5M/ke3J8E9TKbcEE1fx6auHe2frX7V2AafADWm
	 GAPELkr+AfKJMHJ25zlha+PAWjLko2ul4SpUchl4OQWTtHXefNFMj6NIUtc00vnsYu
	 H6R9qHZRAlvE+jP3toK2KCzl43dRViAjpKwGBQeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfLSTNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfLSSfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:35:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F7D24672;
        Thu, 19 Dec 2019 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780539;
        bh=2N4Y9xksKY4hiMNzYExeA6o7SGmT7mrkpbxqZrLxnAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxMJ1eEDhI2oCOgiDy9KMHDqoed53ZlJMeSr19lquInq4Pcw9K3VDVBj8fXB9qBD5
         tYnk3e3WWWicvjjFKzy4+jjJRApGEo/ig8GviQG+aDfHxO+W5uCFK6rXUCTYkXpuYI
         EFIPBT9Jnle8BH1WtPExs08XefryC/DBjcaR4Zxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 016/162] extcon: max8997: Fix lack of path setting in USB device mode
Date:   Thu, 19 Dec 2019 19:32:04 +0100
Message-Id: <20191219183206.742077693@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit a2dc50914744eea9f83a70a5db0486be625e5dc0 ]

MAX8997 driver disables automatic path selection from MicroUSB connector
and manually sets path to either UART or USB lines. However the code for
setting USB path worked only for USB host mode (when ID pin is set
to ground). When standard USB cable (USB device mode) is connected, path
registers are not touched. This means that once the non-USB accessory is
connected to MAX8997-operated micro USB port, the path is no longer set
to USB and USB device mode doesn't work. This patch fixes it by setting
USB path both for USB and USB host modes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-max8997.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index b2b13b3dce147..3d6b42f61f56e 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -320,12 +320,10 @@ static int max8997_muic_handle_usb(struct max8997_muic_info *info,
 {
 	int ret = 0;
 
-	if (usb_type == MAX8997_USB_HOST) {
-		ret = max8997_muic_set_path(info, info->path_usb, attached);
-		if (ret < 0) {
-			dev_err(info->dev, "failed to update muic register\n");
-			return ret;
-		}
+	ret = max8997_muic_set_path(info, info->path_usb, attached);
+	if (ret < 0) {
+		dev_err(info->dev, "failed to update muic register\n");
+		return ret;
 	}
 
 	switch (usb_type) {
-- 
2.20.1



