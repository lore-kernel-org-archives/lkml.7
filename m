Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEE3C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 04:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDBB207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 04:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P7ZzXL12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgAGEJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:09:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42171 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAGEJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:09:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so27841354pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 20:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UbDGfz+Zv6xQM4bcQDYbb7lyZLmyc5f8z1Itmiihj5E=;
        b=P7ZzXL12d6nzFrfsOQH7cZ60lX/Skm8S2B2/8CYu7pgFaR84V4+X0XLgWZsQAIYV9Z
         kXS9/VEgm5233KKw8jzFsG/PQgNvohqYMLSu6XS2HwF3LnGptQlDpDQ9/IGNmlV+sjTR
         gwwTyZTy7ZKUbZIPS3eKJqDd6csG9+QyEImwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UbDGfz+Zv6xQM4bcQDYbb7lyZLmyc5f8z1Itmiihj5E=;
        b=lqWdCWSDoPEUHwxAwnlTnbOI3yK3tdsH9xOw0KoxWQO0H70GfArJnqyUjdcIrVIIE3
         5NoqDqN9pm+K0xiwyeUNg5rUS8ul1V0w2lmB+lnXfqj59cOlaB8pii6UOuSCgRLUr1Ib
         etEdOA8pqSp5wrs7cOMw5XBsekCT+eNhprRqQWRCINS9JiseExRnCJFAMXzvy5a6/OIc
         9WTCWpp1m7WkN34SMI76aGGES/tC2yUQB/SZZdnGWF6NKyQHJ+FIh++ijvYc4JSfyT7d
         m0duSN9YakNsa4XQqztqlMpFIl1iLdGr5s7Yvwatvh3lZBYNRBBhCb8U6qlgy8njg2st
         24SA==
X-Gm-Message-State: APjAAAUixGSd87kPlt9ib3PPiKjFwxzycn+AYWeanH3tAqCl9v+fE6Wh
        8zY4v9JMbeXGJQzWDNjhGZDwIw==
X-Google-Smtp-Source: APXvYqwCRqwSnTJPSRlsXvvZZojFZ5FxBSbE1N3+S2c5ISE5p/eR35zjbZydfXoqInwd86TvLoWRrg==
X-Received: by 2002:aa7:874a:: with SMTP id g10mr94042109pfo.205.1578370170296;
        Mon, 06 Jan 2020 20:09:30 -0800 (PST)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x65sm82920355pfb.171.2020.01.06.20.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:09:29 -0800 (PST)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message
Date:   Tue,  7 Jan 2020 09:39:12 +0530
Message-Id: <20200107040912.16426-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform_get_irq_byname_optional() instead of platform_get_irq_byname()
to avoid below error message during probe:

[3.265115] bcm_iproc 68c70200.spi: IRQ spi_lr_fullness_reached not found
[3.272121] bcm_iproc 68c70200.spi: IRQ spi_lr_session_aborted not found
[3.284965] bcm_iproc 68c70200.spi: IRQ spi_lr_impatient not found
[3.291344] bcm_iproc 68c70200.spi: IRQ spi_lr_session_done not found
[3.297992] bcm_iproc 68c70200.spi: IRQ mspi_done not found
[3.303742] bcm_iproc 68c70200.spi: IRQ mspi_halted not found

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 85bad70f59e3..23d295f36c80 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1293,7 +1293,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		name = qspi_irq_tab[val].irq_name;
 		if (qspi_irq_tab[val].irq_source == SINGLE_L2) {
 			/* get the l2 interrupts */
-			irq = platform_get_irq_byname(pdev, name);
+			irq = platform_get_irq_byname_optional(pdev, name);
 		} else if (!num_ints && soc_intc) {
 			/* all mspi, bspi intrs muxed to one L1 intr */
 			irq = platform_get_irq(pdev, 0);
-- 
2.17.1

