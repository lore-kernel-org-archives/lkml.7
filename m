Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23397C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9ZpIwVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCLOjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:39:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37913 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:39:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so2785634qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nz3dIg3XDyF1EqxxRA4MGOL4ptdjMNMGlH9B+ViHc5k=;
        b=k9ZpIwVcBlWtAJT/v2talNiU5iBYpLUt2BuBTrlVP9RDmjLUYlqHv71cyFWHi1nSMn
         LbCzXkT+bvdhi2II1lkZnz5sCKstgzqksrz6PtUqKD+UXqCehj2oo5YhcYIFEqtDShlf
         HmybQATXr8otXb2fwO7MGG9g8t2Dm9Wwpu8/17UDB8wt/0UeLQWT0zjz9WEvXb9MQYQu
         lfJpqljLq/PvvDutH9IayhWOFYAurAi3P2fBg/OIJ/EiYw6ckwPfDU5vSkLq8+sfNxBv
         rOPN/gGVVWKlMqyiib4wUupdR8rF3eE7CHaT89mMNZrgAg81eHZHbHiHdAtiA91Kp5IJ
         CVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nz3dIg3XDyF1EqxxRA4MGOL4ptdjMNMGlH9B+ViHc5k=;
        b=SbKkUespSRbF7IXriNy+7VKi4azfOSfDo3Vx7orbci1HnUVvVyCJcu9Jz501VH+y7n
         +Pfpmmf3oiJFE0vtgVMArKu+vFZkh0M/97kf+Usg6eg0o7EgL0lJZBOeFUOgMq0VcYb1
         ZnIUk53s5+3sSrp9dRXZvmO6KM5c0t0cokUMGHShd+1z4hqTSEw0y8s9FHTVJQ+KQZO3
         I4/WMBl9ZAPphM8gIghg9VINsfZ5XJO3DO13mIjpox+wRyNUcFkGc7Z9a4Z9ko/Pbtne
         /yi0y80PfKgZDP0pDqSN4BTNUluvofcVrAkZtdonv2nthIeL9WVzTs/9873luCdLGIXu
         l4pw==
X-Gm-Message-State: APjAAAXNbyPlg0nMF1TFAsWbBivYCILm3i8ucHIPdaDTx4C90Pq9p9md
        B0rBUBVMcfYMm3u+z4JZVD4=
X-Google-Smtp-Source: APXvYqxgPL9uZjlDXv7db4pWIhbptPpbi5YK6WBeYGer/YCvhpP+fwB6GfbzoeQnR0GCAB6BUkO2Bg==
X-Received: by 2002:a05:6214:8e:: with SMTP id n14mr6727932qvr.182.1552401580948;
        Tue, 12 Mar 2019 07:39:40 -0700 (PDT)
Received: from localhost.localdomain ([177.76.237.150])
        by smtp.gmail.com with ESMTPSA id m88sm4616344qte.68.2019.03.12.07.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:39:40 -0700 (PDT)
From:   Guilherme T Maeoka <gui.mspace@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme T Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 1/2] Staging: rtl8723bs: os_dep: Fix several coding style errors
Date:   Tue, 12 Mar 2019 11:39:13 -0300
Message-Id: <20190312143914.4471-1-gui.mspace@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guilherme T Maeoka <gui.maeoka@gmail.com>

Fix coding style errors and warns complained by checkpatck.pl. To list:

	- remove braces for single statements blocks,
	- add space required around operators,
	- replace spaces with tabs to indent,
	- add blank line after declarations,
	- fix braces and 'else' poistions in selection statements.

Signed-off-by: Guilherme T Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 112 +++++++++----------
 1 file changed, 50 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 6d02904de63f..86f1e090436e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -14,14 +14,14 @@
 #define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
 #endif
 
