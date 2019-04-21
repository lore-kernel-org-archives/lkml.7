Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD4C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A94020833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA+cCq6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfDUQ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 12:56:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39963 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDUQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 12:56:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so13199578wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mT9XJLK/o44Uptq0p07MTEyG6GHZtHulPAi7nZhArF8=;
        b=FA+cCq6cRLqSbzt/TFzy/A1FeLMtbzYKcGn4oUOPIvPnqoaipfPl+rY3yFDKZqjESf
         wBwI4iRno1XJHeMZG3Ew7pQvvwCl4pfy94mzOiMnir9gQ0PvwpsA0jJ0seGF9oa3WDnr
         bVTcMXfCDz2sLYqqxf8fni0XB73PY3mgSwUIcYPQtAbt0L9JUP6rjBv4YbkJENNJpElQ
         BFCJ0dfOduRCtRNorYvYVvzKkaSm6LALtubBgN1kiT6XjUBD46SHgqlKiGjaJKqAPOWF
         1ccHAh7oqLWThMfmhbbH6VY2u4pS5dqCyOtUpn3C0e17DDBtdsmJiPqGW5gAI7WWAgUK
         6h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mT9XJLK/o44Uptq0p07MTEyG6GHZtHulPAi7nZhArF8=;
        b=OsJAIL7C6FZUasVNvi9szbvOVG+J9BnilKfTl2hiII2iC6NIE2WBTyjANaeD5l09vt
         2b52jO6pXhz3HAhinqfpO1Y2lG0sk9fJM6zXkFYKW6EsPhJq/Iz7VEnYL753tUhDGjPZ
         /O2d/vtshl2M42VYE4RWbjmQdqLZsxN3rZFDf0WGV4Ul604A2Zq6pevLsclazjQ9lqhS
         zRaQsXst2yy48ueLZbqKQK2lE6vU34x+JN7BcVrq9oPWfqH6n28PzhPm4qtAsh7+2/fP
         FxYWh7nihR0JB4v09lsRCsN5T4U7dIzj/NQnbpWqNhwAFjKIxzjoJju1Ppb3glQZ+WIo
         aBww==
X-Gm-Message-State: APjAAAUwTGDO6T+DxNKGcRBRZbViU66r73XBI1zTE/bBXa4GU1h1PiyY
        4V55/Pso8jbLARn/1zoKoa5GeoSU
X-Google-Smtp-Source: APXvYqz/qF0YNa7mY11E0+L41+3YOgd8O0pqUQ1Zms90iPycg/BW2AguWZS3TkO7UB80OV4ST7/UBw==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr9946540wrn.23.1555865800909;
        Sun, 21 Apr 2019 09:56:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb88.dynamic.kabel-deutschland.de. [95.90.187.136])
        by smtp.gmail.com with ESMTPSA id a22sm10012268wmj.44.2019.04.21.09.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 09:56:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup indenting issue in odm.c
Date:   Sun, 21 Apr 2019 18:56:28 +0200
Message-Id: <20190421165628.15864-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup indenting issue reported by checkpatch.
WARNING: suspect code indent for conditional statements (8, 17)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 95a8fc23e62c..74f7c9c81bf6 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -1096,7 +1096,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	} else {
 		/*  Turn Off EDCA turbo here. */
 		/*  Restore original EDCA according to the declaration of AP. */
-		 if (pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA) {
+		if (pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA) {
 			usb_write32(Adapter, REG_EDCA_BE_PARAM,
 				    Adapter->HalData->AcParam_BE);
 			pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
-- 
2.21.0

