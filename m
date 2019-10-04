Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B09C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA510222D1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHm78qz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfJDXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39088 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbfJDXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so3804068plp.6;
        Fri, 04 Oct 2019 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yjj0ewSKx7ox/yYkfSTVMnTAWZ/lGeFABqgpIkt08rk=;
        b=IHm78qz1FqJlfD5KHvJKh8yZH1kmSAMJOhY/m7kn/wgS59HqfD/mlsuCAzu80QtdP4
         3Oefhce4mgHkrz1BBJL9/EsEWGTt4bsanbjiY7ppz9IoNUDa5AHPJlHrZbDuhaaksMMO
         Ybxo+73VJ2ahMp98dUtcjH7EpFYwxMbZjkf79LiERlMchltrLUNqlYPY+L1K1H0jHbSz
         CYsMH/zevb1TOWy9suUdD67i/HMV2ObeJsh3nfU1oY3wBI1RFtMjYMvDtiDl0Iq1YMz9
         5V+dBf8JSaCpu8OwemItAY+VpIab4GX2swklN06exySTl6uwFtFIiFR0csiZBm7hfE1u
         RM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yjj0ewSKx7ox/yYkfSTVMnTAWZ/lGeFABqgpIkt08rk=;
        b=kZONWgRQCcY8KDiW7sGkEztDppoEyOvpocHN1mWLAxpk/Ewd8mL/+yYDCJgY6gYaEq
         0dH6nLOD/yFHt5hl9gJx7H2PNuh+yQpiTgElJN1monW2/JXb6Setx82UcWqi5bEx3bgR
         yOSnp+N0+dvTyFWAykxXMNO2ebLHFMfDj/ntEOfvNjPP6fslQZl1JtuktmqflJ8HBr2H
         7rY1hmSyLnjmsWIf4052YsXclA9pmOEofG9c0Up5ske/ngcWLgJNQNOc+jBZbELj9tV5
         3suxqLlKDq2kKSdNp/XkmOC221alWsTg7AoQE0amc1n2+wn9ZgEh9tTlSmYfx30g3auX
         dVjA==
X-Gm-Message-State: APjAAAVwqewGg229vx9gVw6K7+fsZexjZEy6cCzL1U44k5tdzzl5fLUz
        kALEexS27Prp4eGx7SVD7aQ=
X-Google-Smtp-Source: APXvYqzLakY1ydYvGFKWS4SDddsfkd04iJuPWj6lCDzXCZSQ5YmsKi4iqDwSdZSOUfocNuyoYMQ78w==
X-Received: by 2002:a17:902:144:: with SMTP id 62mr17717673plb.283.1570230622173;
        Fri, 04 Oct 2019 16:10:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/7] regulator: s5m8767: switch to using devm_fwnode_gpiod_get
Date:   Fri,  4 Oct 2019 16:10:11 -0700
Message-Id: <20191004231017.130290-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_gpiod_get_from_of_node() is being retired in favor of
devm_fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/regulator/s5m8767.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 6ca27e9d5ef7..bdc07739e9a2 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -567,11 +567,10 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			continue;
 		}
 
-		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(
+		rdata->ext_control_gpiod = devm_fwnode_gpiod_get(
 			&pdev->dev,
-			reg_np,
-			"s5m8767,pmic-ext-control-gpios",
-			0,
+			of_fwnode_handle(reg_np),
+			"s5m8767,pmic-ext-control",
 			GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 			"s5m8767");
 		if (PTR_ERR(rdata->ext_control_gpiod) == -ENOENT)
-- 
2.23.0.581.g78d2f28ef7-goog

