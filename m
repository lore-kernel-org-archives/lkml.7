Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7218CC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A66208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOIFu5q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfL1Ugi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37941 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfL1UgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so7881714ljh.5;
        Sat, 28 Dec 2019 12:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7a3lxaMDdErpekYLxYZCSpGszEjiHMz9VIU/9b2FAA=;
        b=rOIFu5q20h6pfPTi2R/Hgf5zEf9HXzEYD8z6XRgs/pHcP7CZeujybQP4MbqLAPoimW
         8P40MW0B1iW0bgOptXotu1Z/P1JX7E5LHvKR3Y5RyPU6oAATbCgntODNQz17e0j0/DK9
         hVvqOn+3pvaxxxFpLNTOZXD6cAvfReJWyouidlIaw5B53w7ql3VekIrvF03sxl2kLkEE
         lBgP36kRDTBvK5meACUWnQWN6uXP1FXsrCQcqTBI5MWMKrnqtrgBtZCIPuVnNrAQaDqJ
         iXqcqBYYw4Lq13Kmbugpnx5aELzmA3Akmbi3BB/yJEi8NtL4912Sj9V3o9YMCRLeb3TQ
         sRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7a3lxaMDdErpekYLxYZCSpGszEjiHMz9VIU/9b2FAA=;
        b=b6FioKl5c5Z01tuqPQkUeSBPe6Y2t3RQ1Evt0ayiQst2ts57itcFb2xOTrHVjaKUth
         phqkZIhVtbfYuK1kmAC1nCJ6Lc1z/5Kkg8p5p5LM4V+QWjRfOCMnc30i90BdmeGCY3rS
         t4rePl40fuz6KlVkSXBp9Eg4SqbTVVAmDiHFZSDS6ZSKvIlMQycMxRHM4s+zgBxOTG2L
         PCGW89ng01uGyfnWBHp/QFW0oKesEhApekmHSBPrBQ7smWH/B0oWkcjZtRgUjIj/W+Lf
         rQqPBW1gLcQYFlxxO4EfEXfLC2AX+u/90nroc50oqfj5duCxbnRz/IaVdVhl7WS+2gTW
         tVdA==
X-Gm-Message-State: APjAAAUsP74wlwq9SKHeuJw6HeJTyzR1J5dXhPFB333uxFc/6oQSKqZb
        m2M08ggG2BZ1qeCiy3P3fB4=
X-Google-Smtp-Source: APXvYqxlkVkY44EWlcgxylvUomN8C358DUF5YWnb6WP53Zvts81rUTCe1/w+INkuENI3c1IAa0WLtg==
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr27544546ljn.115.1577565372641;
        Sat, 28 Dec 2019 12:36:12 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/16] usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies
Date:   Sat, 28 Dec 2019 23:33:57 +0300
Message-Id: <20191228203358.23490-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, when ci_hdrc_tegra kernel module is loaded, the phy_tegra_usb module
is loaded too regardless of kernel's configuration. Previously this
problem was masked because Tegra's EHCI driver is usually enabled in
kernel's config and thus PHY driver was getting loaded because of it, but
now I was making some more thorough testing and noticed that PHY's module
isn't getting auto-loaded without the host driver.

Note that ChipIdea's driver doesn't use any of the exported functions of
phy_tegra_usb module and thus the module needs to be requested explicitly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/Kconfig         | 1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index ae850b3fddf2..d53db520e209 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -7,6 +7,7 @@ config USB_CHIPIDEA
 	select RESET_CONTROLLER
 	select USB_ULPI_BUS
 	select USB_ROLE_SWITCH
+	select USB_TEGRA_PHY if ARCH_TEGRA
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on ChipIdea silicon IP. It supports:
diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 7455df0ede49..8bc11100245d 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
 	struct tegra_udc *udc;
 	int err;
 
+	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
+		err = request_module("phy_tegra_usb");
+		if (err)
+			return err;
+	}
+
 	udc = devm_kzalloc(&pdev->dev, sizeof(*udc), GFP_KERNEL);
 	if (!udc)
 		return -ENOMEM;
-- 
2.24.0

