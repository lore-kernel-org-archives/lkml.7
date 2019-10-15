Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5368C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB520872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHRbHEAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfJORCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:02:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbfJORB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:01:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so21041738lji.2;
        Tue, 15 Oct 2019 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMLeb4rCRknKwJs2ldIvPlE4Vxnf8XUAiOeAjO+3B/E=;
        b=qHRbHEAHSKjIsdIVNhFyZ8C9xJli6HjJrmNPlxXNgIudVULdjbjEIMpb4W6Lwyv3OV
         ASpbuRqSx9yxiybq/Sx3AD3761Pgdf4VR/6X6AZvNLqcfx1om9owTpFkOjqcGXhxdHQ9
         56F3yPgl2ydfJzyTVEDkqO5PUAl6m2QQnpLXLg8ipnI+WPwr8hFTXxT9FuKxOWfuLmC6
         2mwtY6WtLYnbMNx3iW1fea/+zFdv8oiB9KsbwE2/n1o8pxfCgfy+KtGMVzd2Q+TbakAt
         CbTRgur0cb1/VP9xpuv6Fjr9oncFCZPMu5fzo5l8FZEyVYH/+aPMCYi683syF1qpGYa9
         8J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMLeb4rCRknKwJs2ldIvPlE4Vxnf8XUAiOeAjO+3B/E=;
        b=DrZD3oSful6wycVDxzzd7LcoMl0r8Ish7BMXNMlrCFw7IYv3kgogZcqP7qY3LbbLKg
         OxKmvaD9kDGumBqfdZLo28HOHQ1yXv5p0DvDsWtCMFIgUwYNIR4DFnhD2ohjOCL5bgU7
         z4exh+BVTwR3aOCdKUxbiQV92DzZyDR9NEyg3tXzwHtd6khGHMjmlNqm1KIcgUsprvbG
         zJCZVJN+XofA8BTw4cnVZKuzP6gNiPrfDx4PzHkaUdjqcmS8skQeV3FAMSjJyKgeo3Go
         AeRGlPvBsNOyaStFdhvF3eI5X22a/DhB+kKD7U9Q4EhuKCvaxo162CFncz7a6Zq8KdJ1
         9f4A==
X-Gm-Message-State: APjAAAU+3BEUML3vhWRJrwU2xJQ3KKppD9jF52hDzJSDs//G8cPYEFpP
        ShIVIcuARb8WzPX7+vVRtkc=
X-Google-Smtp-Source: APXvYqxPQFCF9LkpmQlTPq4C97WzGBzvjuaDG0tT65ZcTvYvFaKaYV9TlLRRD8DYZ0fQq31FiyQqxg==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr206241ljn.49.1571158914703;
        Tue, 15 Oct 2019 10:01:54 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/18] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Tue, 15 Oct 2019 20:00:12 +0300
Message-Id: <20191015170015.1135-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Tegra CPU Idle driver now has a unified code path for the coupled
CC6 (LP2) state, this allows to enable the deepest idling state on Tegra30
SoC where the whole CPU cluster is power-gated.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 1a2cff5d4ff3..e38a2f6c11e1 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -298,7 +298,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.23.0

