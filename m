Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C6FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF5022CB8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n80Q06E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfGXMWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:22:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36450 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfGXMWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:22:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so21157377pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnYeQcZ+3/cVOK0YzE3A8jbfV436G2iFovE9bOEsOP0=;
        b=n80Q06E2UaCRMU/QOCTD6GPRnCPN9AfdEkmDzRzxRwDdy4JKzrw5Gi9EBM0Ka72w9Y
         SOPTvBTXfKMoXfoPvtyOtNHjOXVN1HQZ/uoOuK/e18AGB83AeHy6VKC4ej/M5dka1fPd
         UFjPLb5j/2JMvJJKI7X6+8zSex0IyrOvGzaUC8p4PDaufr7+G5BGloroRg8+RVFMGpac
         Cr6cMAiwOWEP2bx2gdVgTyD9JIbvg6Ey7e75J2hYgdBUnfBSbQlbHUEp5BX77t5aqi1H
         YqVhwDKlA9c7Sw5/0/49h6FILmGdH9sXLe9w2iUOu5jsbyTly5LVd4wWjsD2vIFzK6yP
         GDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnYeQcZ+3/cVOK0YzE3A8jbfV436G2iFovE9bOEsOP0=;
        b=Cs3diZNJR8dVygr3jWd6cNDiIaS2AUPHsK8Jyqj8ZvjI8uXMP/IlQPm6xzUH+1QtNz
         cDwvLveTqH53tvfQUQYsOB0lcFoFaaqYaRiy93F6GVg2EnoaCN36m35v/jTnGLyTf+/b
         QMtlranwB/UFle3/lFBSbjs44agP2ClVRlUG02FHiZOX0hFMyzEcUQCojkIZOBb8idk6
         sMdJdIottGmjI3pC2qM1H+Y7g0FsrYLR41CoZFJrNAabU95wMjAEcSDkuC/1Zs24yIFt
         uoQMNdSNtfULfjaEcFXHfs+4O56EZf0kbgT1T3T518oM/W81DgDisnZe49NqqlYCZLK8
         M5YQ==
X-Gm-Message-State: APjAAAUHL2RHVg1HcGOzgzWzvjudczk599+/saEc1o8Bklu1oxuZp6xV
        lOtMxRFdv4AHSIYz1PjGeKI=
X-Google-Smtp-Source: APXvYqzncmJ0bUgd6dB1KkSDBrJ2k1U8j8owNx0skXvoZOM5bAK43HhX7oDWYqv7Ggl0AwX+SEBDww==
X-Received: by 2002:a65:6152:: with SMTP id o18mr78419888pgv.279.1563970960118;
        Wed, 24 Jul 2019 05:22:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h26sm49952796pfq.64.2019.07.24.05.22.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:22:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] nvme-pci: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 20:22:35 +0800
Message-Id: <20190724122235.21639-1-hslester96@gmail.com>
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
 drivers/nvme/host/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb970ca82517..3c6411f4d590 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2845,7 +2845,7 @@ static int nvme_set_power_state(struct nvme_ctrl *ctrl, u32 ps)
 
 static int nvme_resume(struct device *dev)
 {
-	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 
 	if (pm_resume_via_firmware() || !ctrl->npss ||
@@ -2914,7 +2914,7 @@ static int nvme_suspend(struct device *dev)
 
 static int nvme_simple_suspend(struct device *dev)
 {
-	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_dev_disable(ndev, true);
 	return 0;
@@ -2922,8 +2922,7 @@ static int nvme_simple_suspend(struct device *dev)
 
 static int nvme_simple_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
-- 
2.20.1

