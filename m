Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6695C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B736424195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="F0SGbaUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFCW32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45405 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFCW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so17768196lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qz773NbN9VGUdRz2W+Q9CTxauKIYzxumLCEO0NWgoxg=;
        b=F0SGbaULaPAPf/lhvvVE0Wpw/BPfvHCV8/LlOGQ+M+S32MC1HIM9eLKcPY9b0YwcCw
         /QJw5nhnagMmkBHPRpXlPeujOqL/87DPxvE7+hdB8AWZIpNCqAXFIJ1RztzkPF2jhlrc
         PGwC+wLqk52+Jo8TMqV1xYPYJMvoAvmyFSBkuZs31Z3LjWzVR0TTliHuK7NHSpy1nhAV
         TiC/ExWJac9wdzwHbrf829Pn/M2lEMbN9QZqTTjHdcbTIv6Bn6OJqj2xGqd70enPlt3G
         bfiCOjRrJwT5WCHOTeSOZhsUyxxNM049/6HRCVTVN8NAgtaDVNqIFKZ6/UlRtgKRI1VN
         lfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qz773NbN9VGUdRz2W+Q9CTxauKIYzxumLCEO0NWgoxg=;
        b=Tn2HPL6gwNDokyoEHviyLk7cqQjYBYikeL867RaSo1sUrc9LX0f1p8HZX0S4l60opx
         w9TGKog6KeODwXPefduiYhVC0wMk2MmX0wGk/iVVvfpeP1pV4/Npw/0svT3yRCd/lDSl
         z0qg6qhrdA1rfZDyknv9Hxrh7j153LwnhPyQh6li0Lpkvwd8zRTUtDYcFiz/kC2lOk+B
         mF3kOMoswvE9PcL7m8lq+MW/SpeewZj9yuUWYW94lb8RIWp3WzVUDmvs6rP60RZCV0Zz
         PFK4ALhwZdo1CeV1nU4cymjhxslp1OhcdgtR9zLzut9HusFgyCUJUs9vFRrSyZXU4zjq
         D1Fw==
X-Gm-Message-State: APjAAAU4zTmjhX1VFbz9b3huhaFd7+KhuSkxDfqFqfhqzhIKbxBhak0q
        XkPBCLhXu2+dX/IFPMZdR0vwxw==
X-Google-Smtp-Source: APXvYqw3OxjW0YGAZox0GDRk6sa8aCCl/xX9Zi7b+TuGB4FKLa/1+f4JDNXqNKOkQtP64SZNBtUsHA==
X-Received: by 2002:a05:651c:d7:: with SMTP id 23mr3065196ljr.50.1559600963916;
        Mon, 03 Jun 2019 15:29:23 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:23 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging: kpc2000: use __func__ in debug messages in core.c
Date:   Tue,  4 Jun 2019 00:29:13 +0200
Message-Id: <20190603222916.20698-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
'<function name>', this function's name, in a string".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index a70665a202c3..6d4fc1f37c9f 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -312,8 +312,8 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	unsigned long dma_bar_phys_len;
 	u16 regval;
 
-	dev_dbg(&pdev->dev, "kp2000_pcie_probe(pdev = [%p], id = [%p])\n",
-		pdev, id);
+	dev_dbg(&pdev->dev, "%s(pdev = [%p], id = [%p])\n",
+		__func__, pdev, id);
 
 	/*
 	 * Step 1: Allocate a struct for the pcard
@@ -481,7 +481,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 			 pcard->name, pcard);
 	if (rv) {
 		dev_err(&pcard->pdev->dev,
-			"kp2000_pcie_probe: failed to request_irq: %d\n", rv);
+			"%s: failed to request_irq: %d\n", __func__, rv);
 		goto out8b;
 	}
 
@@ -507,7 +507,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	writel(KPC_DMA_CARD_IRQ_ENABLE | KPC_DMA_CARD_USER_INTERRUPT_MODE,
 	       pcard->dma_common_regs);
 
-	dev_dbg(&pcard->pdev->dev, "kp2000_pcie_probe() complete!\n");
+	dev_dbg(&pcard->pdev->dev, "%s() complete!\n", __func__);
 	mutex_unlock(&pcard->sem);
 	return 0;
 
@@ -541,7 +541,7 @@ static void kp2000_pcie_remove(struct pci_dev *pdev)
 {
 	struct kp2000_device *pcard = pci_get_drvdata(pdev);
 
-	dev_dbg(&pdev->dev, "kp2000_pcie_remove(pdev=%p)\n", pdev);
+	dev_dbg(&pdev->dev, "%s(pdev=%p)\n", __func__, pdev);
 
 	if (!pcard)
 		return;
-- 
2.20.1

