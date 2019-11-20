Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D56C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB320692
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUwoi8nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfKTPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfKTPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so14418632pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UhlgzauEtpF8L0LzttCZ+lpDer0t2cSKin9iOeiQFcw=;
        b=xUwoi8nvephl72akSmRItCtyuVQZnA8izas8jNZj+rYlyPmcb+9JkRl9ag74UJG+ml
         a3AmBm12kC24TpIDbEdrgDbeIDEL0YhjYdsNtrjQjlyM081hL+byOlU2NFU5szpTWYtK
         nfO3e/cnd21wuVHFsY7+BgrknzP5Hem30fzsb/D51u+zIar4n8tLYlXyekC0YXWhkdvA
         nErhGCt2lCBYiU+tfR/AbEGfmzt6paXzzsmdpMshpDNmQ9cIykUgNZT4dGgKlurhWy/G
         GSNYEvibA0+XSoA02bj9PeF2pjP186RgMy7enY0pwVH6wDrrHS62DaHoVH8CpcD+Bibe
         xxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UhlgzauEtpF8L0LzttCZ+lpDer0t2cSKin9iOeiQFcw=;
        b=Yet4SkbvVrSDC08PIYK26njLk4pfytgmeukfyOemepruM0OJA9uh9UMiIItlpzrKH/
         B2AcGyEldqSRqwFKiph/JiFju85MWWZ/O4vVt8tV8YjAVW9zYWImvTK3zYWoUsGflbYB
         Lj0U3f+ZrQXvAbVxXmLnTzKAggxs3FxG6RJihzSgP/MJDDqzJmLG8nTXMMLOkZf6/DSS
         vr3BkLQNktIxec5IPXQ25dc0mXOtsDBmjRQoGIJWBQyt5jl93SmBAo5Z5qHFbEO88VAE
         qufrK/IgJCi0iEstfzcRdGWltpC5TuJ5VSuSY0ov8pEaFDhobbRSq2s0L5rhOYl6LBgh
         slMQ==
X-Gm-Message-State: APjAAAXJZKEJyuNQ8I1tjJ0Y8FO/KusxQieuRkctYk4Bes1dLKAGNArT
        HSbLwJ2oz52PY5YMY+mPYMYKjpimInUOrg==
X-Google-Smtp-Source: APXvYqxkcUp9jMDNLha++k3NBN56jJ2v22CFPJkdR1JKEzFx/AObWFImoUDJuhJFCF2aved+yYTp+w==
X-Received: by 2002:a63:778b:: with SMTP id s133mr4140842pgc.406.1574264731098;
        Wed, 20 Nov 2019 07:45:31 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id y11sm30781168pfq.1.2019.11.20.07.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 01/11] thermal: of-thermal: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:10 +0530
Message-Id: <dc742789bf4b3c8207b01c7946f2b401350536a7.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comment starting with /** by simply /* to avoid having
it interpreted as a kernel-doc comment.

Fixes the following warning when compile with make W=1:
linux.git/drivers/thermal/of-thermal.c:761: warning: cannot understand function prototype: 'const char *trip_types[] = '

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093be553e..5235aed2fadd 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -754,7 +754,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 	return ret;
 }
 
-/**
+/*
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
  */
-- 
2.20.1

