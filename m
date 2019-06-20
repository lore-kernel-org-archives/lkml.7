Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D95AC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D76206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVLcV+OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfFTOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:22:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46659 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbfFTOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:22:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so1652489pgr.13;
        Thu, 20 Jun 2019 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+UzUbDRAaaNqwrtJOvlpRknxT3IijEX1YVPa5qy2MtM=;
        b=CVLcV+OS1EoECdFxLm6kqQH5hyOWXfLAQTcbmJfoV8uhVPelXUNHU17+dRpDf9Imvy
         xLQSiRMssA7fqybdSgQ+CL/1jTHEBJ8671OlEROL3mRHI1oRq8ETGUNYAjtmWQI1KTxN
         0ICPLA378wp/hRV6KKBbF8jStbt2es0FYkGEgv6TI2IoiazQeyylKOUtBLQHRS2f0BqZ
         aJ4+z/WYGX0TsK39dX0sQ9aX/B4jhu+qwmQ/T8uLuLS9MBboSd5JoPOdm1K9SEW5Ui27
         Xvj/0YMdpPhv48a/cC7NKRXPjM4qrGLF0oQoDn80zYtvIhkZZk+yXVm8qaF6EHlHZF/G
         Y4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+UzUbDRAaaNqwrtJOvlpRknxT3IijEX1YVPa5qy2MtM=;
        b=ewXdY6PCfOCJu+21TablLONfJc/Dh+Pg8L+39vO5mz7EfEbB4bmFrlsxaH8nF5v4OO
         vyIiMqUBZKrgzfEPYJvJj7eesHyv/l4lVbQYodOFwE/z9nR/QzdCxcR4Tmutwg2nXwQN
         a/hrNYdxckL6YN2MlO4E7ayvbb6kZ7KR8IAUSZZJOdXW4GBt+eLVtcZ8TWffByf+BrL3
         sHfrKFwD61AouZyujjsHGKNWajW59NSoByrb4eF/mFwduMsbanbhf1zaGQyulEURbmqR
         Qd0r93Gt/qiy+vLbRjzRi9f34OVphi88Ep2r9z0elopW9OiyS7tmeAviqbeg5asr6y1i
         cHmA==
X-Gm-Message-State: APjAAAWWFkvskXCmtgOp1pP3Aa7PrIyN6+I7EA839RID86nzvEUZjelW
        DtULGF++a/LTN+tagFc+O+LFsohr
X-Google-Smtp-Source: APXvYqzn9PE8rSgbfO8g9ZCdmiiYdGIs3UtaOb/KrFvi/6cjeIm3mYWHTGm8mmv/MtUEK+hGbww6RA==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr3256035pju.110.1561040557622;
        Thu, 20 Jun 2019 07:22:37 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 16sm22516557pfo.65.2019.06.20.07.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:22:37 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, jorge.ramirez-ortiz@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] regulator: qcom_spmi: Do NULL check for lvs
Date:   Thu, 20 Jun 2019 07:22:28 -0700
Message-Id: <20190620142228.11773-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Low-voltage switches (lvs) don't have set_points since the voltage ranges
of the output are really controlled by the inputs.  This is a problem for
the newly added linear range support in the probe(), as that will cause
a null pointer dereference error on older platforms like msm8974 which
happen to need to control some of the implemented lvs.

Fix this by adding the appropriate null check.

Fixes: 86f4ff7a0c0c ("regulator: qcom_spmi: enable linear range info")
Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 877df33e0246..7f51c5fc8194 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2045,7 +2045,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 			}
 		}
 
-		if (vreg->set_points->count == 1) {
+		if (vreg->set_points && vreg->set_points->count == 1) {
 			/* since there is only one range */
 			range = vreg->set_points->range;
 			vreg->desc.uV_step = range->step_uV;
-- 
2.17.1

