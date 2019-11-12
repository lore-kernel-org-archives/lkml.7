Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9202C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52EC214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfANFb1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfKLQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:55:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34634 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfKLQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id i17so8935323qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KRQTTAE5NIfXPm438X/CfTEjySDioYPsKEKUpYcXxZM=;
        b=rfANFb1/afiONMc6tGNT810eTD97Na2vCiLpUCuJCENzRwhro0TGNKoM5ZuGO6rGBS
         E7/donO0x+mNRUYgYbX9T/DVAIrjihf1chuIsuIsOj5zaObdjOBHXtY3/3F4A8nUWc5f
         KzJNvReUvSp8+qrKyBr+CdmlL5YcElggAoFr28iLs8/hPqDS+HovpmQgMzjWLB8ccYUN
         ZbqaeAj/sm4uC8CMJcaUoNinxpnFHpnVZGWeU9Wy8I/GR7pMP/jtkKJJkhBGoikvikGm
         y6r38LmBmpABtWOmmNhfsXVMBEkrktgLulISgSA1oqrjME6hHBdYt50mZK/fluDeSCix
         2qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KRQTTAE5NIfXPm438X/CfTEjySDioYPsKEKUpYcXxZM=;
        b=d5PgIQu93TzRTf7FWj5fTsYce1yV92UnPuzV8XTvVfaNjQjJOfrR3MptTx6idc3y23
         JbzDFrHSN+bADSR1M4+dEMRKe2tSMP7/m+0ET41X5yO7pRU7PzK3YrsAFEpekmfsqIop
         KuxGEfZS+z1EmcQgXDjpBSrr+iziRXeEmZVePiE351CdBSMLX4s7Yd6LPKCm4dSMeM9J
         ycRcniRuJVXLwe3/hqk4qsQaTU8gIN2ajked1UBAd5C9qzp07mOyX3Y65plzt5ete8bY
         GFRnbfFetNBPYWqM3xnwjhutKApIa2KUuH6f7YZzEmC84WUjA049ZPX5bP/CeL1LizCE
         rgmg==
X-Gm-Message-State: APjAAAVgugHE+ZFHGGNG41dCxSb1xFf85ydJuqFyQnJO6S97GWuAuS4R
        KHdg1cPh+fJZW+U9TcbWB8I=
X-Google-Smtp-Source: APXvYqwsJuw+ah6YDbZwi5p06oiq5/ceMusCowYtPBELi1FvvM9rrolusO8RZKiQgdQIdDrwBTdsCA==
X-Received: by 2002:ac8:28a1:: with SMTP id i30mr33559371qti.245.1573577611445;
        Tue, 12 Nov 2019 08:53:31 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id i68sm9545923qkb.106.2019.11.12.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:53:31 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:53:28 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 2/9] staging: rtl8723bs: Remove blank lines before a close
 brace
Message-ID: <369fa1068078d98d658fe5e8fc335df1b22f5238.1573577309.git.jarias.linux@gmail.com>
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

This patch removes blank lines before a close brase.
Issue found by checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 35 -----------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index e10e2d74cffd..7f88f433345d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -144,7 +144,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		#endif
 
 		pxmitbuf++;
-
 	}
 
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
@@ -222,7 +221,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->no = i;
 		#endif
 		pxmitbuf++;
-
 	}
 
 	pxmitpriv->free_xmit_extbuf_cnt = NR_XMIT_EXTBUFF;
@@ -479,7 +477,6 @@ static void update_attrib_phy_info(struct adapter *padapter, struct pkt_attrib *
 	if (psta->isrc && psta->pid > 0)
 		pattrib->pctrl = true;
 #endif
-
 }
 
 static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *pattrib, struct sta_info *psta)
@@ -529,7 +526,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		/* For WPS 1.0 WEP, driver should not encrypt EAPOL Packet for WPS handshake. */
 		if (((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) && (pattrib->ether_type == 0x888e))
 			pattrib->encrypt = _NO_PRIVACY_;
-
 	}
 
 	switch (pattrib->encrypt) {
@@ -600,7 +596,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 exit:
 
 	return res;
-
 }
 
 u8 qos_acm(u8 acm_mask, u8 priority)
@@ -723,7 +718,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 				DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib_icmp);
 			}
 		}
-
 	} else if (0x888e == pattrib->ether_type) {
 		DBG_871X_LEVEL(_drv_always_, "send eapol packet\n");
 	}
