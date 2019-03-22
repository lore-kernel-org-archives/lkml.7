Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE92183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF1NajOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfCVNRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:17:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38153 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfCVNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:17:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so2315912wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRcNwcratwv/hHyuITxEsb44qhFpstCpxUGarsJUqdc=;
        b=QF1NajOjSi9JVgbX2yCrK1dmv3ay2C1E9foa3jXaLweue4ArsyllEeLGQ92D8k4dEe
         ogddYRWEFWNAFLG80D7bKJDHUVPf3E4wuYyuFwP8H1cB/M/Tc+U7Zok47Z8WUM6Mvlgc
         sq304kbsGLThz8xCP1uiOfvvwtMkkiwwW4WMU0peuyZe2NLrCXqF2R2sGW/56ecDaJi3
         RZjNNEYz6ftTX9xAFI3wFwt19yoVElIsRsx2H1JGHmtl2TDJGyVem7wF00wDMM31LO2s
         4DxXZ6Vj/M9YrFaq6aKsvQTI9Qnkv5aafGafJUVPKxMfJEtJX0zUzLyFwPxpcCDwt6rP
         AVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRcNwcratwv/hHyuITxEsb44qhFpstCpxUGarsJUqdc=;
        b=m7n/m0Z2jmbOhIN91pU0fArtuY3lmjO6fJoW1r5dLZQiHgjcWPeVDScIkVkOhyr5ty
         a6neZFOjaykTn9JqiDcJVyunbVnzgq7oxU28VdaxRoJ8zfKLWNsJB2GVyQsJ7TlDrdcw
         /EUCojD5V2kaTzgvVIdVrD0BEbHqJJwdVIBw/EMw5Kl/xtY/WY79FYxK5o/yjdkWO8B1
         Ob/oTPuZL+yc4Ao1qViqqxzVgpcgjQqPiP7yEb5qFJ5qpN7MG0VViXAgW3jV6NfWv/1r
         W7Z++RPyrFqGmaxLBx2m5kNahZ1cTcQWBojWvfLpnOIr69iYKbKKVSqGbytcexGlpglc
         EJHA==
X-Gm-Message-State: APjAAAVddbVjpG+lnD3GemIgHL3op+Gz1+bjz4nh7Z142MpZx0oduPzU
        uHkgHPCPPTuCbaflBOlDFnom2F0T
X-Google-Smtp-Source: APXvYqw/bin4s5b/3yRghQbyz7s7V+Tiwt/RZn34g+i5iGyrGotVLK/Z9w7h17c2w63n5Ca+W7+nLQ==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr6242894wrp.268.1553260635795;
        Fri, 22 Mar 2019 06:17:15 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb85.dynamic.kabel-deutschland.de. [95.90.187.133])
        by smtp.gmail.com with ESMTPSA id g12sm3458462wrw.40.2019.03.22.06.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:17:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary parentheses
Date:   Fri, 22 Mar 2019 14:17:06 +0100
Message-Id: <20190322131706.696-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in rtl8188eu_xmit.c.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 9e5f23392d58..ab94ad9d608a 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -168,7 +168,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	struct odm_dm_struct *odmpriv = &adapt->HalData->odmpriv;
 	struct tx_desc *ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -486,23 +486,23 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 	switch (pfirstframe->attrib.priority) {
 	case 1:
 	case 2:
-		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		ptxservq = &psta->sta_xmitpriv.bk_q;
 		phwxmit = pxmitpriv->hwxmits + 3;
 		break;
 	case 4:
 	case 5:
-		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		ptxservq = &psta->sta_xmitpriv.vi_q;
 		phwxmit = pxmitpriv->hwxmits + 1;
 		break;
 	case 6:
 	case 7:
-		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		ptxservq = &psta->sta_xmitpriv.vo_q;
 		phwxmit = pxmitpriv->hwxmits;
 		break;
 	case 0:
 	case 3:
 	default:
-		ptxservq = &(psta->sta_xmitpriv.be_q);
+		ptxservq = &psta->sta_xmitpriv.be_q;
 		phwxmit = pxmitpriv->hwxmits + 2;
 		break;
 	}
-- 
2.21.0

