Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982F120673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGB9FbQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFXCGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:06:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33094 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFXCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:06:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so10979574ljg.0;
        Sun, 23 Jun 2019 19:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=WGB9FbQVx2T3JTMXq/Eat9v11Y2gonyHtdAu9XeR1q6V9MqvH+gBZ4yLnpkP/EJMC8
         uvWFnSt8lBoH4+juCjPEXRQelX4c/tL52jSJI2xrMH08NPT6UeoEJZiUpbfur2nebINl
         NnTMflcmg46nMUc9vkQnZ1HGgXwhmM1wRTguXR1WHD86bPkNChnNP3h/3PQx1ZS6fni4
         bYIYTqRU9O1zosNCIGt4jt0Ier1vtXAYUftvykCbjlTZib22vgIdY/5DGInlHPYeta1Y
         n6EdTOg6+JyZMaPibCiIa0dFSjkK/56RIwFgX5Araj39ChJxjuFmcU58jZ9N3m0vZ7La
         H4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=MCJJA5+0aFWOgZ9Deroym6tP++YgHa9V0h1lndpJONu/zPSMl1n67tMqzPP27yuKVN
         RoMlTITLHwKKKI5Jq2l4kECewVJCSS/G8iOJva2fLyOD2o07bWED32dGKzi4x4dkxQ9V
         2RFiwwUVSXkqjElvgdu3B6dv3DqIfSEjmXckX/S8ExPfkd5CD6qBVHrH/gBMheBZ2d1h
         VOYS2SQBMdXfEYprR78+A5oNi5+aIjYUn8HyabB5dYOP401DjrSD652EUTd7Eh5VKhaE
         0r33rXLcEl0yCud3Sm9VbTSTPU3n6nitEXoXnvS6d8QbxQqN8XNVFwizzZT8pSdvo1iD
         Wcbg==
X-Gm-Message-State: APjAAAVna+BRD/AAFc9cyPXd4kuzsYnnpsYJ5E07HlvSb2Yda/NkhO9K
        ZczrzKOJL4govaVBO7A3B/ZOS2wf
X-Google-Smtp-Source: APXvYqzIja7BX53S7BFCXeFerJR9iPTb1Y0Uo3fqKswU1Yv4yT8gef5mcb3Ytc1LcdPdhGoct3OdMQ==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr91659ljk.219.1561336320667;
        Sun, 23 Jun 2019 17:32:00 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id y5sm1495146ljj.5.2019.06.23.17.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:32:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/10] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Mon, 24 Jun 2019 03:31:26 +0300
Message-Id: <20190624003132.29473-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624003132.29473-1-digetx@gmail.com>
References: <20190624003132.29473-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b519f02b0ee9..1ce351dd5461 100644
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
2.22.0

