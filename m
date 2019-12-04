Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C5C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39D62073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbU0t/Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfLDV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:56:29 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49625 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLDV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 16:56:28 -0500
Received: by mail-pg1-f202.google.com with SMTP id u14so538649pgq.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=NAupc/vR8bVWuaMCvX72N/qStHFA90T0ir1IJdUyDdE=;
        b=sbU0t/KzGn2j9p0ayPj+KQNR/KUydw26BP24k17+yr+P4OCHLehU0UBTL/B2Abr+/2
         sQf5fD9mTwnZooHzWk0YZlJXAWEb6f/7Dl2oRN90wghJoWjU1+h309N4d0U4PBHtycjQ
         UXk+UrCUxUqY9RTQNkYfFeqxqIS46oUAo4BZbnFiVoP6yJjiTBK1PFEPvuICfFtbrpss
         mdU+l9/cNMdnFQ3do4so/sm9xyh7Z+MNh4eU0a+QhACZ9wCqQ4mjLA9ZOIS+Dgu3D23W
         rNyRmVb3lUx1so88I8VXF4i54g1OA8QcfKt3BkPTiikWozM40GsdcSzXZP5zA7q/4jTL
         XD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=NAupc/vR8bVWuaMCvX72N/qStHFA90T0ir1IJdUyDdE=;
        b=UOFKSAv99aRAsDvqbe9mnVQx65g2UKqr1u0SBbjDVb2aBRKRq7Ko5GuDU2vQH1lfvf
         Ok53GJVnZxbb2W9v4aT50eBs9c0LAcX14C4gognzonLUGIcEM0gHK4VKDt/m7M6VCzxy
         cKChFL2axUQTTwid6UafOeRRw+ZiDEylTSnXTQmDBHglpDca96OD3I7dLeZnuLH4BCUC
         AOD4xigU6kT9jhq7G1fHDj4QCwet5N1u/kn6GabBDXpHAHGdSTaVNur5Aan6EBao3gEL
         fbUTfs1+cRI4TEoXyINbIxz6OYV4rMdMBLiXsgR4vqcm53Siu5GVrPxawjSqrCOx2VQR
         gkMg==
X-Gm-Message-State: APjAAAWjxrdA9ARlPL+151i0Tpwl29LwzJbTymYE3a4EDE8rDvLZ0290
        5suOfAW8AaUpeLHIU/AdnurkEH4=
X-Google-Smtp-Source: APXvYqxXKUmGZWwlHDbL9ugwrz5hieTgw+FpXeR0Lks6uU8kJqHa5r4R0hgTQHw9EpKYr33quBhpHh0=
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr5708130pgs.396.1575496587829;
 Wed, 04 Dec 2019 13:56:27 -0800 (PST)
Date:   Wed,  4 Dec 2019 13:56:17 -0800
In-Reply-To: <20191204215618.125826-1-wvw@google.com>
Message-Id: <20191204215618.125826-2-wvw@google.com>
Mime-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cooling device registration behavior consistent with
thermal zone. This patch also cleans up a unnecessary
nullptr check.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..64fbb59c2f44 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
 	struct thermal_zone_device *pos = NULL;
 	int result;
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
-		return ERR_PTR(-EINVAL);
+	if (!type || !type[0]) {
+	    pr_err("Error: No cooling device type defined\n");
+	    return ERR_PTR(-EINVAL);
+	}
+
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+	    pr_err("Error: Cooling device name (%s) too long, "
+		   "should be under %d chars\n", type, THERMAL_NAME_LENGTH);
+	    return ERR_PTR(-EINVAL);
+	}
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	}
 
 	cdev->id = result;
-	strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
+	strlcpy(cdev->type, type, sizeof(cdev->type));
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->np = np;
@@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
 		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
-- 
2.24.0.393.g34dc348eaf-goog

