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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B29C04E87
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C45A21726
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oec2a1Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfERGfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:35:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34580 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:35:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so4749680pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mnk+Z+ykkkxx1iqAG4OvYzZ3Yw4zSRGNz5ufCwke+I=;
        b=Oec2a1TpHwupRsO7p1zgG7T0646zlZ4BtWnC62LOFlWhSgXO4ralnDDEGmu7Dul600
         YKvXWol+sEJm6ef+ezLzngP1hJLSNUWIbNcRDz5hoMyLCtiY9Co5WwVcyeFvjzxUAcg3
         l/61AIet0sn535etImCbm1lQ1dxIUc2pJzPqi5oldmZc7q0dR8Ko+Le2M+nc3kSi4gtA
         fXsT6RDBTjC7KVFvZtYRL9IrXRnItn4SAYfAtd54/oiUd8HW9BMYEf0Lpr1lgwqmczm1
         hotOdAa7z3HXAN/J4bNCQyhGbx0OWpG+S8sGqxjdMTHLwLxTglmQzowsfh5mcSFw09bM
         xuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5mnk+Z+ykkkxx1iqAG4OvYzZ3Yw4zSRGNz5ufCwke+I=;
        b=nurQTlQIXG1eSJnXVJ4dkpm56Dv2vRg8/R4+fUOqDnUAKiDJFCfdWcb/gqIK+6PA3y
         ALEhl7TCQIfOqWaUDX5wOlrNbPDrotZR+wO/V+sW0VHJy0AOrrDUjLyPmGL6dUROQtIn
         DjAKCqsw3zeCiST6Za8OXoJo4KYfDVT/NUYYuvvc8mVh7FXpMdaOxn1rdJalTICtVAEH
         phwi6zsQQCaW/wTV4WF4ed8zyGaKMvOKo4fl3+enxOnDXIVtpWzkeF5SoH0ZYKtpOkJW
         h9ZGS7cAY26/JxIPs3zuzd9ag3ArHJ3POJ/y3TRFeuG1aP2o84M4Mi1VCSmV9PcljYHl
         DvAQ==
X-Gm-Message-State: APjAAAUuUYBZEZcnmfEBhke2QRILkUUGaZCFJFhGuYH6rtnIM2JqOERU
        O1Cm9r+keMxB8qauaEmY28M=
X-Google-Smtp-Source: APXvYqxsHZcdHVIQQH3WQpAnv1MPChzSxIlUVpY8xN0ntf0z+hzEvqot+UU0pQudB6WPJYMAjC1mOQ==
X-Received: by 2002:a63:8242:: with SMTP id w63mr60658747pgd.169.1558161306322;
        Fri, 17 May 2019 23:35:06 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:35:05 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 6/6] staging: vt665*: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:41 +0530
Message-Id: <20190518063341.11178-7-moseschristopherb@gmail.com>
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
 drivers/staging/vt6655/Kconfig | 5 ++---
 drivers/staging/vt6656/Kconfig | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/Kconfig b/drivers/staging/vt6655/Kconfig
index e4b224fedf5b..d1cd5de46dcf 100644
--- a/drivers/staging/vt6655/Kconfig
+++ b/drivers/staging/vt6655/Kconfig
@@ -2,6 +2,5 @@
 config VT6655
    tristate "VIA Technologies VT6655 support"
    depends on PCI && MAC80211 && m
-   ---help---
-   This is a vendor-written driver for VIA VT6655.
-
+   help
+     This is a vendor-written driver for VIA VT6655.
diff --git a/drivers/staging/vt6656/Kconfig b/drivers/staging/vt6656/Kconfig
index 51e295265ba6..f52a3f1d9a2e 100644
--- a/drivers/staging/vt6656/Kconfig
+++ b/drivers/staging/vt6656/Kconfig
@@ -3,6 +3,5 @@ config VT6656
 	tristate "VIA Technologies VT6656 support"
 	depends on MAC80211 && USB && WLAN && m
 	select FW_LOADER
-	---help---
-	This is a vendor-written driver for VIA VT6656.
-
+	help
+	  This is a vendor-written driver for VIA VT6656.
-- 
2.17.1

