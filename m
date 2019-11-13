Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E48C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16340222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUAYyn5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfKMOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:52:44 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41138 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKMOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:52:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id m125so1926582qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sn9pVHm74Rw5zcVcwKY9qhnttEm3LKTT86EDfnHaeSg=;
        b=XUAYyn5FNWyiJY668xT4WWtxlgdzjMRSgKWZ8x0updTL2qzbPm0Peaop0lP+bv6VeO
         B77hf7591CMB+Bl1oPOc0OJMT/n4/suiHqlMGRI3rRFfG7IOXMdTHUxAJjJy6gALV+22
         RjD+h6JehCszadPbbR4v/Zj5gvwBNqLXPHkNIjLYhivMCYMl/l1KqOl8iAg+A4nCfUOF
         PYBfjdHpcGxcNwKe/5/5z/ZSPgWOSVurmoCoGx5ewFoYWyoqlbhKfMm3BfpRXI1YLJQ8
         QEaJdcz0txTAuJXsb87p9goX5TC+wgX1O37BhDUdZZC0McmWUy4AulASNfFCK8qallTa
         Xw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sn9pVHm74Rw5zcVcwKY9qhnttEm3LKTT86EDfnHaeSg=;
        b=AYNO5Cz/urgwDJuvgE9FsprLKr4xlYptAE4II6fJ1+HuqsTVREN2XPbFqITsVp16mF
         ps5dBgODPPZ4QXpinxw8gL0R4LMXTatnN9PvvIZ0rui9YwJnhl0Ni56MwJuYVY/KeMoJ
         Cwb1Pu9XEp90s1c3ocDi7ib1O+xrwcwusVLwxnNHVesUf9qr4P5uHSqfg4fpN5+2u0Il
         hXeDWc83Hnr4nhIr1mxWVwmttTcusA1sDfTyctxReNE44viIqnP9CbNeH7cGZB9lpMrw
         BIQ29FNTz8s/4tmref5L2FtAUNRaAQnRbKjAb0cac5DPjDEc2mOYdT9Yt9YN2ft65UTg
         G1DQ==
X-Gm-Message-State: APjAAAWkojdcEVgeN/Cv9kmIy76zn1coLSG3S/Fk+HNV90cPEQ2Kq3Ac
        7TcBFf/ry0RASrzoC78ZFuNwc3HbqvGe6w==
X-Google-Smtp-Source: APXvYqy2GpS+D438d7eJFr76BIAz885Qr5V0A8K1nscKluUykoiF20QzNt4i2oU48YLTO+W62Uyb8A==
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr2694003qkz.499.1573656762309;
        Wed, 13 Nov 2019 06:52:42 -0800 (PST)
Received: from gmail.com ([184.75.212.4])
        by smtp.gmail.com with ESMTPSA id w18sm1083957qkb.41.2019.11.13.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:52:41 -0800 (PST)
Date:   Wed, 13 Nov 2019 09:52:39 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] staging: rtl8723bs: Add necessary braces
Message-ID: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds braces when they should be used on all arms of
the statement.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
Changes in V3:
	- No changes.
Changes in V2:
        - Add braces and balance statements in the same patch instead
          of performing a new change in a subsequent patch.
        - Fix a typo in the commit description.

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 34 +++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index fdb585ff5925..44fc604ea5b7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -370,9 +370,9 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 	/* 		Other fragments are protected by previous fragment. */
 	/* 		So we only need to check the length of first fragment. */
 	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
-		if (sz > padapter->registrypriv.rts_thresh)
+		if (sz > padapter->registrypriv.rts_thresh) {
 			pattrib->vcs_mode = RTS_CTS;
-		else {
+		} else {
 			if (pattrib->rtsen)
 				pattrib->vcs_mode = RTS_CTS;
 			else if (pattrib->cts2self)
@@ -679,8 +679,9 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, get_bssid(pmlmepriv), ETH_ALEN);
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_ap);
-	} else
+	} else {
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_unknown);
+	}
 
 	pattrib->pktlen = pktfile.pkt_len;
 
@@ -724,9 +725,9 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		rtw_set_scan_deny(padapter, 3000);
 
 	/*  If EAPOL , ARP , OR DHCP packet, driver must be in active mode. */
-	if (pattrib->icmp_pkt == 1)
+	if (pattrib->icmp_pkt == 1) {
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1);
-	else if (pattrib->dhcp_pkt == 1) {
+	} else if (pattrib->dhcp_pkt == 1) {
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_active);
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
 	}
@@ -926,8 +927,9 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-	} else
+	} else {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
+	}
 
 	return _SUCCESS;
 }
@@ -1204,8 +1206,9 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 			ClearMFrag(mem_start);
 
 			break;
-		} else
+		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
+		}
 
 		addr = (SIZE_PTR)(pframe);
 
@@ -1446,17 +1449,18 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 	case AUTO_VCS:
 	default:
 		perp = rtw_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
-		if (!perp)
+		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
-		else {
+		} else {
 			protection = (*(perp + 2)) & BIT(1);
 			if (protection) {
 				if (pregistrypriv->vcs_type == RTS_CTS)
 					pxmitpriv->vcs = RTS_CTS;
 				else
 					pxmitpriv->vcs = CTS_TO_SELF;
-			} else
+			} else {
 				pxmitpriv->vcs = NONE_VCS;
+			}
 		}
 
 		break;
@@ -1509,8 +1513,9 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
-	} else
+	} else {
 		DBG_871X("%s fail, no xmitbuf available !!!\n", __func__);
+	}
 
 	return pxmitbuf;
 }
@@ -2177,11 +2182,12 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 				, attrib->ether_type, attrib->dhcp_pkt?" DHCP":"");
 			allow = true;
 		}
-	} else if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_ALL)
+	} else if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_ALL) {
 		allow = true;
-	else if (registry->hiq_filter == RTW_HIQ_FILTER_DENY_ALL) {
-	} else
+	} else if (registry->hiq_filter == RTW_HIQ_FILTER_DENY_ALL) {
+	} else {
 		rtw_warn_on(1);
+	}
 
 	return allow;
 }
-- 
2.20.1

