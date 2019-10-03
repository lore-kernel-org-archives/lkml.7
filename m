Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D5DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D545222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Dd0VrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfJCMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:25:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJCMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:25:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so2729013wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1MIz5EDU8fb+WO6SYE1MsjHkZdySFg/UAMzsWR0fZmU=;
        b=R0Dd0VrXbaQ8iMbdDkbin/M3ehCJ+TFt+vgZMuaGkSxhpn8dt7rCzaqOvvfdGzxUp8
         H2CKT1PFR0uK7pkJT8ldk5Xx7mwteS98LHMq2L8JAUVi2tKYuZeQu9UlBvMMoS8p8uqM
         NY95bj/Dsumn59tDEdXvdodA2sfCdNRIE1XcOKnROR3T6ygVjgwBm/82cBM+l244YPiq
         dMF/Naw7fF21CK8auertOOcIy5mhoiOZHV910EeDa+J9fCg7hUJcbiv/pBg5anrzcedw
         rfC/HyS63wQH5UTbTCtVzKm2w+vZwE2MTj8g5rxW3VMr4hhX5APzALrTw+QvD9X6eOWt
         cOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1MIz5EDU8fb+WO6SYE1MsjHkZdySFg/UAMzsWR0fZmU=;
        b=bfzhbDu9VYd3FqEcYyrkQ1AsUBD16opW1Dd3CF+yl/rjyUMp5QNpODyaaTXuhrKAD3
         E8amZhRL22NNsDpyfIQFXr2BcnwWJnYgkdwh7Cfm1cNzlnxGUgZAgi/VbEbiupcMVPlu
         qVE28kkrhM8RDstQSqxMA3CcDv6wa7Pboc47/ywHyIoV45IYvcW3weOV5GeJGvPgexdm
         X8mZFOATJev/MZGNs9BkOvUz6TfiCt5FZfuPTuLA2FRyoIBdZbpQleSjLNBfkz8rN90t
         GtSDy/h+kEMkVk0/6LrEQudw6BoKiU1B90fwCN45CrLcdCqUAxEFnRqSDB5kzUlD/VHH
         QT+A==
X-Gm-Message-State: APjAAAWd1Btibz5siWwoJcBJ2ec2nkbb5GlatUSs+KvQKSGe+KFjux0k
        bSnnCzrUZL2qiQmR2Nsi82o=
X-Google-Smtp-Source: APXvYqwsRQ1osNJCwcSzxWiN/fkXIuxBBG88iy+2ZSAE9wi5t7JivoY2kXLeN0s6gOUHMFbJXg9swA==
X-Received: by 2002:adf:f34b:: with SMTP id e11mr344902wrp.369.1570105534428;
        Thu, 03 Oct 2019 05:25:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id f17sm2699322wru.29.2019.10.03.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:25:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: convert variables from unsigned char to u8
Date:   Thu,  3 Oct 2019 14:25:11 +0200
Message-Id: <20191003122514.1760-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003122514.1760-1-straube.linux@gmail.com>
References: <20191003122514.1760-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the local variables max_AMPDU_len and min_MPDU_spacing from
unsigned char to u8 and remove unnecessary castings to u8 pointer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 51a5b71f8c25..1e4461a74474 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -560,8 +560,8 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 static void update_hw_ht_param(struct adapter *padapter)
 {
-	unsigned char		max_AMPDU_len;
-	unsigned char		min_MPDU_spacing;
+	u8 max_AMPDU_len;
+	u8 min_MPDU_spacing;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -576,9 +576,9 @@ static void update_hw_ht_param(struct adapter *padapter)
 
 	min_MPDU_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_MPDU_spacing);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_AMPDU_len);
 
 	/*  */
 	/*  Config SM Power Save setting */
-- 
2.23.0

