Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFCD20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA29vNTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDHVne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfDHVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so888436ljg.3;
        Mon, 08 Apr 2019 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KBWTMEMtRtwMsmta6uI9Ct0NHdu3EaaYE8CORm6INI=;
        b=LA29vNTytL0sLNYaMiFFsRIL/lSZMN3uwNOF3pEDmU7OwoDOl0KyZ9nfn6KnAzvjtt
         3wMhrqdJ3TCCEs0IP9l3jCZjYGzB6db1fVqZBxTHym4uEcL1tUEKiikqhMprBU303zQi
         7QFKiq1KcRgOMJ0yNbdtgduq/r6Iq6KUp76K+s7PaeWooX37khDiCwUgAbblLifeqkdx
         tEJ9qle158Gk0gp+OgtO/pVPo0gbzI/Q8MppbeP3ndxtdiR/D6asjQrUTgNUu4fDImHd
         cUb9YAznrWn8nhp3Wkazc4pUenkQBEVO6CHKHQxqUFPkqFhkOeL1BYIoSUbh1z1cKj4+
         ixGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KBWTMEMtRtwMsmta6uI9Ct0NHdu3EaaYE8CORm6INI=;
        b=nw7h5n/HPJEYTU0yh25qDm1GcO+K2ztllPqgawgVm/nF4wXedNKjuO7L8U9a49J8pj
         jY3yKBzoQ2vHZmj0QwNxjDAnxu21ey8oaFUIqx6jfW97dZPbWuq7S4TMrxJA11G00s/H
         EGfdsmLszpJlpA8DkyKfcar1cs9PHBE2T1Rvvu17reyra2YVT0LFp4dYbS8pDfyPTYuG
         OECC90nGcRUhkDORalsQazhE5zu1TGwF7DHIzSrFyjuqPx6omLFrYSPuVWlTQ9DB9ieY
         COhCfGDTyonzK4deKT/X7d2S5b8AhM6jf8eQbuWjRxftZLr4dYjywhlah/8O6nA3yjTR
         sanA==
X-Gm-Message-State: APjAAAXOI2e+ouVU91SlI5wR9KO8gPVwCccqfsTmObgLUhBVycPTIE8T
        70kLqk2pT1ri8jyQ4U2rOBE=
X-Google-Smtp-Source: APXvYqyuu4ewWklTqwI/KvE07ZiNVBG3SAeOZrAjin8lu0uhLSJ5KjxskcBtZ5UQOUeJY1pu9lfU+A==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr18254086ljc.105.1554759804177;
        Mon, 08 Apr 2019 14:43:24 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:23 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 14/14] media: ov6650: Fix stored crop rectangle not in sync with hardware
Date:   Mon,  8 Apr 2019 23:42:42 +0200
Message-Id: <20190408214242.9603-15-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver stores crop rectangle settings supposed to be in line with
hardware state in a device private structure.  Since the driver initial
submission, crop rectangle width and height settings are not updated
correctly when rectangle offset settings are applied on hardware.  If
an error occurs while the device is updated, the stored settings my no
longer reflect hardware state and consecutive calls to .get_selection()
as well as .get_fmt() may return incorrect information.  That in turn
may affect ability of a host device to use correct DMA transfer
settings if such incorrect informamtion on active frame format returned
by .get_fmt() is used.

Assuming a failed update of the device means its actual settings
haven't changed, update crop rectangle width and height settings stored
in the device private structure correctly while the rectangle offset is
successfully applied on hardware so the stored values always reflect
actual hardware state to the extent possible.

Fixes: 2f6e2404799a ("[media] SoC Camera: add driver for OV6650 sensor")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 001457d39742..cffe6aa906b2 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -500,6 +500,7 @@ static int ov6650_set_selection(struct v4l2_subdev *sd,
 
 	ret = ov6650_reg_write(client, REG_HSTRT, sel->r.left >> 1);
 	if (!ret) {
+		priv->rect.width += priv->rect.left - sel->r.left;
 		priv->rect.left = sel->r.left;
 		ret = ov6650_reg_write(client, REG_HSTOP,
 				       (sel->r.left + sel->r.width) >> 1);
@@ -509,6 +510,7 @@ static int ov6650_set_selection(struct v4l2_subdev *sd,
 		ret = ov6650_reg_write(client, REG_VSTRT, sel->r.top >> 1);
 	}
 	if (!ret) {
+		priv->rect.height += priv->rect.top - sel->r.top;
 		priv->rect.top = sel->r.top;
 		ret = ov6650_reg_write(client, REG_VSTOP,
 				       (sel->r.top + sel->r.height) >> 1);
-- 
2.21.0

