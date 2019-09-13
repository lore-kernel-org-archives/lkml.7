Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D70C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F005C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Leu/DrQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbfIMPZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:25:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33460 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391435AbfIMPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:25:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so32546458wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YR/vHc0/aYOgQ7htuSAKCOpYZUSwbX4XADi3ha+KA8Q=;
        b=Leu/DrQJjKKYfvqHogFl3YpcT43VdEBKD/+N9xaZ5aX1MwS8dy5gsahY0TJNorpYbj
         RCM87o79r3lSZplmrXS7UrRD6815d9/SoKwUkCjFRlnYWOrDccnYMBMOP/LZQ2sCY/Sd
         XVdH/57tU+/Oh19meKnLhqO3VPgF/2Ob1PKAPKmvhbIbkr6gplGq24WEvwL7ekeu7bYh
         c1H3omILP/rlmpUkgQkyAarA4r4hlL+byuhBCLJ3Us5c4oY2LnWwh05rO3TQDL5yA4za
         p/jZNguN1Tr1Z09DdtxeI3uGrpp5XCyGPCGiajOWr+3JV9Jj7tcMTH9jSaTQo1yIrybV
         W5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YR/vHc0/aYOgQ7htuSAKCOpYZUSwbX4XADi3ha+KA8Q=;
        b=iq9fwssNDz/5LDcu5vZ1V95KFyT7s+fqRE8nXwflV8+fUxV5vVJWKi6hqRwn7NMhlP
         3loGCuyvfnD640KzfDMAg6dgenck+r1IRO9ZPoijo/hU2eZTaXyIcp4MlstY6H9h67ON
         1sP4ODBRK6lst8B/IygDdH1d/yF4WFVL16Acm7SQp7ia2j8debTrru4j1SXG5+Cd1NK/
         qqQ6r9BcFAeHcgrWwZ9Bf5AwON8YLGbJN6ZjdlGLZITfMJrM28ew5ph/yNwY/qphC89v
         mlqZ9bBOwPryzowKzTc/EA5eaPmOn54VH1BZ8vdFgx9K2lPNF3qOU3lFzLy5Tcdi5V89
         6suQ==
X-Gm-Message-State: APjAAAXH8KkpzE6GHHVkoPq/j754HpJ7eo+uruEX1OoRW/4vlv54Ljf6
        Ch/MDgzRl0Tv8B6SZd6cjInl3g==
X-Google-Smtp-Source: APXvYqx5KIGVhI6Q2FBF3QcxBYLhi5+KVQWIxV06imlRDiMLqZKuoCLmV2QR4gmgFC/+mTzjSt9zxg==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr28521700wrg.13.1568388342113;
        Fri, 13 Sep 2019 08:25:42 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id d9sm48717728wrc.44.2019.09.13.08.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 08:25:41 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] misc: fastrpc: revert max init file size back to 2MB
Date:   Fri, 13 Sep 2019 17:25:32 +0200
Message-Id: <20190913152532.24484-6-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
References: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the integration of the mmap/unmap functionality, it is no longer
necessary to allow large memory allocations upfront since they can be
handled during runtime.

Tested on QCS404 with CDSP Neural Processing test suite.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 40b48db032b5..ee6de5d9993d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -32,7 +32,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
-#define INIT_FILELEN_MAX (64 * 1024 * 1024)
+#define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 #define ADSP_MMAP_ADD_PAGES 0x1000
-- 
2.23.0

