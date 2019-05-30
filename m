Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BCC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53724D42
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188142;
	bh=NCfw1U1CQMpRXu+CHoKx2Bzex75ACkaz93vAgIsN+Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7Jc76z2MvHLzKn7wJshGTP0A1Bb4oqbz8YTqJHHLm/EbemyqLIYuLxoJulI/56sL
	 dhUdEa9zSlvXbp9ioagSBhcKac/ualucRVftwBhn0C7sTArkp+ZPzFg2iZbAOnXLdJ
	 /QjCxCLc2WxLur0SdGjilwInBlNO89hI1b9H0P6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfE3DtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731534AbfE3DUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:17 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F5E2491D;
        Thu, 30 May 2019 03:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186416;
        bh=NCfw1U1CQMpRXu+CHoKx2Bzex75ACkaz93vAgIsN+Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxYSUVwS2PiKUyfmBkfvKwsBS1Ajws92hifeYafNqlrDYRLiWDaFL4QpK1KZaS8/s
         egUerEUiltc6qfUhjopscUbLk41aG6grA5uKqhX0ZXN1nYVW+EekYrNHyVrEouH2vj
         naVrkfZ4O74W+VQdcjt76zhXZ87HwK9IK54zJ9GM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 190/193] drm/drv: Hold ref on parent device during drm_device lifetime
Date:   Wed, 29 May 2019 20:07:24 -0700
Message-Id: <20190530030513.268297456@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
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
index a7b6734bc3c32..340440febf9a5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -505,7 +505,7 @@ int drm_dev_init(struct drm_device *dev,
 	}
 
 	kref_init(&dev->ref);
-	dev->dev = parent;
+	dev->dev = get_device(parent);
 	dev->driver = driver;
 
 	INIT_LIST_HEAD(&dev->filelist);
@@ -572,6 +572,7 @@ int drm_dev_init(struct drm_device *dev,
 	drm_minor_free(dev, DRM_MINOR_CONTROL);
 	drm_fs_inode_free(dev->anon_inode);
 err_free:
+	put_device(dev->dev);
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->ctxlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
@@ -607,6 +608,8 @@ void drm_dev_fini(struct drm_device *dev)
 	drm_minor_free(dev, DRM_MINOR_RENDER);
 	drm_minor_free(dev, DRM_MINOR_CONTROL);
 
+	put_device(dev->dev);
+
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->ctxlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
-- 
2.20.1



