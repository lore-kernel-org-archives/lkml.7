Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A1C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B123A20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLg/VDGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDNTPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:15:09 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38636 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:15:09 -0400
Received: by mail-wm1-f53.google.com with SMTP id w15so17404491wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/WshFKwVEOSIDmK/jXaqIellNMbewgiCDoskQDtQ9tk=;
        b=VLg/VDGJIgUw2fofdR/TgK4EhPCTTiduiQf83iqMWlGRtI0nuE00H33BTZvFiRNgcT
         ska17eYtWMxAeZ2BXWOeMlnDJBLiJKXIsPeD+DqDG1Qsfkr49FwQDdk8A6ySLg6paemW
         Haxl/Zzmp0jWeZiwjY74kDghz5wwwOKxKFqJLOuRWnvne1CSwdC6xQIp4f5f6vVvDJSm
         5yk+mo2iriyuzMvRVhXieC11h3mzVFVrEo9MnY9pWV6sc4gM0x484joyKhqnyJSIms/e
         +9dV8snSshP/Jr428V5sKrfx85oyFsxV2DK8Q0h09aUkWiu1vvQHf6yddNuatw287qhg
         H+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/WshFKwVEOSIDmK/jXaqIellNMbewgiCDoskQDtQ9tk=;
        b=A4HzoAvq9Hbh2B+rOKGDup+79uxbd7UmSpTMO0QdVHxustnD76OLMxHeXWqb5PvL97
         kIvYtRXDFvyHRV+pgum3Xz0l3G93/7d5/nPVJmvvV5ChT8RUEQv9Kb24yp/q4+x14qia
         JYTAATIwe20UBHJlxPZiuQw+93+zLrgBZpKSucF3j/m3IiBkTn0MjLbds1HTIj6EJVY0
         gaBUORteKLpQ7KG70xMQSsEf7TRFvYf3SovRIOONHfNbw3BWEgZ+ZxX+QoAJ/mjN5R/X
         GBZC0zfPf/ll4O4b/Uei01ksnWfEdKCiv6F960M656+3zFda76c60KOUuUHl9bOpznEo
         yayA==
X-Gm-Message-State: APjAAAVJ4Qponk8MZ2D1qCsgexvKvbWOCKwTxPsKA0JFehPDFz06wxp4
        O25kyoaPyDT5yAhW4+hYh9A=
X-Google-Smtp-Source: APXvYqx+jDH6MmAkrZ+Timy7nHQDcQmWzrUIcxA/WT7cYjMlvS6JDBW9obXqMgmwG5+CKAqcncDVsw==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr20193317wme.72.1555269307205;
        Sun, 14 Apr 2019 12:15:07 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
        by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:15:06 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, daniel.baluta@gmail.com
Subject: [PATCH 0/2] Fix invalid license IDS
Date:   Sun, 14 Apr 2019 22:14:48 +0300
Message-Id: <20190414191450.18377-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches solves two issues reported by Thomas Gleixner

Andra Danciu (2):
  ASoC: mpc5200_dma: Fix invalid license ID
  ASoC: mpc5200_psc_i2s: Fix invalid license ID

 sound/soc/fsl/mpc5200_dma.c     | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

