Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20EE218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254531;
	bh=KQCThzqkvF2ZszDll8dAsl5G8qgTPoQ5LcymjWwtHfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fjMkPTlpRqLej2KxXjMLCkw3Z0LKVqfrfjTm/BuFdSw6PItH388n9tqsMBe1VmZ4L
	 opAEYz2H1EPvmS77VCrRGMZdyyEjli+M9ATZQDGltHS3cYe6ZWotkOBABBe7GcsOxQ
	 KtkA2RWksw9TYGZjr+De9eF7Wz6Vb7jNrkrz/Seg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfCVLfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbfCVLfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3192183E;
        Fri, 22 Mar 2019 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254524;
        bh=KQCThzqkvF2ZszDll8dAsl5G8qgTPoQ5LcymjWwtHfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1etHeK1xsUclOlAxEMvrWMR3UobINxS7MzsWOzOQUf9YqyIvfDEMlfTGrxm6WZyRF
         hewNi0NuDcDLb/DVaajPlPgoGr0ekxh6dx+iFdH2QvaaKBbEhHGB2Fi+OuKbE4SVoj
         jXQgDZjyYvIL5xnmo+uw8YOiwjjQW39gQAosureY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 162/230] Input: st-keyscan - fix potential zalloc NULL dereference
Date:   Fri, 22 Mar 2019 12:15:00 +0100
Message-Id: <20190322111248.089530843@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



