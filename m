Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14105FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA552067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebMtAJuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfJPMGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:06:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so14165837pgl.10;
        Wed, 16 Oct 2019 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F55Wt5S26tfWJ9YDzUSzM52fARPw99KqXvjlrC+Fh3g=;
        b=ebMtAJuQlngR44Vl7KMnrR+dFZ+Nrj0hqzA0pmoxrQ8fVwoy255CC5iS0TkYgBwldj
         1m3eTLY6SrRNaEqZ7MkV9cv+dsAMAtEqRo1JYYHlcam860EhPfAKxCm4G2fEYaTFd2ld
         SLOM7PU99kY8AySQ+cDC5EILWMSetW3CPlzjMtxg6KBdRF4uAE1YTqzrjhaj/g/0LAOa
         b1FthkhUXBwClscDHg6Z+svRgzOjTJDTpTW+kJ7K8uBlMRAFCGc8wAQS8v9SZhVAFHKC
         j2/Yr9DE8gNtE6qOMdGyiqDKOIb9UaRa6r1hOpGl6kpjyvrxENJKCS3Fq4go6uxUWRAE
         f1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F55Wt5S26tfWJ9YDzUSzM52fARPw99KqXvjlrC+Fh3g=;
        b=b+JNIUQAgZ/QQmEJyZISYHJna7hwILUU2hRuMIj+FHF2J7kqYWd1q3r7SZb74V7afG
         3Or4d//WIxlbec/rgF732aHlsHEzHPEcEpS6TnFh5G0v7MCLsfaxMC19Gh9kWLuHsA/i
         8WxC7Sm0KnouWHEKRxYl6OguYJDAxcbHANBiIQhNLP0GaJiq5oYMYCLc3tThtwJX3wKX
         lhTrVuS4kbBposASpUGIUwBCllHGuhMmj5qNmMj5HVskVv4YnD7hHPYx8xGq/NOP9qUC
         asdc2K0t+pSRjfF8cBncmjRJpibFP55SEVXLLsC8P2Mmpdzr6lI8eNRh5Po13jgPxap9
         f7Cg==
X-Gm-Message-State: APjAAAWo2V/veEwTqMr9eqkM6bTMaz4AAiC7xO2ex+jzbZU+IF4pJJJY
        cVO+TjSIH+Sht31eg0lcMoDeAMYUYlE=
X-Google-Smtp-Source: APXvYqw2dVLQUTIg1pKd/sv8fErPpPzrpqUTL/fKfnkVJIl7Arsc/6Hacpewc6Ec/BgLci7MAYRgfA==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr44514091pgi.221.1571227577442;
        Wed, 16 Oct 2019 05:06:17 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id j16sm2641670pje.6.2019.10.16.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:06:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] leds: an30259a: add a check for devm_regmap_init_i2c
Date:   Wed, 16 Oct 2019 20:06:07 +0800
Message-Id: <20191016120607.32718-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

an30259a_probe misses a check for devm_regmap_init_i2c and may cause
problems.
Add a check and print errors like other leds drivers.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/leds/leds-an30259a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 250dc9d6f635..03ad068f29f7 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -305,6 +305,13 @@ static int an30259a_probe(struct i2c_client *client)
 
 	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
 
+	if (IS_ERR(chip->regmap)) {
+		err = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			err);
+		return err;
+	}
+
 	for (i = 0; i < chip->num_leds; i++) {
 		struct led_init_data init_data = {};
 
-- 
2.20.1

