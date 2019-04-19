Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866DC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941AB217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTPBTzWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDSVdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:33:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45389 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:33:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so5236046otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jdl6t2IM6ApyBuk8s8xMjHnlErgRbISG8DOVqfNGV/A=;
        b=cTPBTzWF0dsLmxIn9aIbf9/hKrwgfoFAgZ61w3fVVeRKIwaP3FtGNYFUXDAHqx9gKy
         JK3kpHJWiCzFBMyktQ8hx7ScmdnMTvwH42s4gcZ4bP3OAqc+21lUlCqnjBrZEsh/4IyL
         iVRiy8DpYCopaoaAUJc0hGmoSWZ5TZCJSZvAmm63JTTJlJMNcHwIv3JQfbZgD5Xn2TnB
         y6Ydyg8lCOA3WXGRUvH+h7tgkbiLpahLFqubHxFWCnNb+Tn/jkeKdbdOqEfAXGryA3oU
         1OY2tgG8ZqrAidATKLeA9It1GyR71ErEdjY4URq61JFhxpAKanF9aDH3Hwp74Ivujuel
         FoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jdl6t2IM6ApyBuk8s8xMjHnlErgRbISG8DOVqfNGV/A=;
        b=nPc2uozdusRirIbMJ0IwpwMTHMs+kpNxtmTTwof7hB+rQOxLhhNV2a5fEq7ZSYv3Bu
         Rln/eHb1nbquOhFUCW9smhX8A6ge0V7l0Hv8NX3CAyNC+cJvs8Y62fxD5ZGaC+9Sxh7W
         L8Ybun9yIHwy2BrlRq6W9QKGuysX4R3i2lnfBYg38YD2aEX1JZdprAsCQ0md6h4SFIDD
         pG+o9ox+2PrkdxWSMolSRXNdglSCYC1gbbQB/cbsVLzIqQ2rIH+47VfsHjqJ5qqlnFhe
         LSEhZ1zaK6990uez3JfCKSan7+K32Gpq6TFNciSx0/uzjhTU+uA6R8j8GujBsrMjjUO3
         +pIg==
X-Gm-Message-State: APjAAAVtLi6fRoDh65g9uyjFR3czo730miC7QYT74Cb6A8C99/0oN+Gp
        XaOf9JGP7ZNaw/FrfYYkyM8=
X-Google-Smtp-Source: APXvYqwqBWKZlOefGul/8H8WX2QV8Cj64yNBo3hMyA7F6tZIVHYOD94/zV1YoLjqYQRIqXQ20cIPLw==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr3396593otk.205.1555709580019;
        Fri, 19 Apr 2019 14:33:00 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id 6sm2534476ota.79.2019.04.19.14.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:32:59 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: rtlwifi: Replace return type
Date:   Fri, 19 Apr 2019 16:32:56 -0500
Message-Id: <20190419213256.23032-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace return type and remove the respective assignment.

Issue found by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtlwifi/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index 2cce65368f92..1e4e858f7517 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -377,9 +377,7 @@ static u16 _calculate_wol_pattern_crc(u8 *pattern, u16 len)
 	for (i = 0; i < len; i++)
 		crc = crc16_ccitt(pattern[i], crc);
 
-	crc = ~crc;
-
-	return crc;
+	return ~crc;
 }
 
 static void _rtl_add_wowlan_patterns(struct ieee80211_hw *hw,
-- 
2.17.1

