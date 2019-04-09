Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D609A21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhDrlG/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDIQQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:16:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36152 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:16:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so14058742oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vcl9DvRucY/MI+ulR1RLNLEmR8gfdNKs9weZOvAmOgw=;
        b=FhDrlG/NDcm7t5U12VPzXa7qdBxX27e4Gh0+2cbzeVwWUmAMmwG7sm9y9R1kjmFxgO
         H2I4roKAlcTHbA8lMU2YUd7Hj67UVPR+TsGEg+ZFWVrVT1+y6LezjCgQ+XWwtutsxNqB
         hRuMS11NlkMiH66rxEp/lu/u+sBrXTvsdjS5Sk4AIESjvkqiV0+5vUvoXCudSn5J/mvS
         8KhVUkteuMf16PJ11QLt8XX0ucZS8RhRVjovUDSs3EkKw2/ksnv2+Z4IQ/CSfqrg+/Eh
         V7ouIVPq4GmOzMlLO+grDROMSvsm5o627OfTvYPLMMMWpUDVtmldJ9z7oUbh8QvmlVbp
         66ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vcl9DvRucY/MI+ulR1RLNLEmR8gfdNKs9weZOvAmOgw=;
        b=Ld2FYs9uzkIzOff5v7KLkeLS6hFerAmW9iwOi0MG0DbZGDZYShIUC8DBprfrkuXfEs
         ivqSJbo9oe1NWjO2/Lif25wgWnEu9uYbhFLWrXYL47jdD/vp7JqEFlJsY9wXXtJc1EaD
         /v3GiiukJ4HV7thY/Iuc36j46IjBHhgtzBxq/9yqHE6w9e9Bydp4QlDkL3t6bDAiY52u
         laJxA4+jEShQT/ZLlDyGkWt/Fry18qaPODLZyEb/7wbGQKYwc3R+lUr1XIycZKxwGWvU
         QjTMKI2vnWIxxzTfE4Z1B1JWasU25FotxZaaka4hx9dq8AwXHRb1Ih/z+O3SzfsxOtoZ
         XDAg==
X-Gm-Message-State: APjAAAUamy0ey2Qpst+0GSZtmd3k4XNSeEX0MdisL6L0yQ9GuTZ4frE7
        ZLue9o4FBWabAf7bXtgVw+CFU73x45s=
X-Google-Smtp-Source: APXvYqyEPKkePali7MhM2QMlKozagW0VKkboWJngnjLuteGXrsQahh4xwYXGGuehQl1pDEmRCccueQ==
X-Received: by 2002:aca:abce:: with SMTP id u197mr12542860oie.151.1554826586056;
        Tue, 09 Apr 2019 09:16:26 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:c4bd:8b21:88ac:fb11])
        by smtp.gmail.com with ESMTPSA id 6sm13386665ota.79.2019.04.09.09.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:16:25 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Date:   Tue,  9 Apr 2019 11:16:17 -0500
