Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7660DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500C92196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC2K9Mvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfJKFwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:52:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46038 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:52:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so3936744pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84eJ1lI0FM0l9W+xwQ+ZMb9OxUSPGPie2ZC1/+v5gJM=;
        b=TC2K9Mvx2CPCxfqDEZasJqs/w9UNEXCTpKsRPZw/4nlx1eikm6F6XGvcevrlGaP+VU
         /U+QbWz4VhLGb+KkBBlRBX9WwC2aH8+S1ydHQfU1ud6Kq80Pdv9XURX7cHOoXzBoii+Y
         L6vxc0qAn7jfjRa0ZhtrGNE2dZM9gcmBKTSDbkz9Y63g6NAuQ806fKsm6/YxEFTXnMUn
         jwoKUG+IyFHGjs7dTBVgA7jfR0UX9j1niC1uuLwiwkI9LWHNmZAMHGaG5FHrxDCOtl23
         PGb5lLZHzMrEMI/D2X0lrot/jlkFcGf7o0eMwDyRpsHemOXuqAjMHZd/xE4GuK4gMlYu
         k8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84eJ1lI0FM0l9W+xwQ+ZMb9OxUSPGPie2ZC1/+v5gJM=;
        b=nOMxEwVCbNiLmzZuGRSr36CrUgcjQlH0LFiML3jNG2LdeFC1uvD24w/IrEu8JXtDRS
         hy5Qnts0Q4gVZYVxtt4A/cLmYvv3nnHKF9j3IbwQc5tI0IeCyG8fSFHoVpc9o9PMYD54
         9sWIM87X3a6t11pjxaWFaS5UwvuJGl8no5CBPJDtTqCha2DhP+s7Ge9+WBr2Q41SGy8P
         ixnCj8IW9ZPnPtqvKzqrOktl94uAVA99Gs907lSyHWF+tcy05qxhwCBaNTJlaD5S2FcJ
         Bf93samrN9FOqjwXg5+zMaZGvfFCZYucWo6nmuUC9W1ouESFCtD5ur/EtNzxCrp0wO8p
         nItg==
X-Gm-Message-State: APjAAAUOLvcCxAetkYn0h2+2bo1gnwWccH2mVov+PwOITBJSphMa93O6
        haG1zbnnq/49D80u4WDlTgw=
X-Google-Smtp-Source: APXvYqwG9wc9xAzPckhhc7TpzInZFNPvqiaKQtdp6dH0hcBDz6jATtv5H2SQzY5kuBYKC4a/zN758A==
X-Received: by 2002:a65:4189:: with SMTP id a9mr15019908pgq.380.1570773129793;
        Thu, 10 Oct 2019 22:52:09 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id i184sm10257782pge.5.2019.10.10.22.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:52:09 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, michael.scheiderer@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] KPC2000: kpc2000_spi.c: Fix style issues (misaligned brace)
Date:   Thu, 10 Oct 2019 22:51:53 -0700
Message-Id: <20191011055155.4985-3-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011055155.4985-1-chandra627@gmail.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: ERROR: else should follow close brace '}'

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index d1f7360cd179..66cfa5202690 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -228,8 +228,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
-- 
2.20.1

