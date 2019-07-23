Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE8C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D82239D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgXFgknv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfGWDPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:15:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43190 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfGWDOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so28203303lfm.10;
        Mon, 22 Jul 2019 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=WgXFgknvnfkeS7v2+zUIJMy4rqWKOjM8Fgn2kZGqRtoEqxjPpqxH8PTgh4H5L4GE5L
         IKf9++MbTv8QlqOAoxYx3qOIwWLCsYfAulHctkxmMkm43WKysAAf+kpHZExNFd39L0re
         pbFCSFL48+vYRyX6QazYfCIFqbjJm6UglMAb+TBBMEA9lncETtC1q0T+UmFQfShVfsYa
         g0NeknUULHptVmXT5t7ZZfVnR30Yn144X656M8k6EsWmW8n4eyHv3bmFdf/r1zIGca3l
         fNTD5Esgd/BFtx1hRbrJWBGFwqAaaXuf1UlEbmEIVIPujGFF+rUb7yL19ZgtH44SKubC
         f09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=bcCMEnv7DNIZItlPjOCpTSK+uVNeH0ZsCmb+Hc6P5+c/z3O4A7JEHzMkEQS+MFwSI4
         EmwgXXcCSPxDFH5yTSLCrQ1pPrWUEAQTEaq4FUp4dONXozzmrYcCHRMcIEXGquRybgHc
         GOm2lDchMOz5u/wsRaWTfuJjL98+5opxmXAagIgZhUW8pIZbZaaePQB1FCDA/YIYraEz
         eQSYyusI3+WsVUPyL5hGxMN70foUTO7RYj5ZWXfpc0Uu43uXifWqoLDn6stLkG2ygBP7
         9/2QzS1HIverfnHAKzSwZWMlssmD9GafCepLQW4Arc26899PDU13oLGzkZK4ETNt0KN3
         6+xw==
X-Gm-Message-State: APjAAAXCyHEocZAEOInZNjQYw+h5e0Y+F7YP6A1VoI3zaAsLdkpiWVV3
        BzJSGf27yqTs+TvhWuGZfgA=
X-Google-Smtp-Source: APXvYqwOegy2Z+X+IyXXAmnbH+rJc2bWj28ot1MndGzkHRoOKy7hQLB1EGRIWLBmtrFbtvozgRCwCw==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr34995859lfn.70.1563851654296;
        Mon, 22 Jul 2019 20:14:14 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:13 -0700 (PDT)
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
Subject: [PATCH v8 07/15] memory: tegra20-emc: Increase handshake timeout
Date:   Tue, 23 Jul 2019 06:12:39 +0300
Message-Id: <20190723031247.31932-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out that it could take over a millisecond under some circumstances,
like running on a very low CPU/memory frequency. TRM says that handshake
happens when there is a "safe" moment, but not explains exactly what that
moment is. Apparently at least memory should be idling and thus the low
frequency should be a reasonable cause for a longer handshake delay.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 25a6aad6a7a9..da75efc632c7 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -236,7 +236,7 @@ static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 	}
 
 	timeout = wait_for_completion_timeout(&emc->clk_handshake_complete,
-					      usecs_to_jiffies(100));
+					      msecs_to_jiffies(100));
 	if (timeout == 0) {
 		dev_err(emc->dev, "EMC-CAR handshake failed\n");
 		return -EIO;
-- 
2.22.0

