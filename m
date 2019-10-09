Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F77CECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CD120B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWaEyzGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfJIOli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:41:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfJIOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:41:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so3317713wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcLlMzjMsysWETgQh91f6OPcWKj+qkhd5X668mmqw/Q=;
        b=GWaEyzGql51eoXnd1+9HbztdXoU4S+/WAXkpE3JiLjoAdSXYFfOCdRlo8ka9teKRo+
         qctTklxUCgnX3HTAEi1A/qI8zu4jpaZ8Gpl0WdfdlypBR0CL9S2J6Kf/MT1h2byvXceh
         QK/dtGGW0CV4g99zEJvCwYenJUQLXrnwtV6F3uoN4j3DxmWgw7W3Io/JU8KvRo5Pcp8L
         Hdk2SNOFCK/hZLLxkSTEnvE8/h6YMePlmmSNE9eLQk3bWmnXbJspBYFqHiU7dmQb1xOs
         SHODCutnrqaEqWbryPH3ZYsK4fGW2F3TBYA3Lwu0I1O9fZWYurW1/M2EpF/1Bj4zKuMj
         H6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcLlMzjMsysWETgQh91f6OPcWKj+qkhd5X668mmqw/Q=;
        b=Lf+KdFKi8nyFFY6dWOGR2YDqxNGQ4FQKUYrBxxAfEPo2tg5jIuBkJVmtknUhLLNbA+
         RsQ9Q7NBpvU3c/TOgWQbETzI9NJXcTfeT/0y+V9Uia/DxvWgzMXa7tCOXr1MDHbbGrc9
         RAwRZM1w8yiXktQc87kcwv3F/Cz+ctVq0W6882kOX4QGTBXuaaM0oFYZLtLbVaJto+pG
         4QB9WRZDmkGVOzuCRtRDp6J2S+w22peiJywEPH35ZljYDSVZ67Ba+4yMg0ZyNBpvAAJb
         2qkaUQ3z6cloI0XIpmBge50LnIQhpn3/JUo8xNNbiqqbP34QiQlwEhS2dYFapssEEESs
         IcBQ==
X-Gm-Message-State: APjAAAUxdK+jYrSSjtYxmY54Vw/+XOoYFr0DF1rXbu8HipJ8UVB71NwM
        LJSgfqiTkhk72tO+i50tKa9tCQ==
X-Google-Smtp-Source: APXvYqxydnAiNuYi21zzjBXjR+z8z1rVa1I47B0cpHpyMgSL01A5yw7XriPlERbrOpW2hLnh+ZYe3Q==
X-Received: by 2002:adf:de85:: with SMTP id w5mr3185456wrl.278.1570632093491;
        Wed, 09 Oct 2019 07:41:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm3031770wrx.56.2019.10.09.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:41:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/5] misc: fastrpc: do not interrupt kernel calls
Date:   Wed,  9 Oct 2019 15:41:21 +0100
Message-Id: <20191009144123.24583-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009144123.24583-1-srinivas.kandagatla@linaro.org>
References: <20191009144123.24583-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

the DSP firmware requires some calls to be held until processing has
completed: this is to guarantee that memory continues to be
accessible.

Nevertheless, the fastrpc driver chooses not support the case were
requests need to be held for unbounded amounts of time. If such a
use-case becomes necessary, this timeout will need to be revisited.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c0fe3419c685..666c431380ce 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -959,8 +959,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	/* Wait for remote dsp to respond or time out */
-	err = wait_for_completion_interruptible(&ctx->work);
+	if (kernel) {
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+			err = -ETIMEDOUT;
+	} else {
+		err = wait_for_completion_interruptible(&ctx->work);
+	}
+
 	if (err)
 		goto bail;
 
-- 
2.21.0

