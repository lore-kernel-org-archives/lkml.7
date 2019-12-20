Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC327C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28902467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVoJGKq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLTCJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:09:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41127 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTCJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:09:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so5782084lfp.8;
        Thu, 19 Dec 2019 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1ykwHNme5m8J5pJ5Jtq/C0G/pyWBlt4Ts6VhwBcNiE=;
        b=vVoJGKq4b+Bv6DCzZeTi+Jyt+JCNr+7OCPfYL0Z19jCvyS4toKgfLXZYN9/xeLPoF0
         WOEwn00No/TiwVLw/LNZBQHYU0ceZTtmMg3U3zcFi805tHVz5bZKceTmAkUeFeFEKkGs
         Gz774fHwrwSYtBzH/QDH/vS1pd0U7ZKTorWvvLN2KXqYwCnlcGt+ZTSuwL/BF/Qnfq4f
         6QCfqDLbzZKUqeiCKRQ0GN13fnDD3qALzDpeZuFh43dcOvpgFd6sko91D5vyp91xjDgS
         Ym1Mb4lLhJwm7/Lv8a6DeMHzYqzvyrzAWlJii/1Xy6xRkHMM0ew11WR0IMuz0AGNKn7i
         9EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1ykwHNme5m8J5pJ5Jtq/C0G/pyWBlt4Ts6VhwBcNiE=;
        b=ZCv3dUFYz2irsm1z+CsC9onOrT+YoFQuOs5XZneC/sFhrG2mbQSk8XRpsjkLcTz4rW
         PZFJFYyN5hsj0gZLnJY/mxxHcPAgM2zAfcpx2GIR47K3C3Dp+pP9cCTO3QJ0mMD52029
         sCjPe9zKb+hlPM1YfLBIEcZwyCIyP0ji4qzTi0w7zv0Cq/rt5p1VkjLKABnLFq45nayU
         yHfyQWp9w0Z1lcGXV2DcRThyIHJGDQE39aXptm08hDXpB6ddTBUKQ9KKfM9MRouit/VY
         6HEE8K4P3z7TCrpUUushiiIgKpLvfaZn8XImWYEXhXPUIIe17Cn2Sm/AOvTjsX0HI/62
         XCJg==
X-Gm-Message-State: APjAAAWPQ9gCZGWgiNcyQcvGlq6yCDKjbyKsmYYAVpFmPSlQhbqCn9mR
        wrW9yd8D4VvMfNMLXaveern04atL
X-Google-Smtp-Source: APXvYqyv3gDnqMEXb9QZeoURQRvG4M4bEehRYz24no5L7WLAPJWIRWaB8ze1NksoYI1E8IXqCyFBGQ==
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr7357164lfp.82.1576807764526;
        Thu, 19 Dec 2019 18:09:24 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3279818lfo.40.2019.12.19.18.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:09:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] memory: tegra30-emc: Correct error message for timed out auto calibration
Date:   Fri, 20 Dec 2019 05:08:49 +0300
Message-Id: <20191220020849.11175-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220020849.11175-1-digetx@gmail.com>
References: <20191220020849.11175-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code waits for auto calibration to be finished and not to be disabled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 2f91437a5f20..581565591ebe 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -632,8 +632,7 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 				!(val & EMC_AUTO_CAL_STATUS_ACTIVE), 1, 300);
 			if (err) {
 				dev_err(emc->dev,
-					"failed to disable auto-cal: %d\n",
-					err);
+					"auto-cal finish timeout: %d\n", err);
 				return err;
 			}
 
-- 
2.24.0

