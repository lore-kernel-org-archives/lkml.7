Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C6C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D23620815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf6L+Q9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfEZBTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:32 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38686 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfEZBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:31 -0400
Received: by mail-vs1-f66.google.com with SMTP id x184so8377936vsb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6Ng0YgGWXiNGzlc0581CkbBTTW9Uf73AKmysyNcLng=;
        b=Yf6L+Q9J31gPQCtI+ZutcjbC8Z2ybHGHiFmB72m+aPQ2YnaRBoBo2qS/hwa8m5nl1a
         rxyp0/b0duwXuzAjDl6sfw9fUX/9rXyBvzlsaEOeOp8jtOPTRrTAYwOhZtCCT2GJTnHu
         P1+h+RNI2EfzOtQXnzVUmtR+FGi9Hq9ulH4e1SuDgkKBA+Oc7JPPHegOR7Ehs0aPyDwh
         y1EfeG/f2BQbLJLZGOGLrP2zP0lYyQO6icxRvum03unK2uOKILritd6peM12XvXvxDNP
         obzP9MtDfvwqjdgqwLWFrLmgBGwoJ9msvnnxejj2/uB2W8JelG4i1Irhyv/8U4fz81AS
         8rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6Ng0YgGWXiNGzlc0581CkbBTTW9Uf73AKmysyNcLng=;
        b=iyVv+guwzYvbhRoBOQoGYXRwoBM5Ra0xqtB8SKZuLPErIOfY99BmJVpXF4cfrqiv1X
         XsZHq3Bbds2076vnAfeN/L9RrVchdRyer2UEeRJ6sKcnO+p/V9EPFCF2TxItejnHWeoW
         3LYBGbyt9m61WkrcDxFmA4raCnmxs6WQOi/wL9eQR/mNQGjyyGCg467ANEexZn/XbqGo
         IlbdVazAqvwvtLV8mNngF+vYFPf13ZQ6XRC2Ti/GRaLgxnzUz+foAV3u1QmiS7FXbGQv
         aE+Zrc26KzX3i5sNl+LmEp+BCJBo1i3WBFBJcGgnDbMy7yZY4293rYKYlfGUuiDMcjUN
         tv9A==
X-Gm-Message-State: APjAAAVMKHLTF7m4pQXKzhK90gtqGvLsBjhU1tIcpYTBBjPRSlXQSY4a
        +eA3wYH3xaQsb/sHYk1A0xA=
X-Google-Smtp-Source: APXvYqwvGOCHofrqHNxqy92jK34PscedhwycjdA9GX8VTqFwPEETvEJXS2M0AVd9G8hp58IKuozYTw==
X-Received: by 2002:a67:f5cb:: with SMTP id t11mr57611899vso.197.1558833570906;
        Sat, 25 May 2019 18:19:30 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:30 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 1/8] staging: kpc2000: kpc_i2c: Remove unused rw_sem
Date:   Sun, 26 May 2019 01:18:27 +0000
Message-Id: <651e1f5f40fb7e7f45179eb8c550f34d51ed4787.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pi2c_probe, a rw_sem is initialized and stashed off in the
i2c_device private runtime state struct. This rw_sem is never used
after initialization. Remove the rw_sem and cleanup unneeded header
inclusion.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index fb9a8386bcce..2c272ad8eca6 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/fs.h>
-#include <linux/rwsem.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include "kpc.h"
@@ -38,7 +37,6 @@ struct i2c_device {
 	unsigned long           smba;
 	struct i2c_adapter      adapter;
 	struct platform_device *pldev;
-	struct rw_semaphore     rw_sem;
 	unsigned int            features;
 };
 
@@ -606,7 +604,6 @@ static int pi2c_probe(struct platform_device *pldev)
 	priv->features |= FEATURE_BLOCK_BUFFER;
 
 	//init_MUTEX(&lddata->sem);
-	init_rwsem(&priv->rw_sem);
 
 	/* set up the sysfs linkage to our parent device */
 	priv->adapter.dev.parent = &pldev->dev;
-- 
2.21.0

