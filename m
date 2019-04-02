Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72131C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEB4206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILDqsSxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfDBGay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:30:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46989 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:30:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so5718729pll.13;
        Mon, 01 Apr 2019 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNedWm3Hz3KKze8HS2QeLEYl8kQ1q+G71sLG9i3ZRic=;
        b=ILDqsSxyB02bx9BVIh9Q+V6ahH1FtKycYJdcDWYBcuhkZuyWTkKwWMHegUoTHYL083
         KhpHR1vYrBzG5hCwiVWzTKsKIek2jmlfYKPLhIJL63gAa3llh1jtWrJdAiuDErRdw9d+
         ntgurJRKRgu+i5hlA+uVWyLiS+lzl9EB2jvvsWyENnvEGH6Ya7YxQT9bpKVmq5rY5BIP
         sm4+OX4Lu0zQ+bJNfJ5Y5NjOtG3QrBwlRk6xxkx56Kn56FfRLeINM7yWEGjreqUDSxJi
         Ye3nXJuvtLWkE3dggxILMsil8LjKGgK4g2OFj1aZRnJcj0MxvjHuZXgBbrOtiuBLaV+u
         G++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNedWm3Hz3KKze8HS2QeLEYl8kQ1q+G71sLG9i3ZRic=;
        b=rkXUfyukqM9EmcbGC5C7DOYUw1Kit/5G2oY6gePdO4OTX//KnKwlRJOTATTkkPzXON
         dSlQ7ssdGJmW6mTg0n7kskF4f2McjuNwJBUdkxVjXYxixvwUSKr4BTvXtvnkLL1ctK8P
         4380rXV7UG6opDkc0iG4/YThGgn/P7Frw9x1V3MDTxMv+9xgYM61cXjLAFkZsJX0PPSr
         50kBooHuaBQRf3OPj/4GnRR3WPZAkclfxAuEFRLdCTC4oeKjYJmvS7GX/xlBopJo/APZ
         YZDJe37xANuaW8eJfYi4i2yZandF6tOwfT23gTFQigoZovq4JuTUCP16EeGJPGQeTyvy
         nO0w==
X-Gm-Message-State: APjAAAVzClE+uWHzwS0lz7rnopsZlRqIcU7lN99/4A0DqGG9MMVMhPuo
        3wGLeMaSG42Pff8Gg2ceEt4=
X-Google-Smtp-Source: APXvYqxpx5VONZZMdLqSroCuHbE6BH9Rd3clDwrowABSUBtP+YUH+S3IPSsfGnO/djWOf39TRGfdqQ==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr69293700plb.237.1554186652921;
        Mon, 01 Apr 2019 23:30:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:30:52 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 04/18] iio: 104-quad-8: Update license boilerplate
Date:   Tue,  2 Apr 2019 15:30:39 +0900
Message-Id: <a2c4ce0bc824738e682ca544f937151da11786de.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the boilerplate license text by making use of a
SPDX license identifier line.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7735..72b6352e09f0 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
-- 
2.21.0

