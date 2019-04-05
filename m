Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19CEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806CF20854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSWayY+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfDEDow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:44:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35109 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDEDov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:44:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so5912330qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hC6r6XJeiKsgws6znH9HxtwXxFeS1sBQGKD1lmer77k=;
        b=RSWayY+ls1on/oHe6BbhqCyTIglRNZdxNkWXYksFHH9EcrC+93a2AgYM+JY8xY6eRd
         uLCVGlqmxzjJsabUCZVrwpoq9GVvfQJGE1RTX2/cnfEOjo2VqQNXHQS48qjo6ErEBcmS
         jncAOqLrXFXG5hZOr44v5nVAYOmgFG3nB7voIg3kRC8w5zbJqt2bDt5QEQgpTzr3r/hl
         r4dRiGi09IR9uYtx3ER//pHDaoyvnGMm5GpS47tn9T+MTZnlbT+fy0jVZH/H3YrCD6CW
         MF630Frw7GdLD7I7ea4G1LZ9GewRr+LMXO/rVr8avAlTSLkXUNsQn93QJM4m94KZU0TQ
         Ompg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hC6r6XJeiKsgws6znH9HxtwXxFeS1sBQGKD1lmer77k=;
        b=MB2tZ71lu8XXSaTVqZGCxJ6zpr+BL+HtdZJBSJ1Q/wgtY0ZfNRDAyRyTWD536zcoXV
         xe84ALJvXxN6umkOLqk8KCfLUJjONIs/UfKs5hokBGrXE88LOSupO8TBul+ye8cm6yZx
         dPQO9VIACfQv3i6TO0A91wW3TplfyrP/Ye2N7IJ5zHgrztGbwUOyW5cZVPGU3bKJD2vU
         nPWaXdUNwsG+oLsGBwk0lL7FYYkm+dx8herUZg8DvDCePPF8MOJMHZZdkQ2j9YtvOLFx
         eJ4e1BNGiT9/JCDqCKMuYJ+gc7QiM0IOzpAAf0abP0CFhiBM8OBczUyuw8lEUFiS1bqm
         0iRw==
X-Gm-Message-State: APjAAAV7aejFQkL6gv8qd+LZgOPt4XyMkrb006A+xl41tKFfZdAmOOUn
        ok98XFISFsObPxodw57f49o=
X-Google-Smtp-Source: APXvYqy9CUo33f2cc4Fbv9sp5/8DO+11lH0jbjtVDafdKef2S2/iUm7Y8z46DaUJiV2BjNYM4n/Jjw==
X-Received: by 2002:a0c:85a4:: with SMTP id o33mr8143839qva.105.1554435890774;
        Thu, 04 Apr 2019 20:44:50 -0700 (PDT)
Received: from localhost.localdomain (200-100-115-46.dial-up.telesp.net.br. [200.100.115.46])
        by smtp.gmail.com with ESMTPSA id d41sm15134791qtd.90.2019.04.04.20.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:44:49 -0700 (PDT)
From:   William Tustumi <whatust@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
        whatust@gmail.com
Subject: [PATCH] staging: rtl8723bs: add space after enum declaration
Date:   Fri,  5 Apr 2019 00:44:22 -0300
Message-Id: <20190405034422.30639-1-whatust@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space between "enum TXDESC_SC" and '{' at line 86.

Fix the following error from checkpatch.pl

WARNING: missing space after enum definition
+enum TXDESC_SC{

Signed-off-by: William Tustumi <whatust@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index 37f42b2f22f1..ea1396005a13 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -83,7 +83,7 @@ do{\
 
 #define TXDESC_OFFSET TXDESC_SIZE
 
-enum TXDESC_SC{
+enum TXDESC_SC {
 	SC_DONT_CARE = 0x00,
 	SC_UPPER = 0x01,
 	SC_LOWER = 0x02,
-- 
2.21.0

