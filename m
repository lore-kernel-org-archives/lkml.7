Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D020658
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXqpKJGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfKMSyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:54:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55937 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfKMSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:54:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3129333wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znf7mo4G9jPIzVfiurHEWnDBV3kCfIxmHe1zoQ/j1JI=;
        b=jXqpKJGh1V1p5/zJKPLSg8aHuXISAB+G6IUG18JBJ++ehzluBYs0E7RavYC25cumyh
         zylqE+mpEVyNVyEFmLw0uCdQi1P8cwzPE5q10jbtC157GvZwsg138aXk0Hv7RgOswA1q
         K9v27zdFW1hggQaqzvF9WZ1sz2eaKn/3YM6w9FbLsSPvPXR0K24Bn0jWRdqqhkM+V4ie
         gXaOtkQRnA5oINYeBEzRNQT7bHQO3YhGy+r10vMKcjpJyj74YWSegP0Ka9kz6r6QdKZn
         GkoqMj/u4If5cgtA70HuerUoNfQDA4sUz/4UV3lC+pfcttUY0x6tzv+iJwPQIFK84oUt
         Lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znf7mo4G9jPIzVfiurHEWnDBV3kCfIxmHe1zoQ/j1JI=;
        b=iwHchvtB44EVRIcUVNAfrEXcgnjTg0oyFWTnRnAQ6ftuZwWGcmvu+48EtmPp+LNVe+
         207aySOE7ns4+g/h9qARYo5Amc4oIY0Vh9evhQWTT4wJlCGWijZEtuHzIqQuvI4eit67
         cnsKmPDGmI+8cM1NDIRbkEl2INbl4dIJ40q6BmsE7WV6YUKR6xzvGUi78D9Xj5BIaEWy
         we6zgm2leuo+o+TnjNz3j8hf1n8UTxW/dLaFM8ob9Xd0WYOupl2xcf+1ITskQbwBBGrT
         Xu9568AH+NzVuB/osmQ4+d2kH4mffI62E9+nkYBa8Tw8W/ixthUdzyZSA52GYkFKB5z/
         etkg==
X-Gm-Message-State: APjAAAWchgVuYGw1i+1Z2IteguUOUP+RTpjeao7YHMxSuHBQJG0Obz37
        W0I2INONc39ESVefUFPbdX1ds4uU96Q=
X-Google-Smtp-Source: APXvYqwwH8BCjmSktAETpbChLwTN/XW+mm39prw4iii5WPmKfFcupKLbgzRkJjUgZvfEw0qFgCe7ug==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4491750wmc.28.1573671273779;
        Wed, 13 Nov 2019 10:54:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ec92:781d:6592:837])
        by smtp.gmail.com with ESMTPSA id 17sm2652848wmg.19.2019.11.13.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:54:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH RFC 3/3] cpuidle: Use the latency to call find_deepest_idle_state
Date:   Wed, 13 Nov 2019 19:54:19 +0100
Message-Id: <20191113185419.13305-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113185419.13305-1-daniel.lezcano@linaro.org>
References: <20191113185419.13305-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the dev->use_latency is filled with the latency value when this
function is called, use it as a parameter to the
find_deepest_idle_state() function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f68a6c9e8482..659d8b1ece6d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -124,7 +124,7 @@ void cpuidle_use_latency(unsigned int latency)
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
-	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
+	return find_deepest_state(drv, dev, dev->use_latency, 0, false);
 }
 
 #ifdef CONFIG_SUSPEND
-- 
2.17.1

