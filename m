Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8DA206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zppns9CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKNFOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:14:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:14:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id h4so2919193pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 21:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2wlRR3w/KTNdVqCYnrEwvs7sg2WubrsMP6gUzcCK3w=;
        b=zppns9CQ9NJAosr/LOsW1qDHdqq9EqFz5ZPBd7ZGpXbY79fJ2UVFUjsC9feu+OeRHH
         jtupVXzvx24ZZtmezz8rILhUwtykHm72bbXRADz/wG5Xyooq0ab2j+kPJKt4jiwKJl2d
         FH2/0qcxqyE1pxV4oVsrEIrqwNllLXxa5i0qQnqNr1U07RISfVBVpvjI8JKBOtAyQMtG
         TPcfcF9CbhRNOJM8m+sCcSigAOWit4iAi+t6k1O8M6SDs42jo6jnMYYpF+IBAn8AYM/g
         LA6GbbSwny1FrxmFPJ0PUtas1pgDTEqsAhyHs9QWGcgeXZClDrz4iDqFg1KfJvQXdYx3
         Qp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2wlRR3w/KTNdVqCYnrEwvs7sg2WubrsMP6gUzcCK3w=;
        b=a2eXJAOwPu27/dx2fbmI6uCGHRI5EERwOG2zYLWoSxyJBF4oMEeScOHfbpXP1FTwML
         QsXN08VNtW2v9cxEEGPbG9zd65HgN0kcgXIfARFmRAeHBHw741vCBea3Vmfsz/Oe79O7
         KPOGjGgmoJ2d1cN2mM8V/86cyvzVM337ADY224QInryOhs6bB6opxZwc9OQn9H2FFg/4
         RGVG3ILTfUuMBLueMgfKM/VlQf39CgTGBFf/VM5ERdzjHcO9hsyt2ncg+O97fnyDssCj
         89kdGM3w4kBMKkFAF5FfL5g8fKmAEyj43SDcXa9ilKArKKAYjydYKWNmq9FrHdyyko10
         fUvA==
X-Gm-Message-State: APjAAAUVWMCRTxhUw9rpAai2yarnZNFL6SNMwD8ylsWIKMMm5BI1gTJ7
        /3zC3/t8WnrtNBOV2fI46hhk+Q==
X-Google-Smtp-Source: APXvYqwlEusLa94m5U+3WaWntarTbEi19zhc16zy/LNNcM+ekH+5cMHfghn0WaJojuUTkNWrbbbtHA==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr8967673pfb.63.1573708481126;
        Wed, 13 Nov 2019 21:14:41 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f5sm7329049pjp.1.2019.11.13.21.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 21:14:40 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 1/3] libfdt: define UINT32_MAX in libfdt_env.h
Date:   Thu, 14 Nov 2019 14:15:08 +0900
Message-Id: <20191114051510.17037-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114051510.17037-1-takahiro.akashi@linaro.org>
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
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