-static const struct sdio_device_id sdio_ids[] =
-{
+static const struct sdio_device_id sdio_ids[] = {
 	{ SDIO_DEVICE(0x024c, 0x0523), },
 	{ SDIO_DEVICE(0x024c, 0x0623), },
 	{ SDIO_DEVICE(0x024c, 0x0626), },
 	{ SDIO_DEVICE(0x024c, 0xb723), },
 	{ /* end: all zeroes */				},
 };
+
 static const struct acpi_device_id acpi_ids[] = {
 	{"OBDA8723", 0x0000},
 	{}
@@ -84,46 +84,42 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	sdio_claim_host(func);
 
 	err = sdio_claim_irq(func, &sd_sync_int_hdl);
-	if (err)
-	{
+	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
 		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
-	}
-	else
-	{
+	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
 	}
 
 	sdio_release_host(func);
 
-	return err?_FAIL:_SUCCESS;
+	return err ? _FAIL : _SUCCESS;
 }
 
 static void sdio_free_irq(struct dvobj_priv *dvobj)
 {
-    PSDIO_DATA psdio_data;
-    struct sdio_func *func;
-    int err;
-
-    if (dvobj->irq_alloc) {
-        psdio_data = &dvobj->intf_data;
-        func = psdio_data->func;
-
-        if (func) {
-            sdio_claim_host(func);
-            err = sdio_release_irq(func);
-            if (err)
-            {
+	PSDIO_DATA psdio_data;
+	struct sdio_func *func;
+	int err;
+
+	if (dvobj->irq_alloc) {
+		psdio_data = &dvobj->intf_data;
+		func = psdio_data->func;
+
+		if (func) {
+			sdio_claim_host(func);
+			err = sdio_release_irq(func);
+			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-				DBG_871X_LEVEL(_drv_err_,"%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
-            }
-            else
-		dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
-            sdio_release_host(func);
-        }
-        dvobj->irq_alloc = 0;
-    }
+				DBG_871X_LEVEL(_drv_err_, "%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
+			} else {
+				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
+			}
+			sdio_release_host(func);
+		}
+		dvobj->irq_alloc = 0;
+	}
 }
 
 #ifdef CONFIG_GPIO_WAKEUP
@@ -131,16 +127,18 @@ extern unsigned int oob_irq;
 static irqreturn_t gpio_hostwakeup_irq_thread(int irq, void *data)
 {
 	struct adapter *padapter = data;
+
 	DBG_871X_LEVEL(_drv_always_, "gpio_hostwakeup_irq_thread\n");
 	/* Disable interrupt before calling handler */
 	/* disable_irq_nosync(oob_irq); */
-	rtw_lock_suspend_timeout(HZ/2);
+	rtw_lock_suspend_timeout(HZ / 2);
 	return IRQ_HANDLED;
 }
 
 static u8 gpio_hostwakeup_alloc_irq(struct adapter *padapter)
 {
 	int err;
+
 	if (oob_irq == 0) {
 		DBG_871X("oob_irq ZERO!\n");
 		return _FAIL;
@@ -150,9 +148,9 @@ static u8 gpio_hostwakeup_alloc_irq(struct adapter *padapter)
 	/* and failing can prevent can not sleep issue if */
 	/* wifi gpio12 pin is not linked with CPU */
 	err = request_threaded_irq(oob_irq, gpio_hostwakeup_irq_thread, NULL,
-		/* IRQF_TRIGGER_LOW | IRQF_ONESHOT, */
-		IRQF_TRIGGER_FALLING,
-		"rtw_wifi_gpio_wakeup", padapter);
+				   /* IRQF_TRIGGER_LOW | IRQF_ONESHOT, */
+				   IRQF_TRIGGER_FALLING,
+				   "rtw_wifi_gpio_wakeup", padapter);
 	if (err < 0) {
 		DBG_871X("Oops: can't allocate gpio irq %d err:%d\n", oob_irq, err);
 		return false;
@@ -224,26 +222,25 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 	if (func) {
 		sdio_claim_host(func);
 		err = sdio_disable_func(func);
-		if (err)
-		{
+		if (err) {
 			dvobj->drv_dbg.dbg_sdio_deinit_error_cnt++;
 			DBG_8192C(KERN_ERR "%s: sdio_disable_func(%d)\n", __func__, err);
 		}
 
 		if (dvobj->irq_alloc) {
 			err = sdio_release_irq(func);
-			if (err)
-			{
+			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n", __func__, err);
-			}
-			else
+			} else {
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
+			}
 		}
 
 		sdio_release_host(func);
 	}
 }
+
 static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 {
 	int status = _FAIL;
@@ -251,9 +248,8 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	PSDIO_DATA psdio;
 
 	dvobj = devobj_init();
-	if (dvobj == NULL) {
+	if (dvobj == NULL)
 		goto exit;
-	}
 
 	sdio_set_drvdata(func, dvobj);
 
@@ -330,14 +326,13 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	PSDIO_DATA psdio = &dvobj->intf_data;
 
 	padapter = vzalloc(sizeof(*padapter));
-	if (padapter == NULL) {
+	if (padapter == NULL)
 		goto exit;
-	}
 
 	padapter->dvobj = dvobj;
 	dvobj->if1 = padapter;
 
-	padapter->bDriverStopped =true;
+	padapter->bDriverStopped = true;
 
 	dvobj->padapters = padapter;
 	padapter->iface_id = 0;
@@ -368,8 +363,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	padapter->intf_alloc_irq = &sdio_alloc_irq;
 	padapter->intf_free_irq = &sdio_free_irq;
 
-	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL)
-	{
+	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL) {
 		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
 			("rtw_drv_init: Can't init io_priv\n"));
 		goto free_hal_data;
@@ -444,16 +438,15 @@ static void rtw_sdio_if1_deinit(struct adapter *if1)
 	rtw_cancel_all_timer(if1);
 
 #ifdef CONFIG_WOWLAN
-	adapter_to_pwrctl(if1)->wowlan_mode =false;
+	adapter_to_pwrctl(if1)->wowlan_mode = false;
 	DBG_871X_LEVEL(_drv_always_, "%s wowlan_mode:%d\n", __func__, adapter_to_pwrctl(if1)->wowlan_mode);
 #endif /* CONFIG_WOWLAN */
 
 	rtw_dev_unload(if1);
 	DBG_871X("+r871xu_dev_remove, hw_init_completed =%d\n", if1->hw_init_completed);
 
-	if (if1->rtw_wdev) {
+	if (if1->rtw_wdev)
 		rtw_wdev_free(if1->rtw_wdev);
-	}
 
 	rtw_free_drv_sw(if1);
 
@@ -489,9 +482,8 @@ static int rtw_drv_init(
 
 	/* dev_alloc_name && register_netdev */
 	status = rtw_drv_register_netdev(if1);
-	if (status != _SUCCESS) {
+	if (status != _SUCCESS)
 		goto free_if2;
-	}
 
 	if (sdio_alloc_irq(dvobj) != _SUCCESS)
 		goto free_if2;
@@ -515,7 +507,7 @@ static int rtw_drv_init(
 	if (status != _SUCCESS)
 		sdio_dvobj_deinit(func);
 exit:
-	return status == _SUCCESS?0:-ENODEV;
+	return status == _SUCCESS ? 0 : -ENODEV;
 }
 
 static void rtw_dev_remove(struct sdio_func *func)
@@ -563,20 +555,18 @@ extern int pm_netdev_close(struct net_device *pnetdev, u8 bnormal);
 
 static int rtw_sdio_suspend(struct device *dev)
 {
-	struct sdio_func *func =dev_to_sdio_func(dev);
+	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct dvobj_priv *psdpriv = sdio_get_drvdata(func);
 	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
 	struct adapter *padapter = psdpriv->if1;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	if (padapter->bDriverStopped == true)
-	{
+	if (padapter->bDriverStopped == true) {
 		DBG_871X("%s bDriverStopped = %d\n", __func__, padapter->bDriverStopped);
 		return 0;
 	}
 
-	if (pwrpriv->bInSuspend == true)
-	{
+	if (pwrpriv->bInSuspend == true) {
 		DBG_871X("%s bInSuspend = %d\n", __func__, pwrpriv->bInSuspend);
 		pdbgpriv->dbg_suspend_error_cnt++;
 		return 0;
@@ -591,8 +581,7 @@ static int rtw_resume_process(struct adapter *padapter)
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	if (pwrpriv->bInSuspend == false)
-	{
+	if (pwrpriv->bInSuspend == false) {
 		pdbgpriv->dbg_resume_error_cnt++;
 		DBG_871X("%s bInSuspend = %d\n", __func__, pwrpriv->bInSuspend);
 		return -1;
@@ -603,7 +592,7 @@ static int rtw_resume_process(struct adapter *padapter)
 
 static int rtw_sdio_resume(struct device *dev)
 {
-	struct sdio_func *func =dev_to_sdio_func(dev);
+	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct dvobj_priv *psdpriv = sdio_get_drvdata(func);
 	struct adapter *padapter = psdpriv->if1;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -635,8 +624,7 @@ static int __init rtw_drv_entry(void)
 	rtw_drv_proc_init();
 
 	ret = sdio_register_driver(&sdio_drvpriv.r871xs_drv);
-	if (ret != 0)
-	{
+	if (ret != 0) {
 		sdio_drvpriv.drv_registered = false;
 		rtw_drv_proc_deinit();
 		rtw_ndev_notifier_unregister();
-- 
2.17.1

