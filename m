Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF37C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C058620883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165805;
	bh=WdErRR+FEWb1VdMrBSVMG1iZgzTcX+iiy6i+tHppxnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hw+CWU2u5JVF56AKM2WOq16k8c+z3dFDMDqNReVJUiPJpRGww+mq5fWsWoxosIxX5
	 BWaT3cB1Rn0we3FlghMq3DSRbkBWiCEaM2pEu/bcn8GBaX1utTrwi8V1ca3l0Zumop
	 Tk3nulSdQl0ddaId+3tHJSEc5JXFH3Eu36pbXthc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfDBAnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfDBAnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:43:21 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC702146E;
        Tue,  2 Apr 2019 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165801;
        bh=WdErRR+FEWb1VdMrBSVMG1iZgzTcX+iiy6i+tHppxnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSFz5bK8Bbrt6/QbYecfMmVD0cgbRTHzUqn3nZ0uQp9XOetukYHGGYf0tV4Oel7Lq
         JZ1fpkaNqTKBlzpIsmTWm7o+ENhVORR1QbAbhMsRXyiGCdjB2KJqQlTX0ICoSN4Eut
         Yukz5hL9SeGpQFLNq1pXTF2sckRitPdW6cd0XsMw=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: Clear devnode->media_dev holding media_devnode_lock
Date:   Mon,  1 Apr 2019 18:43:18 -0600
Message-Id: <20190402004318.30309-2-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190402004318.30309-1-shuah@kernel.org>
References: <20190402004318.30309-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix media_devnode_unregister() to clear devnode->media_dev while holding
media_devnode_lock. media_devnode_register()'s cdev_add_error handling
does this correctly.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/media/media-devnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/media-devnode.c b/drivers/media/media-devnode.c
index 6b87a721dc49..d92a68a7ad5b 100644
--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -290,8 +290,9 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	mutex_lock(&media_devnode_lock);
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
-	mutex_unlock(&media_devnode_lock);
 	devnode->media_dev = NULL;
+	mutex_unlock(&media_devnode_lock);
+
 	put_device(&devnode->dev);
 }
 
-- 
2.17.1

