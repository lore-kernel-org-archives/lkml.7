Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95C52171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgctJgQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfB1IrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38451 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbfB1Iq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so8877541wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=nndQGYFFOr4grK1i+R2EPjQLJkTwDEACtn+vc5zD1zQ=;
        b=KgctJgQF3zBjvz92zvXNAiGlQ4r4426BexYQEJBjkyXm/EQgWK1TOl5k3bk6qUcglu
         G05g3GEok3Ec1bfK0dIWxk5kQWAdE8NYukLGUL0FGV68vhxvZ9TB/6zVK3c76ZAXP3FN
         IL4t2FNZpIFJNTbvU8r4i/a8X/cy73KnJFxBiOw3VPV0Ia8/uTBLgjAKQG9lMxi1rO+W
         Ja/k+4lO9JqM00emsitZxApoF2D8MffnB9Wyw88USYzy/P4Scgy830+iPOymKH6yrZkP
         2aUNKalFbL5dGUQIbGBYvjD9F/B2YIGc5cAfcKq7+7Fj+Gdms4YKY0eTlZG+bjhwBg4s
         rYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=nndQGYFFOr4grK1i+R2EPjQLJkTwDEACtn+vc5zD1zQ=;
        b=ukyse8a9ZZQZVYsUn3k9FIYWf6l9xj1dntKW4qDbADFnIBj++ucY8C/vAWn/6o21cH
         xPMCNcp1xDE4Ragf83M9CwU6353gC/56pq0sy9Lx2Hx7zUs4TwKXYZqAEIzBfEwoqX0A
         ur7OTXw5F2A2z/EEvrHDfMAMO248/r6u3gQQ7sGKZHkph7lSLMlrCY8iCa5/gKlo3ATz
         4m/64eofntZlmAnRI3C3ipRIlW/Iki8tVpqqGKesqkDLs+89IhSjih9q1OTJs2HTbcFc
         HDr/PAFZHrBMcpZteFA6dpNKwqF8xK4EWLecBhySNUceM0eJuMIVM1KwZWmIYa5IZ9A1
         uPIA==
X-Gm-Message-State: APjAAAU7+KcOxs+qEE4bDY9ri5zBWuD16fftddGkdRTjvy25nO4vV2A3
        VUqXmNriVgtqsK4l58cCTIc7sTXx
X-Google-Smtp-Source: APXvYqwg0InsFolUzXssZHxIS89SLgI/ux3cI8zWLTQNWnlOVroNFUEsBPFjTNOF6i59tq6M3YBDLg==
X-Received: by 2002:adf:f690:: with SMTP id v16mr5513142wrp.139.1551343615406;
        Thu, 28 Feb 2019 00:46:55 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:54 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] habanalabs: use NULL to initialize array of pointers
Date:   Thu, 28 Feb 2019 10:46:23 +0200
Message-Id: <20190228084624.25288-15-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse warnings:

drivers/misc/habanalabs/hwmon.c:20:56: warning: Using plain integer as NULL pointer

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 7eec21f9b96e..af81084ef495 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -17,7 +17,7 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 				struct armcp_sensor *sensors_arr)
 {
 	u32 counts[HWMON_NR_SENSOR_TYPES] = {0};
-	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {0};
+	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {NULL};
 	u32 sensors_by_type_next_index[HWMON_NR_SENSOR_TYPES] = {0};
 	struct hwmon_channel_info **channels_info;
 	u32 num_sensors_for_type, num_active_sensor_types = 0,
-- 
2.17.1

