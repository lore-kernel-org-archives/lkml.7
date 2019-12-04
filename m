Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05632206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AE0BRV5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfLDXVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43112 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so1240699ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl8V4L186TosF/Foo+q0QrKTNn4dTHR6LIi9ACqiBcU=;
        b=AE0BRV5bLa+uNHAmKvhtTBvjE80e4SGtol/mGUZwRXzmA9JbICpa/9qcgzzUtLz7/M
         9j4dSuNkgY7Bmzcpq78KE7Ss8vruQEIoUqSOyyqle9kuADuWUFtK1lgwhUB3DjU1DTz8
         2Ysvd7vuFYaTyCI2mu2If7sx7doKGn7Mvw42bcbAwp7eZjbuBTjd6gfT93CXR2ux8PWh
         8YK7wvYDnQh+cjQS9SDg3qRDLbAkRspbI3QIL32RBl3wuYOPKhF7sBW52xTU/qylgda8
         gQwg6IDikZDt4i32x8F98uAyPY+J5nB7Gge0GoE3bIOKkn+3WW9wcZ2trO/Q6xMQaAih
         0I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl8V4L186TosF/Foo+q0QrKTNn4dTHR6LIi9ACqiBcU=;
        b=euwP1ghw0PueesvOKWYhdo+9FSw0PIIjM1zForJxdv6UkgjgM9M7upQJ4193zoAIMX
         Gl9vO6IRtbWVe9lgQza+j7lCaCarvEmisd4nMaRUkZ6ZQa/mrf7DT247TWmrMz3HPcYv
         xrb4IDgnwR18Eld+jT/+rStjLwaNE3J+oshb1iZULfwHakh8e0dBEhcwLW9uR+fQL7HE
         8lnzx992Xa+kEaKuJ5au0UIv4cB8d1HPNlSBb7ujIM1wXW2zJIYYGepuFfyHFqA3hCVp
         JRKB8/0T6PKUFOE6frvWIcPTKLNjqvcTx8huSX4ptQ3AEQw9kt138d230G8ImomyraUO
         fUGA==
X-Gm-Message-State: APjAAAUYsnD0kkgPUkMrPjktcjMnhld0AmNNxNRZXMv3pUv/9ldrS55x
        ma2+rcPxdxkRk5kADOm5MEzeIA==
X-Google-Smtp-Source: APXvYqx1jcCUzhn2w8sQ4CXIhEpr80go+HYVRZUiUrM0uEPJqXQgzz8JzMZV56rRJDJwjmYFPAI1pQ==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr3599265ljg.154.1575501701983;
        Wed, 04 Dec 2019 15:21:41 -0800 (PST)
Received: from localhost.localdomain (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id q186sm3975832ljq.30.2019.12.04.15.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] mfd: motorola-cpcap: Do not hardcode SPI mode flags
Date:   Thu,  5 Dec 2019 00:19:31 +0100
Message-Id: <20191204231931.21378-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current use of mode flags to us SPI_MODE_0 and
SPI_CS_HIGH is fragile: it overwrites anything already
assigned by the SPI core. Change it thusly:

- Just |= the SPI_MODE_0 so we keep other flags
- Assign ^= SPI_CS_HIGH since we might be active high
  already, and that is usually the case with GPIOs used
  for chip select, even if they are in practice active low.

Add a comment clarifying why ^= SPI_CS_HIGH is the right
choice here.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/motorola-cpcap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 52f38e57cdc1..a3bc61b8008c 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -279,7 +279,13 @@ static int cpcap_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, cpcap);
 
 	spi->bits_per_word = 16;
-	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
+	spi->mode |= SPI_MODE_0;
+	/*
+	 * Active high should be defined as "inverse polarity" as GPIO-based
+	 * chip selects can be logically active high but inverted by the GPIO
+	 * library.
+	 */
+	spi->mode ^= SPI_CS_HIGH;
 
 	ret = spi_setup(spi);
 	if (ret)
-- 
2.23.0

