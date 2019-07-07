Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D44C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3675C206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIIH//Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfGGWzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37117 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfGGWy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:54:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so11903760qkl.4;
        Sun, 07 Jul 2019 15:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=oIIH//Abet6BLnbJS+4/o+IqiPi11QG8nuIdaqI+8GjjF5quph+rI64IPv1OjmTJjN
         y+2BTzhk2tWPTifCM+zS+PdqesPnq9FJh2vaDO9Mytwa1OpolTyYIdjjpGEP+3hjjpk7
         dN4dp5z0EGwIMPTdIQfiiPjf5LB9DFqPTpAeYPID5qknKu4kTfIa82gyt30ySfwLApuy
         H8AVEG54cRP5JtTyu2ExoO4BbhQsYZfbtGb64f+TkCV8qt9GZCbpUO1lGhhjKWoOSZmP
         S0gPDmkgsl/phOdj4/veuZiaHYgqy1HpSPNGJ1mPvhgw78wHLNdELZEAHa9Xs7u8S91e
         rgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=Il8z0GFVKPrimJlxUPthiXBJKXutJrMRfgNh5L+FPf/mF66jGrXV4Pl+p26rJBWejO
         qT17CSupSZtFY7b5YOjfeJgu4iDh2HteD1Ok4lbdgFYhdMYcJt9tgv7i+jlIwbbaG+3Y
         hlcUYTfpCWuoIMmG746LcxNVib6xFfgkdr68gj5tXyZ4wwJOatDyZl/LVcyeH86cmpti
         pRGdfwX49VVzFFx5pX+Zv8ftAmU1qDfHBBhiXD6cNLVg17ETYTEc9voDJuNmBCHGkSUL
         MkqPhq5InbAfp3g+/HNdnuhTV08et+aZDEg9lSkrdkHNh+qv2hQ3+B4gouryebqPrBpg
         JaEg==
X-Gm-Message-State: APjAAAVin2G8prB2qndYgis3USjNqCGCTjXkGn7VVMiJ9G75ivQnk8Bp
        xfUifhq1yAK1Pc56UJxvwgA=
X-Google-Smtp-Source: APXvYqzuQGeqpUKUlzeFegeJwqJT8jb1Repp+4LegFgdil4NeMt45ND6g/vNrBEvtXVDm9cjeo+Rdw==
X-Received: by 2002:a05:620a:5a4:: with SMTP id q4mr12112193qkq.64.1562540098247;
        Sun, 07 Jul 2019 15:54:58 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:54:57 -0700 (PDT)
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
Subject: [PATCH v7 04/13] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Mon,  8 Jul 2019 01:54:15 +0300
Message-Id: <20190707225424.9562-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
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

