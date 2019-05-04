Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA40C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC3B206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEOewwgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfEDSsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:48:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:48:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so4358453pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hmTYC1IMrcB9vVn4blmFDPwB368HGffmno6HFyxlFBg=;
        b=fEOewwgJy+by43IHCWkxFNXTyAXP6B+iuW6YwAxyWS626ZgBu8vHqedCtgcTSKyE9k
         Nj87dgstydB/6jy/ZnDqoqx/qru5iV5NYsqqTSdKlIIfuHErQrIEB8pXQlonnvgn6bLC
         auxEli5EQ+5/4sdwjAZ+GUVBuB2H4c+aMZZdCH5dgjHsD+hOMA5jWQBmZCMj7xKTv0wS
         NKPtcxlBd1BPjTgZKKHeYf1Q6mf3UCMmhrCkFT+Yf5xknyk3OjGAFPju4vSerHDCiXgY
         Ge67kwXXx2TTnbj72/vzGXlELFhEYex7ulPSqwFJD765CIf6NThdJp0Am2FTlD2FJNl3
         eWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hmTYC1IMrcB9vVn4blmFDPwB368HGffmno6HFyxlFBg=;
        b=KTKBXKbdEmVJV+iBhtDTnH5xZWpFyk7PhQVQrgp7O1bm64JuZsyxUbIPi/PHq37tSy
         mUioSYKky6kJn+FHw8comzzNCSt3AwED3BwEewtVVI5J5nhoD3uszA1vIft9zC9aPxGY
         dMKo+FEC2BNSLUNXsitsA2fBXPIsyU0vnTCK17fYsHfEVmkF2dym+s8MzqsRgpWFyIJw
         OTErUn5PUPAmPBMBQW6GETaevhneR4tvoagehfhlzDm/rC4ICj4LaeB9LORCJkl/hyjd
         QLyWlpOBQZ+0HHhIWFO8RGGjQJ3eV2qSVOizGTt2On1yFNB6oObADI7pn//OcYfm7xOq
         F8yw==
X-Gm-Message-State: APjAAAXqWTHQ9sYoei1bw2VsUO6z9tRZZZjcBixWgM5rh+z+HDheh7jN
        t9C1MwRIAjS6MdXYCsEDbAc=
X-Google-Smtp-Source: APXvYqwht0JimG6n+2DPZhcHPWNdY9Fi57tT/TCXMmaeFarKieDMoWy1sDk5VRxKpfocLxh8N4MXpw==
X-Received: by 2002:a65:4183:: with SMTP id a3mr20477551pgq.121.1556995704305;
        Sat, 04 May 2019 11:48:24 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id m16sm9550571pfi.29.2019.05.04.11.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:48:23 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 5/7] staging: rtl8723bs: core: Remove braces from single if statement.
Date:   Sun,  5 May 2019 00:18:01 +0530
Message-Id: <20190504184801.26056-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single if statement to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 60079532bddd..6f0205c9504b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -370,9 +370,8 @@ static void init_channel_list(struct adapter *padapter, RT_CHANNEL_INFO *channel
 		struct p2p_reg_class *reg = NULL;
 
 		for (ch = o->min_chan; ch <= o->max_chan; ch += o->inc) {
-			if (!has_channel(channel_set, chanset_size, ch)) {
+			if (!has_channel(channel_set, chanset_size, ch))
 				continue;
-			}
 
 			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
 				continue;
@@ -1950,9 +1949,8 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 
 	category = frame_body[0];
 	if (category == RTW_WLAN_CATEGORY_BACK) {/*  representing Block Ack */
-		if (!pmlmeinfo->HT_enable) {
+		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
-		}
 
 		action = frame_body[1];
 		DBG_871X("%s, action =%d\n", __func__, action);
@@ -2397,9 +2395,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 		pxmitpriv->ack_tx = true;
 		pxmitpriv->seq_no = seq_no++;
 		pmgntframe->ack_report = 1;
-		if (rtw_hal_mgnt_xmit(padapter, pmgntframe) == _SUCCESS) {
+		if (rtw_hal_mgnt_xmit(padapter, pmgntframe) == _SUCCESS)
 			ret = rtw_ack_tx_wait(pxmitpriv, timeout_ms);
-		}
 
 		pxmitpriv->ack_tx = false;
 		mutex_unlock(&pxmitpriv->ack_tx_mutex);
@@ -6421,9 +6418,8 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if (pparm->mode < 4) {
+	if (pparm->mode < 4)
 		pmlmeinfo->auth_algo = pparm->mode;
-	}
 
 	return	H2C_SUCCESS;
 }
-- 
2.17.1