Message-Id: <20190409161617.29871-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in struct sdio_data and make the respective changes in
associated files, as the struct that has elements that can reasonably
be directly accessed should never be a typedef.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  6 ++--
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 .../rtl8723bs/include/drv_types_sdio.h        |  4 +--
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 10 +++----
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 30 +++++++++----------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 92191e9789bb..97b82b9e2b43 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -425,7 +425,7 @@ static u32 sdio_read_port(
 )
 {
 	struct adapter *adapter;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	struct hal_com_data *hal;
 	u32 oldcnt;
 	s32 err;
@@ -473,7 +473,7 @@ static u32 sdio_write_port(
 )
 {
 	struct adapter *adapter;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	s32 err;
 	struct xmit_buf *xmitbuf = (struct xmit_buf *)mem;
 
@@ -1207,7 +1207,7 @@ u8 RecvOnePkt(struct adapter *adapter, u32 size)
 {
 	struct recv_buf *recvbuf;
 	struct dvobj_priv *sddev;
-	PSDIO_DATA psdio_data;
+	struct sdio_data *psdio_data;
 	struct sdio_func *func;
 
 	u8 res = false;
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index bafb2c30e7fb..b0623c936940 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -220,7 +220,7 @@ struct registry_priv
 #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
 
 #include <drv_types_sdio.h>
-#define INTF_DATA SDIO_DATA
+#define INTF_DATA struct sdio_data
 
 #define is_primary_adapter(adapter) (1)
 #define get_iface_type(adapter) (IFACE_PORT0)
diff --git a/drivers/staging/rtl8723bs/include/drv_types_sdio.h b/drivers/staging/rtl8723bs/include/drv_types_sdio.h
index 23bf30ece2df..09263ad27ce9 100644
--- a/drivers/staging/rtl8723bs/include/drv_types_sdio.h
+++ b/drivers/staging/rtl8723bs/include/drv_types_sdio.h
@@ -16,7 +16,7 @@
 	#include <linux/mmc/card.h>
 #endif
 
-typedef struct sdio_data
+struct sdio_data
 {
 	u8  func_number;
 
@@ -26,6 +26,6 @@ typedef struct sdio_data
 
 	struct sdio_func	 *func;
 	void *sys_sdio_irq_thd;
-} SDIO_DATA, *PSDIO_DATA;
+};
 
 #endif
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 6d02904de63f..052482554f74 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -74,7 +74,7 @@ static void sd_sync_int_hdl(struct sdio_func *func)
 
 static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 {
-	PSDIO_DATA psdio_data;
+	struct sdio_data *psdio_data;
 	struct sdio_func *func;
 	int err;
 
@@ -102,7 +102,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 
 static void sdio_free_irq(struct dvobj_priv *dvobj)
 {
-    PSDIO_DATA psdio_data;
+    struct sdio_data *psdio_data;
     struct sdio_func *func;
     int err;
 
@@ -176,7 +176,7 @@ static void gpio_hostwakeup_free_irq(struct adapter *padapter)
 
 static u32 sdio_init(struct dvobj_priv *dvobj)
 {
-	PSDIO_DATA psdio_data;
+	struct sdio_data *psdio_data;
 	struct sdio_func *func;
 	int err;
 
@@ -248,7 +248,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 {
 	int status = _FAIL;
 	struct dvobj_priv *dvobj = NULL;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	dvobj = devobj_init();
 	if (dvobj == NULL) {
@@ -327,7 +327,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	int status = _FAIL;
 	struct net_device *pnetdev;
 	struct adapter *padapter = NULL;
-	PSDIO_DATA psdio = &dvobj->intf_data;
+	struct sdio_data *psdio = &dvobj->intf_data;
 
 	padapter = vzalloc(sizeof(*padapter));
 	if (padapter == NULL) {
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 43a9d922e3aa..1787534487b4 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -12,7 +12,7 @@
 static bool rtw_sdio_claim_host_needed(struct sdio_func *func)
 {
 	struct dvobj_priv *dvobj = sdio_get_drvdata(func);
-	PSDIO_DATA sdio_data = &dvobj->intf_data;
+	struct sdio_data *sdio_data = &dvobj->intf_data;
 
 	if (sdio_data->sys_sdio_irq_thd && sdio_data->sys_sdio_irq_thd == current)
 		return false;
@@ -21,7 +21,7 @@ static bool rtw_sdio_claim_host_needed(struct sdio_func *func)
 
 inline void rtw_sdio_set_irq_thd(struct dvobj_priv *dvobj, void *thd_hdl)
 {
-	PSDIO_DATA sdio_data = &dvobj->intf_data;
+	struct sdio_data *sdio_data = &dvobj->intf_data;
 
 	sdio_data->sys_sdio_irq_thd = thd_hdl;
 }
@@ -30,7 +30,7 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	u8 v = 0;
 	struct sdio_func *func;
@@ -67,7 +67,7 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	int err = 0, i;
 	struct sdio_func *func;
@@ -102,7 +102,7 @@ s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	int err = 0;
 	struct sdio_func *func;
@@ -137,7 +137,7 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	int err = 0, i;
 	struct sdio_func *func;
@@ -172,7 +172,7 @@ s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	int err = 0;
 	struct sdio_func *func;
@@ -202,7 +202,7 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	u8 v = 0;
 	struct sdio_func *func;
@@ -234,7 +234,7 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	u32 v = 0;
 	struct sdio_func *func;
 	bool claim_needed;
@@ -299,7 +299,7 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 
@@ -328,7 +328,7 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 
@@ -404,7 +404,7 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	int err = -EPERM;
 	struct sdio_func *func;
@@ -461,7 +461,7 @@ s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	struct sdio_func *func;
 	bool claim_needed;
@@ -505,7 +505,7 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 
 	struct sdio_func *func;
 	u32 size;
@@ -565,7 +565,7 @@ s32 sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	PSDIO_DATA psdio;
+	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 	s32 err =  -EPERM;
-- 
2.17.1

