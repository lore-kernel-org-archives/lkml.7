Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BEA20644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC/eQ7/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfHTCGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:06:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36236 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:06:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so2258911pgm.3;
        Mon, 19 Aug 2019 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1o9lF1pZgVHiLgtSbSIAOz8s4TWZAVFJmsuylkZmIys=;
        b=OC/eQ7/dbTmz3BtsWPFojIj5Wf/sTMjmzwg66TGiPcP0AAH8kdRZzff2jaszNT6Pwj
         6ohqUXscE/Mw/emlYVQZtwe3BzPDNPqXidoG26mbVci9NfS8ux29dGpRLDV5kOXS1v3Y
         EUojKDRWeqm0QX8ZveeVoMw4ShXb+Jk1zKBgzbqYGv4G5prbbLYeXnls2+SJxA5bql/0
         6HlzcKHcnH5EGKjVHcc0s2aRC0fEttukhfzuteD6nliJ8X/yIfo7vYr1SyPWOqgpjqOA
         TTjPaRkjqUkS9z88iXTfc+p4ToU/8Gh17S5rUtNUezE1uirAnMBFeSP7xAhghQPoUUge
         z+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1o9lF1pZgVHiLgtSbSIAOz8s4TWZAVFJmsuylkZmIys=;
        b=oJYCAKMtkEsO00ehpwSkQ2AF5ThXwWWJy71wTh8g0Brp29Ia22D0eB+wOVTbR2C6nz
         j2gsGjETkBYp/9FEs29zDsz9IFziy4TPopZ3baK3y9s8Wz1HpkmIpfikQMDBP9EBowBa
         CIt+/OOX30R2t2sCkVHbEWkhiNRVMurWogMkj3AiI/S7y5E332/exnsjczgjEm/UgCa3
         /5eOrCI/IXFfKpNxJj98YIkr33tFHNSJCmnYh6kuWUhFV0QmTXxXPBVFpWa2DDTVECtk
         YJje0x+T/QdswEoHxwO+jRNX2E7wJ5oVssdjiOBM6uvDxSsb76+w83fPk2gZabRT9Aoq
         wIQg==
X-Gm-Message-State: APjAAAXIaal9QOKCNPgKY8urfFofj0qBNVHuXhQXOg3VoDYuP1dulR5q
        TEYxNdXPzofLV6bvErwolwA=
X-Google-Smtp-Source: APXvYqyykwzgbtYITvsNiwihk/cs7KMBXEnWh3nQqqaON4gG9KbVfHrbynhg6lI6HessGHtkd/3TcQ==
X-Received: by 2002:a17:90a:bc4b:: with SMTP id t11mr24221494pjv.87.1566266773272;
        Mon, 19 Aug 2019 19:06:13 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id b136sm21570693pfb.73.2019.08.19.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:06:12 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V5 1/4] mmc: sdhci: Change timeout of loop for checking internal clock stable
Date:   Tue, 20 Aug 2019 10:06:25 +0800
Message-Id: <20190820020625.8230-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

According to section 3.2.1 internal clock setup in SD Host Controller
Simplified Specifications 4.20, the timeout of loop for checking
internal clock stable is defined as 150ms.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..bed0760a6c2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
-- 
2.22.1

