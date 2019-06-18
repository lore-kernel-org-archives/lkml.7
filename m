Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD33206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StBLuVNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfFRS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:59:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35768 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfFRS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:59:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so8195755pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KhmMKOSmpu8SqgnzUE1h6NWxiRGa7i6ZJDyLxzhQcgY=;
        b=StBLuVNjXb1KUTHS1j3aOzNsFTQanhyAF9GXBkg8HHVIv77BKCnUGSDghC7ir30Xqb
         id03qaWdx03OCflYSHi0Z/Jj/jDY+oRc3MJ85hLpXZUDyhoGEMaEsjYf5llCq9C+5cC6
         ispDXsq71X1YyZmaKKjxphcqam1vpHa9h6dFeUfvZZjYQB1rStZ9jcb5P7BU3uVXHriJ
         2a/hAVydqU9UWBbsYlWhSEtq5m/GKbl2rnOqqgvdNsp4Ujm0JABeO8o2TqBgfVrj0yqj
         v5yUWrjiZDjdSAxredbylMPTIJB4ZKxihbAymHEvM+7PpXulZ5dcSpx5Nsp77+llN5Vp
         qRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KhmMKOSmpu8SqgnzUE1h6NWxiRGa7i6ZJDyLxzhQcgY=;
        b=WZ3V2e8qBw1gWWVz+NQYlajJVAsFdfNawnWlOsFjVkDMlb10d7KN6adOeCjX2CJeIg
         35JLoxoujGFXWW3A5lTrSGvez9GughxM6RKWb2Ccbo0MOR0ycA+wLYn42g9jRfNMTp7T
         7mlvvuR3bl2Wu2Djic9O0+X/BqzGIIIMAviviHmvqooPvg7WcIA582bhvvD1nSJmBpIR
         Wx7wyEuewv7RjgDr1J5Kt4BzyE78OuE4ljIj/pa3JcAdYOQxjvcaCXqHPVgUkea0O1L4
         mvgogwYKe37OMvf/pnWfKl2vmO4zScS+r2swfF4F19iYr8LrrnaHdKlvIVHDDJF9XJxF
         0S0Q==
X-Gm-Message-State: APjAAAUNOybknoKvV1Sh6y4GTWJ0jR6LuZsPPvXqhKk4KnINt9JiYgwZ
        9U8BAp2zMS2oI8ywjAFiqCA=
X-Google-Smtp-Source: APXvYqybzRDkkEDrAQ1VAQr1kytjBCrUoCVXjECnVciqNYsQHWPI2v6Fqy9Nl/Vuch5PUgyojSTOng==
X-Received: by 2002:a62:e315:: with SMTP id g21mr6651308pfh.225.1560884354089;
        Tue, 18 Jun 2019 11:59:14 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id n89sm6532091pjc.0.2019.06.18.11.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:59:13 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:29:08 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: hal: rtl8723b_cmd: fix Comparison to
 NULL
Message-ID: <20190618185908.GA10489@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issues reported by checkpatch

CHECK: Comparison to NULL could be written "psta"
CHECK: Comparison to NULL could be written
"pmlmepriv->wps_probe_resp_ie"
CHECK: Comparison to NULL could be written "psta"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index e001d30..ceb317f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -436,7 +436,7 @@ static void ConstructARPResponse(
 		DBG_871X("%s(): Add MIC\n", __func__);
 
 		psta = rtw_get_stainfo(&padapter->stapriv, get_my_bssid(&(pmlmeinfo->network)));
-		if (psta != NULL) {
+		if (psta) {
 			if (!memcmp(&psta->dot11tkiptxmickey.skey[0], null_key, 16)) {
 				DBG_871X("%s(): STA dot11tkiptxmickey == 0\n", __func__);
 			}
@@ -753,7 +753,7 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 			cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	/* inerset & update wps_probe_resp_ie */
-	if ((pmlmepriv->wps_probe_resp_ie != NULL) && pwps_ie && (wps_ielen > 0)) {
+	if (pmlmepriv->wps_probe_resp_ie && pwps_ie && (wps_ielen > 0)) {
 		uint wps_offset, remainder_ielen;
 		u8 *premainder_ie;
 
@@ -1316,7 +1316,7 @@ static void rtl8723b_set_FwWoWlanRelated_cmd(struct adapter *padapter, u8 enable
 
 		if (!(ppwrpriv->wowlan_pno_enable)) {
 			psta = rtw_get_stainfo(&padapter->stapriv, get_bssid(pmlmepriv));
-			if (psta != NULL)
+			if (psta)
 				rtl8723b_set_FwMediaStatusRpt_cmd(padapter, RT_MEDIA_CONNECT, psta->mac_id);
 		} else
 			DBG_871X("%s(): Disconnected, no FwMediaStatusRpt CONNECT\n", __func__);
-- 
2.7.4

