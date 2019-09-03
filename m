Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89C23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP7NBDNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfICOWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38099 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfICOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id h3so9390976ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5QBbUbIGIGd6IsxRdoAWwzoHYpPt8QRqVo3tuh083M=;
        b=RP7NBDNto85o8qwpd+eBtArA8GsDbwZzo/N21c5w/x6H5zZ5ZPvBKOgT5AKNZjn4UQ
         VtlHjUycq/Sjk7L+8sIg5gVnv9YNWJl5mP61BIRnivL/jWz1tFolfQUSHRItCk0FfYBB
         tTbntNmCtOIEAtIBHrJLVQcmfKNvs03l4FAeYhME9rQZYWB2FEJ58cmnmtC30es9NDRV
         VCHMolZ3jrdPU57/NxfzMw6I7vpgpIjQyMAfJrwOxX9/5dccWgMqFFjuDxfa0iGilerx
         7mr+AforWPw4ExJA6GKojspQDjLzq8ixKdjDidfmy3xZkXBIoaTRRLSfwlfYKC72AKzE
         OAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5QBbUbIGIGd6IsxRdoAWwzoHYpPt8QRqVo3tuh083M=;
        b=sPbTV5v+jnFnEZA/81JJZ9kVvDNCHZ3UO4OTSg5txYQVJ0z1RoDHjyZBQhWKZU5tY/
         4wSuNDkNMSIyJb5UYE5+jg9Kp6FRLRHebXsGQUCsPabCW05eRlzyin//4EF67h1nj7oS
         v/P/CYe/iOG7rBcliAVNdsFb27iCnrIAbNXvJPQd2Hu3uBn2x0GdPeJGxcqGzHNGDfo/
         0wB/J0RZVWH3bbEcrmIZddWBfoVOHJ4oIrfKwvd5ImryhC5hZpEmRyyYomCphKnjFjIH
         nrOciQzg/UD0En7CAT3fdNbLL2p9pxFDbtfQN1NkV47REVyQIoDYR1l4Za+pZjJHLx+m
         z48Q==
X-Gm-Message-State: APjAAAXcsbgZr1f4k5BtxhxijING13OsBzSt0HtYcLSbT+dBGMsODCrx
        44wKeoGfB1w1IkJPILSKuQCLwQ==
X-Google-Smtp-Source: APXvYqyYZS0LZ/x/v3d6oArjV2CxJmO4miYGU2bMEsj46wakq+VgwT1upJ9K3Ttnb344DmtcvFVNBQ==
X-Received: by 2002:a2e:99d7:: with SMTP id l23mr1996664ljj.86.1567520554912;
        Tue, 03 Sep 2019 07:22:34 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Tue,  3 Sep 2019 16:21:57 +0200
Message-Id: <20190903142207.5825-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid each host driver supporting SDIO IRQs, from keeping track
internally about if SDIO IRQs has been enabled, let's introduce a common
helper function, sdio_irq_enabled().

The function returns true if SDIO IRQs are enabled, via using the
information about the number of claimed irqs. This is safe, even without
any locks, as long as the helper function is called only from
runtime/system suspend callbacks of the host driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..0c0a565c7ff1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
 
+/*
+ * May be called from host driver's system/runtime suspend/resume callbacks,
+ * to know if SDIO IRQs has been enabled.
+*/
+static inline bool sdio_irq_enabled(struct mmc_host *host)
+{
+	return host->sdio_irqs > 0;
+}
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
2.17.1

