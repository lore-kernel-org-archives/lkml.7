Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90252222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmNVICLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKMBeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:34:19 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46201 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKMBeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:34:18 -0500
Received: by mail-yw1-f67.google.com with SMTP id i2so152453ywg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KTbx8THkN+GwoXxFCq1t6L26ozFMFKbJa/YT/1/F7yY=;
        b=gmNVICLEMuYX611vc3KTbImRxZcEfC/nHYQJx4TOXIbBQ+YwgWGcRmiXQCtVK23Yjj
         1UjFYqP6+zDrMaV9x4zlQT/uIVLKsZb7ddBr2rBrBRERkZp3iJjhnme+cuLvyvW+SLIW
         NLg1OX4XVSeNAcRJ5zq4K0BSUC2bNNP3gfIELubp0FjjJRBJT3i7jO4BEadFlDmyuNyj
         STu5ppZUnEtyT35KDvxeSu/FzzqocY/rD02mZ6GxossZvtmBj3xvUjl7p36Uk0D5bIeW
         YIyiA8RYAOkYSmTYoBCYJwWYn2GQN60dh5jvC1iDJjiwMYrJV3wtN1FnaC18r6aBzyxJ
         XJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KTbx8THkN+GwoXxFCq1t6L26ozFMFKbJa/YT/1/F7yY=;
        b=Ylq1MgPEA0QRG02PDvZvUd0jW54RP3Yb60wBWrxgqO1RnCINT037IQEonO3mwPkCLW
         joPSVogjuOQSR6lBWsZq/y2ealWQH29FYMBBcTPsUu+SfrxenPgsfm0VD35AnBmHHGcU
         LwJlxrXh9AAq6D5mAK7W/eLlzLIcfaDoU4d0r3b84+ghGxT81m6TkO56Hr4uM4Aw86r5
         Es6lNCyLIQQ083rzaIVSOyeRpkpAXJZO0hABFZMluo5i3I9AGBYqGbNMVQMFhVxPFAEv
         lR07t58f6gvqXgmPboXhCpEfmaLgpNFys3fQliQrAtbtuAkhEDFsvozJDnZhHaUdK9q8
         2QiA==
X-Gm-Message-State: APjAAAXeHS06gJak9FlK5jo5HWdvwJ1a7gMEJaod1JOc0IabJDFNaLXL
        RMyjzaNwXPmQ5+bhMj/qTQ65h2Dp+njlCw==
X-Google-Smtp-Source: APXvYqyC8TVBZCt3ToqFyKQngSS9ds3WfKoTCwaugX2vrv28ST03sXlrJUSqsu/zzePdYcLvXJymog==
X-Received: by 2002:a81:2c6:: with SMTP id 189mr654056ywc.43.1573608857371;
        Tue, 12 Nov 2019 17:34:17 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id d203sm510956ywh.48.2019.11.12.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:34:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 20:34:13 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] staging: rtl8723bs: Add necessary braces
Message-ID: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds braces when they should be used on all arms of
the statement.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
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

