Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50751C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E92222CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clpDbHtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfHSQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:57:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41412 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so1543352pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xvTcLjnkXNY0U7N5Qvkal8m7tS4ZRCcCLTcZeCRTKcY=;
        b=clpDbHtFXRz8wQ42Owus5HXV6eB12cbtxeUFbAmP1rI1qnofmD1sep3gbAuSeJS1J5
         b2Y21NFpBsGAhu8l8CvlkSHk01w3VGAsShMeLQhtqOCZtaogmezWlA1r0rM5I72t+yZ7
         ETNpYUpu+oDlrYaWYPAq9pGhgeT1UXkWnn1q0H49bzfU0nmRHkd0/XuS030FYl1VN9+X
         ixdUOHp+ckMuJCWFhBQCsK/3dj5Ru3Sa0ORxdzu/fJNeBvyGGImMrGO2EhaOoRm2K5Qt
         /fheNLNhhBD3Zq0Ua3LL5M7DfU2Qgd2J19wzA4MyfcjGaTNHHJI/VDoCnc0cjsqochcu
         0XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xvTcLjnkXNY0U7N5Qvkal8m7tS4ZRCcCLTcZeCRTKcY=;
        b=pUnaN9rltIvrjyK5U/7vaZLKws4hA9E+lbqxk3U5C4fN2wNNCbkJVfnhuBSJZNK+E5
         D1sfH5K6rhwwPsjWG0N864N2/T84iuYDxvA0Hutvm3XWBoarHp3wSKu/ggldFqNAl7yd
         qWIzcr9TyjeOkiDQKfx4RZETZgiupT9Rj1o+QRVpJHKzIIbIC+YlMlnhPfE9JL0Yha1S
         v6O2ys+T5FkZJxHETQciHCwvKLd+T/DEY7A7hhG99c98J3e5urbMg94Nd8JyG45g9qXp
         j2sKyxjVxaqx3dH9SwhR5VOtujg0WLNIvVM+hj0ch6M7qwxKwL02rhgmi6x/TB3/Rewt
         i3pw==
X-Gm-Message-State: APjAAAUvuZILnWcH8OV9W3d0B+nlL7KulPyuwFoAPv8RzTwOrj2UceMp
        WDYIyJ2zygP+wP+wfeKT2lA=
X-Google-Smtp-Source: APXvYqyPx7OIhsMLPg+yGcZQQHQ2HDF0QCfz0tvt6kaxvDEHNghyC8WRB/jSyI1Mt5vJ4v5REPeqLg==
X-Received: by 2002:a62:764f:: with SMTP id r76mr24583727pfc.149.1566233832013;
        Mon, 19 Aug 2019 09:57:12 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.90.246])
        by smtp.gmail.com with ESMTPSA id m9sm17412035pfh.84.2019.08.19.09.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:57:10 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:27:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: Remove unneeded declaration WFD_OUI
Message-ID: <20190819165705.GA5782@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded declaration "extern unsigned char WFD_OUI"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 02f5478..6d18d23 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -13,7 +13,6 @@ extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
 extern unsigned char WPS_OUI[];
 extern unsigned char P2P_OUI[];
-extern unsigned char WFD_OUI[];
 
 void init_mlme_ap_info(struct adapter *padapter)
 {
-- 
2.7.4

