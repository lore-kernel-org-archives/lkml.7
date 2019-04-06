Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02677C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40C421019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBN8YRaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDFWR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:17:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38193 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDFWR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:17:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so11432554qth.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PeFRlnr6HrZC1NxNfu7wjw3w0uGSbLIsFKks9lD+0RE=;
        b=iBN8YRajNKfdIG8AKFePX37UCO+q4F2qN0tGjlaotu9EBphSoqnq/pKYd54UnBMs5k
         5Cb5IuuYtq19D+WCEGegcwjSQQXi8gmUlSWEie//CoHyP8B8roPYHgOh4ja+BtZhpmpj
         b0lz1Rz7vsmuE6lmJpEI3PFN8tthN/PD2xmdYwu6YRY/eaeiHPKZwuelVXk+rYfVUNb1
         5WNcLaCeq/cUumVw3jB8Xz9Vk90R2/hH9KL//g8jEfili59xqfjYBCmmwhad/D2JqIAa
         XSrsIzwG2iYwzqVKFMumD2iPcRke3eLOynrdr/lj4Y3pEMv1hu2/7kwzSv0dqAD4gQm3
         b1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PeFRlnr6HrZC1NxNfu7wjw3w0uGSbLIsFKks9lD+0RE=;
        b=QPXwGuhK9D5KVOPfvQOkA4lAaocq6URslDs4jVG67DV4yPkTX9JiDkYz/WMEaMe+R3
         +FFq2/Tl3tNS604GAon/MZZNhWTZ5BEAIsBDIRwuX6bGVjoeM0ZM/26FsWFdetCjQ/ho
         J9eiXXNSseG5a/4yjsBTYNFvnNHxcP6oST4cHOGqmnQK8QcmXsXU/SRzUn9VChzOAn+P
         9J9/6Yl56DrsSxTGZBRqRIktYfltU2UDiqHE/jA9tyPwlrhG59YPjg1TGHQMM2/zUKvv
         29PLrl03YaBwHiLE7fKeZspjpWGhxlkRaXS74imWX8zOCbyWmqWjIE/x+XMF4SSlAxwR
         TjFQ==
X-Gm-Message-State: APjAAAVVPDE4ELFqM1xR8sar3/VvpjtwTwwZDSMU6xb4NoX7lkKoQk/U
        jIEUZRJtfzayvIuUjvEGosk=
X-Google-Smtp-Source: APXvYqwC11jQYOu1t1wqXVhBTMSLPmDTktE/Y+WzMFPUqqhvLKONW/sMgqp/UepoZY1C9xvUWtdl4A==
X-Received: by 2002:a0c:bd81:: with SMTP id n1mr17063421qvg.65.1554589078105;
        Sat, 06 Apr 2019 15:17:58 -0700 (PDT)
Received: from localhost.localdomain ([177.194.125.83])
        by smtp.gmail.com with ESMTPSA id x184sm4911663qke.35.2019.04.06.15.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 15:17:57 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] Staging: hal: hal_com_phycfg: fixed a coding style issue
Date:   Sat,  6 Apr 2019 19:17:44 -0300
Message-Id: <20190406221744.27570-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a blank line after declarations.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
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

