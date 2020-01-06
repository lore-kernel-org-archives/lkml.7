Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE5C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1318215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWANhkqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgAFBgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:36:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgAFBeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so35320839lfb.6;
        Sun, 05 Jan 2020 17:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVv25b7UbdH8MSdwvAWkrRlinknRcU0zNyku2LR0yFY=;
        b=iWANhkqcsEmapSS1Dv70dSEUIJndQo9oGFny+ntOBn+ZTZ0X7WcisS+7ztVZtGp4eM
         wzaSYWL9CEcphhcgYW2wj9wnzovFdJ4vDrlx2TnprgoQ7pAdiGvRpU1nrl17tup56hYR
         bQBTOQPgkf2j999gmn0Ct3zabVWt/KC/zJJ7EU5dyU2f73FmZXbtCo+jLUb43HrOhV8Z
         8bEvfsh7lHkaXDkueGTdGMbbLPacoM4j0t/ZyjKnID5H5xAWz5Tq30Wft7MOd4Hsshd4
         hbW8I19jZhnLiS+84Y4Bsj4rzz8qn7JNoQzx47T0k4OvvnoDuTostgdmb/aN9dTmMKvi
         fZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVv25b7UbdH8MSdwvAWkrRlinknRcU0zNyku2LR0yFY=;
        b=kREGXofkfqqFFIxS3JvNWT6CQeTj6CzRR0Z6T1IoDMWgmESqJ85iUKe8C2ZBnmK1xp
         V/COOSu7tSuO8vQYd5QKC6kmd+YeSNrvkM/Wg7Dc/diCywuFsY7EoKXIpx8741Ga8xCm
         UJnwu6KauBjptNT7pGlmwhjgZvBpsYu22IkBSUeiN8Jlm3w1P9wNAziBrmzfE4GpdkZI
         229Jxmnb6jiNRr5buMX1xgxEuf7Q1Qx3Kkpv1YQv0MWZ7o5DPH0PoHJ/Q+LB/RQUvbwc
         AwwOnjE8mJItBE9ZahqYihBC32dUHcp+pP2tB77OoaSrvBj2fzJHnJMwxfIfjL8hJ+VH
         bWGA==
X-Gm-Message-State: APjAAAUHDcXx1tioljB2JZTwuYtnUEY7UGvBmuVEh4qMLFLW7L9lom8y
        11lhe0d33O9RWKUNettPPOM=
X-Google-Smtp-Source: APXvYqxJvMjgHQITK1cRLuczzMw1hlzhnfwwWKjIsTNuV852q8iqzceypqY+7ir4l4qVQFaIs4Lwcw==
X-Received: by 2002:a19:9157:: with SMTP id y23mr59543548lfj.74.1578274483517;
        Sun, 05 Jan 2020 17:34:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/20] usb: phy: tegra: Clean up ulpi_phy_power_off
Date:   Mon,  6 Jan 2020 04:33:59 +0300
Message-Id: <20200106013416.9604-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the PHY's clock needs to unprepared to keep prepare count
balanced. Secondly, downstream code suggests that reset is synchronous
and thus it should be asserted before disabling clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index ea7ef1dc0b42..99acfde4ab8d 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -757,8 +757,19 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 {
-	clk_disable(phy->clk);
-	return gpio_direction_output(phy->reset_gpio, 0);
+	int err;
+
+	err = gpio_direction_output(phy->reset_gpio, 0);
+	if (err) {
+		dev_err(phy->u_phy.dev, "reset GPIO not asserted: %d\n", err);
+		return err;
+	}
+
+	usleep_range(5000, 6000);
+
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
 }
 
 static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
-- 
2.24.0

