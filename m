Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856DECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE8F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjs4uSR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfJOPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:45:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46587 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:45:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id r18so6797108eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUcJdIWqrr+IZvPOnEuHNqfscKpmA1S5L5Mn3MxIjpA=;
        b=Rjs4uSR6HFoaUox/Lyrg5MAheF9DPnt2lhYu5CkHrJ6jknC33tce11zjNl/X2LT1H/
         4KBE7KXgFPBIp6pznnl1o2vLj8wiZMJ8wZ/ahjdrwcqTM/PaWBUbxcpom2z4mG6iut8E
         G2vvBApfArbEbU0HlJcRvSQraFVjlS2Vqo/oqYkajspXVJRTaAjzzJ+tXhh/tUmXZsq6
         j6OvcYoc2jRSsMDQnZ2Ln/yEYVe2pInA8y8fFBaUNorGBq0lG1Ak7TW1luj7Ot6ipCIf
         u0mV7dxukL1ChzoPEPJgYLCJBs/jfMMNvAzn4ANTQQA6iNmqlFmsuL86ScXDJSWVj71d
         s+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUcJdIWqrr+IZvPOnEuHNqfscKpmA1S5L5Mn3MxIjpA=;
        b=eT4XzhrZ7hGoGa91wIuuZTKr30w57Rj5LjDWzi3Lo/MV+gY9JSPp4cL8O+6+O0bF+B
         ircIwhJ9dTNIp6XiSFEJCFKxr32JdJ2jwuRKJ5mNcMl+p6g7ZwS/pbAdjNA21ToH9Mb7
         rzm1n7IehG7xQ+tF3oKK5bRB4yZ4rcuOzemOQQxjODgRbjEvaJ1yMBVbGhc30nMoq+j9
         g7hCZBeM7Z4uX4ftmQUVAO+KoIjR2UjLFIa1Ly6AYj5hpHyG4f1QgzqBs45Se1EBfMHH
         oaEmPCHOe0UBdQjaVCyjuyk6Q4x6eaRqI516pPFHnvcuwNxv1h4CEye3TF0meK/6VQqm
         SwYw==
X-Gm-Message-State: APjAAAXCXG8KUf3/mx3GufzVK/r+0Nkd/uXYoO/V+rd0UdzE8YCVTl76
        6FABY9Bti7XFmhrqcHGs95U=
X-Google-Smtp-Source: APXvYqyPqKBY6p0jGAoXx34Ep7cXaNbnu9p/U+zEyRaY/bKXmWHPd2LYIPpLryRMPOdrm2JMNWc/8w==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr5091433eje.171.1571154349774;
        Tue, 15 Oct 2019 08:45:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id nq1sm2807787ejb.75.2019.10.15.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:45:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: convert variables from unsigned char to u8
Date:   Tue, 15 Oct 2019 17:45:34 +0200
Message-Id: <20191015154535.27979-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015154535.27979-1-straube.linux@gmail.com>
References: <20191015154535.27979-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the local variables max_ampdu_len and min_mpdu_spacing from
unsigned char to u8 and remove unnecessary castings to u8 pointer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 6d56ca7ee7b4..1e261ff8f0a0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -729,8 +729,8 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void HTOnAssocRsp(struct adapter *padapter)
 {
-	unsigned char max_ampdu_len;
-	unsigned char min_mpdu_spacing;
+	u8 max_ampdu_len;
+	u8 min_mpdu_spacing;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -752,9 +752,9 @@ void HTOnAssocRsp(struct adapter *padapter)
 
 	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_mpdu_spacing));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_mpdu_spacing);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_ampdu_len));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_ampdu_len);
 }
 
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
-- 
2.23.0

