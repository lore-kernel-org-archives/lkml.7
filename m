Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B853C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+ivJIKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfDXX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36685 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfDXX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so10089170plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOUnfc0mskmHUriZ2lh0NHuF85sviT6cRaKiI0gIcKg=;
        b=F+ivJIKpvIw5MQQK39Hd1P5k8RNgQH9fmrIiQqZyqmgIUetpPLyu9GVKFPIMfnpvak
         yUtv52Q1CaC0B3dj4sN9N1svHDC1gnxieQTDF31SItPRHO8Vq+1dyjP5/HNn51TJ4e4j
         HDis3gHAwcZh4TpNiuKv+2IQKRJgkEf1qMTnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOUnfc0mskmHUriZ2lh0NHuF85sviT6cRaKiI0gIcKg=;
        b=UbiUjnLE2lYkKwDaI747aXJCM7qyFZ5Xi2oeCOo1/9LYhQqnG59EjHJIIqudWk8rJq
         rJ+zKE4o33YG6HsCtJFKLcLESNkmTRZ1nOMeHGcg69wIRhGKgzLggNZjDPgfUppyvlXT
         y1B1+W/2nf4TleWKaETX1QrJ8yLwMiYNNFri1oKakqpWJr3K64bm09Msj4T381ITS7AD
         BRQLoGg37TGmg30MjzK65uVwN+O4a2xTwmVhQHVPLSPjrXZf1NGqcQdFyjXTMiAjq9zv
         2fnvpNfPikactLJb86L0cUm5c0Ljpi9aB5P454PH5sf9ShzCBxPDg6GV1K/YjKFBLPcP
         sLLw==
X-Gm-Message-State: APjAAAW/xedAf6q1Rsfxwud1zOHObomos4+uqz+euI74Z+nsowy/Nu/P
        fUI92XP0bifXvYJDG4ajJOABLQ==
X-Google-Smtp-Source: APXvYqxSUZrLBpqwkcQy0Ev+isxxgsAseSAM6kqQyfjONAg1MNpTL+FxlFRSOY/ZUg/+KkfZ9qSx5g==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr20380287pla.116.1556148570765;
        Wed, 24 Apr 2019 16:29:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z8sm528416pgr.10.2019.04.24.16.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:30 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Wed, 24 Apr 2019 16:28:50 -0700
Message-Id: <20190424232918.243308-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined out build macro used when compiling embedded controller
firmware.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 6fa508643da3..374f64caeb5f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -13,6 +13,11 @@
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
+
+
+
+#define BUILD_ASSERT(_cond)
+
 /*
  * Current version of this protocol
  *
-- 
2.21.0.593.g511ec345e18-goog

