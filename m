Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEEC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31907206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380569;
	bh=5nIOL2h4r6TvSPKoD6zGtjoBy+pqnN+ilAla3xlGQ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HDoPdN48h0sXYNwr/EKfPvxxXh2SDLujYv5oeZ0SZrpt229bBwKxvFoowYNVs4MfY
	 sy8ZOzyWw0rj0TnF92ZWRU9TfH/6w1SSs8LK1zMgY+G20iG4ksYNVi4aEcGL9le/yK
	 9JUZVzKAI2dEWVvCV4v08sFPLoSbsi7L5weG9mp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbfIMNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389787AbfIMNQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:04 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E37206A5;
        Fri, 13 Sep 2019 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380563;
        bh=5nIOL2h4r6TvSPKoD6zGtjoBy+pqnN+ilAla3xlGQ7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B61+NQ4fWnj6VaWF4yB427yuTcE1NYcBt5ltLyi1GR81JP47FO8W9wijrmJUJcJ7U
         xKHu5HiyR/x0SmI+yK0W9qoi08HxByv+PU89bh9QKOGsmPUgbINyhhoMNIYOPCYo53
         wjtQL2q7SigtizJl6ghyk+tI3Vunl4Cok4QzX9Vg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/190] drm: add __user attribute to ptr_to_compat()
Date:   Fri, 13 Sep 2019 14:06:00 +0100
Message-Id: <20190913130608.048188994@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e552f0851070fe4975d610a99910be4e9bf5d7bd ]

The ptr_to_compat() call takes a "void __user *", so cast
the compat drm calls that use it to avoid the following
warnings from sparse:

drivers/gpu/drm/drm_ioc32.c:188:39: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/drm_ioc32.c:188:39:    expected void [noderef] <asn:1>*uptr
drivers/gpu/drm/drm_ioc32.c:188:39:    got void *[addressable] [assigned] handle
drivers/gpu/drm/drm_ioc32.c:529:41: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/drm_ioc32.c:529:41:    expected void [noderef] <asn:1>*uptr
drivers/gpu/drm/drm_ioc32.c:529:41:    got void *[addressable] [assigned] handle

Cc: stable@vger.kernel.org
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190301120046.26961-1-ben.dooks@codethink.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_ioc32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
index 138680b37c709..f8672238d444b 100644
--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -185,7 +185,7 @@ static int compat_drm_getmap(struct file *file, unsigned int cmd,
 	m32.size = map.size;
 	m32.type = map.type;
 	m32.flags = map.flags;
-	m32.handle = ptr_to_compat(map.handle);
+	m32.handle = ptr_to_compat((void __user *)map.handle);
 	m32.mtrr = map.mtrr;
 	if (copy_to_user(argp, &m32, sizeof(m32)))
 		return -EFAULT;
@@ -216,7 +216,7 @@ static int compat_drm_addmap(struct file *file, unsigned int cmd,
 
 	m32.offset = map.offset;
 	m32.mtrr = map.mtrr;
-	m32.handle = ptr_to_compat(map.handle);
+	m32.handle = ptr_to_compat((void __user *)map.handle);
 	if (map.handle != compat_ptr(m32.handle))
 		pr_err_ratelimited("compat_drm_addmap truncated handle %p for type %d offset %x\n",
 				   map.handle, m32.type, m32.offset);
@@ -529,7 +529,7 @@ static int compat_drm_getsareactx(struct file *file, unsigned int cmd,
 	if (err)
 		return err;
 
-	req32.handle = ptr_to_compat(req.handle);
+	req32.handle = ptr_to_compat((void __user *)req.handle);
 	if (copy_to_user(argp, &req32, sizeof(req32)))
 		return -EFAULT;
 
-- 
2.20.1



