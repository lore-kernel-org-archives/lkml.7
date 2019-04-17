Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF0C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p9Jf6mR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfDQH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:56:17 -0400
Received: from proxy22674.mail.163.com ([113.108.226.74]:47252 "EHLO
        proxy22674.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfDQH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:56:14 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2019 03:56:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EJs+Pn75tQ8zEK66nG
        hKJeT69tU9ljVkzK9qJi3DK2M=; b=p9Jf6mR4GutUpUfvZC6M4w/RMVT9KPaQ1m
        UcujxjgBm7hO5LUtDDJFmKPtYQrfH8gjV3JQFlsesZQAXvgjJNtkQYRgShvQUKmY
        2EjOBsmGFQ6+uZkSDJ02PDCgUmX+1eKxJnZRwXFYQtEKNgNVYpni+bMBCyV+Von8
        kOmUlIO4o=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp3 (Coremail) with SMTP id DdGowADn99dY2LZcr4YVAA--.35S3;
        Wed, 17 Apr 2019 15:40:11 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Willem Riede <osst@riede.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     osst-users@lists.sourceforge.net, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: scsi: osst: drop SCSI devie reference taken before
Date:   Wed, 17 Apr 2019 15:40:00 +0800
Message-Id: <1555486800-107606-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DdGowADn99dY2LZcr4YVAA--.35S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDJry3Gr4rGFy5Gry5XFb_yoWfXFcE9r
        Z2qw1xWr9Ygr4kXFyak3y3Zr929a1DXa4fur4Sqw1rCrWSvFnxG34rXr9xZrs7C3yxG34j
        93WkZr1avr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbZqXtUUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNguZclWBeIps0wAAsP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function __os_scsi_tape_open, scsi_device_get is called to take a
reference of the device. The reference should be dropped when it is no
longer used. However, when scsi_block_when_processing_errors returns a
false value, the reference is not dropped. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/scsi/osst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index be3c73e..f2b2b86 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -4489,7 +4489,8 @@ static int __os_scsi_tape_open(struct inode * inode, struct file * filp)
 	STp->rew_at_close = TAPE_REWIND(inode);
 
 	if( !scsi_block_when_processing_errors(STp->device) ) {
-		return -ENXIO;
+		retval = -ENXIO;
+		goto err_out;
 	}
 
 	if (mode != STp->current_mode) {
-- 
2.7.4


