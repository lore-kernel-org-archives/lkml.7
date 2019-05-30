Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F97C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C6423E30
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188047;
	bh=0Z11osrJPDVUTFcHjQOPdOwtQXp2VYNINeIfJT/Bcgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KewKlvnUFz8Vtekz0Iai2yXQqy/wP6oJEVC1EM/M7oBeg1gBwR7+4gmdBIFUztswL
	 f1lWiN1z4LAMYnguon4ki9KVPspmsIKtjdjShqCgafanBtEh0l9iTj5c5LZQGBocTV
	 7fTu9pDDhub5YBRilYXaTRrTlcTKcQPWHy6+urxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfE3DUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbfE3DPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:55 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3FC2458A;
        Thu, 30 May 2019 03:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186154;
        bh=0Z11osrJPDVUTFcHjQOPdOwtQXp2VYNINeIfJT/Bcgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzr65Uk5Ams9NDXIsubQFVAIy91qdaNM4tc6uG38KBhY3Rd57F6S1pwkB8FzuK13F
         +1p6bBWvceK8IrUGt6ZgAvAneE/PeQQkMckf3W+M9gH/fkgR9lqWSAvPN9yu8SLhFE
         +pQlUNqofaMsCbFTIlJFSSVhUaC3qcl83aspDg18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 341/346] drm: Wake up next in drm_read() chain if we are forced to putback the event
Date:   Wed, 29 May 2019 20:06:54 -0700
Message-Id: <20190530030558.004800089@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 60b801999c48b6c1dd04e653a38e2e613664264e ]

After an event is sent, we try to copy it into the user buffer of the
first waiter in drm_read() and if the user buffer doesn't have enough
room we put it back onto the list. However, we didn't wake up any
subsequent waiter, so that event may sit on the list until either a new
vblank event is sent or a new waiter appears. Rare, but in the worst
case may lead to a stuck process.

Testcase: igt/drm_read/short-buffer-wakeup
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20170804082328.17173-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 3f20f598cd7cf..9c5bc0121ff99 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -567,6 +567,7 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
 				file_priv->event_space -= length;
 				list_add(&e->link, &file_priv->event_list);
 				spin_unlock_irq(&dev->event_lock);
+				wake_up_interruptible(&file_priv->event_wait);
 				break;
 			}
 
-- 
2.20.1



