Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05181C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31292173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420119;
	bh=2G9q8qP6fJ4eEklSPm4lYLVjtzDEF3InBG5aajNxFn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJXF+kg9k9zmX3ayeBXz8jKMTQuo21m3wIkPdrtVxCY5+U0zwAOV9hR1B4acmLVZ2
	 R0T0a9EQ6hcSoQ8nTgMWxGzyYUsAdoxFjZqSZcEYRF7gRa2VjECX4KZzEyMgXZdJq+
	 n7/s/BDbmWWMndrSp9nGx7gssf4qgJJk60leJcbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfGRDV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387680AbfGRDJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:29 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973452053B;
        Thu, 18 Jul 2019 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419369;
        bh=2G9q8qP6fJ4eEklSPm4lYLVjtzDEF3InBG5aajNxFn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vexa7grTK069RqHAMhTT/T5tFeuP5xt7HjsBHBIJbs+WccS4up2cyKkkwE8S4+mir
         ygeTpDMDx/9T18k1qpxAdqa+t0MjH8LDcwK7U9baFPcVCDzxElLCXEzSYMOzjXzQlw
         5nLEKrUopCabXeDV/Tt0Tjtz75FoAn8jNVosLH3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/80] drm: return -EFAULT if copy_to_user() fails
Date:   Thu, 18 Jul 2019 12:01:25 +0900
Message-Id: <20190718030101.285675784@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



