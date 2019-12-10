Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF06C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D46B2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vbl/HqYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLJKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:07:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37212 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfLJKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:07:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2431104wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/qds3iLdYR3bbvA/Sxj6rrlo3vwcNFPffUebEm2fbs=;
        b=Vbl/HqYiYF34szVFoZ/lOAuXg6w8DieuguG8Li8kuUfF8x0vmT8I6ofLttsisfAf3U
         Kt/TUBwsxXfpKBB/Pts1MbO44b2HkGi/FIfp3WQhPUd6gfJOu/lY4GmmC3kTheo013rD
         XzxD+e4AytfCqM2f9tkMoYc8OFIlMuv3fPoCIyDgtRlE1Kp8GK+0X/f6v204HQ5gPl29
         vrXfyXCUMiz7hrfzMCLXvDT4zazwA4hvJ9AAG6VsSVk391mlx+pZZn0EEDJuB+NQcIHy
         mSkwGvTkzrtc3y7nz+FNvX+ncXNDUADgOb+J4+o+6pvm4857taHWoyO48EAegGt+Ib15
         mF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/qds3iLdYR3bbvA/Sxj6rrlo3vwcNFPffUebEm2fbs=;
        b=reaBimt/R+8pNy/jpra1j9l/nt5H60fVfHpCVUQ3ozCm8nPjASzJPUVZkw9peGwOG8
         htGu1NQDE+lJI7dhq4wMnHgWCZrXJUlgTXp9qe67YU0fT/VKfIBXV5JeHqz/VSXZsYNw
         nZEcCajXlYyaZZ/3d/9TPNmJ0phurnQK4amYjtRzvvdO/7w1rUQfJJsNKVoqDoFHxJ+r
         D/DttclEfTDdk+fe4q/eUmXBRZKhkD028dG9S6lNZ1rXRv+jJoOPu0CgL5yaYuLEBhBs
         oKbwICKsgxLRAnztAYn93YgZGEz2aqHlTSCwKCZ4RzUNQZYgHEpruYvevJMXsMm/SCes
         udVg==
X-Gm-Message-State: APjAAAXDQOBTwWyKxgA/U2uW/MqOrq3jiNPUqSv3ghT+No/MWBQEFKE/
        kMrPbCzGpA2LRyLmdydqnQG8RyHMlY8=
X-Google-Smtp-Source: APXvYqxx+f5GIgs3DkVFmMx2x0QZrsO+/ElFSb+ShXJaUYLhsHZtS5J3Z4PxATO+JOOX56k3YYpP3A==
X-Received: by 2002:a1c:9903:: with SMTP id b3mr4020982wme.139.1575972450291;
        Tue, 10 Dec 2019 02:07:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s8sm2628622wrt.57.2019.12.10.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:07:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regulator: max77650: add of_match table
Date:   Tue, 10 Dec 2019 11:07:25 +0100
Message-Id: <20191210100725.11005-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the regulator driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/max77650-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index e57fc9197d62..ac89a412f665 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -386,9 +386,16 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id max77650_regulator_of_match[] = {
+	{ .compatible = "maxim,max77650-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_regulator_of_match);
+
 static struct platform_driver max77650_regulator_driver = {
 	.driver = {
 		.name = "max77650-regulator",
+		.of_match_table = max77650_regulator_of_match,
 	},
 	.probe = max77650_regulator_probe,
 };
-- 
2.23.0

