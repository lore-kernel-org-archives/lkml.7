Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC2C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7920825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS/cbBKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfFGFwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:52:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:52:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so73066pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmFqEcJ3VNaj9ijKAKVAqwYyQZzMZfiX/GyQUpT57+o=;
        b=lS/cbBKY+juSQwYNlefp5BGY1yMcvRTiEXjA4pofzJW7Zxz27IfgSt0B/PIN5Sy1p3
         D1ckVjciYVf/Wba8neZ7il2ahHIIf5nr2GFohyeAc8CzCG9MDx1aYun2MUiMFP8iDPQO
         vAIzjxzRikdoQi+EYBozcHcuV7zFs4sVwsPGpBwuXmAgAPy6Q01N1a38cyS5kgGc60Ig
         8EHAsxhcb+L8aE0wlMe0tBm62NclFEGVQ2xq6RM6TTzAh3vof5QtQbXhs90YedVvhFV9
         txo9t1mm1sO48D/Zu7ZHwumydtlZIlK+XFLTrUILqW7vgbeV2jSZbtrEDPml4oxnA2Jl
         esjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmFqEcJ3VNaj9ijKAKVAqwYyQZzMZfiX/GyQUpT57+o=;
        b=p+qzMbidSIaHCN+nmuQ8glLkGBjbXxa5KXsk6jhnVtW5pWybg957KnBGnrgOGR8raF
         3MYssDgH+mzAYY4Xbna1Yt0uWItK2S4OF7JwaUr04yDr6glPL0NRySYfV+OKGGViZj42
         z5Db7GbEm0QYpRYjEt23odq5BvUcJROo7PoMem6gRLyyiTaDUV8cZoSabF9Wr2gc/9AQ
         yzTHANUwNJBAHe/3XREMgt5iadVRs5WPTttxTa6FZwUvy0lnl0Lz8Kvyv+SYaXp7qd9D
         XRi+DlTOMRsPe7xSh2VOm87Pn7yT9IiZj/ythCoCElPkzecQsOIEBMuoHUOZ6zDjtT6W
         LcWw==
X-Gm-Message-State: APjAAAW5tWxsc4AAMCol/uKpgB31R7DSEkVrbySjYFua50EuxP8yifRU
        B21Aw/0BStcHPx5vkBK7Dxw=
X-Google-Smtp-Source: APXvYqzjY1stl/jV0RrG2iweKYKkCUns9qBVSUq7wSNzWpKgi1Nna7KarneX2XoPyCND2AY2Opjyvg==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr1305990pgv.130.1559886754882;
        Thu, 06 Jun 2019 22:52:34 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id d9sm861740pgl.20.2019.06.06.22.52.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:52:34 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8712: usb_ops.c: Remove leading p from variable names
Date:   Fri,  7 Jun 2019 11:22:08 +0530
Message-Id: <20190607055209.20954-3-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607055209.20954-1-nishkadg.linux@gmail.com>
References: <20190607055209.20954-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading 'p' from the names of the following pointer variables:
- pintfhdl
- pintf_hdl (renamed to intfhdl in keeping with the convention in other
functions)
- poption
- pops
- pintfpriv.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/usb_ops.c | 84 +++++++++++++++----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops.c b/drivers/staging/rtl8712/usb_ops.c
index eef52d5c730a..e64845e6adf3 100644
--- a/drivers/staging/rtl8712/usb_ops.c
+++ b/drivers/staging/rtl8712/usb_ops.c
@@ -22,7 +22,7 @@
 #include "usb_ops.h"
 #include "recv_osdep.h"
 
-static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+static u8 usb_read8(struct intf_hdl *intfhdl, u32 addr)
 {
 	u8 request;
 	u8 requesttype;
@@ -30,19 +30,19 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x01; /* read_in */
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 	return (u8)(le32_to_cpu(data) & 0x0ff);
 }
 
