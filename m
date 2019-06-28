Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A58C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4E2208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/72Rf6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF1RBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:01:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43367 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1RBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:01:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so2844809pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=df6t7IoIMcwVexqcsaR7ueHFxAdzOzWUJRRIycElmx8=;
        b=D/72Rf6KevRHPN2ptbZR7J4YKRjC07H5K4UDWhJaxed6ogy+KoiL58qjg3tZnE53+j
         fYkO+MpQqlXf2QC1ws++TMyNPguIWX9YMJjEd59y+AiBKEiPMNRYY6VvQEdIYZJ9+dIS
         0AoUIdZUFxkq6bqShoPoAdAryydnSnwODWIovI/6hVRFTugpvEjgFhjRRPfMPwv97nvB
         wiFkVYqgG6mCGMWvB/K8U90Sl3zZxIHsEH54Fg5gDNwDk9WEcdXa59++9lZhnnCupOSt
         +dCk1uTXBPzDyqGOeZHX/dj4loK62HOhn6CJ2QPNGc8WS0qT76D0tg0NELShUCx3/TrY
         GwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=df6t7IoIMcwVexqcsaR7ueHFxAdzOzWUJRRIycElmx8=;
        b=SVcIJNqquu6rOYYy9q9htHb6K1UXgV3/YsocG0KDAse5Mf7zRQVulQO3pkC3FfQehq
         9Wn5e3DCjnx+o1sykWyQ1gxs7EBiOlM/ruP+L9l0lqJJno7i75TwPvYhDcHA6s1kA5A+
         1duXAINK3oU3gtDz9Dvb+p3ZGrls66UHhdW5eXWyjxAO3CQSDGWWBPKUX+upValiwu6H
         yF5B/ThHw6Lfw0DShW77bg0/4A/YR6rFu+nu0UAXiSeID5wyEp/dfzIhuFH53NkDpyZy
         slfGDAPZu0jOre7wfELi9/gOveA6/hZ9Q73M4ilx9ebaX8Nix86MMVviVfGslghJYkA0
         YhsA==
X-Gm-Message-State: APjAAAVQLwc5ItDfg/BIRKtNpmj/+t/ac6snj9KQGqHGMj1m/BkWn4Gu
        9JxCCAekz1mQEc8pidRDVKM=
X-Google-Smtp-Source: APXvYqyTKUen5VttrfF33n85deip8smc4yS8+LU5LmmQHCNoBo+5tNFH6Qk/uEvJLfC5daBtukoEZg==
X-Received: by 2002:a63:dc11:: with SMTP id s17mr10462017pgg.47.1561741299635;
        Fri, 28 Jun 2019 10:01:39 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id 30sm2971033pjk.17.2019.06.28.10.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:01:39 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 2/2] staging:kpc2000:Fix integer as null pointer warning
Date:   Fri, 28 Jun 2019 22:30:46 +0530
Message-Id: <20190628170046.3219-3-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628170046.3219-2-harshjain32@gmail.com>
References: <20190628170046.3219-1-harshjain32@gmail.com>
 <20190628170046.3219-2-harshjain32@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <harshjain32@gmail.com>

It fixes "Using plain integer as NULL pointer"
sparse warning.

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 204f33d0dc69..155da641e3a2 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -679,9 +679,9 @@ static int pi2c_remove(struct platform_device *pldev)
     //pci_set_drvdata(dev, NULL);
     
     //cdev_del(&lddev->cdev);
-    if(lddev != 0) {
+    if(lddev != NULL) {
         kfree(lddev);
-        pldev->dev.platform_data = 0;
+        pldev->dev.platform_data = NULL;
     }
     
     return 0;
-- 
2.17.1

