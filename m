Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3567C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B2224683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gaur1TkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLTB4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36663 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLTB4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so8325909ljg.3;
        Thu, 19 Dec 2019 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7a3lxaMDdErpekYLxYZCSpGszEjiHMz9VIU/9b2FAA=;
        b=Gaur1TkDTfgRCAAJ2jfXLAtd91digvvIIikB88uo1dJJu/ngUmUAduyjVTTecEsPbY
         2ezfycR++WnNJa5bhjjWIlzkn6K9EKUjdMxteA2Re2xODQ8wqQ3BOL33fru9bl5htJue
         QjAnWq0dRdUmL0vuMovs6SyWKCErWy3B+ZuiXBPudXUX0HdDYMYtrdLdQAMp9bzsExtD
         XV8wwqTLH+5LcNW0tmY8K7qI40dYA0ddYen2acLCSKofTrakr5nDPDSqxS0dDiKQZe8+
         04t1P4sAYMw6109j1HfsmdSSUEVzd3xclbPhQZL2zGe3pX5x7pAm43gVmxAU3Pasbms+
         TX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7a3lxaMDdErpekYLxYZCSpGszEjiHMz9VIU/9b2FAA=;
        b=fywmB/oamn+5sVvB+hV7Ph82fSO3kkkon+VpS19JDp01D7UXmt6g0nyzCU6hhLrQT4
         tTD0zDa49zH20VgTJAlhlr3KPHVhUwu+MclcfFuHDrc0AYxnkFDqrhb97CfBnSM7LkAX
         X41FLIiXcPWU/vAyeRrVEvj+5ujl0PaUFU4ptgljcBX71cHUBsjAebcCrNEWaKEayyi4
         quW3ltYzXjvYKcEkMMZlzfjd3c/bcJxMb9lazJ0ISHjiIc3J4ypoqFLJznLGMnPtH5a+
         VctaxB6z0kT8LXrgD5stzo2lEsfKspq1sqXGB9h8Dmx9dAxnNKmtLLV2L0GqE7o5gfQk
         UTUg==
X-Gm-Message-State: APjAAAUfmyeAWKfaNsyjHN5k1mi3U+3GGVbCL9GXukl/l7xKo4hl/AkY
        vTqxkQvAFlN9mRj8ZjcT0RMNiRfd
X-Google-Smtp-Source: APXvYqwbN97kGheLd00XaTVr135VZRcJmbkDNLnp4cnbkDtsFk0Z5/dfW9k80jO5EEXSV5IdepTn0Q==
X-Received: by 2002:a2e:2c04:: with SMTP id s4mr8493693ljs.35.1576806974736;
        Thu, 19 Dec 2019 17:56:14 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module to driver's dependencies
Date:   Fri, 20 Dec 2019 04:52:38 +0300
Message-Id: <20191220015238.9228-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
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