@@ -809,7 +803,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 
 			if (pmlmepriv->acm_mask != 0)
 				pattrib->priority = qos_acm(pmlmepriv->acm_mask, pattrib->priority);
-
 		}
 	}
 
@@ -866,7 +859,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					rtw_secmicappend(&micdata, &pframe[16], 6);
 				else
 					rtw_secmicappend(&micdata, &pframe[10], 6);
-
 			}
 
 			if (pattrib->qos_en)
@@ -939,7 +931,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-
 	} else
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
 
@@ -976,7 +967,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 			if (pqospriv->qos_option)
 				qos_option = true;
-
 		} else if (check_fwstate(pmlmepriv,  WIFI_AP_STATE) == true) {
 			/* to_ds = 0, fr_ds = 1; */
 			SetFrDs(fctrl);
@@ -1067,13 +1057,10 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 						psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
 						pattrib->ampdu_en = true;/* AGG EN */
 					}
-
 				}
 			}
 		}
-
 	} else {
-
 	}
 
 exit:
@@ -1230,7 +1217,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit_fram
 
 		mem_start = (unsigned char *)RND4(addr) + hw_hdr_offset;
 		memcpy(mem_start, pbuf_start + hw_hdr_offset, pattrib->hdrlen);
-
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
@@ -1482,7 +1468,6 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 		}
 
 		break;
-
 	}
 }
 
@@ -1566,7 +1551,6 @@ struct xmit_frame *__rtw_alloc_cmdxmitframe(struct xmit_priv *pxmitpriv,
 	pxmitbuf->priv_data = pcmdframe;
 
 	return pcmdframe;
-
 }
 
 struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
@@ -1607,7 +1591,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
-
 	}
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
@@ -1867,7 +1850,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	else if (pxmitframe->ext_tag == 1)
 		queue = &pxmitpriv->free_xframe_ext_queue;
 	else {
-
 	}
 
 	spin_lock_bh(&queue->lock);
@@ -1911,7 +1893,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 		plist = get_next(plist);
 
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
-
 	}
 	spin_unlock_bh(&pframequeue->lock);
 }
@@ -1961,7 +1942,6 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 		*(ac) = 2;
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
 	break;
-
 	}
 
 	return ptxservq;
@@ -2044,7 +2024,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 
 		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
-
 	} else if (pxmitpriv->hwxmit_entry == 4) {
 
 		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
@@ -2055,7 +2034,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
-
 	}
 
 	return _SUCCESS;
@@ -2109,11 +2087,9 @@ u32 rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe)
 	default:
 		addr = MGT_QUEUE_INX;
 		break;
-
 	}
 
 	return addr;
-
 }
 
 static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib)
@@ -2294,13 +2270,11 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 			ret = true;
 
 			DBG_COUNTER(padapter->tx_logs.core_tx_ap_enqueue_mcast);
-
 		}
 
 		spin_unlock_bh(&psta->sleep_q.lock);
 
 		return ret;
-
 	}
 
 	spin_lock_bh(&psta->sleep_q.lock);
@@ -2353,13 +2327,11 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 
 			DBG_COUNTER(padapter->tx_logs.core_tx_ap_enqueue_ucast);
 		}
-
 	}
 
 	spin_unlock_bh(&psta->sleep_q.lock);
 
 	return ret;
-
 }
 
 static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struct sta_info *psta, struct __queue *pframequeue)
@@ -2393,9 +2365,7 @@ static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struc
 			phwxmits[ac_index].accnt--;
 		} else {
 		}
-
 	}
-
 }
 
 void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta)
@@ -2499,7 +2469,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 		pxmitframe->attrib.triggered = 1;
 
 		rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
-
 	}
 
 	if (psta->sleepq_len == 0) {
@@ -2544,7 +2513,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 			pxmitframe->attrib.triggered = 1;
 			rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
-
 		}
 
 		if (psta_bmc->sleepq_len == 0) {
@@ -2554,7 +2522,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 			pstapriv->tim_bitmap &= ~BIT(0);
 			pstapriv->sta_dz_bitmap &= ~BIT(0);
 		}
-
 	}
 
 _exit:
@@ -2563,7 +2530,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	if (update_mask)
 		update_beacon(padapter, _TIM_IE_, NULL, true);
-
 }
 
 void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta)
@@ -2628,7 +2594,6 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 
 			update_beacon(padapter, _TIM_IE_, NULL, true);
 		}
-
 	}
 
 	spin_unlock_bh(&pxmitpriv->lock);
-- 
2.20.1

