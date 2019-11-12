Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A47FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD8A214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUNUmyID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfKLQyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:54:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44596 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKLQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:54:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id o11so20435298qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRDDtR+g6T7cAS8dOvWZ7lRag0SQ32/105UUcuFUgRM=;
        b=cUNUmyID1o3qDKWEHs0cHvbYKAtTw8mUvrIS96y3gScQeRnNKqbRBmxMN5QIkISvMr
         2BkKyMv3ROjWyx7NwaGKhqMGclN2QmjQLw0SI8R4EHvvJrluQ5GhbaL6GFZ1DmMEasDW
         sszIqlk55au2BZ67KtfPO++ZjNjRMhlNXncTWtHcFRvcHfsb2MzyWmotrpVqhBsaM1QI
         z4oLaGGo1qiTbE1shBQ6YR1YsQhwJ0d1pMEuwtlJdfwE37IdY6pIo+EWrqG+wkqJmdRQ
         Uat+ctVZTn1o7xxUgR7DbMRWzw3NTyo1ydixeAA7dooDwuEul9TI4JDQkBYGk+pgvMaJ
         VxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uRDDtR+g6T7cAS8dOvWZ7lRag0SQ32/105UUcuFUgRM=;
        b=pInWYm6qizOXYuoMosLeWEBDiZLv3S45md35kJW1OON7GXmzfIBg0PETfB2R9KCIRA
         OTVAn8Km9+seQt0afJoj1Q2U+5fPGddyVdwN+V7yclBa1SU3riVu+uxFQFWQQe8liDhF
         WB+CBfkWS/HoARb+L6evFiFWYaet8Fjvnd5yB3kwJdt1F7GpQXl4P2Bh8r765xyqX86X
         LLyI+HzgcLFPisjTeg3VFZgy58fgA7hmfeSGu01eU4x/l3TL5IBXPIhQwhbpY515B3QR
         U/D0T01EiJmA6di3Ls6oJpRU4vMMuhytBh2VYNndByP8P6dDg3sleD+dvZFnf5aImeCb
         U2Iw==
X-Gm-Message-State: APjAAAV6h5IGJRZTVhLc3CLzhhRx0lY+7S/xW8GMGVnAd/SOTZcv5dIU
        MzKcpCLt4WwkUadSJ7Oi3bM=
X-Google-Smtp-Source: APXvYqzpF0K2QgWiKLVfp3joUweRj9OqdPCMsRNClBWdw9JOdMXCa+rKCXhn2Vx6+SgM57fUIKA61g==
X-Received: by 2002:ac8:4688:: with SMTP id g8mr32103887qto.361.1573577675467;
        Tue, 12 Nov 2019 08:54:35 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id l14sm9628968qkj.61.2019.11.12.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:54:34 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:54:32 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 5/9] staging: rtl8723bs: Add necessary braces
Message-ID: <9653d1c5ea7ebd7b4137edea4f5eef74ea65703b.1573577309.git.jarias.linux@gmail.com>
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

This patchset adds braces when they should be used on all arms of
the statement.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 31 +++++++++++++++--------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index fdb585ff5925..42bd5d8362fa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -370,8 +370,9 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 	/* 		Other fragments are protected by previous fragment. */
 	/* 		So we only need to check the length of first fragment. */
 	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
-		if (sz > padapter->registrypriv.rts_thresh)
+		if (sz > padapter->registrypriv.rts_thresh) {
 			pattrib->vcs_mode = RTS_CTS;
+		}
 		else {
 			if (pattrib->rtsen)
 				pattrib->vcs_mode = RTS_CTS;
@@ -679,8 +680,9 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, get_bssid(pmlmepriv), ETH_ALEN);
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_ap);
-	} else
+	} else {
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_unknown);
+	}
 
 	pattrib->pktlen = pktfile.pkt_len;
 
@@ -724,8 +726,9 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 		rtw_set_scan_deny(padapter, 3000);
 
 	/*  If EAPOL , ARP , OR DHCP packet, driver must be in active mode. */
-	if (pattrib->icmp_pkt == 1)
+	if (pattrib->icmp_pkt == 1) {
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1);
+	}
 	else if (pattrib->dhcp_pkt == 1) {
 		DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_active);
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
@@ -926,8 +929,9 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-	} else
+	} else {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
+	}
 
 	return _SUCCESS;
 }
@@ -1204,8 +1208,9 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 			ClearMFrag(mem_start);
 
 			break;
-		} else
+		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
+		}
 
 		addr = (SIZE_PTR)(pframe);
 
@@ -1446,8 +1451,9 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 	case AUTO_VCS:
 	default:
 		perp = rtw_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
-		if (!perp)
+		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
+		}
 		else {
 			protection = (*(perp + 2)) & BIT(1);
 			if (protection) {
@@ -1455,8 +1461,9 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 					pxmitpriv->vcs = RTS_CTS;
 				else
 					pxmitpriv->vcs = CTS_TO_SELF;
-			} else
+			} else {
 				pxmitpriv->vcs = NONE_VCS;
+			}
 		}
 
 		break;
@@ -1509,8 +1516,9 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
-	} else
+	} else {
 		DBG_871X("%s fail, no xmitbuf available !!!\n", __func__);
+	}
 
 	return pxmitbuf;
 }
@@ -2177,11 +2185,12 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
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

