Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51FCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD67218FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQwhqBuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDHVnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40129 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHVnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so12636477ljq.7;
        Mon, 08 Apr 2019 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZGMHVwL/wB6dikUoQRPrzvmQgfUVtWFgGUr1uNGhMY=;
        b=mQwhqBuQTIXPblU4ESPPmFjwApe521h4TYIx6DoWH7QyZqIBlB2+W+QKl60WqEWq2Z
         mTleF0qCmpJHjj0TSo3iQPzPhWMCP65/yIC4r17NjLG36rL33dE6n/vm6AvpwYikCvex
         aBzDhZOfyy8s/tBAzgEGJxbDLB92RFXEGXQI2vtyjXnkqHWohzqtEY5ydkooECTXhFZX
         /S4eEZ7RFVetDDqNFcGiO1tZSM6rmlDYbChvrX9Yv6A5Xp0m1/Sb36721kdO1fycnZ0H
         pdeghNy5pFMvvQ7rI48Kkj0BOH9mhgH4IzbpddxXLMr+C4uMrgg9Dzh5TFM7H1TjVlgV
         /tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZGMHVwL/wB6dikUoQRPrzvmQgfUVtWFgGUr1uNGhMY=;
        b=pP/4HlwDnnDAbZ7i+3/Md69r93rELVkpngd320F+vG1Waj3Et22AHRnLP+XgvMGY3U
         sKabdoHv9WHaKJIUAhHOOTYmDH66nn8wSWaSzN2TVB8GNQU33nXXzU2WqNDYQUDOJX9A
         G4DE93yrAFRVau0A9IwJujksqn6U82CSGhAf9x505Ro9opzQN4bPdtviGGb4a5ouGv5l
         ZXtQqrCHy+s/CYuUeRzP2Pz+vSZAwWCWrQqGYUmV783oFvZ4j69QUi0JHgQLjGh7L9Zc
         JtI+I4X61A6fIB42739cFdVd5tqqD+xkKuilOnVsypNQvAbFtBdfwa8R1iSfJDoBk8NA
         9y0w==
X-Gm-Message-State: APjAAAUflV2Ros2J1hjaTkiz1FIvyoMT9Pvi+37v0dulMYWcr2yIwRZO
        u5J8jd7Pgr9ILSwO/nuLGkI=
X-Google-Smtp-Source: APXvYqzg8anJQbJWblybucPJ3c5h0r4nX2dbwzEuxrYYctHEH9GkwKi4ygVEotZfoL2e7nyEmgKVAA==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr18377256lja.68.1554759787065;
        Mon, 08 Apr 2019 14:43:07 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:06 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 01/14] media: ov6650: Fix MODDULE_DESCRIPTION
Date:   Mon,  8 Apr 2019 23:42:29 +0200
Message-Id: <20190408214242.9603-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 23a52386fabe ("media: ov6650: convert to standalone v4l2
subdevice") converted the driver from a soc_camera sensor to a
standalone V4L subdevice driver.  Unfortunately, module description was
not updated to reflect the change.  Fix it.

While being at it, update email address of the module author.

Fixes: 23a52386fabe ("media: ov6650: convert to standalone v4l2 subdevice")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 1b972e591b48..a3d00afcb0c8 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -1045,6 +1045,6 @@ static struct i2c_driver ov6650_i2c_driver = {
 
 module_i2c_driver(ov6650_i2c_driver);
 
-MODULE_DESCRIPTION("SoC Camera driver for OmniVision OV6650");
-MODULE_AUTHOR("Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>");
+MODULE_DESCRIPTION("V4L2 subdevice driver for OmniVision OV6650 camera sensor");
+MODULE_AUTHOR("Janusz Krzysztofik <jmkrzyszt@gmail.com");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

