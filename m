Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4BAC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B56F21872
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWuUDd9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfE2GYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:24:24 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:59992 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfE2GYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:24:23 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 02:24:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZdPphefzlMESscBLlx
        sYKjtJRw7OPChqniARbyt54IE=; b=pWuUDd9HnWKG6/VDfV1I7jIR1j8INfRD9l
        YIe/arGo5g4RsptJOPT0KjMU0nOWyfVX5pG6Mr+hAk1pX3vooE2k59YlKxI3Nqw3
        YANXb+oyLSV8YCKjjlN+kQuDfGwjfHczaspMw+OGP5VRDzW1uHfuuX3sMTtebZEO
        2ueK34pF4=
Received: from localhost.localdomain (unknown [218.106.182.173])
        by smtp19 (Coremail) with SMTP id HdxpCgCH9Yv_Ie5cxgcSAA--.153S3;
        Wed, 29 May 2019 14:09:07 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Xidong Wang <wangxidong_97@163.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi: esas2r: esas2r_init: check return value
Date:   Wed, 29 May 2019 14:09:00 +0800
Message-Id: <1559110140-3544-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgCH9Yv_Ie5cxgcSAA--.153S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1ruFW5CFWkJFW3GF17ZFb_yoWxKFg_Wr
        ZrAr1xZr47CF1xtryftFy3ArZ09r48ZFsYgr1rtayfZ34xWr1DWr4UXr17Zws7W3y8uFyU
        Aa90vryFyr1jyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRlAp3UUUUU==
X-Originating-IP: [218.106.182.173]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbivgPD81ZcV9Zx0AAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In esas2r_resume(), the return value of pci_enable_device() is not
checked before pdev is used.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/scsi/esas2r/esas2r_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 950cd92..883d35f 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -686,6 +686,9 @@ int esas2r_resume(struct pci_dev *pdev)
 	esas2r_log_dev(ESAS2R_LOG_INFO, &(pdev->dev),
 		       "pci_enable_device() called");
 	rez = pci_enable_device(pdev);
+	if (rez < 0) {
+		goto error_exit;
+	}
 	pci_set_master(pdev);
 
 	if (!a) {
-- 
2.7.4

