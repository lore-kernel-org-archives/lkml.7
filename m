Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E03C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F522064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334408;
	bh=P3u4Anos50aB3NvsXsErWkQvqtWZ4/vqyqTg610MaqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hj/7oj/hNDsd4BAFYJ/AeBH9wanJWNvcJjV5mLSKyr6dnXSEX6UuFyFzb8peLHfyK
	 Y/3TMSy22t47vb9O1XWrOhN0SVtD+AHZ5WCCVVhbMsNLD40gjrEAVufBnJNcf990Kl
	 lDw3SDK/cEJ6ERwIJPa+t+STY9+iRslV96jaaQS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfCKUAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbfCKUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:00:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4D2214D8;
        Mon, 11 Mar 2019 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334403;
        bh=P3u4Anos50aB3NvsXsErWkQvqtWZ4/vqyqTg610MaqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIrIt8yAwhiqovKaz0iNUj2byoqIg6m6qGjov3zF7voXQg3MyejWXGsaVuOYkjLuu
         z/qGlpdZr08xyVWSTdzQPUKbxT9q/edlSx1DxQYL5WR0jQPr5OTy84ObK4ZDYbX5Id
         hJ8icj1VLTKriOWYiZQyU/G4IbZ0SCTnr+Lko2yo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Fernandez <gabriel.fernandez@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 6/6] Input: st-keyscan - fix potential zalloc NULL dereference
Date:   Mon, 11 Mar 2019 15:59:51 -0400
Message-Id: <20190311195951.139741-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195951.139741-1-sashal@kernel.org>
References: <20190311195951.139741-1-sashal@kernel.org>
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
index de7be4f03d91..ebf9f643d910 100644
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

