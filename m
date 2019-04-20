Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0415C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B812087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIVNwcLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfDTLrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:47:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfDTLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:47:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so3649763pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=edlLfHEtYPVpjA1GQeqdzipSF24UsGUKADYgltVbJa8=;
        b=uIVNwcLLA1Is1TY94IZ3nQsWG0d/vcGap6jSt4uynB8J9Hb25xzPGLTtJgp7nbS0bA
         6quVpP3rfLdqRK9jLdYTvGmNVnko76oMclh3tNKm9ItPrfmkXOKIe6E0+eesfpdLggfm
         se61/YNXkMenE4R68Htrmeq7M3IB2HTVxf4qY+BUEt9ZoolHKiv6ZHgYc7Dp3ftXvK5i
         k+EcPO8hKyXOv7easnKc/nbY504B4c4hN1QcA23adyp0QCzDLRbIuBHzxmlzeQrdk9Oc
         PbhAF8PEUI0VzxFDxf60YTl0LYdG6dWyUZqmNNFQNayFN1n1cX9j52LtewEW3kE3O+dQ
         JDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=edlLfHEtYPVpjA1GQeqdzipSF24UsGUKADYgltVbJa8=;
        b=a2RgeUkvFht09EgU10T5vAu8XU8HCLZ/K6qjTp4zDhr2buDpqdPZwZ3lSryZTjYHV9
         LFBE8ey8FKJDkRLvy+71ihvY5rAuLmsxRS5qk+5Dih2QYwqm1TWJCdBETBxzuRb6UtNj
         U9YDXpiRS9qNd8aIudUqv0FfVHUlqpRe521aUU/d+YzQHcQal1xyTwNh55gtVBf/PEkz
         mnv65JXYFuWMeyhovpEHIThwr1KWPoPRYFZ6QE+7xG1eLzfY5nmrL8gvUD4I1UznlrZy
         p6IvHXNxvIA17xfyNzDIegQYxIMysl2/d/Q9c0V1rMG8nFAHZ6nNsxALzkR2HEvKTmaR
         G1Fw==
X-Gm-Message-State: APjAAAVD3ECtHa9Ey3E9rNY8Qsc59fv2hsFFH4hiq1wn5UYArrC9IENn
        wXuuLctbDcF1/RNZRy7+IcCF+Kqhe84=
X-Google-Smtp-Source: APXvYqwVlMNpSRqqe+6RixtfHUcRJLA0Gf84N/Rl3VaMqNksUN2Df+Kq7ECIL9pZjOGsjOUkmfONVA==
X-Received: by 2002:a63:db10:: with SMTP id e16mr8958406pgg.142.1555760820660;
        Sat, 20 Apr 2019 04:47:00 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id 4sm9946245pfn.159.2019.04.20.04.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 04:47:00 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        sparmaintainer@unisys.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: unisys: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 11:46:46 +0000
Message-Id: <20190420114646.28817-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/unisys/Kconfig            | 2 +-
 drivers/staging/unisys/visorhba/Kconfig   | 2 +-
 drivers/staging/unisys/visorinput/Kconfig | 2 +-
 drivers/staging/unisys/visornic/Kconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/unisys/Kconfig b/drivers/staging/unisys/Kconfig
index c27dab3b610f..b9c814df5d36 100644
--- a/drivers/staging/unisys/Kconfig
+++ b/drivers/staging/unisys/Kconfig
@@ -3,7 +3,7 @@
 #
 menuconfig UNISYSSPAR
 	bool "Unisys SPAR driver support"
-	---help---
+	help
 	Support for the Unisys SPAR drivers
 
 if UNISYSSPAR
diff --git a/drivers/staging/unisys/visorhba/Kconfig b/drivers/staging/unisys/visorhba/Kconfig
index 241d8038261c..4b67634b236d 100644
--- a/drivers/staging/unisys/visorhba/Kconfig
+++ b/drivers/staging/unisys/visorhba/Kconfig
@@ -5,7 +5,7 @@
 config UNISYS_VISORHBA
 	tristate "Unisys visorhba driver"
 	depends on UNISYSSPAR && UNISYS_VISORBUS && SCSI
-	---help---
+	help
 	The Unisys visorhba driver provides support for s-Par HBA
 	devices exposed on the s-Par visorbus. When a message is sent
 	to visorbus to create a HBA device, the probe function of
diff --git a/drivers/staging/unisys/visorinput/Kconfig b/drivers/staging/unisys/visorinput/Kconfig
index a3817e0f7e5c..c0681f932d76 100644
--- a/drivers/staging/unisys/visorinput/Kconfig
+++ b/drivers/staging/unisys/visorinput/Kconfig
@@ -5,7 +5,7 @@
 config UNISYS_VISORINPUT
 	tristate "Unisys visorinput driver"
 	depends on UNISYSSPAR && UNISYS_VISORBUS && INPUT
-	---help---
+	help
 	The Unisys s-Par visorinput driver provides a virtualized system
 	console (keyboard and mouse) that is accessible through the
 	s-Par firmware's user interface. s-Par provides video using the EFI
diff --git a/drivers/staging/unisys/visornic/Kconfig b/drivers/staging/unisys/visornic/Kconfig
index 1676dc7072d5..33a9b63bccb5 100644
--- a/drivers/staging/unisys/visornic/Kconfig
+++ b/drivers/staging/unisys/visornic/Kconfig
@@ -5,7 +5,7 @@
 config UNISYS_VISORNIC
 	tristate "Unisys visornic driver"
 	depends on UNISYSSPAR && UNISYS_VISORBUS && NET
-	---help---
+	help
 	The Unisys Visornic driver provides support for s-Par network
 	devices exposed on the s-Par visorbus. When a message is sent
 	to visorbus to create a network device, the probe function of
-- 
2.11.0

