Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D6C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1070E204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lH5XM5ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfFFLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:22:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40575 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:22:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so2003473wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HEs0MSpYL/dt4ruohAAYosuccjeeKQUzYlFrfc+6zvI=;
        b=lH5XM5lywTiuLbf3TJDU9hyYU1xSAF8s/CUIoBMZ2vJA/FwiFIjtrpP1YExH2Jim5h
         mJP+e1bdfvUvPo/VdxJToF5787YNEIbsyv4dOl6YX73oBr7BLFsg1o+fUzX5YQwEN1Ik
         Z6N/oJXYuE2klr2eHuzCSyZFnw1mkQUlcoUrWIhz0F1A/8osMu04SdmKwhhAxa4iVedC
         kXKCMZL6/cjDb+sIEsrGdMyDHNi161BVk4BUO9RzzY2nVatp2lMmfJRCnVn3jjjuRHrP
         YXYnWPz/rOb3joaEt05BrcJMmxErb5qvE8g4I59aC4Jwopo1qKjElK2z0QuzoUaHSkF3
         NoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HEs0MSpYL/dt4ruohAAYosuccjeeKQUzYlFrfc+6zvI=;
        b=NlN8eM4U1BzT4E++rTGXrNCx/yu05PFBjEpcb8Rd3ubHpb7MPA22ua8Cv7v07ZrGXJ
         W5j4KfiWDmNXBMTMLADrE2pDFwOUuEyJ6w+DaPVfUY2sPn0CjIqUxGodjF+9EgNJeJzM
         9+pWX6R40zcnrUICLtfCH8FkCGzGZjlasCsXq5H+6qrHUKjI+YXqGd54cuZI+t1goeN/
         iP+Lgu5suOJ8dX7Hwo1k8YJiG9ufhlBrgE/WleE+swoAtaJSyvG5RNkIhK7r69507XtM
         8G3ksx8HO65P64tQthZC/bpCqIjuMO0baG47e1S9uQTcBWI011DSqQo1rAOO8iEZIxhF
         l7MA==
X-Gm-Message-State: APjAAAU2ZunVAbtbP3Z9wpuXflGXoDUS43NiYALAUtkO46AzTGjK0Jx5
        TSpoIoaW93+dFe1eBSJcVmLH4IMzuI2FIg==
X-Google-Smtp-Source: APXvYqySGNx3xiNsNDxvwdQWV+8OLNPxIqztO//kuJu9oMKRLpxuvyvrfr7FXa/ozMXLEThD23sD4g==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr29554545wrd.22.1559820149989;
        Thu, 06 Jun 2019 04:22:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d10sm1629867wrp.74.2019.06.06.04.22.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 04:22:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] soundwire: stream: fix bad unlock balance
Date:   Thu,  6 Jun 2019 12:22:22 +0100
Message-Id: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

multi bank switching code takes lock on condition but releases without
any check resulting in below warning.
This patch fixes this.

 =====================================
 WARNING: bad unlock balance detected!
 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
 -------------------------------------
 aplay/2954 is trying to release lock (&bus->msg_lock) at:
 do_bank_switch+0x21c/0x480
 but there are no more locks to release!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index ce9cb7fa4724..73c52cd4fec8 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			goto error;
 		}
 
-		mutex_unlock(&bus->msg_lock);
+		if (bus->multi_link)
+			mutex_unlock(&bus->msg_lock);
 	}
 
 	return ret;
-- 
2.21.0

