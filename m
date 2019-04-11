Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14136C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6520218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZwqLB4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfDKWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:09:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40623 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDKWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:09:11 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so6770760iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYO7yPGl77SlvK3Hnow38o1TOlaAvK5sTQp7oXwNnwc=;
        b=BZwqLB4gNsK3tTdafg4JARyz54TI2T1DyAzGfEzYaevFsK8VKqQFQtROrITaYsjkXg
         YtjSm7qFfsb/M+trycr4SSBMPPYSE86xrzACky8yZNbwV+RcIOGmErC4XgtIyHxbrqEW
         /DQcWZ4a8AhkkTpfUfunnYArFgcgdtAou5dlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYO7yPGl77SlvK3Hnow38o1TOlaAvK5sTQp7oXwNnwc=;
        b=KF8hLP0SHu72FpqqB3qq3QeQJr06B/aVpJX2y/gacWsZqCXLqX94uTD4Nnf/VyTMHq
         zk22mrb7Erb0eoL7rzr4+MM4W1ZUPG4IcpqQyk9LTjpUgnIsIvSFoX68uy3gaj5Vn9VB
         Xojx9hb2qYxkFuT1f2dd8wcsc03hw0eUGlxaQpaM8YirCD7AEpTeLnlX2HWDQwF4di6I
         kwg6eCfb2ENNcJej6h7wFox+kcCFNYrg+OcfZVms9XbcawedcS1DqLBJZ0gk+WzM/nX5
         pzD39s/lqU+w4rK17j7COMsq4SMN453IeaLW5BJOXv6vtvizPVBJ8jszLg1+j44vGL2D
         QOLg==
X-Gm-Message-State: APjAAAXn5f3OnlPUVcWr0fju+ZvWQslkZi1yQTgtL8cnQvR67hMgCDYb
        8WxlvHZeMXVJ5rCEcwFXMwSnqw==
X-Google-Smtp-Source: APXvYqxWU7ZztJqQGSd9ylhDY9md3BjC8EJOn6fQ3w2fl32XdRweFyIEcLUgIGJ9BfHvUUyc3haTQQ==
X-Received: by 2002:a6b:5006:: with SMTP id e6mr33428786iob.176.1555020550998;
        Thu, 11 Apr 2019 15:09:10 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id a196sm3347775ita.14.2019.04.11.15.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:09:10 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Liming Sun <lsun@mellanox.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 2/4] mmc/sdhci: Rename sdhci.c to sdhci-core.c
Date:   Thu, 11 Apr 2019 16:08:20 -0600
Message-Id: <20190411220822.81845-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411220822.81845-1-rrangel@chromium.org>
References: <20190411220822.81845-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing to add an sdhci-trace.o to the sdhci module.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/Makefile                  | 1 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 73578718f119..11174945c116 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+sdhci-objs			+= sdhci-core.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci-core.c
similarity index 100%
rename from drivers/mmc/host/sdhci.c
rename to drivers/mmc/host/sdhci-core.c
-- 
2.21.0.392.gf8f6787159e-goog

