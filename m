Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A34C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B4E20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFzZCC2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAGTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:13:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgAGTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:13:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so321291pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6RBmiJn3vvepXtqRcMGLSKLPe+MyPC3dovzqBwEizXA=;
        b=wFzZCC2hB33q5nY3rpG9BYRlJ/DYhNrwDyCwXgKONEPUKS3BXUkldZiReSMok1g6v9
         fWKk3uH02Nhtz7bLWpvywVrDn74I5xa2e+HMjMvAQBQqBk2JzcCCfXxuV/+pta4RicV9
         9+/Uk/RapzTX40UqT/ywy5aGPY0ZiidgpkqtUUFHJXA+p5+syoJfCyqjGWFWUCK/EP5a
         bLB5Mz9BSZiYjVA6QDtUroljmr8EB2fYBv8md/VRlfgPmdv2JHJLD3MpcqlUklE2FBk2
         9e/tBHYTzeVxbN1+/N4vrbGU8/9d5G16pWwvC/FNYDEcymXw7awACZ+MmJRgmFwD3uR6
         CXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6RBmiJn3vvepXtqRcMGLSKLPe+MyPC3dovzqBwEizXA=;
        b=W0b2KN8CnNijm9xLxw1nI780TktxDcyLajXIlYudDQOH92NaesKiV8cZO1Jc0KGDsi
         B8z8WFyl/uZ42/caHDji+JY5yMVvcvvYpHOK0K8Xc+DtSouZ6/6NW1aQMa3sHch3+WLZ
         sp08AgFMivBPRlfcZMc7D5tJzwNtSJDPUddL61k43cC/JikO8AnEaUwoy0owyGOiQ2cr
         DFr0FIyG0P829vDqIXOF2P8CBS8wbTyAcl5nU+iwzdmi6BaHswqdYNdLfChUosl1tIxX
         SBtfxJ4ibm9DHi/+FDrzkgU+qfbkBPfzpEZWDmnKsDJRAxXSWh0jSf/J00JaJgdBK9I5
         PpZw==
X-Gm-Message-State: APjAAAUSE26mTS7KAnKo5p/T1m0phqVpO5gtizasfn7Qfo5g42qfo7Ft
        QnyHBKNQGkc5Kql7xpk2SKBZoW6Xt1Y=
X-Google-Smtp-Source: APXvYqwbkBG/N2jhyFRdAjvg2n/kSukzsNcutGD97tUBd4I9jnC9OLL5RLn4BeXSX8pova0uoKEnmQ==
X-Received: by 2002:a62:e80b:: with SMTP id c11mr830599pfi.28.1578424413489;
        Tue, 07 Jan 2020 11:13:33 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x132sm296324pfc.148.2020.01.07.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:13:33 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2] reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be a tristate
Date:   Tue,  7 Jan 2020 19:13:31 +0000
Message-Id: <20200107191331.8930-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
to allow for the driver to be loaded from a modules.

Also replaces the builtin_platform_driver() line with
module_platform_driver()

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix builtin_platform_driver line in driver code
---
 drivers/reset/Kconfig           | 2 +-
 drivers/reset/reset-qcom-aoss.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3ad7817ce1f0..45e70524af36 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,7 +99,7 @@ config RESET_PISTACHIO
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
 config RESET_QCOM_AOSS
-	bool "Qcom AOSS Reset Driver"
+	tristate "Qcom AOSS Reset Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  This enables the AOSS (always on subsystem) reset driver
diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
index 36db96750450..76367f17fc73 100644
--- a/drivers/reset/reset-qcom-aoss.c
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -127,7 +127,7 @@ static struct platform_driver qcom_aoss_reset_driver = {
 	},
 };
 
-builtin_platform_driver(qcom_aoss_reset_driver);
+module_platform_driver(qcom_aoss_reset_driver);
 
 MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

