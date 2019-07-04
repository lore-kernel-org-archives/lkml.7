Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F79C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B06A206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Si3d4G78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGDGIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:08:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36076 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGDGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:08:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so4924984ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rKacEqNLZlH3pkCMNqkZZev5jRQGonkQdhJh46q48g=;
        b=Si3d4G78WkF+dGOrqKME7EsmUB3Q6evaEmrKh5UCNZLAio+mkyR1XPBijRsHFoP1kZ
         W3ocZkyBOpF/vQV6mywe84AJMxIG7OwKtxohL20q9SvnsDuusysfr+lwvZYFuV9KlVAS
         KnDBgfHZCRtUmZ5mWDbvb8rbu2nOuXF+PhcD6qLY+yQA3oMdZoILZVOO5C04fy421f/V
         7u/ZdwwjXy154XaeQtBiW4OdeSj9YecMNh58xM2staH+W0hU0ltwvYfimNS1csZxnAeT
         Pyo4aPiNEf78kvlb8hnpy1CPKKuxXy8sHlNcl9LYr8iO3sKlTf+Cvk/izaJPaNlyH4XN
         2ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rKacEqNLZlH3pkCMNqkZZev5jRQGonkQdhJh46q48g=;
        b=U+RBZoR4SoF12WGuxDL2Czf5cOUDQcLHFs0pHVYtwvrHA/M5vn5G7g/VurEQLAXmbB
         zjOVIz5sFNp+T3vZzZmr7MscghxmxrL7qfGwiD07AcjAwxE3p7Re/ZQwJusdNKauMFoe
         317FOMDiRaKIWSwRuGvJaSo9uLW4Z4FO9eyvJzb73q6darKD3xSYGDV+rX6HtE7VwAqX
         9BlVApZinv2Wo5bl2x1zhbT0t5wfEtHUNN/0L/zm/09pxcv5t/ckdp2f1fwfr3jx7thY
         ercvW2NK5dIFyrsaw3Ou8UdzLMUMPHgiRioHNqOyCzvXMYW1sT2EZvbdRsyH0tL4TOTk
         5m9A==
X-Gm-Message-State: APjAAAXUgyBrqRpfS6TPFIP3TC7jRivXmv7a6vSbjhzwnPgcjIDlwduf
        +RZCriKFrw9Uw0RL7UjtfN1Ojw==
X-Google-Smtp-Source: APXvYqy1O+4L1Crris1SidTvWq4YsmTh0R3REhDsfkFpV7kN30vjXSchs1fjY88KZ0Zitu19nZIDrw==
X-Received: by 2002:a2e:981:: with SMTP id 123mr23869157ljj.66.1562220500101;
        Wed, 03 Jul 2019 23:08:20 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id b4sm710440lfp.33.2019.07.03.23.08.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 23:08:19 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 1/3] staging: kpc2000: simplify comparison to NULL in kpc2000_spi.c
Date:   Thu,  4 Jul 2019 08:08:09 +0200
Message-Id: <20190704060811.10330-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704060811.10330-1-simon@nikanor.nu>
References: <20190704060811.10330-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning "Comparison to NULL could be written [...]".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 009dec2f4641..35ac1d7070b3 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -436,7 +436,7 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	master = spi_alloc_master(&pldev->dev, sizeof(struct kp_spi));
-	if (master == NULL) {
+	if (!master) {
 		dev_err(&pldev->dev, "%s: master allocation failed\n",
 			__func__);
 		return -ENOMEM;
@@ -460,7 +460,7 @@ kp_spi_probe(struct platform_device *pldev)
 		master->bus_num = pldev->id;
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
+	if (!r) {
 		dev_err(&pldev->dev, "%s: Unable to get platform resources\n",
 			__func__);
 		status = -ENODEV;
-- 
2.20.1

