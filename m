Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC3C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4320825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCAa2tBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFGFw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:52:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41543 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:52:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so385663plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FoiuBjLg1UBbIKZrQJR0cHIwrk4ez4qkdIgo7/m+JI=;
        b=lCAa2tBOhvpvbHKQYVJJK9xdcKBZQ8w0bMYmxLKz9SmQQOYD/UVsVinvz+wuS5OwWy
         0Z/ARsfeteZO1VqgPrbTGBV7MP6cu/SnZkB9WXxlWba5dmXb+npC2d5dwKUlOqF6uY6c
         sWl19LxFkxSWnTpDfAL+ScicQNYwxjuL9jgxEAbKin06N/xYXYxq3+g9DBEvGhGkqCdO
         PaQl+ECh152rUPE9ouoh0G6KeHdKliIWH6oBUuwRLLap4A+Rw+TpN2OlEnj4M7usM67s
         euONSZS/7durJ+8nBsj4fVzC6IxqwSlOJtFY2/PFmpwlJsPp37CEefIGWlqRRSiFbZ6N
         Pdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FoiuBjLg1UBbIKZrQJR0cHIwrk4ez4qkdIgo7/m+JI=;
        b=lJcivGKazN+/fetVaze/+1vIuw1RQbytG10NUIbyfSO1BJo3AKzVKCJOt8698tGGhb
         27sny4VyW/GA3hodAwEA3IJvj6+fbPKgUl3g1ICt1e33xt8sh1jMmdxa91ymEa1ilJD3
         ESPgEqw6wBnujRyiGTv0zKnjwzeZcGMVBHEA5crUwbjMexShF8Hqc+KWhiNUOI4htcBP
         CttfN6k8aQLthP4Uexln960pXuRuX+pzLnSif1aSADMHGXL4C8A1dLk6ZCUmx+eMqIFj
         m2Q7RTRtbQIYgqVgvZDamIAhwtkQs7nd4Ev+5SEcja5v2INfknedsYflbN1o5qwH8RUy
         6FMQ==
X-Gm-Message-State: APjAAAW/9T/39K0K0qthX+vBPEKqe5Ap9yZSNMVeidog2K1BCmfxOSV+
        RHUG5kWjv0VRnNaUJV2n1xs=
X-Google-Smtp-Source: APXvYqynylZyHUR6Qr9SPx3GANNBO4MfRAuEkVYeOLLJhjRzqva3Ms99Qt92YE9aw3mRVmTfj6oqLw==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr27545267plt.318.1559886745565;
        Thu, 06 Jun 2019 22:52:25 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id d9sm861740pgl.20.2019.06.06.22.52.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:52:24 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8712: xmit_linux.c: Remove leading p from variable names
Date:   Fri,  7 Jun 2019 11:22:06 +0530
Message-Id: <20190607055209.20954-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading p from the names of the following pointer variables:
- padapter
- pxmitpriv
- pnetdev
- pxmitframe.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/xmit_linux.c | 50 ++++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 8bcb0775411f..223a4eba4bf4 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -93,22 +93,22 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 
 void r8712_SetFilter(struct work_struct *work)
 {
-	struct _adapter *padapter = container_of(work, struct _adapter,
+	struct _adapter *adapter = container_of(work, struct _adapter,
 						wkFilterRxFF0);
 	u8  oldvalue = 0x00, newvalue = 0x00;
 	unsigned long irqL;
 
-	oldvalue = r8712_read8(padapter, 0x117);
+	oldvalue = r8712_read8(adapter, 0x117);
 	newvalue = oldvalue & 0xfe;
-	r8712_write8(padapter, 0x117, newvalue);
+	r8712_write8(adapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
-	padapter->blnEnableRxFF0Filter = 1;
-	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
+	spin_lock_irqsave(&adapter->lockRxFF0Filter, irqL);
+	adapter->blnEnableRxFF0Filter = 1;
+	spin_unlock_irqrestore(&adapter->lockRxFF0Filter, irqL);
 	do {
 		msleep(100);
-	} while (padapter->blnEnableRxFF0Filter == 1);
-	r8712_write8(padapter, 0x117, oldvalue);
+	} while (adapter->blnEnableRxFF0Filter == 1);
+	r8712_write8(adapter, 0x117, oldvalue);
 }
 
 int r8712_xmit_resource_alloc(struct _adapter *padapter,
@@ -147,36 +147,36 @@ void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *pxframe)
 	pxframe->pkt = NULL;
 }
 
-int r8712_xmit_entry(_pkt *pkt, struct  net_device *pnetdev)
+int r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
 {
-	struct xmit_frame *pxmitframe = NULL;
-	struct _adapter *padapter = netdev_priv(pnetdev);
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_frame *xmitframe = NULL;
+	struct _adapter *adapter = netdev_priv(netdev);
+	struct xmit_priv *xmitpriv = &(adapter->xmitpriv);
 
-	if (!r8712_if_up(padapter))
+	if (!r8712_if_up(adapter))
 		goto _xmit_entry_drop;
 
-	pxmitframe = r8712_alloc_xmitframe(pxmitpriv);
-	if (!pxmitframe)
+	xmitframe = r8712_alloc_xmitframe(xmitpriv);
+	if (!xmitframe)
 		goto _xmit_entry_drop;
 
-	if ((!r8712_update_attrib(padapter, pkt, &pxmitframe->attrib)))
+	if ((!r8712_update_attrib(adapter, pkt, &xmitframe->attrib)))
 		goto _xmit_entry_drop;
 
-	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_TX);
-	pxmitframe->pkt = pkt;
-	if (r8712_pre_xmit(padapter, pxmitframe)) {
+	adapter->ledpriv.LedControlHandler(adapter, LED_CTL_TX);
+	xmitframe->pkt = pkt;
+	if (r8712_pre_xmit(adapter, xmitframe)) {
 		/*dump xmitframe directly or drop xframe*/
 		dev_kfree_skb_any(pkt);
-		pxmitframe->pkt = NULL;
+		xmitframe->pkt = NULL;
 	}
-	pxmitpriv->tx_pkts++;
-	pxmitpriv->tx_bytes += pxmitframe->attrib.last_txcmdsz;
+	xmitpriv->tx_pkts++;
+	xmitpriv->tx_bytes += xmitframe->attrib.last_txcmdsz;
 	return 0;
 _xmit_entry_drop:
-	if (pxmitframe)
-		r8712_free_xmitframe(pxmitpriv, pxmitframe);
-	pxmitpriv->tx_drop++;
+	if (xmitframe)
+		r8712_free_xmitframe(xmitpriv, xmitframe);
+	xmitpriv->tx_drop++;
 	dev_kfree_skb_any(pkt);
 	return 0;
 }
-- 
2.19.1

