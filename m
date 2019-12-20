Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C216AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97566206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbiLKIjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLTRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:45:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54356 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLTRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:45:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so9757960wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb72jc4spAcABwLaDNL79fswtIsTkbWjFqxfZ/KoMkQ=;
        b=sbiLKIjoBcIPp6lfdCUskCN7rdWS5ztUieDzd5hGCa43P6jDxZRKu/2VB4JjQp9fVv
         5ipiNrhR2ruTMTgIxzvyVQjCpK8kngCih3h1WZcvdZUxmdYoVwdWLuLg8jW2PMdM6MfW
         bERjEraoO7LAhdGBDaogKaO0v3ftBxYc1j9Rn+yeAnMdM/Tq9YIskDox2i40bI9O5n8J
         yt6NPD2X3le9L6KopHwuS5nKvGoHjZnnmSMunaQ9w+HSSewc9RhkJMDyIucnLCYY+YzL
         +bSwUY9/fXkbpP6U0T+YO6mSB9o10qjqDWqepqez56HVJu4vATttHZfXxP7/khnVcJ/T
         Mjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb72jc4spAcABwLaDNL79fswtIsTkbWjFqxfZ/KoMkQ=;
        b=QfECuAa4+mAGecz4AItLbyOSzQWHh5SoOtIeilE9M6J9BCI5nCyydf3LOdRySYN6NR
         4tHfU9Um03ridUL5eDOzkUOYGOZRAiqU0ohTNW+Sk3HhXW9NoOhQsDU8BGPla+sB8jcL
         oGroMGrURfRH/ur/eFelc5s26nLZ1f1HjH3WoV2eO0QlmGDsAA5mjfg3mdcXkK32TZ3s
         EqUijs5PxJoXMH2MjTGayisbfKLlFRQ1M9Zl6m9wxEe4Mv5OsZ8Z4BP7YF5dNWenCW4J
         H5y1ABy1pd/54KXfIzXHTdgXGZljbXJZdgboma6FfBqhb7EfU5HppJWrmKWKYo55Vxti
         3zjg==
X-Gm-Message-State: APjAAAXYCd/TRYVIEm9Iuwgsa9h1WXi5PPBoapJ+vLkHzjfRlaQVsjhN
        +YDn3XsiUvL96m/sWafbFZI=
X-Google-Smtp-Source: APXvYqxrHraXo73B9lFeIY5XoWKQTek2jE0WVcL0zSjObjZUUXEqjBNuXikx/k4BRqrNKhXKKYAEyw==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr16881907wmf.60.1576863897866;
        Fri, 20 Dec 2019 09:44:57 -0800 (PST)
Received: from localhost.localdomain (dslb-092-073-054-252.092.073.pools.vodafone-ip.de. [92.73.54.252])
        by smtp.gmail.com with ESMTPSA id b68sm10715536wme.6.2019.12.20.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 09:44:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use break to exit while loop
Date:   Fri, 20 Dec 2019 18:44:13 +0100
Message-Id: <20191220174413.13913-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bContinual in Efuse_PgPacketRead() is only used to break
out of a while loop. Remove the variable and use break instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index d9b0f9e6235c..0b86ae8338d9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -402,7 +402,6 @@ static u16 Efuse_GetCurrentSize(struct adapter *pAdapter)
 int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 {
 	u8 ReadState = PG_STATE_HEADER;
-	int	bContinual = true;
 	int	bDataEmpty = true;
 	u8 efuse_data, word_cnts = 0;
 	u16	efuse_addr = 0;
@@ -422,7 +421,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
 	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
 	/*  By pass right now. 2009.02.19. */
-	while (bContinual && AVAILABLE_EFUSE_ADDR(efuse_addr)) {
+	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		/*   Header Read ------------- */
 		if (ReadState & PG_STATE_HEADER) {
 			if (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data) && (efuse_data != 0xFF)) {
@@ -464,7 +463,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 					ReadState = PG_STATE_HEADER;
 				}
 			} else {
-				bContinual = false;
+				break;
 			}
 		} else if (ReadState & PG_STATE_DATA) {
 			/*   Data section Read ------------- */
-- 
2.24.0

