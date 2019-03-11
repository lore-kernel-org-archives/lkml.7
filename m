Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB720C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838492064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334507;
	bh=08ZBeF8CLF3RZli4ixSGutjomqLkWrRsbuVh8n19LPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVQMqQYuXtpRn9jZYxTuvxi4pXHTstiBxtqsspCC0fSo7Y1WfcIUZtlKc2dhjrApf
	 KETB1EyjtcS7UCNHfo8nOpvFcP7Ib+fczmhdomdPn9Z8ainAWgXg5sQ4UvcGEeE5aK
	 4Z1gqz6JXUtCnSdwRFq290Q60Jqej6zamvhNOOa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfCKT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfCKT7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AACA2084F;
        Mon, 11 Mar 2019 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334352;
        bh=08ZBeF8CLF3RZli4ixSGutjomqLkWrRsbuVh8n19LPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoEjNVc6W0ANczXLVFz5pKmpoTHQNS69DWdFQDbHMoT6i2zcOvReieZFcpDUclqXY
         5P1Mkzna3EmcfiUXAn30XkJCSi9Y3OY3wPiH3QcW0wrdIAC4Dvb/Lrq+PvBYkT6Cqz
         9UvsOViIelso3VNb/LAPyAxFEURXd16j/zyg8QSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Fernandez <gabriel.fernandez@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/27] Input: st-keyscan - fix potential zalloc NULL dereference
Date:   Mon, 11 Mar 2019 15:58:24 -0400
Message-Id: <20190311195824.139043-27-sashal@kernel.org>
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

