Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E190C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EAA20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnoLarij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfERGep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:34:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37460 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:34:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so1714879pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K0RkBKBSAGCnpFcKILpVOgzIRW/m7dsAxctpIh7X+yo=;
        b=HnoLarijvVvlAxglikknWASEnm3kilfMpvNkN5e7PwpgpeEyk1QXovfa1eEnoRcCyc
         ecO78LxHCkDaHQQ1goUfaHbSeZa74wCtXmpQ2vdjTbm/IWBjJactwpVUIKOSUFfGQ++z
         dWBi09MdNtekUp0f4zm1QbONjSlZUO3VFbll+iidqYZWYQxRLPoJRWpYhgaARaI+A2US
         DEiP2NdOQdbA7+5qInPJKXucZ9rcXXi7FhylNZ3XAb4vuWj3SRGHeIkED6+05nMl2q5K
         eKJ4RbBVdJtvgVqJmLyDxJTauWsQ1ohHNb89jFMpyYis6VCQ/yyhNcmc4TIuOjmBBu62
         Hx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0RkBKBSAGCnpFcKILpVOgzIRW/m7dsAxctpIh7X+yo=;
        b=nUERF5XImyp1Us0PkujWmCHfVUyyneCfYrRBUZ8efKtn11qSk3/1e0MjDm4fwzFytd
         FxlJVKKRjNu9yG7Wc0DFo4Je+ztd0gsgSEsSQHBqW5LR3QC39mI3BD7HKB3UMMM6zfI2
         5dG1ObeIjoGjwVbhosAZoZfqeg3MV4/TOqKct1e5wa5zMwvHUr1a46tMvMk2/vvQc4Pj
         t2L287UHHL14mtf7/IvXC1hCjXyrEERzjz7dXiT2gw4hOe9PRiJ4HK2US2bZh2hZKvVk
         4XidYpPffURWu3QF7e2CKhsgGZ4+NCyS0DEWpYd1SBrYcTYDNXcBMSgF7CIUHS01ZuPf
         5Y+g==
X-Gm-Message-State: APjAAAXkuY4Tk8QCBKtlOAz4wWWK65ycvVwEYDkPNfyit+YkCbP4PUaK
        /yqkcGQayrQeCGMTboTiqsM=
X-Google-Smtp-Source: APXvYqxj5IQslagNyOzjXphME0wdgCZfHpdO+UuiT8WRXZL6twJSfa2PppVZJc9fQ/rcnqjDFCnUjQ==
X-Received: by 2002:a62:2687:: with SMTP id m129mr67165162pfm.204.1558161284011;
        Fri, 17 May 2019 23:34:44 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:34:43 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 2/6] staging: most: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:37 +0530
Message-Id: <20190518063341.11178-3-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518063341.11178-1-moseschristopherb@gmail.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/most/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index db32ea7d1743..8948d5246409 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -3,7 +3,7 @@ menuconfig MOST
         tristate "MOST support"
 	depends on HAS_DMA && CONFIGFS_FS
         default n
-        ---help---
+        help
 	  Say Y here if you want to enable MOST support.
 	  This driver needs at least one additional component to enable the
 	  desired access from userspace (e.g. character devices) and one that
-- 
2.17.1

