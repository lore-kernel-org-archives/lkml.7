Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D544C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88632073D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxqdzJuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLOBdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 20:33:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45900 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfLOBdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 20:33:18 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so331609ioi.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 17:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=twHtR4aXXJ++Vn0jlK/ZQHhpDH2MxdLzHdpLj7lTb4w=;
        b=TxqdzJuvEpKOlPzpxWjcaBW/fDqrszwu9z2YpjHmOOjAdtoGbZvroZjaFgLdVD6K46
         LXzA+KS1ba6K9wuTZh903zH+K9bKtFTf1wMu48fpD7MKqfnvlyWy87sXPLjp4pTnoUN4
         P2vYRamv41qdFo5Jdm/sb23chNdeQyDavKa2/2wXZ4xpFf7UxVgGhuu1nwSUqaPL9Dsy
         0cqW2TNRitcFSTjNqw57dDW/sBwGL2ChRIIDiI6MeQrmP7x0eQtdF7TN4BJZfdc495im
         SpU6zpf91IBphByb3NgNYmdLpsUuuty5PAY1Ank4WfLFf1Ucq9R4PDuf7VO6n4RPawBh
         86SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=twHtR4aXXJ++Vn0jlK/ZQHhpDH2MxdLzHdpLj7lTb4w=;
        b=ewazPFPvr3Wh5yONzZ7vNmexbZFawRHQnzudCtqS5JmA0aD2rxrmQI3ZA1vQXioVpq
         vjtbsjPD9NZCpofDeQXJpN7Qd0X42o56glmzu6AQZNtP7enb5IgeVsZJL1dvkbaJSb06
         lUCviWVrzrpQ5xvuJBFyheKMvTnvsOks860OCVZu0JXpb30X7TzEc0vU+NgeY5puLBqY
         YRxZxpHiWZvy4UsOd1vEH7URxHbHFM55ifXTQ9pQz7cVxh3883dE1deii1KscS8KPDv0
         hHvHOAf80OKKk/DQdGijf35rLgkX7Rt+a4jX5UWSJUgcEUDP6RML5YlJslzA1N7ZCcyA
         OLBw==
X-Gm-Message-State: APjAAAWgW9MYa0D/RmbHOnW4lSThCY6yHSmkicriSzLfGlfkvYq0CS/b
        P0qC6CHotZ0FQbZyxln8ggQ=
X-Google-Smtp-Source: APXvYqxVuEuEMh9Wh2jXS3PQASEpnW7hDbA7c0sfDrSvLzaSaixbmeInGzm3xrbwOVxrmCdf/D8Jcg==
X-Received: by 2002:a02:966a:: with SMTP id c97mr6650981jai.7.1576373597761;
        Sat, 14 Dec 2019 17:33:17 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t15sm4297605ili.50.2019.12.14.17.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 17:33:17 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu
Subject: [PATCH] staging: comedi: drivers: Fix memory leak in gsc_hpdi_auto_attach
Date:   Sat, 14 Dec 2019 19:33:03 -0600
Message-Id: <20191215013306.18880-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of gsc_hpdi_auto_attach(), the allocated dma
description is leaks in case of alignment error, or failure of
gsc_hpdi_setup_dma_descriptors() or comedi_alloc_subdevices(). Release
devpriv->dma_desc via dma_free_coherent().

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/comedi/drivers/gsc_hpdi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/gsc_hpdi.c b/drivers/staging/comedi/drivers/gsc_hpdi.c
index 4bdf44d82879..c0c7047a6d1b 100644
--- a/drivers/staging/comedi/drivers/gsc_hpdi.c
+++ b/drivers/staging/comedi/drivers/gsc_hpdi.c
@@ -633,16 +633,17 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
 	if (devpriv->dma_desc_phys_addr & 0xf) {
 		dev_warn(dev->class_dev,
 			 " dma descriptors not quad-word aligned (bug)\n");
-		return -EIO;
+		retval = -EIO;
+		goto release_dma_desc;
 	}
 
 	retval = gsc_hpdi_setup_dma_descriptors(dev, 0x1000);
 	if (retval < 0)
-		return retval;
+		goto release_dma_desc;
 
 	retval = comedi_alloc_subdevices(dev, 1);
 	if (retval)
-		return retval;
+		goto release_dma_desc;
 
 	/* Digital I/O subdevice */
 	s = &dev->subdevices[0];
@@ -660,6 +661,15 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
 	s->cancel	= gsc_hpdi_cancel;
 
 	return gsc_hpdi_init(dev);
+
+release_dma_desc:
+	if (devpriv->dma_desc)
+		dma_free_coherent(&pcidev->dev,
+				  sizeof(struct plx_dma_desc) *
+				NUM_DMA_DESCRIPTORS,
+				devpriv->dma_desc,
+				devpriv->dma_desc_phys_addr);
+	return retval;
 }
 
 static void gsc_hpdi_detach(struct comedi_device *dev)
-- 
2.17.1

