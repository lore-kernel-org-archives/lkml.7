Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F5C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A3217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4s2XZTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfHGCvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:51:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHGCvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bz8DpakXTLvdflJtOOIheTWTxpa/h+gBAdxWkh1NJJk=; b=d4s2XZTaEPB1QrBvzxBuG4I2T
        QSqfh248RHABYRYXgejHHvf30bDAdKZDET1NDoaKksxJ2LI2B+FGdf/B6YbbxJFDVFFmRJqJY9Ve/
        eIaxVrR4NxPSrFUgG3LWRQIALbRF6dxhAoINld34yjK3oLyXmFajWN+hTi/iRRKsSRKh+tVHodjIY
        GKHYIL92nIDbhZ/Q609/0LYeGTOVAonM9jV9Rs9Z44Tp1F7se9hfERXBNOtZZnAEoc8ZIgn3S6yDM
        nRbAMaMOvYdrq7Zth+cM/lWJf9XHHrt+1kOkUxx5wyReOSySzdHbjO6wteX1p2NuabSZHkuvDjCqS
        oSY1CwZew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvC2V-0007P8-0o; Wed, 07 Aug 2019 02:50:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xilinx_sdfec: Convert to IDA
Date:   Tue,  6 Aug 2019 19:50:50 -0700
Message-Id: <20190807025050.28367-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This driver does not use the lookup abilities of the IDR, so convert it
to the more space-efficient IDA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/misc/xilinx_sdfec.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index f257d3812110..071b26a8c6a9 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -22,8 +22,7 @@
 
 #define DEV_NAME_LEN 12
 
-static struct idr dev_idr;
-static struct mutex dev_idr_lock;
+static DEFINE_IDA(dev_nrs);
 
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
@@ -227,13 +226,6 @@ static void xsdfec_disable_all_clks(struct xsdfec_clks *clks)
 	clk_disable_unprepare(clks->axi_clk);
 }
 
-static void xsdfec_idr_remove(struct xsdfec_dev *xsdfec)
-{
-	mutex_lock(&dev_idr_lock);
-	idr_remove(&dev_idr, xsdfec->dev_id);
-	mutex_unlock(&dev_idr_lock);
-}
-
 static int xsdfec_probe(struct platform_device *pdev)
 {
 	struct xsdfec_dev *xsdfec;
@@ -263,9 +255,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 	/* Save driver private data */
 	platform_set_drvdata(pdev, xsdfec);
 
-	mutex_lock(&dev_idr_lock);
-	err = idr_alloc(&dev_idr, xsdfec->dev_name, 0, 0, GFP_KERNEL);
-	mutex_unlock(&dev_idr_lock);
+	err = ida_alloc(&dev_nrs, GFP_KERNEL);
 	if (err < 0)
 		goto err_xsdfec_dev;
 	xsdfec->dev_id = err;
@@ -278,12 +268,12 @@ static int xsdfec_probe(struct platform_device *pdev)
 	err = misc_register(&xsdfec->miscdev);
 	if (err) {
 		dev_err(dev, "error:%d. Unable to register device", err);
-		goto err_xsdfec_idr;
+		goto err_xsdfec_ida;
 	}
 	return 0;
 
-err_xsdfec_idr:
-	xsdfec_idr_remove(xsdfec);
+err_xsdfec_ida:
+	ida_free(&dev_nrs, xsdfec->dev_id);
 err_xsdfec_dev:
 	xsdfec_disable_all_clks(&xsdfec->clks);
 	return err;
@@ -295,7 +285,7 @@ static int xsdfec_remove(struct platform_device *pdev)
 
 	xsdfec = platform_get_drvdata(pdev);
 	misc_deregister(&xsdfec->miscdev);
-	xsdfec_idr_remove(xsdfec);
+	ida_free(&dev_nrs, xsdfec->dev_id);
 	xsdfec_disable_all_clks(&xsdfec->clks);
 	return 0;
 }
@@ -321,8 +311,6 @@ static int __init xsdfec_init(void)
 {
 	int err;
 
-	mutex_init(&dev_idr_lock);
-	idr_init(&dev_idr);
 	err = platform_driver_register(&xsdfec_driver);
 	if (err < 0) {
 		pr_err("%s Unabled to register SDFEC driver", __func__);
@@ -334,7 +322,6 @@ static int __init xsdfec_init(void)
 static void __exit xsdfec_exit(void)
 {
 	platform_driver_unregister(&xsdfec_driver);
-	idr_destroy(&dev_idr);
 }
 
 module_init(xsdfec_init);
-- 
2.20.1

