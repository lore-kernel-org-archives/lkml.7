Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E909C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491820684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThLZwOpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfHLSkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:40:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46042 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:40:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so4852763pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wEHsTJtJkpVrJagTBHsYEXur21Gl4Q7vvn3wXU2PQh8=;
        b=ThLZwOpG0O4bmdtkt2UnZX/MXyG86/QHR9MlVnhByElkQHIwAd35+0RY5UWMGcyGQJ
         aw2P+B1KVo9TB47jb+KJMBw6U9RyBKalERMGDjB4SKkxxvBvVhkj7CjoGCa+YXm7fugs
         SxiBsKNdbARGIsliHlsgE5zWCmN+3F56+Bbmt175GGBLHkC4PZkNF8Np6EVmCy160V8J
         Yo3CiJXb0BB2VjnZGePMZqmHiXKOsKVDfPRpdGv67j9IfVIlXRQlq3aQEvz8TMe5GdR0
         oICoptny0sOMxX9IEBC3jkYvbLo6o7H1EJZre5N5CJU50TD4JLi9+QgN3bD6om4D/6Wk
         fI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wEHsTJtJkpVrJagTBHsYEXur21Gl4Q7vvn3wXU2PQh8=;
        b=a+Tl4oe0UY/hLQ7piNCOMI/b62+/6TWpcIH4QaUl3cE+g2QD06iP9FpJZJnYyE1lTC
         JvbJTF2IGMbbRGFfwVMEXp4nQsYAEMMc8jlpnc9bo7kY7xfghFoHYN8vTfKXuJmGaj0o
         jlNqIruKYzKl17F4aGsJHZyri+DLZPWZPIt5pHWnxNWrxbhYYWQXw9KXsepBP3arElSe
         3pzlUQX88FqWadzFWq4UYINhC7ryBxe5SlsGe3w/o4pYVvo0mz9woUjjWH4P40eB+hAI
         R52cf7mc5JV75l8/gKTgmtr7FOZDwMIasc27Up+wwRRefD1cYGe1bllbUpxNjcP0eLoY
         gbjg==
X-Gm-Message-State: APjAAAV+zmJORMveQiPIiZrvbT7PS1sygFMXop8bpao7+AB0QN9FVfSY
        aM8mBiI2FxJSrxDiI+3s1EFy/mXV
X-Google-Smtp-Source: APXvYqzkj5Qqa/vMdOxNgH0OewOSW8q2/FvbkwDsQw7xZNeVclwwuFxbcce6jZOfFLMr8kMYmAHljQ==
X-Received: by 2002:a17:90a:3465:: with SMTP id o92mr641173pjb.20.1565635224168;
        Mon, 12 Aug 2019 11:40:24 -0700 (PDT)
Received: from localhost.localdomain ([203.109.114.129])
        by smtp.gmail.com with ESMTPSA id d3sm301403pjz.31.2019.08.12.11.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Aug 2019 11:40:23 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] regulator: act8945a-regulator: fix ldo register addresses in set_mode hook
Date:   Tue, 13 Aug 2019 00:09:54 +0530
Message-Id: <1565635194-5816-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ACT8945A datasheet[1], operating modes for ldos are
controlled by BIT(5) of their respective _CTRL registers.

[1] https://active-semi.com/wp-content/uploads/ACT8945A_Datasheet.pdf

Fixes: 7482d6ecc68e ("regulator: act8945a-regulator: Implement PM functionalities")
Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/regulator/act8945a-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 5842849..d2f804d 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -169,16 +169,16 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		reg = ACT8945A_DCDC3_CTRL;
 		break;
 	case ACT8945A_ID_LDO1:
-		reg = ACT8945A_LDO1_SUS;
+		reg = ACT8945A_LDO1_CTRL;
 		break;
 	case ACT8945A_ID_LDO2:
-		reg = ACT8945A_LDO2_SUS;
+		reg = ACT8945A_LDO2_CTRL;
 		break;
 	case ACT8945A_ID_LDO3:
-		reg = ACT8945A_LDO3_SUS;
+		reg = ACT8945A_LDO3_CTRL;
 		break;
 	case ACT8945A_ID_LDO4:
-		reg = ACT8945A_LDO4_SUS;
+		reg = ACT8945A_LDO4_CTRL;
 		break;
 	default:
 		return -EINVAL;
-- 
2.7.4

