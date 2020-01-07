Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC1DC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D57C2072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kang4SyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgAGBDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:03:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38779 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGBDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:55 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so8483756pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=01+Id1lIyq1lWtSOqQjL5VE6DOGfgbnglBNzoLWDwZI=;
        b=Kang4SyWPDY5jwuddrU8p81GfaKbeSz3yQ17hIiij2L59bPg16XOhZM3WyhfbKAAht
         UVvGQTh6jeztB4DppGYG/ox/57RUfe3MH5AikiQXWjypHeX7Gc4rZVuyK5DTRLP9/DGS
         Eyv7iQXXKMglh8w4EMRVEfaxVAmqR7FNDopAwMihB3Gaoy6XKBDTNAFUsk918jxAG7dK
         qiGiIxXpmqIlkcQtt5s/g69ZrnKRG7aZcxt1a9C5k5nTFPVPmECaiBRIcG67U8AMlXsY
         UP+RepHtuVpERPMscMQNZrh5oYKldcYCpYPcjwuH2FK0Q6AA1qT5lEApmmbKqDxDi5Ce
         G4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01+Id1lIyq1lWtSOqQjL5VE6DOGfgbnglBNzoLWDwZI=;
        b=Wf6CeETCwy6tdzBS9sJR5pUoCmKLSxUpgw2XidJ4EpnWdBHTGRT6FuulETL2HcdcZQ
         QsQKa6kw6SBMAtpHim3mw5SaL89H+eX+Hp1uvUo5ivBHPHneV1gf3T8AFvYgprIgqSRR
         1+t4N7M+uZwKgPu3XpGDNvnFQENwi8EfKxaEOwOiSwJRVKgAV8dTscvqDPsFOFoJw6Qo
         Yq41h+7MYYVi3e5d72+B7OnC79PUv77bD+YSpG11q+atC2B//eyCxfrplso7xslBfvCw
         GW2G3QY5uc/4TsabQeWVS+xt6QThzo26PLHWKSddSczjzRHuaQAHKiPtZtWcCglXgSc4
         lBrg==
X-Gm-Message-State: APjAAAURc43vT+t9Xozyott6LF3XxGUbLDivJxAuLJP/l7FV83WLPTIg
        Ez2upZ0QOv0EGQpqqePhaSkByvlTdbE=
X-Google-Smtp-Source: APXvYqxERV5CCCdzv7FfOIwUwAgigPOmIbTDxqQejSfludU/qlRYpgJ0+ZUoH/RsWHpnHuXTs4gjYw==
X-Received: by 2002:a17:90a:b008:: with SMTP id x8mr44024945pjq.106.1578359032862;
        Mon, 06 Jan 2020 17:03:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id s7sm26749487pjk.22.2020.01.06.17.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:03:52 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: Kconfig: Set CONFIG_RESET_QCOM_AOSS as tristate
Date:   Tue,  7 Jan 2020 01:03:50 +0000
Message-Id: <20200107010350.58657-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
to allow for the driver to be loaded from a modules.

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.17.1

