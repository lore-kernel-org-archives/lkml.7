Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59EC07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233B1214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl5RYhYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEZBT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:56 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44080 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfEZBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:36 -0400
Received: by mail-ua1-f66.google.com with SMTP id i48so4468785uae.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9RckfaOyTf+xFTNPpwPEwsOHKNyfyEU38Mp+/sU6tA=;
        b=Bl5RYhYlgHEhSe+fBzBodm5gri9kU46xOgubbeARfaOCNWwXx2s4plzGJ9QIB4bX6l
         Xl1WsEcrCWXFebX6rOjCpQWq68SQPGD8yd0eV7YrwrwRfthm+qqJ+0sEVCoCpDa5pSl3
         Kl8FsX46jh2CycJjApTTqMSPPQ+X5ejSHE8XjjYGtDpKBOmGtim8wDGXZ0VxIZvZsSKP
         kzWmwcbvMmZv/iMHOmm3BDyWP77yvAMUra9onJSTNmj09wIZufJK7WU0xRTfYdpUhQVR
         q2x5ZfQfMM60zny5ZvtNqC/o1yyprl7Jmga07pmSK1ic/CmL1PIc+qtLMja849IJfj2D
         8J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9RckfaOyTf+xFTNPpwPEwsOHKNyfyEU38Mp+/sU6tA=;
        b=lqYzIRw8VSJDtPN4DAAxirBMerdRMDMDgEBr2FrggMgw1RahP+oMOkj0QsfzTUuAgz
         N9Wgr7BY3ibyanFHicx+BrcIgW5UEuOpTHaY+kQgVxgxJI6ni0lpP0eERrjhindF64Xs
         dZ0/LmK+lPoV8wY8sG/xzmNbghujgU8nBYYzDbQnnlPPAP+E0//a9gAw/JryhQJGXDeo
         TQhOtydt3Ap48nRPgOxfur4O7gA/0TB78mVAWzHA5/HF6yxrAP60cHRSqio9ap+EMIHp
         50l1w7tsv4BN2KXH5olH2FL0hVeHErQTP9s9KKLzFhIa/xkRuAUipwdEjDrWjrr9stwS
         Y62w==
X-Gm-Message-State: APjAAAWIQ97wGkMD3Ife1JCOGfpWg/VIVLgsd04ZAI94wGaeqamCuFrr
        c5xTsTKvDriIix6BOZWvgS0=
X-Google-Smtp-Source: APXvYqznsTQ083SoPXMAQSzFkUgHLRBwZDotN+YfrQ5Yrk2chJVhMIt0WSVTLDIFdzCKIsWw+3172A==
X-Received: by 2002:ab0:3499:: with SMTP id c25mr12364917uar.56.1558833575389;
        Sat, 25 May 2019 18:19:35 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:34 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 5/8] staging: kpc2000: kpc_i2c: Use drvdata instead of platform_data
Date:   Sun, 26 May 2019 01:18:31 +0000
Message-Id: <e0fff0beaa24a58eee777e7afca3d5be73359025.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_i2c driver stashes private state data in the platform_data
member of its device structure. In general, the platform_data structure
is used for passing data to the driver during probe() rather than as a
storage area for runtime state data. Instead, use the drvdata member
for all state info meant to be accessible in driver callbacks.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 1767f351a116..e4bbb91af972 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -589,7 +589,7 @@ static int pi2c_probe(struct platform_device *pldev)
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	priv->smba = (unsigned long)ioremap_nocache(res->start, resource_size(res));
 
-	pldev->dev.platform_data = priv;
+	platform_set_drvdata(pldev, priv);
 
 	priv->features |= FEATURE_IDF;
 	priv->features |= FEATURE_I2C_BLOCK_READ;
@@ -620,7 +620,7 @@ static int pi2c_remove(struct platform_device *pldev)
 {
 	struct i2c_device *lddev;
 
-	lddev = (struct i2c_device *)pldev->dev.platform_data;
+	lddev = (struct i2c_device *)platform_get_drvdata(pldev);
 
 	i2c_del_adapter(&lddev->adapter);
 
-- 
2.21.0

