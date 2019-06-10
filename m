Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFCC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="P+6xRp46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfFJIoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36840 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbfFJIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so7139836ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HrE3SWkxzOWZuyGJJRbueeV0IUbEbszue8wV9SG4eE=;
        b=P+6xRp464OEsrDvQLaPAgcbhExhH/IEbRLI1cELg/Lj4ryaES0m2U4LUWy+RJC4Ox+
         GA3gM1T7y4w5ZBR+B2NI7izXzfLWg84kWqDm9Fwq4IKBv73JPinCa2S+yJ2sjV+KaduA
         MqMl7Z0bznMJOmNiwNX5r1XNSfwkOtMtPSNfLppmyNDbMF90at1QEZH+8QsM8aT7MBeJ
         SESuaZRloNjlYHTPAkKgSGK0enk5GolaP6qVAoGQTRmCz7JVa3HK/SlrYcUB93mtD4nh
         2OZ8q0HyWa7PuwgeagjbHefqeoYNsCIVxbn6KoiRnsjAFjhut1GbN58VBtZRRwFxykjd
         4L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HrE3SWkxzOWZuyGJJRbueeV0IUbEbszue8wV9SG4eE=;
        b=GpsePD9fDb2zTmlrG9NFqRBHJYTjiIUV0aE4rN5T/+dy1VFUAZ7ryYlWp/XjMpZ8vk
         a/GIFxPHxpDXv1Bj76DL11nqJIKDEYzZZW1Gvua43n1iCoJDW8z8JhvQq5OjEPLCBWzu
         KGwKn3JXPqyXGM5Kbt9sbP4S48MSUihZM5HQXfcRadcYRrRTsBpach7gV+S78v6WcsfP
         EQ/2QZI5yLhBcRQjwGSU3qnBkXqRpna4ep5O8kyrCMQJwD/vf7Xi+bEcRyJv/DNzy2S3
         fyL+jv43WAx+916hsWMd3pwvCZYyjCFXePzTEJQPKTWewQtg5lHucyaWKnDr+WLnyqYq
         tEcQ==
X-Gm-Message-State: APjAAAWry+me3FaCzQ2UTaf2dD1o+k2AjCDp4UoFpJCWJA8QBb+2s1Hb
        /TurxHgm9RSa1EZDdHAijNC5dA==
X-Google-Smtp-Source: APXvYqzeCmNNycATPb+tEdbrWfGa6chXRvAFad2FJo9x6rPYEHXQDOIVQj7kXBClqueQYNN1hd+jCg==
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr1934188ljs.44.1560156290949;
        Mon, 10 Jun 2019 01:44:50 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:50 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 2/5] staging: kpc2000: remove unnecessary debug prints in core.c
Date:   Mon, 10 Jun 2019 10:44:29 +0200
Message-Id: <20190610084432.12597-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610084432.12597-1-simon@nikanor.nu>
References: <20190610084432.12597-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debug prints that are used only to inform about function entry or exit
can be removed as ftrace can be used to get this information.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 93e381198b45..9b9b29ac90c5 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -311,9 +311,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	unsigned long dma_bar_phys_len;
 	u16 regval;
 
-	dev_dbg(&pdev->dev, "%s(pdev = [%p], id = [%p])\n",
-		__func__, pdev, id);
-
 	/*
 	 * Step 1: Allocate a struct for the pcard
 	 */
@@ -506,7 +503,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	writel(KPC_DMA_CARD_IRQ_ENABLE | KPC_DMA_CARD_USER_INTERRUPT_MODE,
 	       pcard->dma_common_regs);
 
-	dev_dbg(&pcard->pdev->dev, "%s() complete!\n", __func__);
 	mutex_unlock(&pcard->sem);
 	return 0;
 
@@ -540,8 +536,6 @@ static void kp2000_pcie_remove(struct pci_dev *pdev)
 {
 	struct kp2000_device *pcard = pci_get_drvdata(pdev);
 
-	dev_dbg(&pdev->dev, "%s(pdev=%p)\n", __func__, pdev);
-
 	if (!pcard)
 		return;
 
-- 
2.20.1

