Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80123C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E401214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596326;
	bh=S+KWZS5ezbMxp4zaxpJSlMrKoXS/YMu9kfnzkHdDX3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hO4yydqGhF/TZP4b8Ng3Epaeofx1PsSQLJvwQh2r1hjtlXp1kLdPxsdE5hbIM/OF7
	 6VsXDE9JMoTy0K4Cdl4linyDdBbrXO/ahpDwtkjTHxJFiQ5s+TXAUsUOjAbnte5ZEh
	 2wdoNnLul+ChAN29T1aQDyHRJJG4mf/gALvap2f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfF0AlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbfF0AlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:41:08 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B77205ED;
        Thu, 27 Jun 2019 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596067;
        bh=S+KWZS5ezbMxp4zaxpJSlMrKoXS/YMu9kfnzkHdDX3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StSXEc84Oh1bVS8AO3avcNqFtTjzCOM9xvQDBsSRQu1XubzKQgHKbGhJomlxPFp7e
         MQ5M+1fJx8X6F2qNDUYYjXyeF2kuUPwE3mNB9kcnfyGpTS3AtZyzJE9SWiVGZI4Wym
         vsS9lbNx+Iqx6bIuYeCEaMj+B/t8WNQdg+WB23q4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 30/35] drm: return -EFAULT if copy_to_user() fails
Date:   Wed, 26 Jun 2019 20:39:18 -0400
Message-Id: <20190627003925.21330-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003925.21330-1-sashal@kernel.org>
References: <20190627003925.21330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 74b67efa8d7b4f90137f0ab9a80dd319da050350 ]

The copy_from_user() function returns the number of bytes remaining
to be copied but we want to return a negative error code.  Otherwise
the callers treat it as a successful copy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190618131843.GA29463@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_bufs.c  | 5 ++++-
 drivers/gpu/drm/drm_ioc32.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 0f05b8d8fefa..b829fde80f7b 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -1321,7 +1321,10 @@ static int copy_one_buf(void *data, int count, struct drm_buf_entry *from)
 				 .size = from->buf_size,
 				 .low_mark = from->low_mark,
 				 .high_mark = from->high_mark};
-	return copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags));
+
+	if (copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags)))
+		return -EFAULT;
+	return 0;
 }
 
 int drm_legacy_infobufs(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
index f8e96e648acf..bfeeb6a56135 100644
--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -372,7 +372,10 @@ static int copy_one_buf32(void *data, int count, struct drm_buf_entry *from)
 			      .size = from->buf_size,
 			      .low_mark = from->low_mark,
 			      .high_mark = from->high_mark};
-	return copy_to_user(to + count, &v, offsetof(drm_buf_desc32_t, flags));
+
+	if (copy_to_user(to + count, &v, offsetof(drm_buf_desc32_t, flags)))
+		return -EFAULT;
+	return 0;
 }
 
 static int drm_legacy_infobufs32(struct drm_device *dev, void *data,
-- 
2.20.1

