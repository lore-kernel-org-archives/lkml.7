Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46354C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183FA218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFG6HwCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfJJHuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:50:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44361 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJJHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:50:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so3334454pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMwVxKJ5pjT6AAme6CzPathy+GO4sDWlKBre4oI24yA=;
        b=RFG6HwCYSDramAhQi1uVRJXiRCVoJbWbPFfqpgOBrr+ONoYndjuqcaaKVXq5mGam8b
         NZtTefp9ssgMDcOeS44tvnd/S01DBUC/puqu1Pc1WrhMLPuHRw/wlomndD3BsbpSaPGb
         gHUbAX/+u3EKiwTIyQl/RS16LhLTepVBNK6XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMwVxKJ5pjT6AAme6CzPathy+GO4sDWlKBre4oI24yA=;
        b=jEr4iE5fXv/PiDcBaN31m/dfAxLYCKTMIaLOlTQAkof7YBLH8SWKlAWvvcQ081FIDO
         VExmZfP4ORwawSdHSuo8hMQlsS1eiCilpJ+wikah88SZHyp2XXk+ZjkLWYnmkljkVMTR
         /cWm55uS0sTLoKz/tFNTgsBzInUKa6hlcI2DA5a4g5pzoZxk1AU9f7BoKmVMx48DAc4f
         Sm/e921B7kcZu6U1petgXa/rN+lXWFIEyPp/dvXCaj7i7Q1329HGfKm6RHmhwO80G1Lv
         Ga+++CGEexwoJK7V3wff1mJV0Ze9CbsRqfs7wjuVjKe+oAwePe2WgSbF3fd/VIxD54kZ
         o4Zw==
X-Gm-Message-State: APjAAAVg+S2q14I3xZnzm3FjmbbBced4oRjyB3k0HPjL6X1ml7QkSl4z
        c0PuRuWqS4Qfvj9T5mcnBuSPvw==
X-Google-Smtp-Source: APXvYqyImi2kgnGChUg2KfgfL+4s6k7vSPd2oI6xHbrOyAm/ZcqmRMonHqTVcAChWDBQgIDHwV/S+w==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr9163082pgb.98.1570693812256;
        Thu, 10 Oct 2019 00:50:12 -0700 (PDT)
Received: from tfiga.tok.corp.google.com ([2401:fa00:8f:203:f5fe:2a5e:f953:c0ed])
        by smtp.gmail.com with ESMTPSA id 22sm4812489pfj.139.2019.10.10.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 00:50:11 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Changqi Hu <Changqi.Hu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Shik Chen <shik@chromium.org>, Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] usb: mtk-xhci: Set the XHCI_NO_64BIT_SUPPORT quirk
Date:   Thu, 10 Oct 2019 16:50:04 +0900
Message-Id: <20191010075004.192818-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek XHCI host controller does not support 64-bit addressing despite
the AC64 bit of HCCPARAMS1 register being set. The platform-specific
glue sets the DMA mask to 32 bits on its own, but it has no effect,
because xhci_gen_setup() overrides it according to hardware
capabilities.

Use the XHCI_NO_64BIT_SUPPORT quirk to tell the XHCI core to force
32-bit DMA mask instead.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/usb/host/xhci-mtk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b18a6baef204a..4d101d52cc11b 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 	xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
 	if (mtk->lpm_support)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+	/*
+	 * MTK host controller does not support 64-bit addressing, despite
+	 * having the AC64 bit of the HCCPARAMS1 register set.
+	 */
+	xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 }
 
 /* called during probe() after chip reset completes */
@@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto disable_clk;
-
 	hcd = usb_create_hcd(driver, dev, dev_name(dev));
 	if (!hcd) {
 		ret = -ENOMEM;
-- 
2.23.0.581.g78d2f28ef7-goog

