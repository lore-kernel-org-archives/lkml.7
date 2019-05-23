Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA9B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFyJpB5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfEWB1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:27:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41955 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:27:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so6580830edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OIHTvEQdYAT7parJfvOCQF8jycaX/hwhP45kc7zzD8=;
        b=tFyJpB5lgIsBjdsnchURs68gF8OtIzlsls5SgWsBO71Vb9bikvj1Pb4Ays6SW+RZV6
         7j3FoAF3hFCKN39t4oLxy06r7U8tCXPkAO7UIAOIrS7DOqcSD562oFPD61ZfoTUjZVuX
         k39pjz/w/MqS21O445irbLNloMb1bq64PFrRh5IdhRLx66OS9+Jp1ujQDLwY+4kyQWgU
         m/e3F7WfJhZb/pw2+xNS1PGzyOk85H07g5Mz4uF1ilJivdJMJxrZpKNWlaDoNj7ZFGnY
         7GzgcpxxsqCl1w0nbIdg8BJwCVniv4KDWEU3XbnhQjUzUpUuaW7HvCAioAHB8eexLcMr
         SIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OIHTvEQdYAT7parJfvOCQF8jycaX/hwhP45kc7zzD8=;
        b=YUalWiu31q8mCOjekyTFGZQMwlrck/yxQFeZE14wD+DXtGRgTEvYVj+MSbV5DEfqaG
         s7onuBUDIa/fLX6PJw6rnJIGGnMIXLrwSs/jFbMxagtCwWycwNJIVKhQOFUCCerFWG98
         JCP5ltd8VgFwko8JVFR2uW+jiLjYF5ZkIuYLv7Ioq3fhmB5sVqHaQPmByMgWr3aypRLb
         dICHJMv7ZGvOsv9hhfqpVaLM2o1Z1AI3TRjt6fGOhPm8fJP3BHGhi+RjHdJ6kXBF9pNY
         8fydAzxc6NQR5iMTZIwh/Lcy/IUzU7oO46FddesZRMNAYsRIzmjAA2DppSO/uOwkaD/D
         pUuQ==
X-Gm-Message-State: APjAAAXYXeg4QpWLrQK2hiOZDH4I+njlby7jGhiIab/NNvHHandTwJRF
        KW98pNCH+k0bnXUmO2C8n6s=
X-Google-Smtp-Source: APXvYqwOesDE0osH+J6szkSgQoaBgI/q6nvUX9TTS5NgIBUoO89FwoXvWh+F/wDyNw2kcvT543WHFw==
X-Received: by 2002:a17:906:b741:: with SMTP id fx1mr21033280ejb.45.1558574825808;
        Wed, 22 May 2019 18:27:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id h23sm4183906ejc.34.2019.05.22.18.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 18:27:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] regulator: max77650: Move max77651_SBB1_desc's declaration down
Date:   Wed, 22 May 2019 18:26:29 -0700
Message-Id: <20190523012629.7707-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/regulator/max77650-regulator.c:32:39: warning: tentative
definition of variable with internal linkage has incomplete non-array
type 'struct max77650_regulator_desc'
[-Wtentative-definition-incomplete-type]
static struct max77650_regulator_desc max77651_SBB1_desc;
                                      ^
drivers/regulator/max77650-regulator.c:32:15: note: forward declaration
of 'struct max77650_regulator_desc'
static struct max77650_regulator_desc max77651_SBB1_desc;
              ^
1 warning generated.

Move max77651_SBB1_desc's declaration below max77650_regulator_desc's
definition so this warning does not happen.

Fixes: 3df4235ac41c ("regulator: max77650: Convert MAX77651 SBB1 to pickable linear range")
Link: https://github.com/ClangBuiltLinux/linux/issues/491
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/regulator/max77650-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index ecf8cf7aad20..e3b28fc68cdb 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -29,8 +29,6 @@
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
 
-static struct max77650_regulator_desc max77651_SBB1_desc;
-
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
 	MAX77650_REGULATOR_ID_SBB0,
@@ -45,6 +43,8 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
+static struct max77650_regulator_desc max77651_SBB1_desc;
+
 static const unsigned int max77651_sbb1_volt_range_sel[] = {
 	0x0, 0x1, 0x2, 0x3
 };
-- 
2.22.0.rc1

