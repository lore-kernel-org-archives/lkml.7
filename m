Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D97C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D4E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyA+tUpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfDWIMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:12:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:12:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1013998wmk.0;
        Tue, 23 Apr 2019 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcYZCf5PYOgjHxDrrN02/6ixDizMI5wh0AGNFjJ5LZc=;
        b=SyA+tUpCM5ovI9Zz+7yPD8BKSvd+AMjgDkZOcXpE19IQWV3S1WBaGiJMPn5zpB/Bjp
         iBd11lr+TdIaRriUJD5eyrJs39kvqb8rvEEDmt9VWJc7Qmegs7igY1udrBMuQGpWFn+A
         e+V9o2b2Pi99KjyWtpkUoW40QHyU+pBndUQSuW+eEhlQJ+1sZA3lr9j47m/U9hnD+hnQ
         AngAHKNqT7d+xsGIKmsLv0d3GQV1LvpIUY9juVCvPdaOnQhhWqOGQn7HufkpwgOJ/pRd
         srGDB+iS5WlnnyqfBndFhWe9ExUssrnN9YE3DP262A+hFx2dpE+dN41bFAI5eEr6dckr
         YV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BcYZCf5PYOgjHxDrrN02/6ixDizMI5wh0AGNFjJ5LZc=;
        b=ZKIreseuE+z+JW//KmPjYKpJXD21fH9fIFSFsQ3zX8uP/A/x2/KLR/T/Fg5NAusqLX
         c+uIWkOGg/d9yX79mdgHbTY15f6+bGNz9AWfUMaLM++tGsVOFglB09Lh3jF1QJNO/Zy+
         lP65uIOoaMndXfcX6OwCm5z7JG4cdvR63HxEvq8eVnLy9oFlt5f+uAg0gAMQ/MZDqtLW
         YElqaoT8LFB3k3KZEfqboFigcq9RYTpv3CPSV8GpYpvrFiAaA17n8e1VATEML21wcneY
         eaqc1l/ZYOYmgq7d3PihBT69oHK+v6z4a+hULCKJ7q9fOVl8fzrDD2iZJjUdMzA7lRfa
         B4fQ==
X-Gm-Message-State: APjAAAUB4uR15g2VD4rFJUI6FCmkI51mwyB1Ix/3o6r8Y+LTDhAeWgrZ
        bn4TmlRI43nafX5V/lknx0tt70Di
X-Google-Smtp-Source: APXvYqxcFDo/+tMhniAYV6M/cV+lnzMoYw47x8tWtHT9MqVzyMHdjvxZ8+s+zegd8pCGOhYUgtIvLg==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr1155912wmc.131.1556007129516;
        Tue, 23 Apr 2019 01:12:09 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.5])
        by smtp.gmail.com with ESMTPSA id o15sm18858829wrj.59.2019.04.23.01.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:12:08 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Return -ENODEV from try_then_request_governor
Date:   Tue, 23 Apr 2019 10:11:56 +0200
Message-Id: <20190423081158.29859-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers don't expect it to return NULL, but an error code.

Fixes Oops such as the one below, when one tries to set a governor that
isn't available:

Unable to handle kernel NULL pointer dereference at virtual address 00000018

[<c0dcf718>] (governor_store) from [<c0539558>] (kernfs_fop_write+0x100/0x1e0)
[<c0539558>] (kernfs_fop_write) from [<c04b09b4>] (__vfs_write+0x2c/0x17c)
[<c04b09b4>] (__vfs_write) from [<c04b33fc>] (vfs_write+0xa4/0x184)
[<c04b33fc>] (vfs_write) from [<c04b361c>] (ksys_write+0x4c/0xac)
[<c04b361c>] (ksys_write) from [<c0301000>] (ret_fast_syscall+0x0/0x28)

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
Reported-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..5539e9be718d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(-ENODEV);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

