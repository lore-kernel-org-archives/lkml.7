Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EEBC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7483221E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5E5kI4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfKLQyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:54:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35135 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfKLQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:54:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id i19so15086367qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wG5UQ9vx6z43wtxl5hxyDe54J635a/DBHWdcC32k+Zo=;
        b=X5E5kI4KhOJ73HWhDn4VfheiAw2kMsi4ydAcR/oRqNFcDFMIFh5QmTXUVPv09/R15D
         FtldyKmzmIrpv0LF0Qgpf5qxpHxMcO0BVGiaV6AyGciyO3EJ76jUrnxT5CMFh9h4jOz/
         RE2WcPPk7W2oDOv2HzedD8GM69syqOTA0vOK3oRlkiNDAbJBKkFRzZ4MrQgJ4FhqJide
         pari72IlUzIpfrhzQuMXYlQrn8T4/R2vkw2F2JmqsDKauNfVaHAhGPhSdG3AX5gAvP6N
         iYyitpuwYiwD4TOVuO82tFF7ScVA8kYtRzWCfjII/gbpDyadseO7G6dGYCgr9ptECXzd
         pFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=wG5UQ9vx6z43wtxl5hxyDe54J635a/DBHWdcC32k+Zo=;
        b=iKY3uPMgwQTAZ2NH8yeiIplOjiKIAOIE+yMJzEwJ1XjWo5Q6I+bW38c1efgwDY0S1R
         R8p6e/01aos2Rx1B2oPly9itwAvkc0jfd9TA1WYbO9rPHL6Mj8ZYMFgwzzhRZ1v3aDLB
         HSiAWBGoIxhGSWYOirEydNhhzdp07S85PQQs08diEfGzkrSg1IsiBcRfJpKJxjzXzQib
         mKBhoxj7v1ae0D+AUT1JTUsLIxBpPg9eBZ2nwsNO4M8rLXjZypbuGXcwvMOgp8A56DDJ
         4b25QzM/x2QgqLS3u1XoyDcFKtgvVizJWM/Ua3W+EBADStvUmIBhg0xJzgs/VhPEzGpj
         DmRQ==
X-Gm-Message-State: APjAAAU/QzClFUCDfS1nWHQJlDC26hTkPeDl3KLMpDYdPaeX6heegld5
        B5vT8qUM9Jtluhpo1GabqqE=
X-Google-Smtp-Source: APXvYqwa96tQKYAwG1lDCLfXMXgO8m6xB/Wpg91A68gn5/0qLIBlX+sgvovm7aXzWqTXKyC1bYjTIQ==
X-Received: by 2002:a37:a387:: with SMTP id m129mr16272830qke.70.1573577654621;
        Tue, 12 Nov 2019 08:54:14 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id q34sm8145541qte.50.2019.11.12.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:54:14 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:54:11 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 4/9] staging: rtl8723bs: Remove unnecessary braces
Message-ID: <041503946a1c58111e69579838b184359745d8c1.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573577309.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary braces on single statement blocks or
that aren't necessary in any arm of the statement.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 33 +++++++++--------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 60e639690fc3..fdb585ff5925 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -253,9 +253,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		goto exit;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = i;
-	}
 
 	pxmitpriv->ack_tx = false;
 	mutex_init(&pxmitpriv->ack_tx_mutex);
@@ -316,9 +315,8 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 		pxmitbuf++;
 	}
 
-	if (pxmitpriv->pallocated_xmit_extbuf) {
+	if (pxmitpriv->pallocated_xmit_extbuf)
 		vfree(pxmitpriv->pallocated_xmit_extbuf);
-	}
 
 	for (i = 0; i < CMDBUF_MAX; i++) {
 		pxmitbuf = &pxmitpriv->pcmd_xmitbuf[i];
@@ -834,15 +832,13 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
 			if (bmcst) {
-				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16)) {
+				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16))
 					return _FAIL;
-				}
 				/* start to calculate the mic code */
 				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
 			} else {
-				if (!memcmp(&pattrib->dot11tkiptxmickey.skey[0], null_key, 16)) {
+				if (!memcmp(&pattrib->dot11tkiptxmickey.skey[0], null_key, 16))
 					return _FAIL;
-				}
 				/* start to calculate the mic code */
 				rtw_secmicsetkey(&micdata, &pattrib->dot11tkiptxmickey.skey[0]);
 			}
@@ -1180,9 +1176,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 			mpdu_len -= llc_sz;
 		}
 
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
+		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
 			mpdu_len -= pattrib->icv_len;
-		}
 
 		if (bmcst) {
 			/*  don't do fragment to broadcat/multicast packets */
@@ -1979,9 +1974,8 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	ptxservq = rtw_get_sta_pending(padapter, psta, pattrib->priority, (u8 *)(&ac_index));
 
-	if (list_empty(&ptxservq->tx_pending)) {
+	if (list_empty(&ptxservq->tx_pending))
 		list_add_tail(&ptxservq->tx_pending, get_list_head(phwxmits[ac_index].sta_queue));
-	}
 
 	list_add_tail(&pxmitframe->list, get_list_head(&ptxservq->sta_pending));
 	ptxservq->qcnt++;
@@ -2043,9 +2037,8 @@ void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
 {
 	sint i;
 
-	for (i = 0; i < entry; i++, phwxmit++) {
+	for (i = 0; i < entry; i++, phwxmit++)
 		phwxmit->accnt = 0;
-	}
 }
 
 u32 rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe)
@@ -2253,11 +2246,10 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 			pstapriv->tim_bitmap |= BIT(0);
 			pstapriv->sta_dz_bitmap |= BIT(0);
 
-			if (update_tim) {
+			if (update_tim)
 				update_beacon(padapter, _TIM_IE_, NULL, true);
-			} else {
+			else
 				chk_bmc_sleepq_cmd(padapter);
-			}
 
 			ret = true;
 
@@ -2464,9 +2456,8 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	}
 
 	if (psta->sleepq_len == 0) {
-		if (pstapriv->tim_bitmap & BIT(psta->aid)) {
+		if (pstapriv->tim_bitmap & BIT(psta->aid))
 			update_mask = BIT(0);
-		}
 
 		pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
@@ -2508,9 +2499,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 		}
 
 		if (psta_bmc->sleepq_len == 0) {
-			if (pstapriv->tim_bitmap & BIT(0)) {
+			if (pstapriv->tim_bitmap & BIT(0))
 				update_mask |= BIT(1);
-			}
+
 			pstapriv->tim_bitmap &= ~BIT(0);
 			pstapriv->sta_dz_bitmap &= ~BIT(0);
 		}
-- 
2.20.1

