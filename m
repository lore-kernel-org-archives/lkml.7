Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C9F20700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="DuZR75PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfKRAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:21:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33953 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRAVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id 19so3078359otz.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ovt6jbDPjyCR0/arOz9a+rgIf56RvTTsMB0ccBa1ek=;
        b=DuZR75PETpq9SHSgVGX4A7aW1VbYfbZpBNrGJMQG94ixdnUnssFw8RwbbiqCZWa/ad
         Ib1io05cexSPa9pmwdrRDzgcgZ7FNsfNhleHAGvS7g/SNVm3GEQbn9XIt7fJ2WUDrVnJ
         vF71JXj/NIpCafPIliMJxG0OjI3A+r//g0kJ1s4eIn0bHDy/Ci0Z4Q1M3TrxGD/1CccX
         T1TcO83huhJL5HXu/UTUdSTCduX4v83PJKYlEktUQgpXvRMqcB+xsHT6QeIEwdHcQVrc
         h6YVSw4gQ3rPaPuT4mzbVcReI8r5mdt90esAKNQ+uXv4Bw6Mxkb+mFPAmxGtbP57LSnB
         wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ovt6jbDPjyCR0/arOz9a+rgIf56RvTTsMB0ccBa1ek=;
        b=UoHSgpVHBARax058j7YffdMERbn8doQrFAq1IBnnastldiILGcoOtMOn1d4Za2gt9t
         4KrWGobC2RizwkY9GUuUfNeV8cKMUGsZf/N1zKyV0me9/WIlVb8qdGCGd2bw7U4bDjM0
         8Goj5K7oealFbapxs09KTEFL5/f6nd/QLsNvt6pAKBXKrI5neGY2fesLeihzsadI1HiD
         QTb/3AsbYcTlIvYsR9UGHZtglwuqw6j7E8pTmNmVsKxzzRpLy0k2jVGOzaweOy2OijTs
         tLbeFLBmEqa0TE8HOJbrmV3MMd3vFBI2v0Aedrs57BLit07MPyBhC37NVKHrGXxpqmtd
         oaZQ==
X-Gm-Message-State: APjAAAXwboOlVoUNrpBetK1dTGeB0H3TRmAZFiotKZ+ea1Z8U37mMqQX
        hD1eSOvfw3LL6jscomn/fUIoTQ==
X-Google-Smtp-Source: APXvYqwrOBmroGm4Xd11i377lyNFKSWESfgTnNADfHHvp4d6oK0HIA88i6ywpvr+uizhKDds258Opw==
X-Received: by 2002:a9d:6288:: with SMTP id x8mr21052106otk.170.1574036476012;
        Sun, 17 Nov 2019 16:21:16 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:15 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 4/4] mtip32xx: Replace magic numbers with PCI constants
Date:   Sun, 17 Nov 2019 18:20:57 -0600
Message-Id: <20191118002057.9596-5-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118002057.9596-1-fred@fredlawl.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readability was improved by replacing pci_read_config_word() with
pcie_capability_read_word(). Take that a step further by replacing magic
numbers with PCI reg constants.

No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
v2:
- Added this patch
---
 drivers/block/mtip32xx/mtip32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 35703dc98e25..225c6ae62385 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3942,8 +3942,8 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 		return;
 
 	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
-	if (pcie_dev_ctrl & (1 << 11) ||
-	    pcie_dev_ctrl & (1 << 4)) {
+	if (pcie_dev_ctrl & PCI_EXP_DEVCTL_NOSNOOP_EN ||
+	    pcie_dev_ctrl & PCI_EXP_DEVCTL_RELAX_EN) {
 		dev_info(&dd->pdev->dev,
 			 "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
 			 pdev->vendor, pdev->device);
-- 
2.20.1

