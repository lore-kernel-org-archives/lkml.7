Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B228A233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdOAkYx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfH2J3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:29:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51887 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfH2J3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so2941556wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2Fx0Pb0mc0UlpujkGqHHioGa7pg7ML7uA9l5iVY0Do=;
        b=KdOAkYx4mUlEdOHRKmFg/Ohrw/cqTc8SxCG5fhUGBqFGvGPkr0MsZW1RTy99SSeksl
         DNDorcOie2Sf0FP5HI46t83xZtN20WwtU66qUQz2B+4y+zGoh9G745lhiJ7MxTJAlArB
         aRt2FRFjKd04Eu9HEfSgIrOnSTG6WlSqhL3TOsl8Ulm4d57y+cCTFmzDWkyG9igZVwHz
         I7n51NEHrGNiUH53mxrK4p+B2aNdN7xobvVCyWBSg5KNr076w2JuiLJ5/SEyvXNMMjs2
         GkbqqSyP2HV2TltnILXR9Rvg8fizFYt5C2gChLXRARQKW02NK95+iY0cFNBqXbDv18Mp
         CbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2Fx0Pb0mc0UlpujkGqHHioGa7pg7ML7uA9l5iVY0Do=;
        b=bgkf2tFov3s3vDkVqpiAP+QiFXGbY5uX4JA28cExETXW6lH8pBjLzWo+E2KebnSvvB
         fThoFdr69KpZWTMjYHDSj/1QNzQ1jp6UjVvBT58lU1xeJyKt/U/iIfF6h3zTx0fKt5oZ
         sraOEU2zs7v/hTfIWXxvty+zrLt41qdnr2cx8bOqfElZPfaRUm0p6tgPGmmeygmRO3Nk
         O5Pfph2C10+y5p5K0muToaj0wtBPN7GCZ+uMl/y+0aRFrulJcZJzgBRjK4yv2oExsaqF
         gPL8X2bTO5kgzsp6I7gq9VLSzy6KePZTV7+tstMK7z++GSEIjK4dzF/RfTvBWkRWs7is
         H0tQ==
X-Gm-Message-State: APjAAAVWQcJ1cIQYKt5LLuaaFaBKBHQO8suHhigJ6/IRSlHvc6m5M6+p
        vEk/W8zmgc2MXFdzC05y0YiTLg==
X-Google-Smtp-Source: APXvYqyu0QQoJV7ZRy9TThXqikuqUKf8hLMAyzYv+K80I5bIT4qhqGE/sAIKKMP5yPM72AF7eLZLNA==
X-Received: by 2002:a1c:356:: with SMTP id 83mr10609179wmd.40.1567070977941;
        Thu, 29 Aug 2019 02:29:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f197sm3609512wme.22.2019.08.29.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Abhinav Asati <asatiabhi@codeaurora.org>,
        Vamsi Singamsetty <vamssi@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] misc: fastrpc: remove unused definition
Date:   Thu, 29 Aug 2019 10:29:24 +0100
Message-Id: <20190829092926.12037-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Remove unused INIT_MEMLEN_MAX define.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Abhinav Asati <asatiabhi@codeaurora.org>
Signed-off-by: Vamsi Singamsetty <vamssi@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 59ee6de26229..38829fa74f28 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -33,7 +33,6 @@
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define INIT_FILELEN_MAX (64 * 1024 * 1024)
-#define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
 /* Retrives number of input buffers from the scalars parameter */
-- 
2.21.0

