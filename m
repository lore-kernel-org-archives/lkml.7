Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B3C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18820838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwCpnUa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfL1UgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40132 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfL1UgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so29855163ljk.7;
        Sat, 28 Dec 2019 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQSvJsaUmtImHWDCh802bCsire4jMh+ciGTtAHkD4o4=;
        b=EwCpnUa6Rdjkjdm1ZyUUxg/rMv6uEDVYsdvh0Lkl0Bl7C5FyodH8g818LWfJbFD6tH
         lYo+BAvwnncDmfj4VmOnImMn/Ig9CEgtn6icquyYlruDPFcCqWV51gberfApqsN9KlKA
         dTW5NoA+b03AuKlwYrp6Hd/6YP8KrGfrFHMPcOliZpsTg5UVlmucLMgi0N0UMvxcsXLY
         7RiBQfzGTAG46NAG2QmutkIeO2juwDroCM9KoogpUSXFdJKx2dV/5GpL0GPQ3Tyqg/49
         C6TJb8KzBew6go6sNElO6z8M8FdyQ4iHRU+VaHNbI6/Px1CM4kVBkmMpHPV92e9//eNO
         pP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQSvJsaUmtImHWDCh802bCsire4jMh+ciGTtAHkD4o4=;
        b=TbcH4xDlM/d8Ef3kNQn7quldq4BJymCWH8zMTYFfuLEhtGTxxLWRlH2nmUzAbGSliT
         +9xIzkSY2IpVODwNfNZM9vDrukfcFohRF6NfaPt4WB6sJU28XveO7qb2U0Sgz3oMbSMO
         9HW4EGXt4f8LtSMTKvrv3xbFbrf8N6+EdxWDkdPqMa6LBqfsV5sKTpsA20uL4UeXhVEv
         bDJCIrN+vROqwEX2fS+A2c93BqMaDkGAh1CQij2iGAESG62LevIeMiPIFmPrwylM2PdL
         GzTYOEWLyQnaoP0btj/yqB8LO1idXWYT9Quyk4VfgukoJlh+UdOjDqKq/KaHhFJkmHgq
         FvnQ==
X-Gm-Message-State: APjAAAUaVt3jq6KgH39q96wQ79KJDkAmZQB0FNlDWEtd7vM6nJ5fU5dz
        0A1hwbGeKfPsl6W5zP41WPA=
X-Google-Smtp-Source: APXvYqzjIGqhK4YdqPHmvCvzoVQBZ0IdsDUc/j3OHXgqTCCYvW/n+nvSrecbS77/mQITRrxP3namMA==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr31603259ljh.98.1577565369241;
        Sat, 28 Dec 2019 12:36:09 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/16] usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
Date:   Sat, 28 Dec 2019 23:33:53 +0300
Message-Id: <20191228203358.23490-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VBUS regulator should be turned off in a case of error.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index cc6cca4dcecb..f7e7df812f83 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -851,14 +851,14 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		dev_err(phy->u_phy.dev, "Invalid pll_u parent rate %ld\n",
 			parent_rate);
 		err = -EINVAL;
-		goto fail;
+		goto disable_clk;
 	}
 
 	err = regulator_enable(phy->vbus);
 	if (err) {
 		dev_err(phy->u_phy.dev,
 			"Failed to enable USB VBUS regulator: %d\n", err);
-		goto fail;
+		goto disable_clk;
 	}
 
 	if (phy->is_ulpi_phy)
@@ -866,7 +866,7 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 	else
 		err = utmip_pad_open(phy);
 	if (err)
-		goto fail;
+		goto disable_vbus;
 
 	err = tegra_usb_phy_power_on(phy);
 	if (err)
@@ -879,7 +879,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		ulpi_close(phy);
 	else
 		utmip_pad_close(phy);
-fail:
+
+disable_vbus:
+	regulator_disable(phy->vbus);
+
+disable_clk:
 	clk_disable_unprepare(phy->pll_u);
 
 	phy->freq = NULL;
-- 
2.24.0

