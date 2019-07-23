Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31118C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABAE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEWJN/qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391194AbfGWRnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:43:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39341 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388703AbfGWRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:43:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so29914397lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFTwoXxJunT2kH1Ot9eM9+cX7DrsPRtBTLu8N/TMz/U=;
        b=eEWJN/qpGbjQbRIR4evYZVPpITZL50hcxujFO284JFDN+o3or8Ykgaev/bDTqBYMLO
         FftCk6Gh8j/cq3c6CqHei6MWD+r+FFxRv+qL1ans9Hrl9BASeuwVTOpQdjCUEnI87171
         5vj/zAmE13otAcjYNbvKgxwG9GjkSvDR5tpE/EBMgTDGgJTVxCJ3rqiACh0NcP5TW0iO
         CnrcSS58UKLgrPdijY5tHH4QdSvLbqMaArahKdXEIEC/bHdvqMdFy8K6WE7gyI8RhZCH
         N0+UKXtR3D3+5DTbSBhiaPoMOQZy3kZ5LRjVWJuiv0MYvsl612AvoHtkxIcK7mcLNWpH
         g2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFTwoXxJunT2kH1Ot9eM9+cX7DrsPRtBTLu8N/TMz/U=;
        b=im7ZuSAf+WuVRjqdKm2ap4qZgjLvB9eoe+dumNdmIZkr7+Lh0l/2+6MJEoZbu36wn/
         s++p89YRjE5IoCAiNPSD0WfV8dGOreGJ2tHF5gc6w220oz8EahfxuaIK1CuCykUtIWGE
         sbJsjbGyhr5ZPAuw/piZlrRvC1xFjVazp84yDq6b6JpAgFT0ZEXB0I/EHaf88lSz7izS
         ZRyoF56A6lC/RoMQzBohSPn7qEzX/soUH5I1eGqi2Fsk8aQs7CZGAY7xGFHJwEoKAaTB
         yD4gd4RH5BfHs6H5ScnmYqC2rf4xl1te5Dmm2Rp1QTc2QpCCN54DWofXR+wybKqEqNgQ
         Q09g==
X-Gm-Message-State: APjAAAVHhEEAddlKJeCSbYVm6OytdNG8f8mrZ4etyWU55RCgPhOw3xqb
        PfDtPZL8ZMx5WuMWOh1Tnqdd0A==
X-Google-Smtp-Source: APXvYqwd1iXuZOIg6pMeytpJ6SoWUlo+7PrxeBtnYDqZeiCllLeRrRdw302zNWrWvjzA+NmGjRjMuw==
X-Received: by 2002:a19:e006:: with SMTP id x6mr35088127lfg.165.1563903819260;
        Tue, 23 Jul 2019 10:43:39 -0700 (PDT)
Received: from linux.local (c-2ccd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.44])
        by smtp.gmail.com with ESMTPSA id j7sm9042247lji.27.2019.07.23.10.43.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 10:43:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mike Lockwood <lockwood@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] extcon: fsa9480: Support the FSA880 variant
Date:   Tue, 23 Jul 2019 19:43:01 +0200
Message-Id: <20190723174301.31278-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The older compatible variant of this chip is called FSA880
and works the same way, if we need some quirks in the future,
it is good to let it have its own compatible string.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt | 4 +++-
 drivers/extcon/extcon-fsa9480.c                             | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
index d592c21245f2..624bd76f468e 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
@@ -5,7 +5,9 @@ controlled using I2C and enables USB data, stereo and mono audio, video,
 microphone, and UART data to use a common connector port.
 
 Required properties:
- - compatible : Must be "fcs,fsa9480"
+ - compatible : Must be one of
+   "fcs,fsa9480"
+   "fcs,fsa880"
  - reg : Specifies i2c slave address. Must be 0x25.
  - interrupts : Should contain one entry specifying interrupt signal of
    interrupt parent to which interrupt pin of the chip is connected.
diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index 350fb34abfa0..8405512f5199 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -363,6 +363,7 @@ MODULE_DEVICE_TABLE(i2c, fsa9480_id);
 
 static const struct of_device_id fsa9480_of_match[] = {
 	{ .compatible = "fcs,fsa9480", },
+	{ .compatible = "fcs,fsa880", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, fsa9480_of_match);
-- 
2.21.0

