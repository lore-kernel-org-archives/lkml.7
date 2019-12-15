Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678CC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADBC20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="T9aEdQlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfLOSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:12:53 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56146 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLOSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:12:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bXZD1GySz9vYkk
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id McuPVEJyQibx for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 12:12:52 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bXZD06SKz9vYkp
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 12:12:52 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id 16so4013567ywz.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1Sd4wDOGySgNuBq62kvgRKaS2P+yDRGvZWncnO1u3k=;
        b=T9aEdQlgrUMr5PCmALh0xtrBogCzg6SwS+LSaCSNmY8AlNcgSeTaopntfe/joFepcP
         apFVkpz0ZNerL8JIjA7AfaAeuyud5z4lZj827ATCowSOXbA9dXiQW0UUD+L0w1rJ0/y5
         LB2wvkflqacATyhGAauiN1U0WMN87XKsd3H4PmoZ0GXNtg7u0jnjTrgOWIMlnWh5/611
         uIju8sfKfv4fhkKbREabtNRv7619hxv6gnu5gKTg28n9vzx/gK0FuLiPpdj38ITIKyXK
         sfyyMshdltskk4aehjxoOhnT6+vkmTiqMH7Z/QInbzAlRL0U6SHRx5rMtwiFavgXWCwq
         nhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1Sd4wDOGySgNuBq62kvgRKaS2P+yDRGvZWncnO1u3k=;
        b=ELYvcwlo2zW7ehpFKmGVTa1rVKodx41c2y7zPu2LP8vZ6hyETrADLGYT2r8DFYq+j9
         2/XRPp4CSHPXAU/ty1Raq103gbYwjwKb+BvKLwfJCmtf6LgS3+taDhnpR5GCvKRDmZ2A
         i0nZupuPXBzNk7yM8IpkyKwMaCwmdKm+LK246Vk/hWTFr+JsDBJQyKqLESuPu6A4CAOj
         yDc8lYa5paYDxjoQVNt2Sa0uWnr57ZDvKUNFHHdbIFcDsF5bebDAmVltwQ3DbK9NCmNf
         7Ke1ztlfUeBN0lI1/LqwBQdAQPEWq7CN1DNOKHkzv0WMKtUrVVEnU+r2Wzq7R/SI1p0v
         CeBA==
X-Gm-Message-State: APjAAAUz4q12f8Edd73uGKIg/F1Ud3K8G3PAXiR8G4i50pcvGuh8SzOh
        Y5sonCz1UqPHj1bBfJpBNNucYEFwZdAAYi3zyTMploaHYpzL0LyGDdpqyJkdplHK7M2nY2LA5H5
        tpxdZ/BMElx+xaxmcUq4VWNUihwLr
X-Received: by 2002:a25:31c6:: with SMTP id x189mr17347169ybx.514.1576433571479;
        Sun, 15 Dec 2019 10:12:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzytpruw2bkHNQvDI6R+irVXH3fLtBBzdcopu87zda/RMDMvWwtbYjdW7j3Uw14zMRE0Jq9Lg==
X-Received: by 2002:a25:31c6:: with SMTP id x189mr17347150ybx.514.1576433571249;
        Sun, 15 Dec 2019 10:12:51 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id u130sm2260529ywc.10.2019.12.15.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:12:50 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vandana BN <bnvandana@gmail.com>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Jeremy Sowden <jeremy@azazel.net>,
        Harsh Jain <harshjain32@gmail.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: replace assertion with recovery code
Date:   Sun, 15 Dec 2019 12:12:37 -0600
Message-Id: <20191215181243.31519-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kpc_dma_transfer, if either priv or ldev is NULL, crashing the
process is excessive and is not needed. Instead of asserting, by
passing the error upstream, the error can be handled.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index cb52bd9a6d2f..1c4633267cc1 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -49,9 +49,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	u64 dma_addr;
 	u64 user_ctl;
 
-	BUG_ON(priv == NULL);
+	if (!priv)
+		return -EINVAL;
 	ldev = priv->ldev;
-	BUG_ON(ldev == NULL);
+	if (!ldev)
+		return -EINVAL;
 
 	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd) {
-- 
2.20.1

