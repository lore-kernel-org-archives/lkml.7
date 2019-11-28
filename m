Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705F21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXOTFhYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfK1QuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46801 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfK1QuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so4771015pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jEs6QE+VfGFRlxMX16dTWWCBFFIHacBUeuklTX9eehk=;
        b=KXOTFhYW31M6DowFuVSnZZCtoVs9n/0m0NvfFFZd/SJgu5toTz3abL8mMkd78Ce33g
         jS4H5Xas4NpISrNogQilOVf2XtLcQFgi241JW6pdGzS9mAe1TpFBHF4dIwqlW2YBDkHi
         LcwZVULYkgOFnRsBSM5zGwnGB+uoPXjd8zsDy9LydhztAqwlpMUZBUjtnbLpM9/eZcPm
         B55+nvIbQgZJi8R9mKUwalRDzBnjtNK9Mow4lfWl94dyekaSG6aLvasftGqFRfTwvjev
         4w2+wCx0fHYT80fgo1kSm6hUHDAFw5HJI/3UXjlz4QSPSaylm0almF6B7yg9RP1vvNF5
         FDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEs6QE+VfGFRlxMX16dTWWCBFFIHacBUeuklTX9eehk=;
        b=KSljoLWefR/EBqyA0JVgyLrFfgryZFwm0iNYO5H8jIm7uTvI8qtUndA/FDFEHw33PO
         jdyxp/i/SeVEktts+BiU3B9CBBVcz6ExsPKY8LLThcVNCZhlo3VWjkfv1dbqyNZPKOfl
         t8jYNTwrh8/aDqFAnmBbJRKqCbdM6kn4P7vJaxwaFrEw0WLLrL+R3FIRfH55db/rrtCm
         LLnXoldSNhu+FEBx5LYYXLGkT6onnoCO6vXQtnyvoYQyHKoKR38n5DLj90f3zrpKLG1b
         k7sMtqiLtj48ASQY+V98VXGxOrO4nfvLlsCcpyeVkSzDOY+tEYiqU+iNl5dioPYBJL5t
         4j5A==
X-Gm-Message-State: APjAAAWvCQq/9UVWyxlN3hP5xe4t3tMfNIX2LSkCG+vmi0Y/cnDCizIi
        zzadiT2xp4wB8O0jYq8xgo68pQ==
X-Google-Smtp-Source: APXvYqx8Qk2Of+BXuSVm+sEuntEca3roAUMLg6UeXFFjMVrolEG4T3O608o00roYtbf9Fj0Zeo7MNA==
X-Received: by 2002:a63:e03:: with SMTP id d3mr6794337pgl.395.1574959806302;
        Thu, 28 Nov 2019 08:50:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 02/17] crypto: stm31/hash - Fix hmac issue more than 256 bytes
Date:   Thu, 28 Nov 2019 09:49:47 -0700
Message-Id: <20191128165002.6234-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

commit 0acabecebc912b3ba06289e4ef40476acc499a37 upstream

Correct condition for the second hmac loop. Key must be only
set in the first loop. Initial condition was wrong,
HMAC_KEY flag was not properly checked.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 590d7352837e..641b11077f47 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -365,7 +365,7 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 		return -ETIMEDOUT;
 
 	if ((hdev->flags & HASH_FLAGS_HMAC) &&
-	    (hdev->flags & ~HASH_FLAGS_HMAC_KEY)) {
+	    (!(hdev->flags & HASH_FLAGS_HMAC_KEY))) {
 		hdev->flags |= HASH_FLAGS_HMAC_KEY;
 		stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))
-- 
2.17.1

