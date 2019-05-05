Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF020C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82646208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss1177TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEENTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:19:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfEENTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:19:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so5306739pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5+ufxo2LIp2vNFzc2baEGBYQFRJKvB7gapWAnt4yEUs=;
        b=Ss1177TGVBZRC4ZdxltdqKk32g1FWS0uad+bzsQ7QW+kLKd+3d0Ziu+rXQpwNNa8Vh
         8V+X/wz0l7spxzPeWNjkrM+EguFYQ56hSaAST8ZpXvYtJAvPXW2y27EMvwa/RuMeD/A5
         lQgCMD4cjpYAGxbYHFQwW/TctBUyjrdwCcOGX0y9BW9qaj0mH+P/GmyVMWVcRAmORSJt
         dxR//VetpPxtOKn5wkTrGq6i+GLj/xo73DEgPTiDtsHlxTMxEjDSwvQdV9mAmBmVXd7q
         btbco3Dp1PeXmocNtTB4a/1HVdQsyx19h6y7V2L70/bSY1PojII1oqrp/e2TnLlpDKQE
         ElfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5+ufxo2LIp2vNFzc2baEGBYQFRJKvB7gapWAnt4yEUs=;
        b=VSFSKDdWhteNV7HGgw7QNm23acFM0rninlDOUF2+uXdRPtZ3ilt9QPLhQJ6UzxjmgV
         tXIg7xKNKFzO8+szUkXjStIKGdh/rImWxuZhVkKld3N6WbqRQR/9NEo2umDOIzccI24q
         NTbZUg0RnhHEBk2zzA6K2b7sRGo5TqAKAA6S44m2XwEDOCd4d22IlciDLUg6ULvQdQbi
         8GLKgGyLrpxRm9q8sQSMs+KwfnyduD3wSv97eSp6wclPP5VBilVb6wwglOCQDi72miS/
         OFqofqL1ipBQJCG+Dmpl3DPxIWPEeC6USfiKMnyXK31x9yyCVHuwbI0XO16ual2MN2X9
         wA/w==
X-Gm-Message-State: APjAAAVfQWSxAY+2tasGP5bpbJoi+96OYASeHtsAtQpxjPhTVvdyhkUS
        8gh39BzcPACEb8LWxvoZy9M=
X-Google-Smtp-Source: APXvYqzi3TyHqWSdbPSAY1PJGeYDoVIkPTtsUevU1g1L1iwW894H5GMHjqVJ6PbHO8Od5NNqn9/ZTA==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr24155274pgm.213.1557062383061;
        Sun, 05 May 2019 06:19:43 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id o6sm14386189pfh.97.2019.05.05.06.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:19:42 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 1/6] staging: rtl8723bs: core: Remove blank line.
Date:   Sun,  5 May 2019 18:49:25 +0530
Message-Id: <20190505131925.4234-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid style issues, remove multiple blank lines.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d110d4514771..00d84d34da97 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -11,7 +11,6 @@
 #include <rtw_wifi_regd.h>
 #include <linux/kernel.h>
 
-
 static struct mlme_handler mlme_sta_tbl[] = {
 	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
 	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
@@ -51,7 +50,6 @@ static struct action_handler OnAction_tbl[] = {
 	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &DoReserved},
 };
 
-
 static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 /**************************************************
@@ -1261,7 +1259,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 	}
 
-
 	/*  now we should check all the fields... */
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
@@ -3219,7 +3216,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 	}
 
-
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK) {
 		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
 	}
@@ -3264,7 +3260,6 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
 
-
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-- 
2.17.1

