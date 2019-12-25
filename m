Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B77BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1C20727
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfp9lN39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLYX7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 18:59:19 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34813 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfLYX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 18:59:18 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so14412525vsf.1;
        Wed, 25 Dec 2019 15:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eeV4yIIWYgaDe+0HGyaX3G5vwQGFRzRfldoDZGG7ATw=;
        b=pfp9lN39jZKzaKlB7YxbCmiZQXgntyXwrtnShyfQSWYmlRoJGqU0hXnSktJwshnJmv
         2ukrC04W8WsPuLK600TejWolS22QMBfmeD7rLrwev9slnjKYoE9TE3t8IN0Q+woTH08H
         6xMC/rE6/yti96UoRyP3ccGG6agNWUOvl+pWwdYn41GLCFYHfYpY3SpM9XiTHcISSSIz
         FvEbWMtco9NbzwIOTVLJMFFFDcnaxSsGUR0fwEnFIsXnvqHMcuaLaoyZdyGs3ETTpoHV
         2JVe4NVLNr1FRIP3GXM0ivO/Y14VSevH0fXXhT02rXn4R5iCieGAIYK6EbJtjCQbNVw/
         6urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eeV4yIIWYgaDe+0HGyaX3G5vwQGFRzRfldoDZGG7ATw=;
        b=SWsiJ+db225NByK85uP/PjHAhQMF1GInT0pm/z5h5egmkf5Upy6M7TItjc3KVBM7nF
         27tn8ONZJVyyGG8Pj8I3eketuzNnnp9zZ4guAptjJEBK1X/XFljOq8E7k1SclnW7p69P
         CP0WbrqkHHp7Kh77nISZ8WPLnLkEq6khmYKnV+3gFYsn83PbObm/9KxqIclAqOUNTvLT
         VDw8fU0cUOE94UWmNnSc2bj+Vq3bNR0JxTS6TJ+c3SAAXcMWP61+cT1meYbHIEAagEEV
         OhXqWyaWccvPMw4J10T8T2Ra8je0KvrCXZwWjjnNMcIxgOZj/CZgNB/FRLbhLCySZETA
         BM0w==
X-Gm-Message-State: APjAAAVC+UBawKEak5MmjWax+H79qpqaEo9gqvX+u7T2/EB+QnIfWntY
        nJisyTcY500PDdr03cmSgQ==
X-Google-Smtp-Source: APXvYqzzjTdRkMHULcjtGD545V5rS+bD220HjiMKiZ4Rn2x/7A915elKHReE2sQOMpdkQu+GjZYjiw==
X-Received: by 2002:a67:ec8e:: with SMTP id h14mr15800242vsp.125.1577318357657;
        Wed, 25 Dec 2019 15:59:17 -0800 (PST)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id y186sm8205734vkc.47.2019.12.25.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 15:59:17 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: huawei-wmi: Fix a possible NULL deref
Date:   Wed, 25 Dec 2019 18:58:38 -0500
Message-Id: <20191225235841.14393-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're iterating over a NULL terminated array.

Fixes: 1ac9abeb2e5b ("platform/x86: huawei-wmi: Move to platform driver")
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index a2d846c4a7ee..42d461eeeff4 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -784,13 +784,13 @@ static const struct wmi_device_id huawei_wmi_events_id_table[] = {
 static int huawei_wmi_probe(struct platform_device *pdev)
 {
 	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
+	struct input_dev *idev = *huawei_wmi->idev;
 	int err;
 
 	platform_set_drvdata(pdev, huawei_wmi);
 	huawei_wmi->dev = &pdev->dev;
 
-	while (*guid->guid_string) {
-		struct input_dev *idev = *huawei_wmi->idev;
+	while (guid->guid_string) {
 
 		if (wmi_has_guid(guid->guid_string)) {
 			err = huawei_wmi_input_setup(&pdev->dev, guid->guid_string, &idev);
@@ -820,7 +820,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 {
 	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
 
-	while (*guid->guid_string) {
+	while (guid->guid_string) {
 		if (wmi_has_guid(guid->guid_string))
 			huawei_wmi_input_exit(&pdev->dev, guid->guid_string);
 

base-commit: 46cf053efec6a3a5f343fead837777efe8252a46
-- 
2.24.1

