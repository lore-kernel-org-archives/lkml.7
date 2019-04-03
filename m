Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B0C10F0C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E6120663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDCMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:49:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:49:48 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.37.190]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7auL-1hHS4v2zDJ-0085fP; Wed, 03 Apr 2019 14:48:52 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Lukasz Majewski <l.majewski@samsung.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "# 4 . 14" <stable@vger.kernel.org>
Subject: [PATCH] hwmon: pwm-fan: Disable PWM if fetching cooling data fails
Date:   Wed,  3 Apr 2019 14:48:33 +0200
Message-Id: <1554295713-18656-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:SNJA6UTMZpWfu+gWuspilff7X2WFCMw5ETn6BxCWzXuOKWr1LNS
 jbeGEOetPlIBHqkVQ+lmFq7wOBbqxInI5aJ4LWYr9N5tgIf9/G6aPmMK5udOvMWiO3P6xXJ
 91DCgdnUIE8C7jYEuyaqH5yRHcqT16xqVGHRkuOGXan01FbM5t1mDKSTKAIJ4U8K1QsgD64
 /KDkho0KkNUHRTe42uK4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iaqfFMWFDNw=:uetN+h/6nFWnnJo7PdTsuB
 9/v1gglRNPtAwitW8iE7fNkmxZ1zf7bfK43mF27dzhUZMTQ9RcGDoyH7xCuRyt1kAzP2NjG5J
 BiP/mztKw338nPEXMq5loV0ToFGvzToef3AFVg7+ScyOKgzijr48kAazvHW3a+QKddB4V4l2q
 FSvq7caoWjimz6SnJTqy2LRZ67tOXB/MAS2M97OoZPLW4M11d4pmgQcXQN3tw+JUL5BUACbdh
 wuF/cDJV33OwH1GFA4bQe/wuFfUhjTpjGD6KBuK4+nV/qBWb8JsqZDvz6eaMmUXfKQ1R5GtFE
 S3O8ABoT36T4K1ueJxVw8nQ5kKRo2fXccH3h0DTB1cQuKB61qPwTUxqU2kHf4dA0qm8d9dRfO
 MW6XbVunOioGCeLtj7Mup45+eczt1GAOkftV08zQSZpZkAuSiiyiHPp0OANQdRVCWpdCth6My
 ae1Ex+CFTOJZdQKyx26rPvJQ1ZjvLiaNcheZQZvY233M8idQTAq8medv0D4+PbycOBWrPXOor
 9QtMWsW69QJgnWivFWnzM3jZRfHp/T9BG3zZ6OJIolT0LmfRKggWTggpV9OInlreIyarta87S
 7PhPNrdPrsw+XR17feZVUwBGWggv9vklC6g78tJXfOe0VOLAreWUYaK3MNs/kSW9BMLpOWwcn
 Tzr6SzwyPCk+HoZZduok4DG0JSlYRjABa9MYaEijFlNli3YJhW8ZmmOI2YbnQzpVe4HWOvbGH
 GUPlbwYEKLJbiwcB0skFis67rvOamnuvB8OhPClB2YfK0OZ2zP0Dk3GGhfM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case pwm_fan_of_get_cooling_data() fails we should disable the PWM
just like in the other error cases.

Reported-by: Guenter Rock <linux@roeck-us.net>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 2e5219c77183 ("hwmon: (pwm-fan) Read PWM FAN configuration from device tree")
Cc: <stable@vger.kernel.org> # 4.14
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c..e4c5197 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -271,7 +271,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
 	if (ret)
-		return ret;
+		goto err_pwm_disable;
 
 	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
-- 
2.7.4

