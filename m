Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B275C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585A0208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmPLQVvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEIIWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:22:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54805 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:22:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203so2034287wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPrdW9+2z6ZUxmiIwYAl4ynBRRcGa0YhreGJjxJguQ0=;
        b=QmPLQVvj57rGV5eY/pOEbo6GIUkWcw6d9oUOE7QHLnfcdKoxk2KqjtiWRImeUGIcm5
         0Up9IGbrN8JuEE8ypnd21uvPQHk4dqJ6WPaiqM7nqzxEmqSfRh2+ugnjDB6Oj8ZagY8a
         W7I2bhppa6pXaRfOnkdG8In9Sj1j6Xy1iGERi4GTtU2RxOcexjX1LEkB6EhnUTmwAFzC
         wllilfkp2qkpEdYLzPFRPKTur7Gu2fDxEaOzBfDFJUINzM+wSxF9kAIAbCLXuolSwlmF
         fAyLBnF7zhkDv0IIBUXgdTexqDQ0bF0VbontWfZX/jZ6LjTfnbSA2aK/5Is0lBlj8uif
         vIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DPrdW9+2z6ZUxmiIwYAl4ynBRRcGa0YhreGJjxJguQ0=;
        b=UGZU/ERhzbIBt7D3xg6mYOCQgRCCxJx+y80ZbFEq4pbnE6Pr2ZC0ws3KbJSHj4Kq/q
         p8gSwss/7O9WW7f+tUobT5ckH1dL+mBnVbhjhmtQafi8UmIJirJw2pOtJ8y+3RzuF+qc
         dmxcKoIsOFoXDn4qVKJybo96mELTbxUlYbqC4OOm9D0Kl37UHAWWBfOoHNiy9Lo2ZP7H
         J1dia2FHK9xqSCAszIwND9WB87bgneCybczQRmt1pMKY5H4k7kHLldMu0eXsxFF4FWCa
         j4BgwZzrQBL1OEN/028+SDTaF5ifUWwaqawret+BN0uIQB0hL1L9t+xp/jGebz/8VfUN
         zvnQ==
X-Gm-Message-State: APjAAAWwuOHCFBBtfdgottNEtnYyswt7HMJsZQUH7QIZ/d50nWwdI34U
        60wgRB44nFchNtrjV/a0aaL9KvLN
X-Google-Smtp-Source: APXvYqwuVBrRYXA/qgWO+V/oJ48tgq/iYoF8W2SZh0ogr8u9IBBsUqPCV7b8QNgavEqkxzXlJ7sGDw==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr1905051wme.116.1557390155439;
        Thu, 09 May 2019 01:22:35 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.206])
        by smtp.gmail.com with ESMTPSA id v189sm2519556wma.3.2019.05.09.01.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 01:22:34 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panfrost: Only put sync_out if non-NULL
Date:   Thu,  9 May 2019 10:21:51 +0200
Message-Id: <20190509082151.8823-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507080405.GA9436@mwanda>
References: <20190507080405.GA9436@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter's static analysis tool reported:

drivers/gpu/drm/panfrost/panfrost_drv.c:222 panfrost_ioctl_submit()
error: we previously assumed 'sync_out' could be null (see line 216)

Indeed, sync_out could be NULL if userspace doesn't send a sync object
ID for the out fence.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lists.freedesktop.org/archives/dri-devel/2019-May/217014.html
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 94b0819ad50b..d11e2281dde6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -219,7 +219,8 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 fail_job:
 	panfrost_job_put(job);
 fail_out_sync:
-	drm_syncobj_put(sync_out);
+	if (sync_out)
+		drm_syncobj_put(sync_out);
 
 	return ret;
 }
-- 
2.20.1

