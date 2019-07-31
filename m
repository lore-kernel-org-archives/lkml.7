Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A212206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577051;
	bh=OpLDvIxJpuqw1Y07+slcLl/ar6SV0gGmWVthQGmxjtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYxiynAM96wDPkInirbJ4GgjyC+SsnLD7ZBUkxcy5tkY2/r+yp83jxlAIm+KYRgkV
	 s5JdJEdIUUGFsvaQXfIxfQUcHTrfilQ1FbRd92dEgQ2HaWDga4jXH/4flyXOFqD4QK
	 R2rXoxmG66C/yxkhJmYTdKg1/d78RDMKlltG3KkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfGaMoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbfGaMoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C742206B8;
        Wed, 31 Jul 2019 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577047;
        bh=OpLDvIxJpuqw1Y07+slcLl/ar6SV0gGmWVthQGmxjtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDKo50NGE77WI8eo25aSgbqjia32TVpK0C4drtWImg+lv0lYu8kouDCPwYoBZ+33x
         TsM21lwfHU9khTHftDxdEPLcp/RrmiZlgI+vKVgy8xyHKSvZi7qEXmF0xlP/qKnzDH
         Z+Wz83KvK4VrGhJ8CYiSZzZZyqwfRQk21DiKFWEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 02/10] uio: uio_fsl_elbc_gpcm: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:41 +0200
Message-Id: <20190731124349.4474-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a sysfs group of attributes.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 450e2f5c9b43..be8a6905f507 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -71,6 +71,13 @@ static ssize_t reg_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(reg_br, 0664, reg_show, reg_store);
 static DEVICE_ATTR(reg_or, 0664, reg_show, reg_store);
 
+static struct attribute *uio_fsl_elbc_gpcm_attrs[] = {
+	&dev_attr_reg_br.attr,
+	&dev_attr_reg_or.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(uio_fsl_elbc_gpcm);
+
 static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -411,25 +418,12 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	/* store private data */
 	platform_set_drvdata(pdev, info);
 
-	/* create sysfs files */
-	ret = device_create_file(priv->dev, &dev_attr_reg_br);
-	if (ret)
-		goto out_err3;
-	ret = device_create_file(priv->dev, &dev_attr_reg_or);
-	if (ret)
-		goto out_err4;
-
 	dev_info(priv->dev,
 		 "eLBC/GPCM device (%s) at 0x%llx, bank %d, irq=%d\n",
 		 priv->name, (unsigned long long)res.start, priv->bank,
 		 irq != NO_IRQ ? irq : -1);
 
 	return 0;
-out_err4:
-	device_remove_file(priv->dev, &dev_attr_reg_br);
-out_err3:
-	platform_set_drvdata(pdev, NULL);
-	uio_unregister_device(info);
 out_err2:
 	if (priv->shutdown)
 		priv->shutdown(info, true);
@@ -448,8 +442,6 @@ static int uio_fsl_elbc_gpcm_remove(struct platform_device *pdev)
 	struct uio_info *info = platform_get_drvdata(pdev);
 	struct fsl_elbc_gpcm *priv = info->priv;
 
-	device_remove_file(priv->dev, &dev_attr_reg_or);
-	device_remove_file(priv->dev, &dev_attr_reg_br);
 	platform_set_drvdata(pdev, NULL);
 	uio_unregister_device(info);
 	if (priv->shutdown)
@@ -474,6 +466,7 @@ static struct platform_driver uio_fsl_elbc_gpcm_driver = {
 	.driver = {
 		.name = "fsl,elbc-gpcm-uio",
 		.of_match_table = uio_fsl_elbc_gpcm_match,
+		.dev_groups = uio_fsl_elbc_gpcm_groups,
 	},
 	.probe = uio_fsl_elbc_gpcm_probe,
 	.remove = uio_fsl_elbc_gpcm_remove,
-- 
2.22.0

