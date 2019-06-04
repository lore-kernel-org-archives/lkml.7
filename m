Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286FDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F115424DAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvCoOxV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFDIOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:14:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFDIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:14:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so211523pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tvMJ5s9gExvOA7lMPut++cP3zHcPvryLWLVuc4mHs3M=;
        b=KvCoOxV2rRHo0LP8pHEGJKzTvkI2+KlTgGiFKUOXH1jmu0LkQFTIONu+GiJg50suqZ
         JdNVybOqlsfUGfx1mhiI2TS+zH2KLWFXdBS3LLxm8xLhFU3eGNeI6zNvWmmqeWjytp5Y
         42gcvY0eJ1ul3Rn/5joOnaJZP7ozr6Y7K59xNy9vWZpUXARufZCxqXgNfpJzx/8WS7H3
         NwWpPhg4ROVRzKll5FlPSOfHhuB26wbtju1fX9bkRpOkQgecgke3eOQmCZZnsJ0x/XOM
         SUjWi2fXYc2UWco7WrnJfyA9cyRnPH5v8KnKBromZG8cE2HtOS758i5ajacD+nXKM/QQ
         6zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tvMJ5s9gExvOA7lMPut++cP3zHcPvryLWLVuc4mHs3M=;
        b=QCRi32rzi16jmeTSOpmetbViJd6dildAqSvk7A/Sa1S/T9ScjZtISWrpPkd3TTN3o0
         YS7hrr8A0j0nMJsyeZWo7TKH3uZZuRuHJLsidD+yOrBkSqPsf1qeLA7STESxbv3PD8qB
         WyXrH0XkWFYrTXcTmn8Z912nxh7d9EXRVx2EVxZOGpoaosU7Og4cjo9TU90TrxHKkd6x
         9IfzVpXdCdrKhwp2Uo8mfinYTIkgc4OvZOy91rfWeVCUdyOJmC306VanDOUiMeLWZozp
         3NrnLDPMHnCDfaH7/3u02W/zo5jVA1Xxx0JrEN28uHJ7vKaBy4EvIdt/8H36o06qcb0n
         ACYQ==
X-Gm-Message-State: APjAAAXRQeFvwm6Yq0D4hpW0ZFzWIWVAiI9F1jUVROg64MBG37BqjoqD
        iCFHXhBOLMWxUL7inIbj5Wo8iA==
X-Google-Smtp-Source: APXvYqz3oaHjaeADX6D9WBKXX/1VIU65dXOf477C7GTyXt8pCwH2Xc5XpXXOxK2eShfdWLpu+lZGhQ==
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr27207253pfr.244.1559636093172;
        Tue, 04 Jun 2019 01:14:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] mmc: sdhci-sprd: Check the enable clock's return value correctly
Date:   Tue,  4 Jun 2019 16:14:21 +0800
Message-Id: <9c76f06c8ba1762c9706f2c20878bf39d46370dc.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed to check the enable clock's return value, fix it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 9a822e2..e741491 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -368,7 +368,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
-	clk_prepare_enable(sprd_host->clk_enable);
+	ret = clk_prepare_enable(sprd_host->clk_enable);
 	if (ret)
 		goto clk_disable;
 
-- 
1.7.9.5

