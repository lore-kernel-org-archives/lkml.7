Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2802BC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D62075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1izBfJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfILF7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:59:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40547 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILF7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:59:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so15237990pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2wlRR3w/KTNdVqCYnrEwvs7sg2WubrsMP6gUzcCK3w=;
        b=a1izBfJNPh0xpl62rBUom1TVz4AD5siG6EraiJHLvL4gUGp0cW8alx2ORZ9jzKbGFX
         xWVqVXev/nHzAR9H/cEc2LKR9JLK9zWH6tIwAT1lb2tISj+ZgqjofZOR/0iNeBECZ+BS
         ISy/kii4aozfEQv4ehzP1Rh7lrkusxFuiyJiIHyoj0SKN/QmGlgCB2U1T/hLXT+RwfrE
         OjtbsEXNz20nDjM751kbB4MqoXEIxqUq9mykMCgRPGxRnkJkL0PwVvQIHk1sCR/Sg/iX
         26r3FUpGtVGk0UXhPg5W9g5oLCXS8RwCvpYAKtspZr+l8KYQFGoiKt+yEy4nJVAuVrfd
         UMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2wlRR3w/KTNdVqCYnrEwvs7sg2WubrsMP6gUzcCK3w=;
        b=lTjpc3DHGlyi5kNA/IK9iDRuz42Gc99QAiRSfz0/+g2ZrlsZ+ShPs4Fu4WIF83gxNT
         MCwyl1GP1lHWVeBHHYuhrqzTjdbT5qWUG0iBhgNJQa14ISEX8pwCckKB6nJXzsFSDSme
         MVIsFp8Y3xG9TsYAACsUYNnjnjKvLctAGBX5bM1I2dma8zAUQW3voXmThKVYNMjt0fF4
         8lD/pLOvuxTN2aV+WZ8mhYXTZeGPHxh5jQ78lYhQjQ58EW7zn8Rsw6RMkJ/qfu80KhSs
         IRonuzKI44cDluSafl49/aM3Wz8PEKjfpolRaYfP2DWu240XJyVgBvHQ7trGxUJ8rU0e
         9fOQ==
X-Gm-Message-State: APjAAAUB58vDX37LqWCWLBUzLp7QQ22y2T0tIjnq0kSKRE3ODTnwh3v3
        VslVYWnaZVJpgS0CIyvwVcJ6RmuVOaw=
X-Google-Smtp-Source: APXvYqxhrvEMXCYdoVnQe8x2WLbfUA2cbM+KZMZ+EXo6BWAKSNzbpi4c8Q5F6ZhyyyGKEBV5ult3JQ==
X-Received: by 2002:aa7:9a48:: with SMTP id x8mr45589514pfj.201.1568267980014;
        Wed, 11 Sep 2019 22:59:40 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id x9sm11590512pje.27.2019.09.11.22.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 22:59:39 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/3] libfdt: define UINT32_MAX in libfdt_env.h
Date:   Thu, 12 Sep 2019 15:01:48 +0900
Message-Id: <20190912060150.10818-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912060150.10818-1-takahiro.akashi@linaro.org>
References: <20190912060150.10818-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of kexec_file_load-based kdump for arm64,
fdt_appendprop_addrrange() will be used, but fdt_addresses.c
will fail to compile due to missing UINT32_MAX.

So just define it in libfdt_env.h.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 include/linux/libfdt_env.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index edb0f0c30904..9ca00f11d9b1 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -3,6 +3,7 @@
 #define LIBFDT_ENV_H
 
 #include <linux/kernel.h>	/* For INT_MAX */
+#include <linux/limits.h>	/* For UINT32_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
@@ -11,6 +12,8 @@ typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
 
+#define UINT32_MAX U32_MAX
+
 #define fdt32_to_cpu(x) be32_to_cpu(x)
 #define cpu_to_fdt32(x) cpu_to_be32(x)
 #define fdt64_to_cpu(x) be64_to_cpu(x)
-- 
2.21.0

