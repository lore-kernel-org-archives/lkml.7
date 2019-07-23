Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29236C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1DF21903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioqX3pf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfGWMqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:46:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39301 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfGWMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:46:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so20611569pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqD68kCeUjLnMnjMcDvk6An8PGKZbr6I3VjMH7CQavU=;
        b=ioqX3pf2AXx4+ruf7u0grl5/sg5w01GEnvz5hinkDg93S923RNmBKgqlFYtXXDbB0i
         uShMa1QoNj2Rl0KlhwyK5XFKu6fvKFmwl5fS0XaeNV4nQZItdxtC9GsPtab/yDZ0U5sE
         bKaD1L0QdfUxUJMOrGkMIfgCGKR7dhfV/LBk61jEs6lFP+5NVd+6slpb5yuyf0Zu/JZl
         r5og3oTOYf+T53l2JFTtXtgYeBN4giGTqKasFBQmX+/FwwQm2+2SQkOstqF8Db0eWx7V
         IjwRFlHQu8TgY6oKO+lvCP57Re3pX/zCPFp1jOhVZyFSwfc4Ilq5lsZz6Yyyf56ZBWx1
         6xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqD68kCeUjLnMnjMcDvk6An8PGKZbr6I3VjMH7CQavU=;
        b=i/MD1AER0TZw9b/9KK+W1YCjk0N2GerZIsqGtRsDYQMDy1OSsEQfdCsMIiD5iIw8Ek
         Ki1K0dAc9ldXKX8f3V/EoC+56F8LgfbwW5gHXu1xg0diZZm/IbICCs0vuvQ+mrjQCkSk
         4Dio+6acAq92OuMkWpSuScX1pq0eSm/XjcK951JgfKTVhRj/Evf739hT4TOpNxB/PlaE
         5pfWyENsmInDD6F711tAkaft32Y1Gi7+Ci5rnQdkPC5tqH16xWRNrGb2c8HF8iijZ8gV
         EExkQDOIXc0OsCGC8jPi7U4MBaeukfLEeyyU8P/mdeiFnIH9Owx+nW07cbTuzKvYFsHz
         VqOg==
X-Gm-Message-State: APjAAAV677LRWjc3okSoCswyPZjtchrDJCd4V9hYAV1wZ08qCv7ElNa4
        AmrTKCrCYibAC5JwpQ7MW5Q=
X-Google-Smtp-Source: APXvYqyYoaqOvvayMf1QJzwsCxHgUGQSldq4g+XATVpQhRkgrl987jQ3qFZvjwCYRGvAQjXJNzCpdQ==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr82641670pls.189.1563885973897;
        Tue, 23 Jul 2019 05:46:13 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id l26sm31702686pgb.90.2019.07.23.05.46.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:46:13 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] habanalabs: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 20:46:08 +0800
Message-Id: <20190723124608.24617-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Split v1 into different subsystems

 drivers/misc/habanalabs/habanalabs_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 6f6dbe93f1df..678f61646ca9 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -295,8 +295,7 @@ void destroy_hdev(struct hl_device *hdev)
 
 static int hl_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct hl_device *hdev = pci_get_drvdata(pdev);
+	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	pr_debug("Going to suspend PCI device\n");
 
@@ -310,8 +309,7 @@ static int hl_pmops_suspend(struct device *dev)
 
 static int hl_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct hl_device *hdev = pci_get_drvdata(pdev);
+	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	pr_debug("Going to resume PCI device\n");
 
-- 
2.20.1

