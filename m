Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362A206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqYTASlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfETKM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:12:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45619 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbfETKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so6475343pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=va9J4UW4i6NFUGtzfpaY8tfEC/B62lw3LIia2oCGJ4I=;
        b=CqYTASlzHxuj19VEkiNYFaWBgj/+AcONyfvUgSBiBiQDowtzgjclMCFW17Cx6Liwr/
         yTHpl33VMY+PK1nwAw97ptE/aov9Ny5Gd9CDUPr0BmI6OPlfMVCa88nBG0nfPFrWKmc5
         4xJmj6AY4t13zS/X2WSYUqFnK48emMw1jtHxivKXmKM0FLP1o78D9881x/AX5Y5H4trs
         BR7RWlDcGDLZXJQywZ1nZaZE1slyONTDCdLubvEOiOJ43/lPQo5uRKtVdbjKNxgEFBYR
         psxab5AHlmJ1Xmw4MdgUFX5yEcnCO4VWW9lbwf2QlwniZg7uBKRAoLg1DUSzr20QZmNr
         5xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=va9J4UW4i6NFUGtzfpaY8tfEC/B62lw3LIia2oCGJ4I=;
        b=HHOLqPj3rwmnr1A7tqj31ystB01infypOl7QvKT2dS0x6hItRBY8MfHPUsbCbNq1jh
         elGTBKN7dyzsGPO4x93iWhR2ipC9jdsvXNpCnchm0CX3UEAW1U6L6x6cnXqCTcpMJTdy
         BcYlBcA3t+4LJfo6EjVDZtaymNhNTy75Zu8CDYQ52aU05RYHxa3p1/pTa9/tEuSow4Ac
         s4pQ6hOx0ncU2KBpvvKyBlVbzn2EJBcS2A64qDpQYRh8knMhSw3wRPgVqoy3on2ML/NQ
         5to7+oM5uQl7G5QoSL76QirmQsbKUcxcCMuOViD7IBplk/9KCPYwijKuww+av49QIGn5
         vvGg==
X-Gm-Message-State: APjAAAUIhbzVPlzi6oZUNGEVC+Ej3aIbcok4Re0Y/RnKWevtlnlL0N4k
        EVY7UiV44FoR3NO5NNZJAL5/zA==
X-Google-Smtp-Source: APXvYqy8HueQjfTYyMBchyG+3yVOgHldG2Viyebm4bLNlkUI6Z3Kj5vcojNZbJJuuIgiyzD8yg/meg==
X-Received: by 2002:a17:902:f212:: with SMTP id gn18mr12999942plb.106.1558347147096;
        Mon, 20 May 2019 03:12:27 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:26 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/9] mmc: sdhci-sprd: Check the enable clock's return value correctly
Date:   Mon, 20 May 2019 18:11:54 +0800
Message-Id: <7e4d922ba5aff5241b0186e9480a98b14693b28d.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed to check the enable clock's return value, fix it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

