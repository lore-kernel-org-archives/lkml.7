Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1241BC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C278C21019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqrS3pD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDFWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:25:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36037 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:25:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id k130so5926479qke.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wqWimifeIDD+Hnp5z69jcMmovjzRExtyp2ICjYUECsE=;
        b=EqrS3pD91lIJpuY45V19/UNfybs/X68xmLcalQGu2+llQwcpO1tD8BUR0kR3h/fBUZ
         wcG9eWXHKS3uEryqYf8iF8J1aehbmppvEMJwuQ8pd4h4EsYvJWACqZv/Sj88RuewL7il
         ExTukldr5qTWbAoEPP6KAeC7mjUtAu3t/rUmdpB3O9LynOBZyGZEa/Ljx+gFEM1FwfFy
         FY/1CxokrHDratyvXl1fAKUCHxQ0obTGnVXIUXRflr1kKkT6OPdpxmyht3mBdeLAW+y0
         NYG+GDo4tU8gfJx4hchKFGHzQCWDm3hmfHaSiuwDj8zyE/moDJOTdeMhBFISK9yPF98J
         Sm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wqWimifeIDD+Hnp5z69jcMmovjzRExtyp2ICjYUECsE=;
        b=b7LX5J1Cl/2LEMOGVQ2IH1jA1Y9ItIHpZMos6OYpzSo7ZS944vCtlmd3Jbb1sj0CFl
         P6xuzRB5MRu/Nu9INhGfRXYEJMfmZ8TlSvhAvD7K+gRZTb6txi13nQNFQw4wdz2v53DU
         7CyuXxNl7z9Tg30YEsWN7Koazhwfq3sJKtLpVsRhnXDZmxtk7gmlz8rig3h2Cf1CPbx6
         9MZ+MXLCqnXFGFbSL+pgSBS5XCsAoClevfJ+i2A1N7BdkY9Cs3NJslpfckXPSIc0nYUu
         XyGOd5zW2DDQWTVczAT0UTLnSeaucevy8jCNmbzGPmzqqPJSiWWWHzOphvb4/b/LTHPD
         KmmA==
X-Gm-Message-State: APjAAAXz9kY4rSyXrYglkkFiKR0n9Re2l3pVFlHXIBdDhvuWTULlA7gU
        Kz4NuzTgeoyieS0Bj9wCs4o=
X-Google-Smtp-Source: APXvYqzHRn2Ow7rUw8tEnECxY0H6Yc6Hz//OHqyvoNH8Y/Mxy/Lb7e050EZRgJNKZBiPNZVS9rxX3g==
X-Received: by 2002:a37:b444:: with SMTP id d65mr16525721qkf.125.1554589544037;
        Sat, 06 Apr 2019 15:25:44 -0700 (PDT)
Received: from localhost.localdomain ([177.194.125.83])
        by smtp.gmail.com with ESMTPSA id i63sm11968545qkd.82.2019.04.06.15.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 15:25:43 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] Staging: hal: hal_com_phycfg: fixed a coding style issue
Date:   Sat,  6 Apr 2019 19:25:28 -0300
Message-Id: <20190406222528.27792-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a blank line after declarations.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

I'm adding STAGING SUBSYSTEM open list

 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 12c1cd590056..c41cf14acea1 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1749,6 +1749,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 
 	if (band_type == BAND_ON_2_4G) {
 		s8 limits[10] = {0}; u8 i = 0;
+
 		for (i = 0; i < MAX_REGULATION_NUM; i++)
 			limits[i] = hal_data->TxPwrLimit_2_4G[i]
 							     [idx_bandwidth]
@@ -1766,6 +1767,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 
 	} else if (band_type == BAND_ON_5G) {
 		s8 limits[10] = {0}; u8 i = 0;
+
 		for (i = 0; i < MAX_REGULATION_NUM; ++i)
 			limits[i] = hal_data->TxPwrLimit_5G[i]
 							   [idx_bandwidth]
-- 
2.11.0

