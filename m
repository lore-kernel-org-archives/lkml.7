Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D8C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE96214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WY/PSxE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIHKMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33657 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfIHKMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so9929198ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njwNwAwc6r0dkq3naz0El9lnBpKIVIeF99HX8Xzv4dE=;
        b=WY/PSxE68qVV9583kfNBuDbYuUpdPB+qveDxNuOd0xhevC45Z2dpWbWg3WoA4MjpAG
         Mc9TplI8Vz7PzhC8BF/Masppqn+si9//Kow3TlGfcY3MXI/nmOJMNP8gA3KmIZoqOyEv
         WRWSc7+aH7p5jqfiO7PUYleEHDNP5OlQo2NV4lTY5JOJ1SAb9YdoAKs7JHsuNWC+G6yl
         3wu8eSlKNQCSxPPgGe9++aKJ0jjfBSO64Tua3fD7kXXfo/dGaAaKpCefSg2Sugel94e4
         An5JKrcuaZG80RHNmKuTLeH/Dbhc/c845T38mjOOJc9x5QuWwooeWNoF19P63Iw7IzGV
         8dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njwNwAwc6r0dkq3naz0El9lnBpKIVIeF99HX8Xzv4dE=;
        b=kqzD8AbwBsuvhGjyr0f12Tq+dBlrEGaZH5SwRHO+nkFDNpib79lv53E1MjbobacwZm
         U7ocQHlPvkqLKIeBC2fPCf4+heTMcaltZXY79f+g+9m6ty7RSdQq+aDnljL9UDsKHMy8
         MEOqVwxU8XEvaTsvRVYppqzz0bpdjWiauO9CNs+toQZVkN0byrIkpjKN2QjJxCfEs9sy
         t0sMk39TKXh12fTj+bE8xTHcUTqvkSPaBKfBIPFUjNYncg2HOtH14sx+3wJvrZjdPSlV
         XfvrHOBlbOllnpYNsYH5s9HhioYFVP0MokofhqV95SyOFzAvZkXiDLsp92vBEH+kkJ+z
         8N/Q==
X-Gm-Message-State: APjAAAUSWw823X35AvOWYZaXYcfRQQDpZtc1rwmw0/KDJ6iJY3r/cwTU
        /N3LHdv9ds4d5ERtkdxl32gObw==
X-Google-Smtp-Source: APXvYqw5LzDY8B2YTdCvLHuC2pxw+qjmoU1Z7hBcb+FHPXc+nj5c8+wJj+AdAqhGC00CKThlLHZ02Q==
X-Received: by 2002:a2e:1415:: with SMTP id u21mr12369659ljd.22.1567937563298;
        Sun, 08 Sep 2019 03:12:43 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:42 -0700 (PDT)
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
Subject: [PATCH v2 01/11] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Sun,  8 Sep 2019 12:12:26 +0200
Message-Id: <20190908101236.2802-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid each host driver supporting SDIO IRQs, from keeping track
internally about if SDIO IRQs has been claimed, let's introduce a common
helper function, sdio_irq_claimed().

The function returns true if SDIO IRQs are claimed, via using the
information about the number of claimed irqs. This is safe, even without
any locks, as long as the helper function is called only from
runtime/system suspend callbacks of the host driver.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Renamed function to sdio_irq_claimed().

---
 include/linux/mmc/host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..a9d52a4d5041 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
 
+/*
+ * May be called from host driver's system/runtime suspend/resume callbacks,
+ * to know if SDIO IRQs has been claimed.
+*/
+static inline bool sdio_irq_claimed(struct mmc_host *host)
+{
+	return host->sdio_irqs > 0;
+}
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
2.17.1

