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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18F5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C10218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKHrdARj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfJCMZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:25:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44440 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfJCMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:25:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so2657753wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9mWuUCV15M116jFIIxOt3SzvdK3XTaBbtn2rQ//v5YE=;
        b=NKHrdARjZrHsbiuL+EU2WxV69YhlgSc3ZsWItUhEgP+o6mMAZA9Rflt3w03vwt1h5B
         iE02uzQcywYprKfQk7wGF9kCfpXzPst+MXM6FTsP5os823geaqlVvpyR0MOLPo2uujtI
         NgF3u9DnVtWc0euJaNVMEe3FOnbC9Xx50i7+BScBL5UrH582fheVYJysfwxSEAaAnXZP
         LGjS4v2dl+p17ZnkDZm1FRRsbK46Qlmxlm5f+NS9/4prifBlYHDx8BoVranDLfsdutpT
         XB+fGbS/J5bz4tUh/aC1XugNkcil6VT5+4FyHn80wq+VaubjJgmByrNbc+6OH0hMGM8m
         Bcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mWuUCV15M116jFIIxOt3SzvdK3XTaBbtn2rQ//v5YE=;
        b=LGls1VDo9CDZw+kDU/rPyxtzuIHamXdHlvqV1ryoZ2kFPmIgPjyRpOOHnPJCrPcKc4
         NAK+z4qvNnvAzo0Tv5uiMSGIYP1XdP7R9IttKjyjkOUZU89F8rv9xH5qAIgEalEojeKf
         hAhjr5qydMjI30+45Wk89moItIJpCrbh1eZWWMqUUj3/aVg2+UVrNGLKu444fQ7LQSt/
         InWnoJ/UX3uD7U7SPdQyk32Zh/iqKZ5IytVrFWU7YAbnFtpRBkmhNopb3Fv6x9vcvw1c
         YxKnjiVf80RhIs7eSz3keWa9/Pr7hFmvu3zhxmmojTADoQn1I/K/k26YYRYbYrbwxhSb
         PngQ==
X-Gm-Message-State: APjAAAWOiak/UlzYW5upqv+22n/EQ/rXf30TFsGcTPV8y6IaLJX7S/0W
        jeAumWBylNRRrqCd9fF2PQwY1XAO
X-Google-Smtp-Source: APXvYqwApmNbpgwx0t4k5CHbGjiqkgCAhk9uWbdou/uxPbX2S767CtLM/ECTQ7aEg5xDgYOmmatirA==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr7377105wrw.385.1570105536096;
        Thu, 03 Oct 2019 05:25:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id f17sm2699322wru.29.2019.10.03.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:25:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: cleanup whitespace in update_hw_ht_param
Date:   Thu,  3 Oct 2019 14:25:13 +0200
Message-Id: <20191003122514.1760-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003122514.1760-1-straube.linux@gmail.com>
References: <20191003122514.1760-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in declarations and reomve two blank lines in
update_hw_ht_param to cleanup whitespace and improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 75c34e8f2335..97cab71cef23 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -562,8 +562,8 @@ static void update_hw_ht_param(struct adapter *padapter)
 {
 	u8 max_ampdu_len;
 	u8 min_mpdu_spacing;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	DBG_88E("%s\n", __func__);
 
@@ -573,11 +573,9 @@ static void update_hw_ht_param(struct adapter *padapter)
 		ampdu_params_info [4:2]:Min MPDU Start Spacing
 	*/
 	max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
-
 	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_mpdu_spacing);
-
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_ampdu_len);
 
 	/*  */
-- 
2.23.0

