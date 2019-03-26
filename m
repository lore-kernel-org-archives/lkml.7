Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A923C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293F820811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtRpJHVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfCZFS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:18:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfCZFS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:18:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so5021581wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=skNEpzEm/S7yvN9Jpa1/tTPD3XXWtt116hN850XD2/E=;
        b=JtRpJHVYPe35+MEw/iMkYbDI69d24+bO1MIxjSWpbha6KQ+85RWB+RLlBNYHK4pMB4
         /hh4hcDeEkQkQ2p8roKonPxQKwAn1BVYAFDGg7h9rc2dbjgyh7Mqy7inu1sbHzH1orJS
         p0evUYB3COoHn4z4Mkm7kiVnIxcpusJf82ER/8N3uvzCXTAl1ZbdgrX5qpvtq3KhAqw9
         2erAFzJSZCUNGsyJELy8JusuKIdtOCHFzSTGfs/koRXs4cryTRF2dyXz1X5+MloR2Q42
         CZ2zLCgxd3lzdcTw8oYddEAjsOeW6M/dZx/7J7WZ6vzb2+XZ4CSrk+E53sVZo5rj4x1i
         st3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=skNEpzEm/S7yvN9Jpa1/tTPD3XXWtt116hN850XD2/E=;
        b=Or4aakyF1uUtPPPnpAyTyXCobEQyEhpiDCJumMT6GKC9pICc/qfStWD5oRnAzxN9Kd
         GTLvfnxwnLt9Q2Wy/EDA2O0ht9HJ9reMH5Z+RGJg6JNVhmIqqT69tjsiMFgp6/WfqX8x
         lOVkmIR8fWnUOisW1b2rWWmR7zqPrIUh8SrIcDl6NRZUVuPvN1NceRnUe8y/EFo4zic+
         b3Ob6rPb1uYeX5zm9P6IpyTI+xyBT72ug39skG6xN8CZpkFSpN5enjmBUfdkZyCgWi46
         SrfS2qtURAw6GMdAxfsdUe0XjB/XvYgcoyh5yYN5VZWxhPIjDBtGJFVgS2zFdjaAdHBJ
         QUow==
X-Gm-Message-State: APjAAAVHq79HsPjxfAWQho2Ur9ayDwf6d5GLXpCbfej7gjJO+O8R1379
        cxLe1uqaPwgoKNiNNd7Qyetj/0dasTM=
X-Google-Smtp-Source: APXvYqxtSw5pvvqyjtDJqicXzY8Lx/ovD/uIiROc9zMKbLTZGv34Wzqu6439ZRpGl6gk/pmMBR/WpA==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr19797183wrp.6.1553577533570;
        Mon, 25 Mar 2019 22:18:53 -0700 (PDT)
Received: from localhost ([49.248.191.105])
        by smtp.gmail.com with ESMTPSA id v2sm16782365wme.29.2019.03.25.22.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 22:18:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, joe@perches.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 1/1] MAINTAINERS: fix typo in file name
Date:   Tue, 26 Mar 2019 10:48:45 +0530
Message-Id: <8ea01476a26ce5eb059b667181262f91873b87c5.1553577179.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325212450.25865-1-joe@perches.com>
References: <20190325212450.25865-1-joe@perches.com>
In-Reply-To: <cover.1553577179.git.amit.kucheria@linaro.org>
References: <cover.1553577179.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace underscore with dash.

Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..d2c5852a3c8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2007,7 +2007,7 @@ F:	drivers/i2c/busses/i2c-qup.c
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 F:	drivers/mfd/ssbi.c
 F:	drivers/mmc/host/mmci_qcom*
-F:	drivers/mmc/host/sdhci_msm.c
+F:	drivers/mmc/host/sdhci-msm.c
 F:	drivers/pci/controller/dwc/pcie-qcom.c
 F:	drivers/phy/qualcomm/
 F:	drivers/power/*/msm*
-- 
2.17.1

