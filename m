Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB871C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89C92184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/ZgkIVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDKWEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40415 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfDKWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so5890970lfo.7;
        Thu, 11 Apr 2019 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pp1ylpAMq1DcvOKU5DqK7TZfKN1qmsD9XOpVBBwXOus=;
        b=k/ZgkIVt47fcoPWCWBk5hWbdPSwH7zPChSsBld5ZnAcDy4qfLRjRhvrSqm8ShVwTTC
         mWCYVTny/g8sSDxO40aHLUioU65rhw1eSAEjyLBBERgc9oez8C9+RNOHc4cZxTImO51s
         81p+JOiTkzlP6HddyB1IHM1gVvmsupbX++L/1leqpi8MUKektvzxjXGt+opvArCHt5Sc
         CTNLpWzlTLPrfrTq8jb9zL1oB2oRIJUHtFLKaccq0zCTgGVUjicsmTFQnbhrTJUrHTCU
         17WKWuoA2aE+UVJxHpYCMIulS1rlfEmMsMyO+CRvgUZ9B9X4aGEjMnCcPSRhVDa0uMBn
         qwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pp1ylpAMq1DcvOKU5DqK7TZfKN1qmsD9XOpVBBwXOus=;
        b=LPXYRa0WAG6thLIGIODm7Q2ZFk/xBBqETn9w+rKj3Zsjj7wa3EPIKxnDli3WH3Cv8+
         /Rql6OWcIh5LraXxTf6SSxo3r2jxWSkiiajvcbKAYg+U5XPUUpHFcqmVIDZQZ7iJRJUH
         z2PJzUTeEBAhbFixRIAIwmX2JzKJmQnjD7lJVAV10RcHcWVM1EOFTyRkatl8WYfEx/QP
         XfFPhSng1R/STh0BJNA1Ipn5ytgTgZeU5ufrqHUxG1V3E1bGFAesO3zYRaGPMisFYtMc
         bf1/96+rwApKNAKnhEe+/OxPcEfdWYKoNATl5DJfXrSZAuiZn9e6T/s7rEXvp0oD0uNP
         sfug==
X-Gm-Message-State: APjAAAWIoNQZLbvGDnax+CTeEPJtaeIB8XK6HAjZVs6T/f7708u2icjs
        JLB/6f69t5r/hcaoyE1j1G0=
X-Google-Smtp-Source: APXvYqxn7l1uDjHXBCNStmQ/tsnv1FDCcDehm0NTAv93ql14E9ymak8RO1YNirI0uDOM7BxLZJCTiQ==
X-Received: by 2002:a19:d1ce:: with SMTP id i197mr13997250lfg.149.1555020267137;
        Thu, 11 Apr 2019 15:04:27 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] clk: tegra: emc: Replace BUG() with WARN_ONCE()
Date:   Fri, 12 Apr 2019 01:02:29 +0300
Message-Id: <20190411220230.21726-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220230.21726-1-digetx@gmail.com>
References: <20190411220230.21726-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no justification for the BUG() in this code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 9a0179235939..93ecb538e59b 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -222,7 +222,10 @@ static int emc_set_timing(struct tegra_clk_emc *tegra,
 
 	if (emc_get_parent(&tegra->hw) == timing->parent_index &&
 	    clk_get_rate(timing->parent) != timing->parent_rate) {
-		BUG();
+		WARN_ONCE(1, "parent %s rate mismatch %lu %lu\n",
+			  __clk_get_name(timing->parent),
+			  clk_get_rate(timing->parent),
+			  timing->parent_rate);
 		return -EINVAL;
 	}
 
-- 
2.21.0

