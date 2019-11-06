Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F97C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AC2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TDfF3VN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfKFQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:48:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfKFQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:48:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id w18so26729755wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsQf+1m23+jsDxNB5IS6XnKaQp9Ng9lV2UMQAWB4LKw=;
        b=TDfF3VN9GaeQ/u0sLLvRvovI5BAhrbb/MI7b7LHt4gu3mjqLxSEwVXmdM5bBA4L5tQ
         g7XAIkJ7IQJfMDsIjivw9DRrqHmIoKbtWxjFhIrjhkqMI0UtiiE0xFVyLu6hxlA53eZG
         y674F5ysqw5/BF1d6i0Fu8yX3hTWMgSLluQXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsQf+1m23+jsDxNB5IS6XnKaQp9Ng9lV2UMQAWB4LKw=;
        b=qQO3wbRP4auG7+2hjqYrVBo7lL/tUJw6FWiWlkMTCPRwyzvoIaGQCDfZyHnWKQPWN7
         Kz00HI8u8hhC1AUcluGo5lRuaLrBDjc5m4Rb9NpyyAxLWTAMyI1fiEeXJuWo4OJyBYiw
         uSa+OkDZXFtKLooyfvgvR1LY1VnEAAbuzrya+Amu9/AdxrKEAH2pc5A4U9SkfFbX9cKD
         T/QlNuVLLfIdOPD2DXP3I8zold64lX+wIqevfd/ew7QaV9qowL/9G3s+upHYpkDvF1f1
         o2tcClnXcukmey02pKHegihxA4sn6BrLlmepUfdUWsX7OYrMnY6sBI+VFc3HM+JwgPVp
         Z1Iw==
X-Gm-Message-State: APjAAAUjafA16lhstLmUo5b3oqJdeYLkIcbdB0Aacbxy1Hns+exsMjLd
        LkuhYF7dgDhonlJd4rbiQfxUnA==
X-Google-Smtp-Source: APXvYqzGy3n/IVXtHdPDD+4tIgpqH4phKgxw3vXsnxKnjEcXZQRREIZ7Z3grAjzpRiN/nIjVtv+L4Q==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr2521944wru.242.1573058881709;
        Wed, 06 Nov 2019 08:48:01 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p4sm16694187wrx.71.2019.11.06.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:48:01 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] drm: Limit to INT_MAX in create_blob ioctl
Date:   Wed,  6 Nov 2019 17:47:55 +0100
Message-Id: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardened usercpy code is too paranoid ever since:

commit 6a30afa8c1fbde5f10f9c584c2992aa3c7f7a8fe
Author: Kees Cook <keescook@chromium.org>
Date:   Wed Nov 6 16:07:01 2019 +1100

    uaccess: disallow > INT_MAX copy sizes

Code itself should have been fine as-is.

Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
Fixes: 6a30afa8c1fb ("uaccess: disallow > INT_MAX copy sizes")
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
--
Kees/Andrew,

Since this is -mm can I have a stable sha1 or something for
referencing? Or do you want to include this in the -mm patch bomb for
the merge window?
-Daniel
---
 drivers/gpu/drm/drm_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 892ce636ef72..6ee04803c362 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -561,7 +561,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
 	struct drm_property_blob *blob;
 	int ret;
 
-	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
+	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
 		return ERR_PTR(-EINVAL);
 
 	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
-- 
2.24.0.rc2

