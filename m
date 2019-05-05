Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1689EC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8798208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMrWHacv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfEENVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:21:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46802 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:21:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so964060pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/W24gNruPHDgOof9DmBWprRyBOAOlA2d0gs0W79Nqlk=;
        b=QMrWHacvhJvQJcbuJTgltiNCAtynYyJRiAeF3TDpt1cxYig3Y409qQ4JZ3tvgUkB3o
         vztrdxmPgtpszJuuFKhIsU9hKN+ekGks88GhfICI+6l7mclzDpEu3+5bAlh3m3e2ycuu
         jIm9hHJBVEvraqlMb9QYUSSgmVo/kFmqtgcXIYH4zbyw9WOibxL95NTwnYTFkjITkLYy
         9DSem1mxGl7geSqVRxcz4l6KVcV/R2/m2vSLnM+N+szAV+8553G1cwoMQmXzD4sPFx8P
         XkeTQydXycW5LGARiUx4z6nsIpuhi8rrDNwKw7OyDWiYeJY291EzB6NDXRloWE9y2equ
         3/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/W24gNruPHDgOof9DmBWprRyBOAOlA2d0gs0W79Nqlk=;
        b=dxf4bg49+7E1Y7bXQ93h5+23b/q6AOXBbbrl+igg7Sm77kW6k9u0n3d1F6DuIhy5S8
         JpiIsUeo0aKZTbSEtqPwP9ydnbiEZJrcXhmXsqB35OMrAYNJK9M9/W68YGJVM0q+oHOP
         Bq74NEbZOJJaW6uNiaX0rLdVrIfD1X3JvGoRoP7itPHZ4i2OVPEWHxlnKXi3OtioHIu7
         g90tUbFXtCzjLuzwf9PTaWo58sLtylxnORw8FUzVMlYlX2tlu2aaZzD2OrDWpwYnXNpt
         uCbqjkLrA4V0SyESKMN3iu2lFY3ND+SWc94J38mg9ZO0CdgaHT9UZa96WEcF9HmHfWD/
         sp+Q==
X-Gm-Message-State: APjAAAX/p1IU82XFVdKJZmI5rxJ70ydKIAIY3LqXH+Bc+zc1zmnqPWTZ
        nwhXt5j9PGpxdb5UP8vdMWY=
X-Google-Smtp-Source: APXvYqzVhSnGwwFTiQq+NfgjIFIj0R+/Go50FMLHUTb9rAVkS58g8ker3N0HJiQy/0PPsLhVVe9omQ==
X-Received: by 2002:aa7:8e04:: with SMTP id c4mr25596656pfr.48.1557062511524;
        Sun, 05 May 2019 06:21:51 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id m11sm10599223pgd.12.2019.05.05.06.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:21:51 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 4/6] staging: rtl8723bs: core: Remove braces from single if statement.
Date:   Sun,  5 May 2019 18:51:31 +0530
Message-Id: <20190505132131.4404-1-vatsalanarang@gmail.com>
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
index 1cf6229a538b..a8ceaa9f8718 100644
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
@@ -6431,9 +6428,8 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
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

