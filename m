Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4BA216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1/it1Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfG3Q6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43645 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfG3Q6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so66549009wru.10;
        Tue, 30 Jul 2019 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=E1/it1YfpdyfnWTgwH3yUnql+MLfJL8znOLkgbPFW/ijT8yoUewMcSROyeKTpQtAyl
         dCn6b5qChaXm/o7JZ9+HFflXTuSULgxlHGjxjFitbHA2mrM74ULB08RZqUGmjdZBXDZO
         UwAjkBe0cN87Lz6VFgiPTHegab30Hb4jyor307SJvMUcPW2iNri6jD38j+jG+YcgqUqT
         H1O7i9uDwqr8Rlr30x4Jjng3P0W9qw+soCWDmZL/gnAUw+OU2cImSwAEFxTjj8eMxBDi
         F0i1vxQ1GUoERNlVuaYTrOFfYlmYvo6Zj1p6D3nV1ZaK2HxMYwLawwP6mGiPNwpFrhb5
         xYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=Jhb23OifNG1OoA9ySoAcmOefthmRSstPpmEJWTR2qdvx0L305nGq2GXR8WZbVoy9BV
         K9C4iHMTUTMEl7sduYoVP527p3yhaiIaT3q8fPJn3yrZR7h0QEW2McRT+zbw+VUvbqbA
         jp6Xem41p0r5OIZM03DngT8rfomJE1xC38grlENBp916KRTWqJf5kAkHRmwOAzApnd/k
         oNUE1SLoh0duaHZ6/JUNNsIM/yX3bod8pl73ZYJNgmdGjH7zj2c+8eH80iPicii5Kt9H
         q1odlyO8/jyBkEoihoaugJEsPsVHcdRM+tCeArzk/RES+Kg+iN+QdD1o9M1RAvQYUBl/
         RgSQ==
X-Gm-Message-State: APjAAAU25A+ATY6HxQasAdFilvFbDcuA6nBkK3XI5O/cLjWbZ8Ue88IO
        rmI8pW3LVxlimyhdWUajWSTVI00L
X-Google-Smtp-Source: APXvYqxw3F87deEBWqc6NSz3v7kKGliaLczt45/4GA9Xa3o9ql3vScL73c6GRyiPc+8NrIE/TBrVjw==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr6819166wru.49.1564505897863;
        Tue, 30 Jul 2019 09:58:17 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:17 -0700 (PDT)
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
Subject: [PATCH v9 07/15] memory: tegra20-emc: Increase handshake timeout
Date:   Tue, 30 Jul 2019 19:56:10 +0300
Message-Id: <20190730165618.10122-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
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

