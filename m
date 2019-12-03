Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F276CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9359206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etsioX30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLCAma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:42:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46246 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfLCAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:42:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so1624321ljk.13;
        Mon, 02 Dec 2019 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vScFMEW5c6mcmahpQZvLBRpTO1V0ohLenYjntTCVwo=;
        b=etsioX30uZHdnWnYOmYEBjJi3Q+cfI/5mmTEm5MQ6/zv24CfUkwa9OUTLzGD6T+CcY
         hZ8Z/0ttdiKFxHbKRz7am+uBNHhRlPQw07qoQS/9v+vywxpRlJxvJtjyHFk85MOx2FYc
         3ygHgWSlY8FYMk/pKX4oAzQqqzp+nKamEwGJB5/tWCNxSF3eNQwWCQ7h4hpzv3nn8Gei
         1Cgx0/tohUMzIbHubYqrhGXtiETxkYXKjFQ515ImuYtWckNK1WfXH4/zIyrOR9DlLjXm
         Pfm+NSm9EgDIJemDuCPn2LOaFiVLvO7G4tXd1R8db7Zm048i56ZRsHF2GO8WAVHq3PKe
         rb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vScFMEW5c6mcmahpQZvLBRpTO1V0ohLenYjntTCVwo=;
        b=DW/HcnXzC4+KH3iyLXm+GHNdXlo5sXmEJlc/EiD9YYGc3adUQeIZ+IWMeHS1D47CfD
         RMF6ipN4E0PsYOmL9B7SqCSzBn13BkO4GqVnbAb1REQj1kjb2TuaTMwen7p+XFLP2+5F
         IVHZr0LQg9p6jTzTviVB0htbn+gw5JOXT2Vq3klM2uvkdod/EJdh6AlsoEVQANOAUxT3
         Td5vclwxXD+1TKWKlU491YDsllCGd3nJxdxhlB8vXdDrmpP5YR658C7E2y2+hH1DqwA/
         zW/Doj6/F3mgmu+y4sqIvhQsjiJjVIYQbDegc3yGiqIYDHOR1OIxqwTolLTu4U6eOXgj
         IYSA==
X-Gm-Message-State: APjAAAW7C/89gBLauD+BzGoInPlkAKz+ZnvbnGYFPR8xJ29yxq4bI2SD
        2VFVVuNE4gu1YwuMUYFhv9PbgDkp
X-Google-Smtp-Source: APXvYqz9xkaiorJSpQ2XyvedcG3TqAAgSLBV9czN755y6OVTLrynxhsLoLgj+T5w/yJy+Kztv6GZyw==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr864195ljh.21.1575333736974;
        Mon, 02 Dec 2019 16:42:16 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 15/19] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Tue,  3 Dec 2019 03:41:12 +0300
Message-Id: <20191203004116.11771-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
index 828b30e352ef..bacc1d1532cd 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -312,7 +312,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.24.0

