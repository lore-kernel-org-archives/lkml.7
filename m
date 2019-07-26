Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA9FC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BF5216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjTC7eCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGZL16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41620 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so31972229lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhZxThgFyoxuQkXVr0Rs3Bv05HhD+nUqY4oSH8BKepE=;
        b=SjTC7eCVIgTYtXnx7wObMb0ka5YstKwcZt/k/di80kRHdujbyS/FGyHfIdL0+e5y5E
         lqNmDrIWjd3F9+9qNIu4+G/nKrBArgVH4eRkpSgNjIXUQQL7OqX6HUs2x1Ml+I+sZnno
         pX9ipCGgGEy+PzZxblaZr+5iGjAtNujUqzId+cjtqMooZh4FFYyb3Mqp8+wyp89GbEc8
         S/X/V6xNLx+1QVsSv3+xGI8bHqkzYa+wYLHyJNbhHBQ8AwbrpN4BRpYeHEoZPCiCftxX
         vPR8yGPV9CnGyRSDMW7ctHuhGVRHFFfSE8q8D8pC8txmN0jZ2KdSIq5gvMjpAZvoSEQE
         FuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhZxThgFyoxuQkXVr0Rs3Bv05HhD+nUqY4oSH8BKepE=;
        b=an8n3gqfOq7JnFEISBoYezYWO9t8bSxXdvcGXhSOkHmMnsj2g+/fHN+s5IJdkGZy3+
         dZBON2oMcIafBGt1cAUu1+BaKbNHnOvimuNg3DTe6318WYMy/zqtR0O9MH5DDimRfRHc
         /GQCUQlRqrefyHRDN0SKdGhgXrCM6RPwlu8vRVWkmNvAS/JVEvRyQl5F9Ub8vWQkMdmM
         6XdnK4U2In80O3JQI9GEv1eb31vi8jbeMWk4emPmWaJqST7qY9HCOJG3+fNWl1ooRYNM
         prcF1yMWY+yTgjiXdlqjOEtGZp1ZWZKUBehqbSIJ27R78EGHoybx89G5ZFCBPFp1StYa
         alrA==
X-Gm-Message-State: APjAAAUgYM8y3Td97fW4YXXBP/VvuI2E7Qz8p+i6omLbI6Q5m0uYC8+K
        9spqPv5MGMTKAwshfDF7jpqbVg==
X-Google-Smtp-Source: APXvYqyUL/trU35EgUR58ovhkkJ/F73GXNx/u2z2iCw1i1bxrDMO/Qc0sIF8m7Dt5hEE57P5lKxzGg==
X-Received: by 2002:a19:6557:: with SMTP id c23mr2265309lfj.12.1564140475478;
        Fri, 26 Jul 2019 04:27:55 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id l22sm9911343ljc.4.2019.07.26.04.27.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:54 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] drm: msm: a5xx: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:51 +0200
Message-Id: <20190726112751.19461-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warning
was starting to show up:

../drivers/gpu/drm/msm/adreno/a5xx_gpu.c: In function ‘a5xx_submit’:
../drivers/gpu/drm/msm/adreno/a5xx_gpu.c:150:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (priv->lastctx == ctx)
       ^
../drivers/gpu/drm/msm/adreno/a5xx_gpu.c:152:3: note: here
   case MSM_SUBMIT_CMD_BUF:
   ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 1671db47aa57..71397ed3c99f 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -59,6 +59,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			if (priv->lastctx == ctx)
 				break;
+			/* Fall through */
 		case MSM_SUBMIT_CMD_BUF:
 			/* copy commands into RB: */
 			obj = submit->bos[submit->cmd[i].idx].obj;
@@ -149,6 +150,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			if (priv->lastctx == ctx)
 				break;
+			/* Fall through */
 		case MSM_SUBMIT_CMD_BUF:
 			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
 			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
-- 
2.20.1

