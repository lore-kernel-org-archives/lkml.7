Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE52C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB312183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh4q9a5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGBH5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:57:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41652 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so5798954pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cBz2esjAGHDv5oNR3Gt+pAymeOEUEv2r2YyR945L164=;
        b=mh4q9a5VqQnLxuODkf0zwc5aOYUw5JWp0wsXLCuIh3ZXUQYJBphq4izbBLqiAwFkFa
         eHfpdDmj+thuBjFR0vxcru0lqwnXpe2gOlnLj3PpRSoMJGkg/lNC9ymbU80DJGMSe4vX
         O6fIJWJ1TUK26BOFRMLIxn4Fa5uCMTik+HHEkw/5dHQKJ+yfogtOfs9kdaG8zMvaSqa1
         NV3OW2RLrnCobWkXEX0k2zoVXP9jRFsa9+f4PrS0d5QXwmmpCyyrgkB5yXw0LrCDUum9
         CwQenQZ8JHz7cbkWIeTmNolLk00mRrs+An+/KTqbbyAxsv9xi+KNK/RALEtX4CLQZE1S
         in4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBz2esjAGHDv5oNR3Gt+pAymeOEUEv2r2YyR945L164=;
        b=SXHNlgAH5hzhK+9JxASAS2A/XUnXCzwlwzH3Zx0E4KkaEJNinxBm8weFXMtXWm5T6V
         K6ZgUTctValISGR/guFp+zJb72xEccgrUpHFqppc5WRLgBOCCMAWcCQvbtIjknPrT4xQ
         RRcuKLqAqD5KSDpUzYn4DfZPTwfF5Xy486GlXfzvGeHHkErvd9djrJ1yZB3jEOwXPIW8
         KmKs+yhv4jJwa9ujvHlKAaUWFge+mjfzzk5MCP3BdxLPoRWdCwichzWAobgtIydRAbvO
         Wb/Yk7HDQDw/6IGfZrIiFt2DxNgFK7Qe79KQi19+7eDpYKwbTFFiluWn2PDtsUENdVXc
         tRQQ==
X-Gm-Message-State: APjAAAWykvurJW36Cc+TK3zVAFcJa9IePDRwZElPgrkfIkzocNIOW8Kk
        rk/H9MY0bm2HBsKaNAJfc0GAMWqYfoc=
X-Google-Smtp-Source: APXvYqy40KC+epngjxncQjdTBVb97kttq5SKbNk8khgkjLhBgCy4Ff9lIxTgwFC1Sk3gJtNKvsAdzw==
X-Received: by 2002:a65:4347:: with SMTP id k7mr29588804pgq.253.1562054271025;
        Tue, 02 Jul 2019 00:57:51 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 2sm13815753pff.174.2019.07.02.00.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:50 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 08/27] i2c: busses: remove memset after dmam_alloc_coherent
Date:   Tue,  2 Jul 2019 15:57:44 +0800
Message-Id: <20190702075744.23881-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/i2c/busses/i2c-ismt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 02d23edb2fb1..2f95e25a10f7 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -781,8 +781,6 @@ static int ismt_dev_init(struct ismt_priv *priv)
 	if (!priv->hw)
 		return -ENOMEM;
 
-	memset(priv->hw, 0, (ISMT_DESC_ENTRIES * sizeof(struct ismt_desc)));
-
 	priv->head = 0;
 	init_completion(&priv->cmp);
 
-- 
2.11.0

