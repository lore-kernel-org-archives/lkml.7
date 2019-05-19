Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B5C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DF1204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTnrrmFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfESRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:31:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:31:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so6056231pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QptrOrhoRrb+8UfSBrbIZc3gQ6845r98RHnMaT6MkU=;
        b=NTnrrmFjSAkT60/o3iMiUogVQSY9vFrlR941e/UEVCPbk7my1cYpToGhOVsbHjEFjP
         3zDpnUc4FdRMlgm1Nrblkd3XZHcr0l89OZGXVpBddWBkyN8DlU8yqG52Cm7Gv/LhXBrb
         HGo/AYFcgTGn9k0UqOK3iUF7FhvHyCNCjdpAt9DMwjzzCSLCLwJ9nJPF55vtRsK/i60/
         dJ3ViHfAyIgIxKd/5pLms/Hoidm6ba4JrcSSAvll88MZhanV1UHaXqgZJi/OXDs7W8HU
         qyKQGsRzok+Bt9Y5clcxEf1jtAIaXo+MNbWWfAF32omH6E857+EyzebipgXjQ4VebecE
         WuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QptrOrhoRrb+8UfSBrbIZc3gQ6845r98RHnMaT6MkU=;
        b=a+sZ8O8bOOlNLlT47epxv9788TGbnheGO8KMUTvqtoS3CCv60ZZNAkxnHfpBUvauYw
         Dqk3nGPxm1xBV36SRU+pSM05GOl5yBd24k20zQJwgnOgBWzujnSWPBkXtH6bJkY5N+UG
         2IzihTjVbUMYYs8aBr2h3Odl7z75vq9uh8caHo+Y7qz5zYC6L9wkumPo4ldq2VAhlnxu
         mIf8TobqVVvqDupd2NHFRNGPADLSWu0jGdiE55bV1+GtNV2E05zgUFynZaveflQjdCRz
         5sTlNOCM62rbpzEgo/+u7IgmjBTKvTB5cdmrQqkXvIZdZgP8dkRt+4P5HuM5fdM01Gon
         lCdg==
X-Gm-Message-State: APjAAAV9BBYeOwT/b+Pp3wIIbJPOPEoZyC2wRw2wC20+XVxw8Lb9wEud
        hLrAayvfpfMUXYQZg0ultJiXRS3F
X-Google-Smtp-Source: APXvYqzHNKOqcWO25MtIB2d+/lQBkISHLKuHtnvwtHM/ktImBVFZhohz6aCLT34vgGaW+GF85+FAwg==
X-Received: by 2002:a62:1483:: with SMTP id 125mr45143058pfu.137.1558278455161;
        Sun, 19 May 2019 08:07:35 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:34 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 7/7] nvme-pci: enable to trigger device coredump by hand
Date:   Mon, 20 May 2019 00:06:58 +0900
Message-Id: <1558278418-5702-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- No change since v3

 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6436e72..04084b9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3266,6 +3266,14 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
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
@@ -3281,6 +3289,10 @@ static void nvme_coredump_complete(struct nvme_dev *dev)
 {
 }
 
+static void nvme_coredump(struct device *dev)
+{
+}
+
 #endif /* CONFIG_DEV_COREDUMP */
 
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
@@ -3388,6 +3400,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
+		.coredump = nvme_coredump,
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
-- 
2.7.4

