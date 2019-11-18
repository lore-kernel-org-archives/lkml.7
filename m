Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAAEC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF8220730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pylT9lIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKRLlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:41:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38209 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:41:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so10276673pfp.5;
        Mon, 18 Nov 2019 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ea8AtOwQ/gMHrbAh9hOSuI0GnsfUP2/RqRm+KGMP9/0=;
        b=pylT9lIw0bTFkxmKB5JcHLpUUBy7rUAvdmqogLQeU0GQR9WSMJLNIadVaFfawWiNW2
         YGfcI+owG6oEM8AkrjFbhMhTWs4d5o2Eyw6dyEHKNJC6Hr8VaCKuS5P/yOq2zWsp2vGN
         PXQusdHZX7lOrdBNgB0AIVrC6aNoYohd0+d06uL+dhEEOAVCyazWXXjnDjZ60kn8DcF4
         osHCp7HsWKWl0tVp5JnkEqjkpScZBdnXolFGMsqYuAY0bwp93sJ/DI5iW3w2x8QRA8Yz
         CjS9bgFfJ/yt7gqnF45KWQPeI2nBEv66t6qn9bTLjAps01WHB4uu6Zr7IY71Y9VWk1Nz
         hYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ea8AtOwQ/gMHrbAh9hOSuI0GnsfUP2/RqRm+KGMP9/0=;
        b=VyMit+ll/WJjqUJPG+ewniaFg8Viw4ifzSCQNX+wSM+ITn2mgM7lOoTXw9yz1Pvzr7
         s4UAU7hdyUnYIVJ3wak8h879iNoPzP6ByneIsWsx47gKjNP7SG7OefJBNyLh7Tw/ReAy
         o7/PFfeb5BlYj/ruEy1RoAnSeWvmXhkseCkAWHMVth+EHQrbmeM/GsXfwyPjCPFCj72X
         FA3CaU+1qzEOisxoWkOzMFNcNjA1yBry0MYl1Ge9btwIXyw2se5dHbj08iDQIynCqYmq
         wMeqLqKUSdr/iS/7TrBW3b6HCWdoE9nY/4sZ6ZWBsJs9kc+saN02m4lSI0kHX686vz/T
         Q4Aw==
X-Gm-Message-State: APjAAAUjhzJXgRndEDLoyMSuliQGE8VnX4OQSlsw1c1L7bHIWFY4ZUX9
        VV5g5LEH57ls6/CXm5TtMKo=
X-Google-Smtp-Source: APXvYqxPXdfD1riKGP6ycbMcTm7jgmPDhZ6Z9zNCVB7POjIw7Y/66PW6oHD/HEsn3QEHkJNGiDpIUA==
X-Received: by 2002:a62:2ccf:: with SMTP id s198mr23517241pfs.42.1574077305359;
        Mon, 18 Nov 2019 03:41:45 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id w62sm22656779pfb.15.2019.11.18.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:41:44 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] usb: dwc3: meson-g12a: add missed regulator_disable
Date:   Mon, 18 Nov 2019 19:41:35 +0800
Message-Id: <20191118114135.25666-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to disable the regulator in probe failure and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 8a3ec1a951fe..d9723d1ad8eb 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -458,7 +458,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 						dwc3_meson_g12a_irq_thread,
 						IRQF_ONESHOT, pdev->name, priv);
 		if (ret)
-			return ret;
+			goto err_regulator_disable;
 	}
 
 	dwc3_meson_g12a_usb_init(priv);
@@ -467,7 +467,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			return ret;
+			goto err_regulator_disable;
 	}
 
 	/* Set PHY Power */
@@ -517,7 +517,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 err_phys_exit:
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_exit(priv->phys[i]);
-
+err_regulator_disable:
+	if (priv->vbus)
+		regulator_disable(priv->vbus);
 	return ret;
 }
 
@@ -536,6 +538,9 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 		phy_exit(priv->phys[i]);
 	}
 
+	if (priv->vbus)
+		regulator_disable(priv->vbus);
+
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
-- 
2.24.0

