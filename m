Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A229C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48A320863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuIWFNy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfIHKMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41497 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfIHKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id a4so9878280ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+P+cYx230fGzdea2f5uH2L1U7ubNclgEZwd45XPj+c=;
        b=MuIWFNy4Uu/WuQujI3WpAnPQN7hQjKKrIACQtyJmDl9F1BuOgykCmjH6TEkGxO5kO0
         1r697iLCtkg0JGaT6SPeg/4Z6qdddHsW02ee6t2vqK1f2ou42EqQ4LblJy7Vmj1t5iV2
         rUB+qTGNpoR9VM08EoU+/of9I3Zr+iY2+i2RSikrhZPEp551ZDnIW0kYxmZiwR5TL6Qp
         zArFDlzIksZN+FzgPGi9LAWJP/GMEV71AfbGi9N+RX4poRuYhEYHcApF3n6Ol7k7Le6B
         NGiDjUxneaOf1lHy5+ShuMbBz7pktD3jf7bDJIzNGJDOHYEo73Qn0+13/WlyCvNWm3C0
         DFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+P+cYx230fGzdea2f5uH2L1U7ubNclgEZwd45XPj+c=;
        b=gCe+eEg4roZxD0tTPXyUIp/gYmdKbLyqSPl0o9iNhan6y3nz35ruUY3v3p+f8nWoll
         SDKV+gl6FmPotsQLNKokYQHpGrhCERcogzSFxkAJpAIqLgoKPgBZ4BzPoZlqfGBhAGbD
         L1s0DFGEGxujJQC9+f6wyTIgkIhR+2J1l0+pYoGwn5Ln8HfyppnWIzXUvrEY5C1w3+2K
         pSZ0aPiq95gcV3U9M2TcFs3WPFb/0isM/aq4aeGBcjooiBdy6VTQF36OyJcvuHDu4Bcv
         wjWuEvlfh8n6dZcHk8xXw6kwSVkVb7DKaAMPpcZnq1YH7OrLDWlk80h1rxo4SvJZPVgE
         s5QA==
X-Gm-Message-State: APjAAAXd76umLj2pOh7Lz3zVabXJXJbRqRDlFTSSr9ja1UF9VqKBGHNO
        0V9Sdmi5yOPTERLXeccVol+ZIA==
X-Google-Smtp-Source: APXvYqyeDghhAOKZpDvXuAhHjLZvljJG/Qs1XijQtmIcegh9WgeMYfGtbWrv7shtlHbwygv65v7kKQ==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr8211035ljk.152.1567937564569;
        Sun, 08 Sep 2019 03:12:44 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:43 -0700 (PDT)
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
Subject: [PATCH v2 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
Date:   Sun,  8 Sep 2019 12:12:27 +0200
Message-Id: <20190908101236.2802-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means dw_mci_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().
This means during system suspend/resume, the register context of the dw_mmc
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the dw_mmc driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the dw_mmc driver, so let's do that.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index eea52e2c5a0c..79c55c7b4afd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
 	/* Force setup bus to guarantee available clock output */
 	dw_mci_setup_bus(host->slot, true);
 
+	/* Re-enable SDIO interrupts. */
+	if (sdio_irq_claimed(host->slot->mmc))
+		__dw_mci_enable_sdio_irq(host->slot, 1);
+
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-- 
2.17.1

