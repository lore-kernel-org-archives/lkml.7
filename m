Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C461C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E567C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewQzMV63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfDDNJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:09:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37916 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:09:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so3094499qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=N7yjLFo55+EfWuYVczb2sen3klWkSPXAeYVkB7pb5K4=;
        b=ewQzMV63jTlwQmUBte3lb7tK5JmzSeX1rZ9IcDsrKGwF64OzGu6E+cHShM3bYbxwxQ
         zIZ2Rdbt8TYoHTymHCYBlta49BHpwV+DweJXoCu6h7u4+hFG+7NWrKB6OvJakzd+1wQs
         4bAAMSk9vvfUmsHnu19Lga7Ddg00aQigeez8jgKRNMcTibI/5Wxm0SCecoLC1Udy5qNr
         GhDKNjXjgCnK0PwQvaMBdpNHeSPREh4//FIvrZRMP1pn8g4kpV3c9VGKiB7SOF2LswDV
         l5LL8HXPt1jrqTaGnPNX9YEQHKbff2tMAl6P3ZQcSR3Uev0zE1HJjWefckm0SN7R4mau
         tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=N7yjLFo55+EfWuYVczb2sen3klWkSPXAeYVkB7pb5K4=;
        b=qJNbQZmKIsF0J8I1oc0oKYVoyy4x4ICn3c/efFIdEsHEtvbhyP45AFszaKq3eHLktw
         lgFnh2nYwjIsC3WnFuIC1hVNPSuy0qatl03nY1g4OBC2FeRKu3kgjoInVfO0ATnkF8rO
         uGqQzHvnAib85OuZvbAfCVtaRI5klCW0cVaP5NN5F3hSscHWTEcvpkXw9ZRGaCDcdt69
         h29E3AUE7zEZYoTAfDHEanuDCm6dqWsIY0/ZuQtR8CwJc57QhOlh59PRpryMnLLfx0LT
         rhLvw1UotE98c+XAxrpiFeupv8EfwA4iEpWg/JNXtnazFaCbvYg35kHMq03/An8bWSvH
         xaVA==
X-Gm-Message-State: APjAAAUPqh9xKPJfD85lMJLCN5or0/SLSDDnNM7GwqD4cBjtFzjL6vRc
        9fvoilLaJFRM4Mdqdvtztc4=
X-Google-Smtp-Source: APXvYqy5q9VvMvoZGPN1zFduqTqqOQAElO3uDJsm7S3Y5Vfe/wY9s6Pi1C3WFsHkfBJwhMAfOhRvyQ==
X-Received: by 2002:aed:2321:: with SMTP id h30mr5098577qtc.253.1554383378295;
        Thu, 04 Apr 2019 06:09:38 -0700 (PDT)
Received: from redir.ic.unicamp.br ([143.106.24.168])
        by smtp.gmail.com with ESMTPSA id x8sm11811936qtj.45.2019.04.04.06.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:09:37 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2] staging: rtl8723bs: hal: replace spaces by tabs.
Date:   Thu,  4 Apr 2019 10:09:30 -0300
Message-Id: <20190404130930.7437-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "ERROR: code indent should use tabs where possible"
in hal_com_phycfg.c:1726.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
Changes in v2:
	- correction commit title
	- added more information about the error
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 828b328adab8..fc49cdfcd477 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1723,7 +1723,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-                DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
+		DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
-- 
2.17.1

