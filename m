Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D04C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C621773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwnTAl9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbfEXRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:24:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42774 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfEXRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:24:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so9315347ljf.9;
        Fri, 24 May 2019 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Qrxk9ALnnyYjcXggRbrooHbezOGaT1OoVydpO/nDTw=;
        b=SwnTAl9IX4msjkpVZwfpJ3W78yvdtmyyJ4vAx4AsSc+DcHNAWJkXgXiDcS5JHH4OCz
         3HyjNOGCTLl+uzGToXkEzdGVrx65joOJkaZnT3SQ8zlSXA0hcFkaaRjIBMgYhVM6DMXh
         GXRKy1vPrB1pa5eilu9NM+G0eSuL7w98wqAcsvVWapsxEwFTuV4LjvIXrKm45Tk81nSp
         +Kuolp+lfTKWcVm2/50LK1NwufkXYJAi6FVE9sJnm9FfygkDjjT6QHXaO5zZ1CFRspIw
         6/zV/2ODODKb6viEJPUAABw1lx/zBselntAHZGviL04rQjLeLI8zBfFGrnK17GYPYaA3
         XZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Qrxk9ALnnyYjcXggRbrooHbezOGaT1OoVydpO/nDTw=;
        b=Fj6LFrIMRoWv9yhqBaJ8Y8mqPPIXGduoXeEUZa49oq+BEBvUEQhuvVmw8ituJmcr+O
         nnNUX/mXzs9+EjlWVAcYlS8z0+8EExXdZCLPaTzlI+t14gI/FlsfxJtDKrSJDh74vtqX
         kz9+d72/J6pyruQq07Sc/RLsy1foER1GMY13rIqh1fc50Hr9GCv6lBSNRtxv7q9bh8Iv
         Yupt6li9lI9gLx+FgIKO/V16hXXfeg8Rw8xBuWtiWOWTQJhYT9Wrxdy5oLrSabmtib7n
         dSshYrBSXwgWgYzVhKV2SbiIOHu4oxJxGlb3oI6QvMjOxFhNlRgYGaAIAaxqkcuAvoI2
         pybQ==
X-Gm-Message-State: APjAAAXrURwioAOvBOXUmT21Vwqi7KOQZ18/3ZROPUYMf56P1zWTmpu7
        G58C96ubEaqNieiDOwjWRq0=
X-Google-Smtp-Source: APXvYqweBkTj2TPwVVxw6UoMopyoh2Nrm2kmKSrcI1J3ZcJSr3ZVKnMJBwbgPGjign5mLIgCbAqY4Q==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr53218443ljd.65.1558718662923;
        Fri, 24 May 2019 10:24:22 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id d13sm196957lfm.27.2019.05.24.10.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:24:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Fri, 24 May 2019 20:23:49 +0300
Message-Id: <20190524172353.29087-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524172353.29087-1-digetx@gmail.com>
References: <20190524172353.29087-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index d3e1f898d745..43aef3614b65 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.21.0

