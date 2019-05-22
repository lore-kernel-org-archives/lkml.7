Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB46C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8523021473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmezZTYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfEVQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:25:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfEVQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:25:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so2857854wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWGOVdMecY70uPThuN9Z8RHD52HpQ5FIVR/nn5jAdfI=;
        b=vmezZTYs//lLcUcn9Z2DSFVgsemU319BFV8a/+s4QFULfj+oV1MkrsVnARJSVUcyn7
         2I+wVuPvs2tzsECElLxCGkqQzkEqht1LnNWCseU2XQt1puHVkJnfN0pagtJLjeV+JiZS
         w7/AoGnhzoewNRIHjyHsiSGerFiIqHMxJUr9O53Yhn5RrZSBVe+rJhktHXli/9xmjrE4
         nAve702w/sZnEWEb7+6h6AZX5/2M136TSuszdl9VG9aHweEnp1ii2wsJ3PHq3iLN5ZpZ
         MCYZYvdJB2SLROSmcFAqJfskNvtQzLsRVIx62tE73OuP+POEIfb6yfrK30MFGOyNliXl
         zj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWGOVdMecY70uPThuN9Z8RHD52HpQ5FIVR/nn5jAdfI=;
        b=Kb6Yl1hdxlUKwkY/9nFFu2K5mAM4s/O7Qqw2mGfMOgTMUKm+D3CTvT3se8+WfRLf4/
         n4p5gISiFPhQStkiHyjZNrRx0xeDL9V1dm85/WDW1OviPCGnJfyxBSGa68fz5DXs0L8L
         BFdkHhmDFUCsTf0MbBSw1kKzmpvkDi7jlsUFkMcNj/6LZIzxlNsZzkLPE4Xpq7wFiqsw
         sl6DNnPG3mxoZWrTJM6dCGVDQGDf7jsUvhj/vktbSeon76f46OMAiln6UuIlj0fRTNSK
         L1mblqCieKfSkoDHedkWhy+ryDa+Wc6oAzEaxVuBBJhQZfGVXiuIYVucbYmWzuM6Kfrm
         toBg==
X-Gm-Message-State: APjAAAUIzhi0SRiAlvEuXJ3QkYOXDiGZq0q2xYSyayhghCjY+ka1KdOr
        0+JGOM8/rAmN3k9YQDfua/BtwA==
X-Google-Smtp-Source: APXvYqx3cV+KcaZgMn/uTRwxQMjy04ngPuH6R/wzSryVgaFWXel2dzT3vOZoSzw8BdI52xi8p/n+gQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr8032679wmc.81.1558542318259;
        Wed, 22 May 2019 09:25:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c14sm20390656wrt.45.2019.05.22.09.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:25:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: stream: fix out of boundary access on port properties
Date:   Wed, 22 May 2019 17:24:43 +0100
Message-Id: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning local iterator to array element and using it again for
indexing would cross the array boundary.
Fix this by directly referring array element without using the local
variable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index d01060dbee96..544925ff0b40 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1406,9 +1406,7 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 	}
 
 	for (i = 0; i < num_ports; i++) {
-		dpn_prop = &dpn_prop[i];
-
-		if (dpn_prop->num == port_num)
+		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
 
-- 
2.21.0

