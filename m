Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE97C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AA7208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLaGsnEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfELPzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43014 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfELPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so5145437plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NSicMFWjbWD88Z8OYiXMq0OpWbZms4tV6m9iLfRYwk=;
        b=NLaGsnEfT+5HzCg3xLdNw/k7DfR417SiGvB6mw3zPLPqzG50VaumHeo4S8t0Ot3HXn
         0YGWqc+c9E6lfQ15Wq9kO7SzoHBSnY4U01CS8LyUqNcbR0N4LJDSXXO3rfZZ8LrpjoL0
         7FQ39M3cy9kmNQgJ22unLA/1L2E0QaLiY5nj4hn1NQDm8whhN4Ed14IDxwAnuH1P4PPn
         K+p1RzQ28p/ioZPfAp7a/3kHpVaC7Mp5K0BbIRN+FIhYeKpXX0FfW2MxqNMeqx4kkRG9
         LB5YbzDDAzYfffW400cfJDz2VRkNvxJdb/9QNfhamPgrAGuP3E8QX/H1a71rULz6Uhv8
         wO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NSicMFWjbWD88Z8OYiXMq0OpWbZms4tV6m9iLfRYwk=;
        b=Ckz19aviU6cSdKCW/xX4KgZsoqbokUURMYCE4TeKZsb6X8DboXOWnlzb/Wd9k0A45I
         uBao86EG8fINRakSmw1lHm9YxW2MJ075oyDUMhS/PNJ445thmQs6IZZ3taWtEdp0kDt+
         DfU8vUlb62jAtve09huuYScpjrYDBhvQTncOfy+bZA1qVBJB7RX2mDtfgoBX1dtoYbpL
         2jwyxQgtNi3yMjiPm8l24wjsSNyDDxS24Tshy4O0WU9VkMdSYIUxsklwdVbjSZVSe99X
         RDO5sNCHL+DKPJLtDeyd4rNoj/p4CmmRxQ5JNB/9lSTpNXsEJPWiZezpGe23x8GRAjWq
         1lGQ==
X-Gm-Message-State: APjAAAU+dZIOK3wQVY/guNRe3V79+YQWeGWP74+Y22wj5dAYxSwJttXa
        1E0ROXhL6u4mxRY+dbdo9Cc=
X-Google-Smtp-Source: APXvYqzpucnDaVV+9QWzfN9AMvf8/RCf6mKKQPQaefH9m2mKDYkIJc5dyBnUu62JSgr+2XLHqSJTew==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr6727525plr.181.1557676500305;
        Sun, 12 May 2019 08:55:00 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:59 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 7/7] nvme-pci: enable to trigger device coredump by hand
Date:   Mon, 13 May 2019 00:54:17 +0900
Message-Id: <1557676457-4195-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a way to trigger the nvme device coredump by writing
anything to /sys/devices/.../coredump attribute.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- Extracted from 'add device coredump infrastructure' patch
- Avoid deadlock in .coredump callback

 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6522592..fad5395 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3288,6 +3288,14 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
 	nvme_coredump_clear(dev);
 }
 
+static void nvme_coredump(struct device *dev)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+
+	nvme_dev_disable(ndev, false, true);
+	nvme_reset_ctrl_sync(&ndev->ctrl);
+}
+
 #else
 
 static void nvme_coredump_init(struct nvme_dev *dev)
@@ -3302,6 +3310,10 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
 {
 }
 
+static void nvme_coredump(struct device *dev)
+{
+}
+
 #endif /* CONFIG_DEV_COREDUMP */
 
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
@@ -3409,6 +3421,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
+		.coredump = nvme_coredump,
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
-- 
2.7.4

