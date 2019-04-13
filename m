Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B782082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIgkT+K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDMKd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfDMKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so13871880wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HFxhlSMGmt73Fks3d5v20ZqWJxUvbBfIUfs8MQCvBk=;
        b=MIgkT+K+CIelmZXek3CRx5ESHg9VavOzjKeiM53SmsqVX/UDtdLuwqWqBVgH7n4fHP
         0ZyTJsNtGRiiQTOoactRu8iXl/cqIX36XAT81q7VfLDM33Z4+bVemaAkHbE1CyRO/Ng8
         XXhJIheYP36NDj6THd3/L+E5P8aJj+fO82UmRN1tz9IiGX7rDGa/tLlChpg7RGbAQv5b
         1NAhyGmwsMChClgwH/sy+a+Xb9TCWHTJv3vki/sedTHm6vLi6i8Ypev+OhAMWqEEEY6t
         V2CAIugISYR8u6Dkg5R5ijbG4Q0LQspDGPFY3XlQ1pATzIIhNwRiktDgIBfbRktgC6Oi
         Drww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HFxhlSMGmt73Fks3d5v20ZqWJxUvbBfIUfs8MQCvBk=;
        b=RUiV3FE1JQT4m/Ufw3aYEDdyqSS7+NXABX6VYlR7rVYAVXlnWNRhZxaK3vy1EDon6v
         yNRZifu9OPSFWzRRux9EeR30m1NWIOkcVAiYMvswJ9NyVzdki+5JRkV4DTfki7I3gBc9
         aTI8utImCu61p6pgGq6z7sHOT59XFdpmBKrE07KnUWuzUlsIndqNt6Nf/c1oE3xUWg3V
         ZTvTPqvBNLDO7MenU/i3vGYGwroGEjmPrnisfnmuJywq0OcU9lG946v0n4ugm9pBHNUl
         FzaYPznhVOrsONDWG+DBmVA0LWBOhGhgtrORoPtvE68InyFGUvBGCBdBSzlxBpZFXKoO
         AIEA==
X-Gm-Message-State: APjAAAWpLzf0tik25/KM/1uFdVCkVvwEXBzdaJZ8qtRHvbYBxXjyvNZa
        43206lr6kal4E9wPeofsvXXDHA==
X-Google-Smtp-Source: APXvYqzxsOWy7ZUsBf+GkHIOlifZ2bd2LgLtg6hJgMA3DY6LNslKsQmLkNXF2bXvLG50WG/q+c3s4g==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr15066457wml.110.1555151596244;
        Sat, 13 Apr 2019 03:33:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 08/20] nvmem: sunxi_sid: Support SID on A83T and H5
Date:   Sat, 13 Apr 2019 11:32:53 +0100
Message-Id: <20190413103305.9576-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree binding already lists compatible strings for these two
SoCs. They don't have the defect as seen on the H3, and the size and
register layout is the same as the A64. Furthermore, the driver does
not include nvmem cell definitions.

Add support for these two compatible strings, re-using the config for
the A64.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 14c114620ed6..e7936380ce89 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -200,8 +200,10 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.21.0

