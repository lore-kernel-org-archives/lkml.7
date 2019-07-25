Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38693C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32F0229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHlOM0Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGYSbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:31:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38804 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:31:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so14632192pgu.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qPt6GSvNaRNxnnTu6bRMZgg7HoSbPOn74FTRNXInFbk=;
        b=EHlOM0QygTwzmZQvs33/voY6md2Kl/JmHanGKPu3dGDQcFuBknI63q591sKbcgB/kN
         haIXUpg22a8h+wmcHTm7QdT5jsPM3YAW/TsCCXITTyAHAwNieSUSmdcCYh2lJm+uBs3B
         FXiQ9BbpQYr0FykEF5Rz0Ey3tXfKRVY6hHjGEGxxkJw+Sa1aHY87qoVAMGMEgDbopUS5
         EnlM6FKEB4s1ipS30YgMF+CjlMkzD0L7nit1nsqvAbUmrOKCHfaD4aC26gVvPJRlA7iI
         KuGbouX5yZC+elOjkG87SlwQCpajKOBv//vIUD0BG72KXkyw04QJ5OW0TKZAJCqGTv8Q
         Tfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qPt6GSvNaRNxnnTu6bRMZgg7HoSbPOn74FTRNXInFbk=;
        b=IMmuljcSLdNfyAT112exHruwfvu+pxM1acngpWXEPZeZcuSBbxWvyn05Kc68KyL/aY
         xCS8Ar26rIUM60OhapO66V8oFWwQmGpeKUKJvmfFBva1CHMvuBzNBBmy9jLOr3G93xjI
         tt/Ctvuu2iMOzkV3ia+Xkwjl7whlkUeXfZMtwMPLf4/W5/bj/dy46lOV5qLqMyF3M8/O
         aOm9SboBooos5JIlkh8KC98+pDS28neFa6N3ytGMUGxBbzUVSvo+VXYHNS2pGuwBiRwQ
         dkZrSWxMJaRNTnnKzXaMs5G3KM1ZNO6WJw8cmXXoa8VNZHHxAX/0DZuC8/lXOmN/yM/H
         2fUQ==
X-Gm-Message-State: APjAAAViOmB/DwmtO0AON/ZuF+16lwSs9ZTgOacp3sMrUlhp9lF2+KwW
        habZVKQYrDEjLlGoJ8eFXxg=
X-Google-Smtp-Source: APXvYqxvm1fX7QjHkQM2xD11QPpwhO6OXzuaDSdDN5yGVIeR7nIoZK+NOr8aXEWhiMrP7Og03UtJ+Q==
X-Received: by 2002:a63:5f09:: with SMTP id t9mr54149080pgb.351.1564079514119;
        Thu, 25 Jul 2019 11:31:54 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id a5sm43583407pjv.21.2019.07.25.11.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 11:31:53 -0700 (PDT)
Date:   Fri, 26 Jul 2019 00:01:47 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: os_dep: Move common code to func
Message-ID: <20190725183147.GA15303@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inthis file all functions has below common functionality
1.Check flag padapter->bSurpriseRemoved
2.Get sdio_func structure from intf_hdl.

This patch introduces two new APIs
rtw_isadapter_removed,rtw_sdio_get_func which helps to do above common
functionality.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 149 ++++++----------------
 1 file changed, 41 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 50b8934..126429e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -26,26 +26,38 @@ inline void rtw_sdio_set_irq_thd(struct dvobj_priv *dvobj, void *thd_hdl)
 	sdio_data->sys_sdio_irq_thd = thd_hdl;
 }
 
-u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
+static s32 rtw_isadapter_removed(struct intf_hdl *pintfhdl)
 {
 	struct adapter *padapter;
+
+	padapter = pintfhdl->padapter;
+	return padapter->bSurpriseRemoved;
+}
+
+static struct sdio_func *rtw_sdio_get_func(struct intf_hdl *pintfhdl)
+{
 	struct dvobj_priv *psdiodev;
 	struct sdio_data *psdio;
 
+	psdiodev = pintfhdl->pintf_dev;
+	psdio = &psdiodev->intf_data;
+
+	return psdio->func;
+}
+
+u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
+{
 	u8 v = 0;
 	struct sdio_func *func;
 	bool claim_needed;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -65,23 +77,15 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
  */
 s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	int err = 0, i;
 	struct sdio_func *func;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 
 	for (i = 0; i < cnt; i++) {
 		pdata[i] = sdio_readb(func, addr+i, &err);
@@ -100,24 +104,16 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
  */
 s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	int err = 0;
 	struct sdio_func *func;
 	bool claim_needed;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -135,23 +131,15 @@ s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
  */
 s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	int err = 0, i;
 	struct sdio_func *func;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 
 	for (i = 0; i < cnt; i++) {
 		sdio_writeb(func, pdata[i], addr+i, &err);
@@ -170,24 +158,16 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
  */
 s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	int err = 0;
 	struct sdio_func *func;
 	bool claim_needed;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -200,24 +180,16 @@ s32 sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 
 u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	u8 v = 0;
 	struct sdio_func *func;
 	bool claim_needed;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -234,21 +206,19 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
 	u32 v = 0;
 	struct sdio_func *func;
 	bool claim_needed;
 
 	padapter = pintfhdl->padapter;
 	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return v;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -295,22 +265,15 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 
 void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -326,20 +289,18 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 {
 	struct adapter *padapter;
 	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 
 	padapter = pintfhdl->padapter;
 	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
 
 	if (padapter->bSurpriseRemoved) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -398,23 +359,15 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
  */
 s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	int err = -EPERM;
 	struct sdio_func *func;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 
 	if (unlikely((cnt == 1) || (cnt == 2))) {
 		int i;
@@ -453,23 +406,18 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
  */
 s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
 
 	struct sdio_func *func;
 	bool claim_needed;
 	s32 err = -EPERM;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
 
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
-	func = psdio->func;
+
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
@@ -497,24 +445,16 @@ s32 sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
  */
 s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
-
 	struct sdio_func *func;
 	u32 size;
 	s32 err =  -EPERM;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 /*	size = sdio_align_size(func, cnt); */
 
 	if (unlikely((cnt == 1) || (cnt == 2))) {
@@ -555,23 +495,16 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
  */
 s32 sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 {
-	struct adapter *padapter;
-	struct dvobj_priv *psdiodev;
-	struct sdio_data *psdio;
 	struct sdio_func *func;
 	bool claim_needed;
 	s32 err =  -EPERM;
 
-	padapter = pintfhdl->padapter;
-	psdiodev = pintfhdl->pintf_dev;
-	psdio = &psdiodev->intf_data;
-
-	if (padapter->bSurpriseRemoved) {
+	if (rtw_isadapter_removed(pintfhdl)) {
 		/* DBG_871X(" %s (padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n", __func__); */
 		return err;
 	}
 
-	func = psdio->func;
+	func = rtw_sdio_get_func(pintfhdl);
 	claim_needed = rtw_sdio_claim_host_needed(func);
 
 	if (claim_needed)
-- 
2.7.4

