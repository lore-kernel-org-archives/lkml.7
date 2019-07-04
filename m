Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B0C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CA2218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230014;
	bh=qtIWUlZhhHDXDpXDtHcNJNcCL7CfAeK4osJtqxlinjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IKNC/FaCxV+13tBw2tOGoZRjjmpuWc9944vbVSCWUEe2sQR31m4LGjKQbSpuc3ove
	 QRSM3UjaXRqa8ZPUHGVtUdkDm37l8qtaIBssbqWEz0WI/73S5Epqy3pz+noopEWYxC
	 /3rikIwhyeoBtWN15g12ipDTthVCW3vPk2Zb9SNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfGDIqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfGDIqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2062189E;
        Thu,  4 Jul 2019 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230007;
        bh=qtIWUlZhhHDXDpXDtHcNJNcCL7CfAeK4osJtqxlinjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG//GIHoNqgkq2z+t6Bjz6KO7Rh5y3z+iamhj72CD8u7+VgFbEQ0q/odyajknog48
         5LqbvsICZnRrZH4ycDqs2euu9VEXB5phKT1n+K01idiwxvzU188LYcyLAPivSys+/P
         L1ZTROUNhaCzIfst0WBd3CalPy+wyjiKvH7HqzxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/11] uio: uio_fsl_elbc_gpcm: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:08 +0200
Message-Id: <20190704084617.3602-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
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
index 450e2f5c9b43..05a9cb10a419 100644
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
@@ -477,6 +469,7 @@ static struct platform_driver uio_fsl_elbc_gpcm_driver = {
 	},
 	.probe = uio_fsl_elbc_gpcm_probe,
 	.remove = uio_fsl_elbc_gpcm_remove,
+	.dev_groups = uio_fsl_elbc_gpcm_groups,
 };
 module_platform_driver(uio_fsl_elbc_gpcm_driver);
 
-- 
2.22.0

