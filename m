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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F58C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE7F20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR8E4eqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfERGej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:34:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:34:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so4361463plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqyqrEGcVflPYSbWxCmc19o3WqCd1AbIiuoNiUkRp7M=;
        b=iR8E4eqKoWFy1XQ29eS59a4xHdMW8JkyLu7jv1f3bCL9b230Wl0UOAJCN+M8HzTSL5
         pdLFoVwg91U7VEawkTPIWYxELDdavsHM0EAVFgJ+vIqziCFtSvOHso7FigAK9eTkqW/G
         478byixgBjGbbErNDW3ZrUuhJbzl5zGuHroikdOyvEDQ/35yKJt5vnxEcVUOWYlvcMUF
         6J0Zpv55SLcZ0rh0wz8j0TJmm7uVz7XIZlDCcz3gqElo6BlslshtN/DAzTm7L3mPm1pl
         Kf2QNPTyTGDZtIY1uAQE49sCyY7a6mUizeSRr53SKhHGedsXvTYpnY8kCL97e/BbjwrZ
         F3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqyqrEGcVflPYSbWxCmc19o3WqCd1AbIiuoNiUkRp7M=;
        b=iiIHcyzKtM0qG+1oOcyIzbDLkbpK9EjOMCK2ktkCmeIgP3+LRUVrtf6tWlHwCJQX0e
         m9pDxOjHWdXzXea/z4QagM5S/GJ6ga+9rmqxntiSrcf3yhtAC9GUe4xskIs1PJEGsttD
         2iN89PvVwT1gWxFNC8ezo4jvSg41+Kmo4bnh7or0ntTXaCp8kYiQxwjgGx5Zbg1TYWBt
         EhuYwivHAU4b7u/WXLCjwpUuV+68+FhKw3hQIkAM7o89dJ5gWDOIK3B/lzH4h20o8Dm7
         nd7rcPuflclXcn+80hofFlwPpl4wWTQ/xkHizJXJ+1iQAngNun6FO5rxJTUB7ezIRjxW
         3R8g==
X-Gm-Message-State: APjAAAXQt5qUnwUh4hQcbUxFBCvXRYe/rrft5Epo7wId87ZYJ+iYhuOS
        O262GL9i6PTyI46gzlkQWpsKpEUswRnEgQ==
X-Google-Smtp-Source: APXvYqy29JCJ1+mDdZ+Eich0xxHz0Ik96q/M/5q5YQlNvQY1obhr7KA1e0bCcTtE3b6Zr4/WUl1wjw==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr62992501pld.25.1558161278327;
        Fri, 17 May 2019 23:34:38 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:34:37 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 1/6] staging: fsl-dpaa2: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:36 +0530
Message-Id: <20190518063341.11178-2-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518063341.11178-1-moseschristopherb@gmail.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/fsl-dpaa2/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 368837cdf281..244237bb068a 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -6,7 +6,7 @@
 config FSL_DPAA2
 	bool "Freescale DPAA2 devices"
 	depends on FSL_MC_BUS
-	---help---
+	help
 	  Build drivers for Freescale DataPath Acceleration
 	  Architecture (DPAA2) family of SoCs.
 
@@ -14,6 +14,6 @@ config FSL_DPAA2_ETHSW
 	tristate "Freescale DPAA2 Ethernet Switch"
 	depends on FSL_DPAA2
 	depends on NET_SWITCHDEV
-	---help---
-	Driver for Freescale DPAA2 Ethernet Switch. Select
-	BRIDGE to have support for bridge tools.
+	help
+	  Driver for Freescale DPAA2 Ethernet Switch. Select
+	  BRIDGE to have support for bridge tools.
-- 
2.17.1

