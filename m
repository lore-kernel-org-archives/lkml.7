Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916CFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B5206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfJHMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:00:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:00:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iHoA6-0006HT-8b; Tue, 08 Oct 2019 12:00:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: char: fix resource leak on kbuf on copy_from_iter_full failure
Date:   Tue,  8 Oct 2019 13:00:18 +0100
Message-Id: <20191008120018.12439-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when copy_from_iter_full fails the kbuf is not free'd on the
error return path. Fix this by setting the error return code and exiting
via the free_kbuf path.

Addresses-Coverity: ("Resource leak")
Fixes: ccf45b18ce89 ("rpmsg: char: Migrate to iter versions of read and write")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rpmsg/rpmsg_char.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 507bfe163883..7db28643db43 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -227,8 +227,10 @@ static ssize_t rpmsg_eptdev_write_iter(struct kiocb *iocb,
 	if (!kbuf)
 		return -ENOMEM;
 
-	if (!copy_from_iter_full(kbuf, len, from))
-		return -EFAULT;
+	if (!copy_from_iter_full(kbuf, len, from)) {
+		ret = -EFAULT;
+		goto free_kbuf;
+	}
 
 	if (mutex_lock_interruptible(&eptdev->ept_lock)) {
 		ret = -ERESTARTSYS;
-- 
2.20.1

