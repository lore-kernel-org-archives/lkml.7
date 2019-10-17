Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC0FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50E2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8ydhIBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502343AbfJQM1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:27:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502333AbfJQM1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:27:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so1551991pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=H8ydhIBW4Hdav4jAbhdZFLfJHJ/rNTYXcPXSEpoc1DBwisHhHI2hsG9clVYOgLtj5Q
         lwx83X6r3G55GLeR9g55BvIxOwYOzNyZeHAmUKLgPyo5rPoXK0lxel4Nrp+YnCViHgNS
         GtvuCSCCb51pgg5WL64XgulygN4+2/iTQa39xCZjpAkuwLrkRehJR9O2DPH8k/F1ARfs
         IRPkGRYPhsEr5qrRWF7lytjQ7cNCDA0S2kJDoVsXnh8lSVkgwkN6YNmstydqRPPieqpw
         C3OsKtmoRM2XSUxCOT+zeAfxj7MuKI+45kSs77GROL4WWApel3iJZTmUv+RsR+Q+WMpb
         Y2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=eimEhYg2h5UCYExpzC6iR2xcTXcPLq+8EL4nUlGTQx6/J/AApiqtjMq8+FO/UDSdd0
         6fyPdHCbUmObc1XdYwIzPKRBsSVa56lI+BMPfocT9qEi9w1sL4+614WooZBqwqU3nH2R
         MUSdp634xM4HggiCcip31yAjfTF6Yl8UKRUUi5gbYkFbzEu92dHOWyzuTzFZzIlUDGbj
         FcDisb9K1H/xmEDhvlcV2DmwLcPz9Tx8V2Au1hp62fIOfX7FRGfUWu73fmnCU7vuUlnV
         Ad5AHaoFz6brQPNVNPl6D3QBdakr40zhxfemm6agbqCIXB8apYOtu1ZjT3QFOrWrwFQk
         72JQ==
X-Gm-Message-State: APjAAAXoO5lspd1HqVcFfx3+F30+BwJEubXBkhc2vG+kl42G65pJ6It6
        9E2ptBpTH3DquXMUfZHpKP+5nTkZeP/NpA==
X-Google-Smtp-Source: APXvYqzmKwMCQLucBl0CUBU8zqp2eDcOrDP2n0WXsN6rWk8R0BxLYnGg7GBjIvPXLmEI1tpdhJpSDw==
X-Received: by 2002:a63:1f25:: with SMTP id f37mr3859122pgf.50.1571315271392;
        Thu, 17 Oct 2019 05:27:51 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id q76sm4615049pfc.86.2019.10.17.05.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 2/6] thermal: Initialize thermal subsystem earlier
Date:   Thu, 17 Oct 2019 17:57:34 +0530
Message-Id: <cc2aa18e2e6004ba099e69b41d0d505a4361443c.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d21b754baee2..d8251d723459 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1537,4 +1537,5 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+
+core_initcall(thermal_init);
-- 
2.17.1