-static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+static u16 usb_read16(struct intf_hdl *intfhdl, u32 addr)
 {
 	u8 request;
 	u8 requesttype;
@@ -50,19 +50,19 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x01; /* read_in */
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+static u32 usb_read32(struct intf_hdl *intfhdl, u32 addr)
 {
 	u8 request;
 	u8 requesttype;
@@ -70,19 +70,19 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x01; /* read_in */
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 	return le32_to_cpu(data);
 }
 
-static void usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
+static void usb_write8(struct intf_hdl *intfhdl, u32 addr, u8 val)
 {
 	u8 request;
 	u8 requesttype;
@@ -90,7 +90,7 @@ static void usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x00; /* write_out */
@@ -98,11 +98,11 @@ static void usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = cpu_to_le32((u32)val & 0x000000ff);
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 }
 
-static void usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
+static void usb_write16(struct intf_hdl *intfhdl, u32 addr, u16 val)
 {
 	u8 request;
 	u8 requesttype;
@@ -110,7 +110,7 @@ static void usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x00; /* write_out */
@@ -118,11 +118,11 @@ static void usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 	data = cpu_to_le32((u32)val & 0x0000ffff);
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 }
 
-static void usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
+static void usb_write32(struct intf_hdl *intfhdl, u32 addr, u32 val)
 {
 	u8 request;
 	u8 requesttype;
@@ -130,7 +130,7 @@ static void usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 	u16 index;
 	u16 len;
 	__le32 data;
-	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
+	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
 	requesttype = 0x00; /* write_out */
@@ -138,13 +138,13 @@ static void usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
-	r8712_usbctrl_vendorreq(pintfpriv, request, wvalue, index, &data, len,
-			  requesttype);
+	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
+				requesttype);
 }
 
-void r8712_usb_set_intf_option(u32 *poption)
+void r8712_usb_set_intf_option(u32 *option)
 {
-	*poption = ((*poption) | _INTF_ASYNC_);
+	*option = ((*option) | _INTF_ASYNC_);
 }
 
 static void usb_intf_hdl_init(u8 *priv)
@@ -163,24 +163,24 @@ static void usb_intf_hdl_close(u8 *priv)
 {
 }
 
-void r8712_usb_set_intf_funs(struct intf_hdl *pintf_hdl)
+void r8712_usb_set_intf_funs(struct intf_hdl *intfhdl)
 {
-	pintf_hdl->intf_hdl_init = usb_intf_hdl_init;
-	pintf_hdl->intf_hdl_unload = usb_intf_hdl_unload;
-	pintf_hdl->intf_hdl_open = usb_intf_hdl_open;
-	pintf_hdl->intf_hdl_close = usb_intf_hdl_close;
+	intfhdl->intf_hdl_init = usb_intf_hdl_init;
+	intfhdl->intf_hdl_unload = usb_intf_hdl_unload;
+	intfhdl->intf_hdl_open = usb_intf_hdl_open;
+	intfhdl->intf_hdl_close = usb_intf_hdl_close;
 }
 
-void r8712_usb_set_intf_ops(struct _io_ops	*pops)
+void r8712_usb_set_intf_ops(struct _io_ops *ops)
 {
-	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read8 = usb_read8;
-	pops->_read16 = usb_read16;
-	pops->_read32 = usb_read32;
-	pops->_read_port = r8712_usb_read_port;
-	pops->_write8 = usb_write8;
-	pops->_write16 = usb_write16;
-	pops->_write32 = usb_write32;
-	pops->_write_mem = r8712_usb_write_mem;
-	pops->_write_port = r8712_usb_write_port;
+	memset((u8 *)ops, 0, sizeof(struct _io_ops));
+	ops->_read8 = usb_read8;
+	ops->_read16 = usb_read16;
+	ops->_read32 = usb_read32;
+	ops->_read_port = r8712_usb_read_port;
+	ops->_write8 = usb_write8;
+	ops->_write16 = usb_write16;
+	ops->_write32 = usb_write32;
+	ops->_write_mem = r8712_usb_write_mem;
+	ops->_write_port = r8712_usb_write_port;
 }
-- 
2.19.1

