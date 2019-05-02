Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CBC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A0B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjA0IkL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBE4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 00:56:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33355 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfEBE4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 00:56:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so539071pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 21:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uEhbXfTbBJ1Z2Kv01LPBYrX3ZS5Rz9y5kPzobESOBI=;
        b=kjA0IkL2lphoYXjpaZd0JAuzOk4YKKTN2UCTNfqgYOGUz6zgSRQY1cyglpFLe9gZ1n
         GRnS9XNzri/D5ysNkPqqdDRMk3KRSwovN2qpgkhVkTiuhC4agg/NTutb4WuN47fVcZCF
         UUIO5robvSzsJ+u7sWK47XdnbhZImedX79T2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uEhbXfTbBJ1Z2Kv01LPBYrX3ZS5Rz9y5kPzobESOBI=;
        b=KS1VxQDxSCqVJ34QUf6Fz7+9kSEU5zcqutOS7+uXUji1SNluPQgbSSXl3Sh5tEqsGw
         /D3QpxHSxYP555+lQvDwzKOt4DMfKxMsmVH0N3OrScsxZXJUBdXI+aiKlA2qVg4AElIP
         4HOyXDD0u3t8fL+natp0PYxgNIBR4YVvR+pTjjebjC6cpS3GFMV96/fo28srzOLdzKAc
         NCj5nnjCv2jJHt9/a4blOiXFJqQMZailk3qa6wzYJ+3cDKZLO4L8QyWoj7u/EWMCLjT9
         CcnCDdxtUMr9U4+4Ow1H5UYdDdaBHLfdw9mqZlDg0ZPUG9UQrj42AKTTZZqXIcjXd5OK
         c2kg==
X-Gm-Message-State: APjAAAXlsEGUG67rNme63JUPH5hNMhZ/F2n9NLWgUG/38EIaK2BgKnzk
        IWtczdWUi/be3t2ERIz+qR2Qhg==
X-Google-Smtp-Source: APXvYqxb8f1zrcqX3NddJRYvEW77UkD+Um0XCa7fQsUuySsX73xUDBYJ7k8eUOzlL/onT4KImTFWUg==
X-Received: by 2002:aa7:800e:: with SMTP id j14mr1786208pfi.157.1556772998334;
        Wed, 01 May 2019 21:56:38 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id a6sm64239470pfn.181.2019.05.01.21.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 21:56:37 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Hoan Tran <hoan@os.amperecomputing.com>
Subject: [PATCH 2/2] usb: xhci-mtk: Do not create shared_hcd if no USB 3.0 port available
Date:   Thu,  2 May 2019 12:56:30 +0800
Message-Id: <20190502045631.229386-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190502045631.229386-1-drinkcat@chromium.org>
References: <20190502045631.229386-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the controller only supports USB 2.0, do not even create the
USB 3.0 hcd/root hub.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/usb/host/xhci-mtk.c | 44 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 026fe18972d3e5b..189f5dc614e6e05 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -527,23 +527,28 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	xhci->imod_interval = 5000;
 	device_property_read_u32(dev, "imod-interval-ns", &xhci->imod_interval);
 
-	xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
+	/* Only create shared_hcd when USB3.0 port is available. */
+	if (xhci->usb3_rhub.num_ports > 0) {
+		xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
 			dev_name(dev), hcd);
-	if (!xhci->shared_hcd) {
-		ret = -ENOMEM;
-		goto disable_device_wakeup;
+		if (!xhci->shared_hcd) {
+			ret = -ENOMEM;
+			goto disable_device_wakeup;
+		}
 	}
 
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto put_usb3_hcd;
 
-	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
-		xhci->shared_hcd->can_do_streams = 1;
+	if (xhci->usb3_rhub.num_ports > 0) {
+		if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+			xhci->shared_hcd->can_do_streams = 1;
 
-	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
-	if (ret)
-		goto dealloc_usb2_hcd;
+		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
+		if (ret)
+			goto dealloc_usb2_hcd;
+	}
 
 	return 0;
 
@@ -552,7 +557,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 
 put_usb3_hcd:
 	xhci_mtk_sch_exit(mtk);
-	usb_put_hcd(xhci->shared_hcd);
+	if (xhci->shared_hcd)
+		usb_put_hcd(xhci->shared_hcd);
 
 disable_device_wakeup:
 	device_init_wakeup(dev, false);
@@ -579,12 +585,14 @@ static int xhci_mtk_remove(struct platform_device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
 
-	usb_remove_hcd(shared_hcd);
+	if (shared_hcd)
+		usb_remove_hcd(shared_hcd);
 	xhci->shared_hcd = NULL;
 	device_init_wakeup(&dev->dev, false);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(shared_hcd);
+	if (shared_hcd)
+		usb_put_hcd(shared_hcd);
 	usb_put_hcd(hcd);
 	xhci_mtk_sch_exit(mtk);
 	xhci_mtk_clks_disable(mtk);
@@ -611,8 +619,10 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 	xhci_dbg(xhci, "%s: stop port polling\n", __func__);
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	del_timer_sync(&hcd->rh_timer);
-	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-	del_timer_sync(&xhci->shared_hcd->rh_timer);
+	if (xhci->shared_hcd) {
+		clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+		del_timer_sync(&xhci->shared_hcd->rh_timer);
+	}
 
 	xhci_mtk_host_disable(mtk);
 	xhci_mtk_clks_disable(mtk);
@@ -631,8 +641,10 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	xhci_mtk_host_enable(mtk);
 
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-	usb_hcd_poll_rh_status(xhci->shared_hcd);
+	if (xhci->shared_hcd) {
+		set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+		usb_hcd_poll_rh_status(xhci->shared_hcd);
+	}
 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 	return 0;
-- 
2.21.0.593.g511ec345e18-goog

