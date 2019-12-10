Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475EC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351BF20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017207;
	bh=njnz3j6pYfNJoPuu2YVlShJ7EsxzQc64B/Gnc2iE8kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PR2YAuJZZjlmOI3naqg7qzOQOuj7vL+9+nP/S5dYY3ktHxWe8siBKhpaOWGoO12NW
	 Xi8c2NGL5FgFK1PF380mf/F5hjlSUvm4hlraB32wzzNwlJwuogXx7hqm77WTbWSlJg
	 BXrTrWz59/dZ8efN6bJvX8tNp1gn1jRxmclOP3DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfLJWd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbfLJWdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:33:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F11A20828;
        Tue, 10 Dec 2019 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017203;
        bh=njnz3j6pYfNJoPuu2YVlShJ7EsxzQc64B/Gnc2iE8kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPrLTSzU1mVurBysgSnHcyMZplWxdIgHCgUtLFZnOhitXvD1V3UWdOJb+WhwO3W+i
         tvI3M82IAWwQsuohMix+iuYTObTM1Jq7C3lOLgxacNkIExOfdyfQqVqFwlolLnqNdz
         nwO6zgBNUI2XG8lA6Fh9emvI/kz3y2CVFneDXLXg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Connor Kuehl <connor.kuehl@canonical.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.4 05/71] staging: rtl8188eu: fix possible null dereference
Date:   Tue, 10 Dec 2019 17:32:10 -0500
Message-Id: <20191210223316.14988-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cabb810369bdf..c6bf8933648d3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -822,7 +822,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv), ETH_ALEN);
 			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
 			   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
@@ -830,7 +830,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
-- 
2.20.1

