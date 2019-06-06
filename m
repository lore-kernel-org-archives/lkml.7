Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D35C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FE32083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfFFPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:01:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:01:07 -0400
Received: from orion.localdomain ([77.9.2.22]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeTkC-1h0wZg2fC8-00aSbg; Thu, 06 Jun 2019 17:00:40 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Subject: [PATCH] drivers: hwmon: i5k_amb: simplify probing / device identification
Date:   Thu,  6 Jun 2019 17:00:33 +0200
Message-Id: <1559833233-25723-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559833233-25723-1-git-send-email-info@metux.net>
References: <1559833233-25723-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:xgFb+Inj4aDfp/gYDygJhDlwg0GJKj5xkP7T34yrBOq4ZvRzA53
 JLjb9bcWg51SPxqYWxL5dMXSM6hYzLLt9NyGZtX2l/rqDIFftl+5b63t4Eyrp/YFdi7Fxzm
 Ht/3l+fat4JzwHxoyPUc2qj44dW5IJJEOHp5B9Dqd7QWzxeR/rNFN9KdAUY14/HawE5/m6b
 U698vPPHR7jbqh7k5n9pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ofB2UevWLU=:fod3Z4yAxcFPc2s76E9TE2
 la2+cS3nXw03X1N1bw5dsk+Ecyhs6pSDSog2f6povlnvcBI/vA42TRJtXgc8cBfythb5SWafF
 PEyZvS9ubxR0QAMjzInmHFiEmaNWR2Oi74oErAZmkrmUxVdYggs01gUYJh4lU7D06c8P60Nij
 cXFT8Twcrlv9FboyJb1QcSECx/kKf3TOYajEu25zKyFUQW+x7eVd1hsZ7fv777xr05ohp8bJm
 EoxVf1bnAal8HHxRa0z/8MCu+FLPcn6m9IIR3twmDWuwkc/ejrXxsaq3GvHoEJAvFg7m+ZLcG
 UpCAx8yzllf3cHinidaE/4dlP1XxJ6uVC37uCZMqJJPEl2d8DYF6b7Y2kTzehYvOc1OCZDIPG
 0CbVkweNiZSP8Sr6Jz7PfGVXFIcmE1hWgZHo5lS5hoR1vgztCgOj+S/6yB8DRbXXCbWE/Y+XU
 Z6bExlJTwC77Vti58xmzgLy4QpH4MnDqfPApu4jzuTFTaRwZwhVxTRwyOeBojg7NxQ7tOdvVY
 3Drn3caShIg6WI4XeoWX/llhUCbO/nrgbZZeoAGsh/94Eh0ifkvtcug8m6R8KdqlfL0E0uU70
 JXkosQ6cWHjLFKDwUyls9TEn4GR9OaBcwZtyH+avw9vR7zxtDb+tFopktbP0nZS1ktEoJ+muU
 VAj67BWKRP2FwHxj49bx2LK42Dgrl1+vDIi4ydXgKppZJ+5irqiltDOb+1w/LJdt5yVElboQg
 4W5E8TT4oYt/+uh2IToKtmgJAcnLGGIkkr1aPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Simpilify the probing by putting all chip-specific data directly
into the pci match table, removing the redundant chipset_ids table.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/hwmon/i5k_amb.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index b09c39a..f06c40f 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -414,15 +414,15 @@ static int i5k_amb_add(void)
 }
 
 static int i5k_find_amb_registers(struct i5k_amb_data *data,
-					    unsigned long devid)
+				  const struct pci_device_id *devid)
 {
 	struct pci_dev *pcidev;
 	u32 val32;
 	int res = -ENODEV;
 
 	/* Find AMB register memory space */
-	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				devid,
+	pcidev = pci_get_device(devid->vendor,
+				devid->device,
 				NULL);
 	if (!pcidev)
 		return -ENODEV;
@@ -447,14 +447,18 @@ static int i5k_find_amb_registers(struct i5k_amb_data *data,
 	return res;
 }
 
-static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
+static int i5k_channel_probe(u16 *amb_present,
+			     const struct pci_device_id *devid,
+			     int next)
 {
 	struct pci_dev *pcidev;
 	u16 val16;
 	int res = -ENODEV;
 
 	/* Copy the DIMM presence map for these two channels */
-	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, dev_id, NULL);
+	pcidev = pci_get_device(devid->vendor,
+				(unsigned long)devid->driver_data + next,
+				NULL);
 	if (!pcidev)
 		return -ENODEV;
 
@@ -473,23 +477,20 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
 	return res;
 }
 
-static struct {
-	unsigned long err;
-	unsigned long fbd0;
-} chipset_ids[]  = {
-	{ PCI_DEVICE_ID_INTEL_5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0 },
-	{ PCI_DEVICE_ID_INTEL_5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0 },
-	{ 0, 0 }
-};
-
-#ifdef MODULE
 static const struct pci_device_id i5k_amb_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_5000_ERR,
+		.driver_data	= PCI_DEVICE_ID_INTEL_5000_FBD0,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_5400_ERR,
+		.driver_data	= PCI_DEVICE_ID_INTEL_5400_FBD0,
+	},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
-#endif
 
 static int i5k_amb_probe(struct platform_device *pdev)
 {
@@ -504,22 +505,22 @@ static int i5k_amb_probe(struct platform_device *pdev)
 	/* Figure out where the AMB registers live */
 	i = 0;
 	do {
-		res = i5k_find_amb_registers(data, chipset_ids[i].err);
+		res = i5k_find_amb_registers(data, &i5k_amb_ids[i]);
 		if (res == 0)
 			break;
 		i++;
-	} while (chipset_ids[i].err);
+	} while (i5k_amb_ids[i].device);
 
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the first two channels */
-	res = i5k_channel_probe(&data->amb_present[0], chipset_ids[i].fbd0);
+	res = i5k_channel_probe(&data->amb_present[0], &i5k_amb_ids[i], 0);
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the optional second two channels */
-	i5k_channel_probe(&data->amb_present[2], chipset_ids[i].fbd0 + 1);
+	i5k_channel_probe(&data->amb_present[2], &i5k_amb_ids[i], 1);
 
 	/* Set up resource regions */
 	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
-- 
1.9.1

