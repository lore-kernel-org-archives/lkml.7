Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90783ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A13214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z45Fjj80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfJORbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:31:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36754 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbfJORbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:31:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so12923881pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7S85Z16eqmxjvMi+R450sz/jCD08hapdQq20bxkJhIQ=;
        b=Z45Fjj80aeFnBh15QFiiV4ZDqGyQ5HJDbtqHNzqjgPSNVNPjO/x2poJPEIrrZSFwpm
         OCMem9CGwlp78RO8LfSd5G8mEF3Nyd2RFh624FvFc7lp5QpQOk+J9/X7AA1OJVuLBMVn
         1RleaZa0ecrjs9JrXlD4ReELJMFxpSUi0gdkDJiF4FnLpedmmsdC1A8CxoITnMEEOsTF
         TD0hM4gvbo4PJAMPxwFtNUirCtNcVbcD6tilIdvWAwLG73xWJC9hLBQGmXaWwpXZ1WS4
         AShMtc0G+WfW6FxqQSAnVlM55aI6K6lK4t8Fct+uwbgtxpNTlvASSWpOURuotpOnAcSK
         /kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7S85Z16eqmxjvMi+R450sz/jCD08hapdQq20bxkJhIQ=;
        b=oUt29fJl4jaLRHrPxNSM8dK9MPJ6tt5MCqrlPa7m+WvG8NldL7527umOorwubMskZ+
         fP9LOawxAVT2g6erCBp2ST5SUqYAhoaogXWpCh5GZaeRJONtfDasmMLDx2INNWYJ55dF
         Z7Zn6TSoxyO6sP1MCof3nFRcpq8JzJUNJ930K7V9GsaDz7MiaaGFn9/oqz5AHnvaFlLc
         dLGBN2zg6p6CgHdzDE2BD8IgkRReSBJawvitpgc7l4ocIkuz1BAZB1rg5mUGEOyEBzqg
         UYus7dHMRK1NKjKybtpLPhmzbHPMK1HXixYqWqb8IeAl7lQR82+ZktjR9Uhah/xeXm6w
         563g==
X-Gm-Message-State: APjAAAXG4ch5g8siVH7yR60iKeHzj2YjKiU4L9VFE919n8encPKOgA+3
        MuQEItTBvoe+27Ed4nBAlsgu
X-Google-Smtp-Source: APXvYqzn4VlP4VPtakQV7y7Ju7xhPBj3ik8f7rFsUS7D6t1HhoQXFgGOrSFOlZClkEbJG1rQSgbgGA==
X-Received: by 2002:a17:90a:9f42:: with SMTP id q2mr43885643pjv.95.1571160659982;
        Tue, 15 Oct 2019 10:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6003:7cb8:25e8:2c45:fab2:b0c7])
        by smtp.gmail.com with ESMTPSA id w11sm28033563pfd.116.2019.10.15.10.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:30:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for RDA Micro GPIO driver and binding
Date:   Tue, 15 Oct 2019 23:00:26 +0530
Message-Id: <20191015173026.9962-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for RDA Micro GPIO driver and devicetree binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..0303502cd146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2150,9 +2150,11 @@ L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/rda8810pl-*
 F:	drivers/clocksource/timer-rda.c
+F:	drivers/gpio/gpio-rda.c
 F:	drivers/irqchip/irq-rda-intc.c
 F:	drivers/tty/serial/rda-uart.c
 F:	Documentation/devicetree/bindings/arm/rda.yaml
+F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
-- 
2.17.1

