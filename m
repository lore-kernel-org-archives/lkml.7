Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B95C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A6720855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuPGV1Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfDEUAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:00:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39317 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfDEUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:00:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so622976otb.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xyM8f+uHzpS9/Zt3zZaRHr47xuUSkhX6ZXoAnfz4fZI=;
        b=iuPGV1Nn18rBPGMiGH2uun4idJi1BirHlST3fkNy5+A2WQEgj+iaGnWPwVXdxR/sWY
         0mr9AAbMwGu4/pPIawst4LngFS6plBtrX0LhEqOD8/vVfBlNouH3Zip3+b2ofdxyXat4
         HO3+PP5Y2i+amvjVzr1UIJbmrff2226k6hmFMr+ErAV1Uehf9hPMAW7cEJv2N/4uE2u3
         TbA2vlohFOTvPyit6kuw85QfKIvRq/6KXBlrY6tkB7tXJeR0RrcZ/LU5pMNTeR5gldpp
         VvNSD/USWUDXlaWYbk5lTdItVvLgzLQZIJgwM2Ip1xhcszi+gUvNjrh53orWfpMFTxlj
         hcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xyM8f+uHzpS9/Zt3zZaRHr47xuUSkhX6ZXoAnfz4fZI=;
        b=D48bA2hIZGIJuLLxIL/Wnl1kPvqnXNJc1gxPu7ksBTt5QLlr0M4E4cXgzhoq7+3qwF
         Vh8xdm2tTn2s2DkADqXMTfVT0C+mftcvPbtQSAqcnboVSO/jM7jXXJc+uUqz4Ubu5utS
         SsgxT/7G8JckmUWmwgIX3LyH4axnwZygnVk7gDN3lpszrurkolCB921X81hJgD5L7tKy
         aWU767ClXAoh2qSdfx/FW8vDZi6VuYGojTvDbq2JSVHfyaCKzLRyNkP+11l1AMnRsAOZ
         V9VOAnbQwzaMzRcCxi/v6UocWazl8lNvzweugekybYOcgZgTs/RdfQPkyZnenv72r8IX
         ByUg==
X-Gm-Message-State: APjAAAXp08gqZabKG+oS5t27DCFOl9NuQrBedYLg1gHlky09ex+2jtZt
        p+cwGX+e26UfPSPqgN1XuCU=
X-Google-Smtp-Source: APXvYqzZrF8nmwHh0/lNFWh2zI4mH6SU7eoHwgnoi/eUcmT1J5164MIzP91+1qmd1qdOdamKNU9v6A==
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr9564876otp.89.1554494450040;
        Fri, 05 Apr 2019 13:00:50 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id s21sm7595849oie.53.2019.04.05.13.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 13:00:49 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: greybus: Fix spinlock_t definition without comment
Date:   Fri,  5 Apr 2019 15:00:46 -0500
Message-Id: <20190405200046.20600-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spinlock_t definition without comment.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/greybus/connection.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/connection.h b/drivers/staging/greybus/connection.h
index 5ca3befc0636..0aedd246e94a 100644
--- a/drivers/staging/greybus/connection.h
+++ b/drivers/staging/greybus/connection.h
@@ -47,7 +47,7 @@ struct gb_connection {
 	unsigned long			flags;
 
 	struct mutex			mutex;
-	spinlock_t			lock;
+	spinlock_t			lock; /* Protect structure fields */
 	enum gb_connection_state	state;
 	struct list_head		operations;
 
-- 
2.17.1

