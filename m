Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA492C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2C2229C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191078;
	bh=19fyECl+rhBtJIFXsu7wTfF73tIVsZeisJEa/ZsHLXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+HN31FHmwNH6TO6GfqGqTz3duZavxcqKLOj5rA2S4d+F5yGySTSF2WZsMAufSpq3
	 GNvEwiyiZcqkTWZH4aAjMqc7g17HQD5J2qFYN5FvFz7fcNUaJQLS1tMSLgyuJrlJZ6
	 OP0VZpPl5JLcBH28euio+fpfsPl1Nr2GvBTzH5Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfE3Eh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfE3DMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:48 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3519244B0;
        Thu, 30 May 2019 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185967;
        bh=19fyECl+rhBtJIFXsu7wTfF73tIVsZeisJEa/ZsHLXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trsELMFLGZQVURt9AizmnrSZ7T+F4ughTRBF7L4XHoAFT4xZgk+XgxgjgSinAqyki
         2/0vSM5+P27ECol+blwW2RZScsRVFSBK5QhLRL2pHHn/yjEbuk1ab3E9aYTctwGz+l
         TFTDzAOxZTpXDRipI0LNnkgEojK/ZdXsuJvo/s/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 397/405] drm/drv: Hold ref on parent device during drm_device lifetime
Date:   Wed, 29 May 2019 20:06:35 -0700
Message-Id: <20190530030600.666129751@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 56be6503aab2bc3a30beae408071b9be5e1bae51 ]

This makes it safe to access drm_device->dev after the parent device has
been removed/unplugged.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190225144232.20761-2-noralf@tronnes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 05bbc2b622fc1..04aa6ccdfb242 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -497,7 +497,7 @@ int drm_dev_init(struct drm_device *dev,
 	BUG_ON(!parent);
 
 	kref_init(&dev->ref);
-	dev->dev = parent;
+	dev->dev = get_device(parent);
 	dev->driver = driver;
 
 	/* no per-device feature limits by default */
@@ -567,6 +567,7 @@ int drm_dev_init(struct drm_device *dev,
 	drm_minor_free(dev, DRM_MINOR_RENDER);
 	drm_fs_inode_free(dev->anon_inode);
 err_free:
+	put_device(dev->dev);
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->ctxlist_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
@@ -602,6 +603,8 @@ void drm_dev_fini(struct drm_device *dev)
 	drm_minor_free(dev, DRM_MINOR_PRIMARY);
 	drm_minor_free(dev, DRM_MINOR_RENDER);
 
+	put_device(dev->dev);
+
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->ctxlist_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
-- 
2.20.1



