Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD521738
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334224;
	bh=08ZBeF8CLF3RZli4ixSGutjomqLkWrRsbuVh8n19LPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UwQxDgmzvjcE9S6IIP582Eo5Rg6oH5dJ2UD554TeacUIeNqisR+szjFcmVnjLI5h+
	 WNkyIVEF36fEkTQsGurDAKUSTciaeQoSXN9l5AetujEnPEWN01YRHSPK5hDz9Nl43X
	 FO89/tG6QUXoJKigev2s5zbWetMElqHkwj/7xNeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfCKT5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfCKT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B102087C;
        Mon, 11 Mar 2019 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334219;
        bh=08ZBeF8CLF3RZli4ixSGutjomqLkWrRsbuVh8n19LPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9WNeBmAisu40I9Qfg6PiVybxOnxdnAPlHZxkMhK2yJYDPirqojEu7fvl0xjx4po2
         S62aY2Z8B5K+nHWAEQ+2rItc9TRZkSjUTMM7YQ+5ice+kAEKnCvAjqBxi3dQRQFaje
         8tOBBMSiBV/DgMRxSK0EOPF+R7oVymoyNC+iTngs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Fernandez <gabriel.fernandez@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 52/52] Input: st-keyscan - fix potential zalloc NULL dereference
Date:   Mon, 11 Mar 2019 15:55:16 -0400
Message-Id: <20190311195516.137772-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

[ Upstream commit 2439d37e1bf8a34d437573c086572abe0f3f1b15 ]

This patch fixes the following static checker warning:

drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
error: potential zalloc NULL dereference: 'keypad_data->input_dev'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/st-keyscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index babcfb165e4f..3b85631fde91 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -153,6 +153,8 @@ static int keyscan_probe(struct platform_device *pdev)
 
 	input_dev->id.bustype = BUS_HOST;
 
+	keypad_data->input_dev = input_dev;
+
 	error = keypad_matrix_key_parse_dt(keypad_data);
 	if (error)
 		return error;
@@ -168,8 +170,6 @@ static int keyscan_probe(struct platform_device *pdev)
 
 	input_set_drvdata(input_dev, keypad_data);
 
-	keypad_data->input_dev = input_dev;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(keypad_data->base))
-- 
2.19.1

