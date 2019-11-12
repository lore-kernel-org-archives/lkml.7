Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB303C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C6B21E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/sD5dIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfKLQyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:54:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46078 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfKLQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so15026551qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbcz9bkPVGGwPZGZcVShlfo+81m3kSOz/HD5MUWR9yk=;
        b=T/sD5dIeNMR1JZLa8dNZ/TbDgDfJgkcU89q+NISDU34LuQCbu4F7sn6bFAmcM+xdZL
         eIW66PLWV0JTBiUW6ejZU6rDhAoNCIYRFfRMMgX9TY2ZoPi7sZsiwYz7T8SJlvFckHDe
         fNTx33Fp8ODyAGdud70n6lsN821r1qEu3B3tryKerYNFClFAj5+mTm4FHPlhTp9WTQCZ
         I4ngg8sOYwSyg3AALHml34Ftti5qw2hzjGVEF67iF5zRR9I5qh2AuESSq2YEJIYTOjlM
         i1uIKrAg1+yEOWkPPoHqU9wP06Tu8vr0A0MTWwq60504csHWk6vBMq8sqV1k7GNegMNE
         II6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lbcz9bkPVGGwPZGZcVShlfo+81m3kSOz/HD5MUWR9yk=;
        b=kqcAT9Sobdb3ZIGPt6OQ1pTLKSFWaEWwEopx6hsB0UWTFOR+gOrt1zu8ymethZ2oi2
         lSXfb8F3VvlwFu7iShXsmWDbyaX3UfjlK/SwjFKtt2tUw432qQGslwYBOnvTZytF1b1/
         VxnbsX5ftrXXGoLkFhAobS9fRUbKqynhNqgzvsWSQYsZBqI5l3sKHyGyfIxt11z00Jz3
         BMFpzoRHvBpCTbkxx1rSq8Ceu9BqkvhFjKzBiB+FwF6MhuEao3TsifH1ClBYsJd5kH8W
         wV5hv0O/N/Pdjdd6ApmNd+Yl0UU4c94tx2LgBs+hTLAjFggTWyMat8z3zsEcKvAtIuKK
         WKCQ==
X-Gm-Message-State: APjAAAXy6yAyggbZ4EOF2L5r+BGnI+k+UPHNrPZOneSUCP0xsNlto5du
        rzBRXc5kxzgOJkDHmduVMNo=
X-Google-Smtp-Source: APXvYqxbTTGYydL9lwCVEVgSKe8AjmInpJRQjl+Bpx239OOvxNIxoBu6F2bcF0MX6rzreH/lEmuSow==
X-Received: by 2002:a05:620a:242:: with SMTP id q2mr6404419qkn.87.1573577635694;
        Tue, 12 Nov 2019 08:53:55 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id w5sm5196039qkf.43.2019.11.12.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:53:55 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:53:53 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 3/9] staging: rtl8723bs: Remove blank lines after an open
 brace
Message-ID: <847ce59f8429afaac1299794987779d0db54d0be.1573577309.git.jarias.linux@gmail.com>
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

This patch removes blank lines after an open brace.
Issue found by checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 7f88f433345d..60e639690fc3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -912,7 +912,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
@@ -1328,7 +1327,6 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 				psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
 			if (!psta) {
-
 				DBG_871X("%s, psta ==NUL\n", __func__);
 				goto xmitframe_coalesce_fail;
 			}
@@ -1436,7 +1434,6 @@ s32 rtw_put_snap(u8 *data, u16 h_proto)
 
 void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 {
-
 	uint	protection;
 	u8 *perp;
 	sint	 erp_len;
@@ -1565,7 +1562,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 	if (list_empty(&pfree_queue->queue)) {
 		pxmitbuf = NULL;
 	} else {
-
 		phead = get_list_head(pfree_queue);
 
 		plist = get_next(phead);
@@ -1633,7 +1629,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	if (list_empty(&pfree_xmitbuf_queue->queue)) {
 		pxmitbuf = NULL;
 	} else {
-
 		phead = get_list_head(pfree_xmitbuf_queue);
 
 		plist = get_next(phead);
@@ -1887,7 +1882,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 	plist = get_next(phead);
 
 	while (phead != plist) {
-
 		pxmitframe = LIST_CONTAINOR(plist, struct xmit_frame, list);
 
 		plist = get_next(plist);
@@ -2025,7 +2019,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
 	} else if (pxmitpriv->hwxmit_entry == 4) {
-
 		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
 
 		hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
@@ -2181,7 +2174,6 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 	struct registry_priv *registry = &adapter->registrypriv;
 
 	if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_SPECIAL) {
-
 		struct pkt_attrib *attrib = &xmitframe->attrib;
 
 		if (attrib->ether_type == 0x0806
-- 
2.20.1

