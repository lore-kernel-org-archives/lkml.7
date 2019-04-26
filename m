Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F695C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D5920675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udHN4jJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfDZDVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:21:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDZDVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:21:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so807933plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2J1TjtOstEzmWtLspAyMVLNIkrOKT0VPlYnQGIz+uw4=;
        b=udHN4jJBs3pXVk16n237GoSyhZGfP8O8KDAYlJyn4iJED7j9WSbV+1zmUqg+jJlnPi
         PRaIOEU5kug5BbH13YwAGbsS2eW5bb/UWaLkxMfFSh/PJiqL/zfzfr0gP5lHldBZM9kW
         p0IWOJd0KbKCXZ3MZiPvhhzXuruHmlyD+Y/lRGzNHPsFYn9qCtzdsnDDpDBB7DqIPxY+
         xWOskoDNaoJk+9eAvzZlKFT+HJzemNiwDrvnNLA3vgywC2bhI+TwS7tCSjYOQJa1iqIG
         13gNkOgz40bdUJwCXQ2vNR9VbrwpaQRK4ELcUgWfjqUmPuiSI4l9lVLzw6i83KmAqR3H
         8edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2J1TjtOstEzmWtLspAyMVLNIkrOKT0VPlYnQGIz+uw4=;
        b=TOCoI+QvO8w6FLPeNB2rKKTKz7UonahMGGZqJByFicypdB1Nnd1s0rNiFLsQEs7FLq
         OnwhZkVzwN8y/sWMImRr02NHA1JLBO0Wo5LLP01p/cWAQBCdsjySIs/2yKjKjJVmFAXi
         FDpKeWQzG9uTDklNN2uY+Vqz+myG+ftOuw1yp/IxBblUTsP4fugiLnObPuKkunJYez2X
         7+lxKgiYMCCjb3TGqIDYsBJeDR0MH82h79JcwfDtoc3Co2pCJ+PPaUoerb5rc9Lyjgoy
         bJ6BInTGF4cUlf02oasc3LzlBCW4mLtyom6viqBJrdoJCS8CfinArMqGmC7i976zvJmF
         rYEQ==
X-Gm-Message-State: APjAAAXnb0JGIVrDizCT08icGIunL6Oy3WbaRlZzez+WNG4Zt3Ytk29U
        tHP6X9/DXCWpm1SNtDECgSU=
X-Google-Smtp-Source: APXvYqzmideczOWmwDVE6IZEwTpFCEMCSkYkYC177nGVkAFFTgTtQJGsO4LuFeTWfsNBVvH589AZsg==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr5024608pls.206.1556248900457;
        Thu, 25 Apr 2019 20:21:40 -0700 (PDT)
Received: from Asurada-CZ80.localdomain (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id 10sm64985956pft.100.2019.04.25.20.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 20:21:39 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     broonie@kernel.org
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
        sfr@canb.auug.org.au
Subject: [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()
Date:   Thu, 25 Apr 2019 20:20:50 -0700
Message-Id: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build warning being reported:
    sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
    sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
    function returning non-void [-Wreturn-type]

So this patch just adds a "return 0" to fix it.

Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 26c27dc..8593269 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static int fsl_sai_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
+
+	return 0;
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
-- 
2.7.4

