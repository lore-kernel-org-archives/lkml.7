Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811DAC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF1208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnS7+qpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfEEPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:49:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35616 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id d16so336523lji.2;
        Sun, 05 May 2019 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=dnS7+qppHSSWTQAjd3Qs9OKsoLpbjk6F40uemGM2JuXX26F0dwb+mAa7BhF+kP8zm5
         MeiAn1AGbJjRIAU0zehfU6cKpLg+O1HWITIdUUlCje600/LtnzWucXyBGDspJWnmQ4Pl
         tGrvVkx7kB3P6N9DKjjVyd6eqyIPNrCA4QiiMt1ZjDO4kApTkh42RzOSp3Pj36niOkhJ
         8KR59MwgiG7hzvEG8wSsqb5Dk91yzH1aWuYoRREZX0NiS9edfHIqG5YrqLnWVyiqRPNF
         kdj5lSns7WdRczN8b6+5xBfJTws5njth9g9zsdXAxbZ4Uw2u5lOziNDD6Bp6N00SAmxY
         AaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=YeFetvN5hjFBlV5nT3ZuRMYmVo9oTLiL4gOwBRkPHTSqs73fgsLk5RXkfMRvvPmO0q
         V6xo6Td15/2b3VutvSSzfMAmGdgNz2tv75bg41fkfMIrVaO8d//MMSqgqUAo+eG5wP3l
         7/QM5OdCh4xeZ6NCidp+g1ZOBtjzZLXl9baTg1hgGbOqeTS+R6QXOq4cpwZONftVJ62x
         6/op5OUDxANMximld3/eKBPON67SUjAo9P3AuOkvUzwTZ6F7KqgxyeSzepyGZn3yP+9g
         VLDCAvmqHKz53vinM2OuNzu7Nrxb8huy1p2qR2olxvb7pJNmN3GZsK/X8mPCFhWU7CSk
         8AdQ==
X-Gm-Message-State: APjAAAXtpu0xqr4g5CGnkcXXsxF8/GnoSHTWYx2+AK+gdghpqweZ8jyN
        1ugPtdwvYPzTG7rRA4MKu2g=
X-Google-Smtp-Source: APXvYqyOlACPFocWylB7YNiciRdAEbM2X9WBfpsvUWPM4PoP56c6GucMLT5B0j0mudKA6pSsCFuaGA==
X-Received: by 2002:a2e:3311:: with SMTP id d17mr11152459ljc.52.1557071315555;
        Sun, 05 May 2019 08:48:35 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
Date:   Sun,  5 May 2019 18:43:22 +0300
Message-Id: <20190505154325.30026-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPS_PERIOD_MAX_US definitions are swapped for MAX20024 and MAX77620,
fix it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/mfd/max77620.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index ad2a9a852aea..b4fd5a7c2aaa 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -136,8 +136,8 @@
 #define MAX77620_FPS_PERIOD_MIN_US		40
 #define MAX20024_FPS_PERIOD_MIN_US		20
 
-#define MAX77620_FPS_PERIOD_MAX_US		2560
-#define MAX20024_FPS_PERIOD_MAX_US		5120
+#define MAX20024_FPS_PERIOD_MAX_US		2560
+#define MAX77620_FPS_PERIOD_MAX_US		5120
 
 #define MAX77620_REG_FPS_GPIO1			0x54
 #define MAX77620_REG_FPS_GPIO2			0x55
-- 
2.21.0

