Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC5C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72A2190A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962410;
	bh=7xf2HOKjieMPIfHgmx1fgDO04wQwRRYzoYkayH4jh80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9prA45Lsk4h15kUfOkykS3rn1ZxdpoFVG+pBPbti/7YaOoUeh9Rwj2dhT0I4XhcB
	 QDhsQn5jjKNhDpA2TtES4WhX2jEN3/Rt2yBwpY1YWbajJrPd8xCi9vH5imwD2hIJmy
	 FYZsZzW3h+Z7vWb7N60jQ7aUcT3azRgrd3iVDKJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfDVTqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbfDVTqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB48218FD;
        Mon, 22 Apr 2019 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962407;
        bh=7xf2HOKjieMPIfHgmx1fgDO04wQwRRYzoYkayH4jh80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Gwq8AKZaNvCjDJcFTf+g+RiAKX+zX/alCPsIbPjgDEJ69Nj9PWGOwXjSQr4spRum
         rtOcdEW9yxwo1pu6rvOuXmY8z3xA4WGpY7lWvqgdAal/V9Hi5ShWlNGBcGTqH4c2HD
         68zTXu+b8b24GqhpXAb8YaKTT79fMJh+BkLaPSe0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 43/68] drm: Fix drm_release() and device unplug
Date:   Mon, 22 Apr 2019 15:44:51 -0400
Message-Id: <20190422194516.11634-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noralf Trønnes <noralf@tronnes.org>

[ Upstream commit 3f04e0a6cfebf48152ac64502346cdc258811f79 ]

If userspace has open fd(s) when drm_dev_unplug() is run, it will result
in drm_dev_unregister() being called twice. First in drm_dev_unplug() and
then later in drm_release() through the call to drm_put_dev().

Since userspace already holds a ref on drm_device through the drm_minor,
it's not necessary to add extra ref counting based on no open file
handles. Instead just drm_dev_put() unconditionally in drm_dev_unplug().

We now have this:
- Userpace holds a ref on drm_device as long as there's open fd(s)
- The driver holds a ref on drm_device as long as it's bound to the
  struct device

When both sides are done with drm_device, it is released.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190208140103.28919-2-noralf@tronnes.org
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpu/drm/drm_drv.c  | 6 +-----
 drivers/gpu/drm/drm_file.c | 6 ++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index ea4941da9b27..0201ccb22f4c 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -381,11 +381,7 @@ void drm_dev_unplug(struct drm_device *dev)
 	synchronize_srcu(&drm_unplug_srcu);
 
 	drm_dev_unregister(dev);
-
-	mutex_lock(&drm_global_mutex);
-	if (dev->open_count == 0)
-		drm_dev_put(dev);
-	mutex_unlock(&drm_global_mutex);
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(drm_dev_unplug);
 
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ffa8dc35515f..e4ccb52c67ea 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -479,11 +479,9 @@ int drm_release(struct inode *inode, struct file *filp)
 
 	drm_file_free(file_priv);
 
-	if (!--dev->open_count) {
+	if (!--dev->open_count)
 		drm_lastclose(dev);
-		if (drm_dev_is_unplugged(dev))
-			drm_put_dev(dev);
-	}
+
 	mutex_unlock(&drm_global_mutex);
 
 	drm_minor_release(minor);
-- 
2.19.1

