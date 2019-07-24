Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D1C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E50521926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw+tu5F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfGXNSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:18:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40824 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfGXNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so20945328pfp.7;
        Wed, 24 Jul 2019 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGVoS35C4loNzLjDedtQfBKQUut8ZAbe4JqEpeR9UYE=;
        b=Gw+tu5F79d77Dwe5b0k7vepXMUNwjz60OAA4HK2OI7Um2S4WTauQ3iALzPuxXwMS6g
         rqIuyi0YvF4/nHdeRq/lUdpQVup8lfrira/SLWZYFuwSDiIaLi5zTx40vlqSCdXyqehM
         fbdEVy1nn2dT+/e3WLvU2G9aDmp60vcvv0t5OYWJznlbrLIre3IUBwQiPGQPYTMJ4kMh
         z1oq84ygowM1sbIi3Dfb4p9OZQCWvmztzEmAG9HF13u+LNnkdMgyIo9yamraIxnls6yy
         Q0z1142QyUT/1pXukEJ578Rnb/PYDps5cVFkNmKlR2ZnMrNxNEodrXM4ioAA5CeFrXax
         GWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGVoS35C4loNzLjDedtQfBKQUut8ZAbe4JqEpeR9UYE=;
        b=V3h4xIwcbOrATSEQkHja0OuhobWtN2GRt4bF00O5Gq0jV0zo+92gx/EZiYpyXtfgLY
         1X1qo0QM5YQdmwj/24fvizwdTZKAPvjyb8uIXcOMeSsezEao8Dxuw8ORzg+ruVzHxFyV
         y/+/bXE1AAJvgEbMtWy/OfA7xgFecIKmwAxXrcxU/gFKUuT0iaAvr2JC6xmt97m8k6eK
         VLFjPvEnb2Xb0oL4ZsvUmi7rYc/EIFrqdW+vXGDjnyoNF4hIEthjR/LxgoETtsiZKMYU
         cnLF3GEjrFsdGS8ORAT8tYh2RNMMsmGwSqA8IsNDyX/sQXyf9CeHquQXjwFp9Y0osvVr
         dCRA==
X-Gm-Message-State: APjAAAVRgq/wQAyvZOw2zhiKm/2cnBC53FImHGKxCSQzX5cuveKFEHGI
        rewyaerL/1T2bxR0D7qqw6RdA4GyJyk=
X-Google-Smtp-Source: APXvYqzM63OwNIGX7R4MXw34+9wybS1L4xU90DDOgtEk22ezf2BoDdccGvAEkDqtliBPLfKQRtA+ng==
X-Received: by 2002:aa7:90d4:: with SMTP id k20mr2243254pfk.78.1563974283397;
        Wed, 24 Jul 2019 06:18:03 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p187sm71011976pfg.89.2019.07.24.06.18.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:18:02 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] serial: 8250: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 21:17:58 +0800
Message-Id: <20190724131758.1764-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +--
 drivers/tty/serial/8250/8250_pci.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index edd6dfe055bf..03b347afd46c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -561,8 +561,7 @@ static int __maybe_unused exar_suspend(struct device *dev)
 
 static int __maybe_unused exar_resume(struct device *dev)
 {
-	struct pci_dev *pcidev = to_pci_dev(dev);
-	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7f740b37700b..b714d8d0e161 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3859,8 +3859,7 @@ static void pciserial_remove_one(struct pci_dev *dev)
 #ifdef CONFIG_PM_SLEEP
 static int pciserial_suspend_one(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct serial_private *priv = pci_get_drvdata(pdev);
+	struct serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv)
 		pciserial_suspend_ports(priv);
-- 
2.20.1

