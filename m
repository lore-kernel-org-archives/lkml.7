Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CCDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1035B206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641537;
	bh=XLHbc+6B7ZaNxnPntoPPYwdcBSRIrTnnS8jk5HI9v34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5vRU35CbvKD4cEYj6zbLKQ8L893Ll+Zy+8Mn9CwDVDPtWgNEpxEGnVMTzNF81FCw
	 hWZTh2D22OyNWgDPYMFd+VagiCCHpY2Su8YSpKYdDMWsqtVNLPR9XhwMgT4WRbY6XI
	 zGuh+SUnygfaUFlCDud3Cln/xaFJaxMYTdhLaSuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfL2Rpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730345AbfL2Rpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:45:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BD7206A4;
        Sun, 29 Dec 2019 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641530;
        bh=XLHbc+6B7ZaNxnPntoPPYwdcBSRIrTnnS8jk5HI9v34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKceEprBFlJ8BqctqKkeV+fFqH9+Ssjx4DCnKS2mdaPLHG5o13O+zqAl0BVpon1Ff
         8EZbV/Yr/YfCMSEzDYjyKp1xOEsWXogWzgj/f96xh978U6cJRCYKbpNDw3Ee5jKctU
         LYNFjkPvY1WhyIBpRRIiZYY6aLBgpCS+pG7XQBvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Connor Kuehl <connor.kuehl@canonical.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/434] staging: rtl8188eu: fix possible null dereference
Date:   Sun, 29 Dec 2019 18:21:58 +0100
Message-Id: <20191229172706.075779030@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor Kuehl <connor.kuehl@canonical.com>

[ Upstream commit 228241944a48113470d3c3b46c88ba7fbe0a274b ]

Inside a nested 'else' block at the beginning of this function is a
call that assigns 'psta' to the return value of 'rtw_get_stainfo()'.
If 'rtw_get_stainfo()' returns NULL and the flow of control reaches
the 'else if' where 'psta' is dereferenced, then we will dereference
a NULL pointer.

Fix this by checking if 'psta' is not NULL before reading its
'psta->qos_option' data member.

Addresses-Coverity: ("Dereference null return value")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/r/20190926150317.5894-1-connor.kuehl@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 952f2ab51347..c37591657bac 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -776,7 +776,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv), ETH_ALEN);
 			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
 			   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
@@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
-- 
2.20.1



