Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB5C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068DD206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJF7A23i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfIPJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:57:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfIPJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:57:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id m29so3261917pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rkhdorkxe0qRZF13/02UUScKqG72498Hp24eJzEwJa4=;
        b=CJF7A23iXJA/Af2Yb6R3fM9Va0UjPmaQ868Hl2yLvWV+aC47MYd9JdyW/tqY/iHD/L
         MURnT8MBPkKqzDjW5NmJexiBpNlSeR7Sf9Pg0dylNDMSy+zIsx/uB/K7NHls5AhyF/Ua
         HPTcBN5DwmxQsRtslqTLJko/yPFzBHJ1CHLufoG76YBwOuBY5XJJYiNPkfqJEFSlm0mR
         K2SaXmJkKZpnRIDqLK+/2CsD6fIM2KMMZ1IWD3eMKpZ9jrQttWjJWjPKNmFSSOjEIZNV
         g9COt5CZ3Z9PehnJDhitdG/itkGSBXYa43Mz1jPk8vv9dT97NIxqDhP8Diyb+mhBvllB
         FGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rkhdorkxe0qRZF13/02UUScKqG72498Hp24eJzEwJa4=;
        b=iAOwbVR1Wr4d7xyidKG8UMC+qBwKAMHZjqK4SZeG6ELs3RzwRfL60B+i7MuEjR3f2Q
         EpBmSdQG9sGZYOF/lTRM0JG4NZOxslKxTmrkVCgc4vwRx956bo8J6fMgirZ0Yl8LyS11
         p2LoveyTSpXPzO5XK/Lvda/Of1GVa40E3eQllIqsN2p/SdVWaVHFkvnVEfsjH5AiuXwN
         8vXK2k8SjRixCC0btl/fGJRFOtiSMXh7wUFJJZcyQGIvTEbbXAvAvRbdnouq8pTw7MAX
         86UDx7sn16FVrj4D+QJfVqs4lpFuibKmcEzh79r1Zu4iAfgCTB0CcV1NbFd6VVWggnC7
         qcuA==
X-Gm-Message-State: APjAAAVRya6Ian8AekH42HDigq66+EQF9RgVltPcy9B8YF6a4wq3pYn0
        1v/suG26dJySqgfA2da2Umu7HQ==
X-Google-Smtp-Source: APXvYqylK1NKzYEcF+uWSCu14dTOkiaD2Ge+hzHZl2r37nI3kD7UrB02MDpe0uV+PdmDsWO2Jvnqrg==
X-Received: by 2002:aa7:8d12:: with SMTP id j18mr71147231pfe.33.1568627836100;
        Mon, 16 Sep 2019 02:57:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m2sm10355923pff.154.2019.09.16.02.57.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 02:57:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        bruce.chen@unisoc.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: eic: sprd: Fix the incorrect EIC offset when toggling
Date:   Mon, 16 Sep 2019 17:56:56 +0800
Message-Id: <5ca714b7bbd12ce24a6e8cc278eb438c576fa75d.1568627608.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Chen <bruce.chen@unisoc.com>

When toggling the level trigger to emulate the edge trigger, the
EIC offset is incorrect without adding the corresponding bank index,
thus fix it.

Fixes: 7bf0d7f62282 ("gpio: eic: Add edge trigger emulation for EIC")
Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 7b9ac4a..090539f 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -530,11 +530,12 @@ static void sprd_eic_handle_one_type(struct gpio_chip *chip)
 		}
 
 		for_each_set_bit(n, &reg, SPRD_EIC_PER_BANK_NR) {
-			girq = irq_find_mapping(chip->irq.domain,
-					bank * SPRD_EIC_PER_BANK_NR + n);
+			u32 offset = bank * SPRD_EIC_PER_BANK_NR + n;
+
+			girq = irq_find_mapping(chip->irq.domain, offset);
 
 			generic_handle_irq(girq);
-			sprd_eic_toggle_trigger(chip, girq, n);
+			sprd_eic_toggle_trigger(chip, girq, offset);
 		}
 	}
 }
-- 
1.7.9.5

