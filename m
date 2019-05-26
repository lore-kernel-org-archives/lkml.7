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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B44C07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B439214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK9zCXuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfEZBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38191 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfEZBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:39 -0400
Received: by mail-ua1-f65.google.com with SMTP id r19so5156523uap.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O4TY6lVCDE5e3lbqqtqZwzcYY0g62xMcUAnXDxRopto=;
        b=OK9zCXuqb2djYDyd6tLcFwsKQD41RcX7VBWl454bvT3DwmHQaWZXkPSYvQWivHUQ4J
         lKHW05tV/IHf2Wtdn6hSnUJb2WsteoUDePbISaDGPoOfPbYhnnZDxyFHFS1gK9b8K0ZA
         NqNIywDE5xkS4K9MNns18y5oWkQZvcA/ZATlu+31GbsqCy3JxOGPiVS/OOpS70yLIj1W
         KqlPFQ5I90ZUQBA7OY0fV6/YWoObZ0pJjxwaiYkeXXxT38YagZK1MLRPNDYCN+BDrMpv
         4R2eSVoTRh2mHl+jPeH0IGRkGx7EMLLLnvYcoMj78J64rXlo4Lne1lTWFXx3btdV6gOZ
         DXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4TY6lVCDE5e3lbqqtqZwzcYY0g62xMcUAnXDxRopto=;
        b=I6HwEi0LgVMtGMRbpcxdGvGzOGxLLFowRpNdWuZV7RNwicUxFvXglTxOkpW85HWTXj
         ALkHU0FFi/PXqGN9OYOfVXmqELl1gttw7mS32Eg78JLrmk44RAwQcdH9d2bzz4lGDapu
         c91ZpzTATheo6hOK47pSAiEOZkk/T2Hr8qYRI91PdLcwJwuwyzK++ce0HR8ccY+fmex7
         gID7IgWSoUG3FRukWDrZxhiutOfKiQwtzrTGNRi1pLmvyaJ4W2uOsGMDNEi3M2oE17AE
         TrD7UcBTXHegrOLawRO3WnC43apidKuJo8smnKTZgRnM6JOnuk1hj04DhCrQRg0mOQYl
         d8NQ==
X-Gm-Message-State: APjAAAUJ440v1RaU2E74WwOgLj0jom5XOarHvvH+1CnOH2nzcgAUYskL
        T0u7UicD2NQti0k40/nyFCo=
X-Google-Smtp-Source: APXvYqyl1JiI0IAFoWqSmmtNqKCx8TUL6ac2FkOU5CYEe6YzGpCcERinHIWKjJwefADpXDDOc7U5Zg==
X-Received: by 2002:ab0:338e:: with SMTP id y14mr3818484uap.39.1558833578405;
        Sat, 25 May 2019 18:19:38 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:37 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 8/8] staging: kpc2000: kpc_i2c: Use devm_* API to manage mapped I/O space
Date:   Sun, 26 May 2019 01:18:34 +0000
Message-Id: <c0c8589d9daf1f11f35a41e24ba461b3ee569a5d.1558832515.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_i2c driver does not unmap its I/O space upon error cases in the
probe() function or upon remove(). Make the driver clean up after itself
more maintainably by using the managed resource API.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 51e91653e183..a434dd0b78c4 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -590,7 +590,9 @@ static int pi2c_probe(struct platform_device *pldev)
 	if (!res)
 		return -ENXIO;
 
-	priv->smba = (unsigned long)ioremap_nocache(res->start, resource_size(res));
+	priv->smba = (unsigned long)devm_ioremap_nocache(&pldev->dev,
+							 res->start,
+							 resource_size(res));
 	if (!priv->smba)
 		return -ENOMEM;
 
-- 
2.21.0

