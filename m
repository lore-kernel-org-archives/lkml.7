Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD56C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA7C2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfJNYorh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEESci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 14:32:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38668 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfEESci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 14:32:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id b1so9619232otp.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ilroapXDZkcgk5LucRhth9os/NqqUQEKzo0yx1KZYRo=;
        b=RfJNYorhTyUqNvcB2b+P3AIoGlP6lRmXUAHZ/CiZ869NeU+SlkD5290+FQTO/nyu5p
         bGHEKeQc11KCQ3rocBVuUrZxWHaTD2KZdj7t3tzUqJgcbATTm7/stJdnLfyo7vY3MIFL
         wjan400FVTh7y42DzJCuoFx/FCn6aNgXGP3ZpZa97ADiRw7NQEe/6j6oFm7h7PPIsxkT
         PVl/X8F8xgFWhAstmGfad4YWEhYeLF8eHPgqv4nn3yr2Cw2y9Ydm9Ne3xDb4hinpt5nY
         JQ7KMM/DrrXSOHdl/ojgYH7YpwQntQcYL3ifw7PD+GrAm0AE1ZmtPO4a/kBfx2FI32K8
         hDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ilroapXDZkcgk5LucRhth9os/NqqUQEKzo0yx1KZYRo=;
        b=Y7yT7XReGfRUOmn1gXuHXExiRqRJ1TCtJp+J9/rCBDjs1YcXu/BHtnm8iHLjjFTdjd
         /amF1HlX047N/9slDyXdnzTPe7BgFKhXqAw39KEYdMAHJPxZSWGncDVt/8Uo5I8pu2qZ
         02dVbPq8ZK14T5NIyJU0AfSVA/2SuAJYkItoLnnl8VbMS6voH/n1nIEAygnoHlMll7a6
         +11ztWHIQqU2rPprSwruuH0YS6DJ0i3aAFc+hJFkMLN5KLBOFoqHu0E3Kx7l6eJ64CD1
         rankPdj9qkX4BfNP8PuDIpxFrhl4/FlIYPj5ElACJ7tyvoVNA5vVh12I40uPr1OFS45l
         8X4A==
X-Gm-Message-State: APjAAAVi3MlLcfb3CsuSBsxasLsMGocFt6XCY8NNZ3JLNiTEGRu2zu/A
        r/62HRmiPZp8Vukqvm6K1tI=
X-Google-Smtp-Source: APXvYqzUwAaGV2anjaIH0cjG/BmFIT9iKjLTsohmrgbffWRrshQbNhsG8W/KaReY7S3ntgA9POplAg==
X-Received: by 2002:a9d:4d03:: with SMTP id n3mr10942297otf.121.1557081157299;
        Sun, 05 May 2019 11:32:37 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:2897:6cea:c841:53a2])
        by smtp.gmail.com with ESMTPSA id e9sm4093787otf.48.2019.05.05.11.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 11:32:36 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: kpc2000: Cleanup in kpc_dma_transfer()
Date:   Sun,  5 May 2019 13:32:30 -0500
Message-Id: <20190505183230.24505-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary typecast in kzalloc function. In addition to that
replace kzalloc(sizeof(*acd)) over kzalloc(sizeof(struct aio_cb_data))
to maintain Linux kernel style.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 5741d2b49a7d..c24329affd3a 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -57,7 +57,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_transfer(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %ld) ldev = [%p]\n", priv, kcb, (void*)iov_base, iov_len, ldev);
 	
-	acd = (struct aio_cb_data *) kzalloc(sizeof(struct aio_cb_data), GFP_KERNEL);
+	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd){
 		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
 		return -ENOMEM;
-- 
2.17.1

