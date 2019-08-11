Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E712C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B642173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5rqKHTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfHKVBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35691 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfHKVBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so6654234lje.2;
        Sun, 11 Aug 2019 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=F5rqKHTkuGSItl/SFJhzPHsZ6eWEUZ8635fYyEgq5ZlwiLOcK4tipDB/UbnauYhhwK
         /OnIt4VL0FZR8yf9Q6dQvCC87oQjhQ/89Ebjxus5J2iF2a4+ucdnTQy7gcdsbhYr6HFJ
         CJxJrlSEqCi1hb61nTtbF6SVNieC5dWly8e9Gt3H7g+lBVhvmdav/iexwwVOLim8tcMY
         FeN6nVoqCwqH7t7MVI+7P3jddRgabUMFjpOKHFSNM2Y/crCpjPuk2O6xbFYlvx+M3IKX
         4Ck7cZv4ffvV9hiVaxc//7SLK73wQxWm7pmSL3eoG4+BQ12C1gy90X6mapM7xz6l2fCk
         g8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=hJydUxaFRoL9KRyULvOFDwtXqVgZgXBxx7rfv+6eyCrUpOiyZQWNVR4pOEK0wGs+bg
         ZsAJ087Ki2UUKEkXUAOz3ZWi58eV3iqH75u5KjeI4AJNQTN2rF3GPA+hLhu2gk2G0UIw
         9uI+rr3hsdLmTi6Qjgw5d+3iGAekIRjrOR3OQWVDdrwljYMNGd2/J61EsuBNAD8QaUjF
         3o3QLyIbahecmE954lQV3UqeG7cFE7bWBez5TTUCGq9334dtY7G8X5Zwvx0gHwo03Ugb
         lw7uByknZi0Z5zHkYznV6cImU3nHytIIiHFjkFjqcZduS2Mw2ZI49e0x2WAuR6s/42vp
         nmuw==
X-Gm-Message-State: APjAAAXs889tOnWuHjtH1MrfVkSYmDpl7g9Q2eJ82bKiwLPsbepBoUUO
        WByEubvHLeqxHoVuOSrM9vE=
X-Google-Smtp-Source: APXvYqxcN3oLfWoRraakU0W1WjQJGDJ9U4FfsahgMk7CkfOmcMdmW5toIJ6pHWweXWQCDbvc/i5LRA==
X-Received: by 2002:a2e:7001:: with SMTP id l1mr4743724ljc.48.1565557294756;
        Sun, 11 Aug 2019 14:01:34 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:34 -0700 (PDT)
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
Subject: [PATCH v10 08/15] memory: tegra20-emc: wait_for_completion_timeout() doesn't return error
Date:   Mon, 12 Aug 2019 00:00:36 +0300
Message-Id: <20190811210043.20122-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interruptible" variant may error out, the "uninterruptible" not.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da75efc632c7..1b23b1c34476 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -224,7 +224,7 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 
 static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 {
-	long timeout;
+	unsigned long timeout;
 
 	dev_dbg(emc->dev, "%s: flush %d\n", __func__, flush);
 
@@ -240,10 +240,6 @@ static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 	if (timeout == 0) {
 		dev_err(emc->dev, "EMC-CAR handshake failed\n");
 		return -EIO;
-	} else if (timeout < 0) {
-		dev_err(emc->dev, "failed to wait for EMC-CAR handshake: %ld\n",
-			timeout);
-		return timeout;
 	}
 
 	return 0;
-- 
2.22.0

