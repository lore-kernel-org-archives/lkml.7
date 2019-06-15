Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69AC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A450D21773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8W3j3s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFOEgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:36:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35810 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfFOEgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:36:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so2587470pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9TzP9R77YBv27zLWGOzWcy2A4JLPhkA+M467EDOabGI=;
        b=d8W3j3s5VKyo3sUWiVy4n82d9ZvQVwr8FxmBMTXW972Z8PRLPFfykO4D7whmkbsV5R
         j1NqpBF/nDxwTpTxy2tXEC4jrgLCOgPO8DkA9AWmqdpnO+qfEfTa63lpDqvqrwOqp6TB
         aTspCZOzuDoMpOLBqr+Tn2MYgIT145PArEJz1h2Jo2/073CNxpt0qfyhIZdGo1uZDdNK
         aP0NgIqTn29dUFXsOxykdQ+DVLUGIJilkYBl48LtUiND/lHZrSN2p0yGVS/iGvt7vou2
         4aVCwgZ8+FqMpM5hqY4r27R+fdsYPdQ1dHu4XOMm+62lEPb4Jb/oHIWFW4CFvi6d08f0
         Hpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9TzP9R77YBv27zLWGOzWcy2A4JLPhkA+M467EDOabGI=;
        b=B015+ObR5Pg7EWgh237D/umX1SJz1U/bzKTgKCWiGCZE9lNobT6Z+A4vMsMIrE3qgX
         ByYPqZeHNT9MgtVkMJpYQd6kFt0MiFSESpvsllPd/EuueM3UthrpbAfgWUFYNzW9Eo0E
         D3eKfKiqWhaDSsvWSVmAC3cj0iwE+jqdnfbXYaTBnw5UfV+sjbWlpd19uC+KxrZUdaSw
         xFM+BU3DDSh0mIUoKmC3R5l23qwOnr7AkhWmBTATyVJmTvElteYmZFXbZPGcyGuVAK9E
         ULyw4/FRX4MiisGelYdkylvRnZZwJeH1omEru1zvtAbsZ+DCPEPexCTqoPS2/9l7yS0L
         WvEA==
X-Gm-Message-State: APjAAAX6zHHRr7fAoJy/DOSuVYonXgu6wozh1v62nk9e128ekVJLI8PS
        +OBEMKX+6Lh6M2jhYvUbFtZcZvqe
X-Google-Smtp-Source: APXvYqwaI9WOyiDgJl/8lBvZQQc6QYyeJSRl5BF6V1zYN2t7lGPJ1xUf/FQUmPNAbmCFFwKbOPXUew==
X-Received: by 2002:a62:d149:: with SMTP id t9mr82212002pfl.173.1560573402434;
        Fri, 14 Jun 2019 21:36:42 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id y22sm8452171pfo.39.2019.06.14.21.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 21:36:41 -0700 (PDT)
Date:   Sat, 15 Jun 2019 10:06:36 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: hal: Using comparison to true is
 error prone
Message-ID: <20190615043636.GA12605@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by checkpatch

CHECK: Using comparison to true is error prone
CHECK: Using comparison to false is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 9cf8da7..215335c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -17,8 +17,8 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 
 	while (pHalData->SdioTxOQTFreeSpace < agg_num) {
 		if (
-			(padapter->bSurpriseRemoved == true) ||
-			(padapter->bDriverStopped == true)
+			(padapter->bSurpriseRemoved) ||
+			(padapter->bDriverStopped)
 		) {
 			DBG_871X("%s: bSurpriseRemoved or bDriverStopped (wait TxOQT)\n", __func__);
 			return false;
@@ -58,7 +58,7 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 
 	ret = ret || check_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
 
-	if (ret == true)
+	if (ret)
 		pxmitbuf = dequeue_pending_xmitbuf_under_survey(pxmitpriv);
 	else
 		pxmitbuf = dequeue_pending_xmitbuf(pxmitpriv);
@@ -85,7 +85,7 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 
 query_free_page:
 	/*  check if hardware tx fifo page is enough */
-	if (false == rtw_hal_sdio_query_tx_freepage(pri_padapter, PageIdx, pxmitbuf->pg_num)) {
+	if (!rtw_hal_sdio_query_tx_freepage(pri_padapter, PageIdx, pxmitbuf->pg_num)) {
 		if (!bUpdatePageNum) {
 			/*  Total number of page is NOT available, so update current FIFO status */
 			HalQueryTxBufferStatus8723BSdio(padapter);
@@ -99,8 +99,8 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 	}
 
 	if (
-		(padapter->bSurpriseRemoved == true) ||
-		(padapter->bDriverStopped == true)
+		(padapter->bSurpriseRemoved) ||
+		(padapter->bDriverStopped)
 	) {
 		RT_TRACE(
 			_module_hal_xmit_c_,
@@ -153,7 +153,7 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 		return _FAIL;
 	}
 
-	ret = (padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true);
+	ret = (padapter->bDriverStopped) || (padapter->bSurpriseRemoved);
 	if (ret) {
 		RT_TRACE(
 			_module_hal_xmit_c_,
@@ -170,7 +170,7 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 
 	queue_pending = check_pending_xmitbuf(pxmitpriv);
 
-	if (queue_pending == false)
+	if (!queue_pending)
 		return _SUCCESS;
 
 	ret = rtw_register_tx_alive(padapter);
@@ -235,8 +235,8 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 		phwxmit = hwxmits + inx[idx];
 
 		if (
-			(check_pending_xmitbuf(pxmitpriv) == true) &&
-			(padapter->mlmepriv.LinkDetectInfo.bHigherBusyTxTraffic == true)
+			(check_pending_xmitbuf(pxmitpriv)) &&
+			(padapter->mlmepriv.LinkDetectInfo.bHigherBusyTxTraffic)
 		) {
 			if ((phwxmit->accnt > 0) && (phwxmit->accnt < 5)) {
 				err = -2;
@@ -425,8 +425,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 
 next:
 	if (
-		(padapter->bDriverStopped == true) ||
-		(padapter->bSurpriseRemoved == true)
+		(padapter->bDriverStopped) ||
+		(padapter->bSurpriseRemoved)
 	) {
 		RT_TRACE(
 			_module_hal_xmit_c_,
@@ -569,7 +569,7 @@ s32 rtl8723bs_hal_xmit(
 		(pxmitframe->attrib.ether_type != 0x888e) &&
 		(pxmitframe->attrib.dhcp_pkt != 1)
 	) {
-		if (padapter->mlmepriv.LinkDetectInfo.bBusyTraffic == true)
+		if (padapter->mlmepriv.LinkDetectInfo.bBusyTraffic)
 			rtw_issue_addbareq_cmd(padapter, pxmitframe);
 	}
 
-- 
2.7.4

