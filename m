Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA372067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Jrlj7HYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfKAMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45179 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbfKAMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so10065960ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=Jrlj7HYitgBzLfyKtrx/OO0IF424h6yFkDFrbEjosMTDF2aA+PaLiTLLafQdKZ3QMX
         5C6WwVKKXs3sGTYF7gik1JvKKrJkzNqF4vqrXVPLMoJUendQcB74HwPti5RNGmw3iPPm
         CvYF9p7XwadVMz+uKIdVanO9hfElGuWD/OUr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4h2w9DiO+4P3jPc0w1TT3xARdv8ATB93lgz8xw4vxA=;
        b=WDUpLMZSfYlDxhb4bHhxeRob/Xza4DBMP+4rFC59xkmCc+M3W36t3qHZuSdq3E7Ha/
         250wZ1xjdGs3Fvawe2Kp/HhNEoXmZ52Fi/+AHKbELVf8CtmVr9WnYbwvkN4avL+fgrFd
         iVTF9Fd+sNTlYBGegvO27mSspBN1CLIsMSMSOdIxH9AYKRiq0Jzc8i57Ehz/btInqevi
         pJ0/m+I12E1PoYxcBWhLboEE8jdrf2Gc+Kz9G2JeMHg7EEOGx6Tnyrr5cHn/ifhGuEo6
         4guBGPVrcrhi0tOn+YKhj9DLq2sVkXvZdQmb8fUkXtGePch5oW46M7jPARsxnSDGhW7W
         diOw==
X-Gm-Message-State: APjAAAWgTPHLbl+SPVu+2c+YiXZRv7XboE1KNXk3EAIBz4bxiIAq4Bo6
        W7KrjHZyjH6Xgtt1eXb8smpeqQ==
X-Google-Smtp-Source: APXvYqx8zrBcMLn5RPWXrg0GJJr4NEf4Bg+m/CRYcm4FtBa1jW4/OjCkrBiVlZ45AD2xz7SMOL17vQ==
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr8265025ljm.77.1572612168478;
        Fri, 01 Nov 2019 05:42:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 27/36] soc/fsl/qe/qe.h: update include path for cpm.h
Date:   Fri,  1 Nov 2019 13:42:01 +0100
Message-Id: <20191101124210.14510-28-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h under arch/powerpc is now just a wrapper for including
soc/fsl/cpm.h. In order to make the qe.h header usable on other
architectures, use the latter path directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 9cac04c692fd..521fa3a177e0 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -17,7 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
+#include <soc/fsl/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
2.23.0

