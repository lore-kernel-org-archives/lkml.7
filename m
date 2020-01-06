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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C60C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3FE21775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl+Qvi3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgAFBfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35356 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgAFBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id j1so41922066lja.2;
        Sun, 05 Jan 2020 17:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igfQ1RetbgHAAuHNfFj/g8fEnXKwtVyqbTA8fDE/yUQ=;
        b=pl+Qvi3r8f1VkmjWjt3l5gq37uNCtLSTCW2MFBVdbip5vWvIWiaFU4HAca0b/NEGO5
         xOOlJQO72CYX1XCP9s7ZAZ7MC2mL9rFTNJQOcozf7LjxiWubp24NoWhzIDfs2JMiyTfJ
         lv7kFoQbl7Hmrx0wfUpatNo3GAAjcsP6P6cfb6TpCyzrJvmHdvCNVnIAF7/JY2qf5Wm5
         nQNYRLz7lMb1may7oij8S5Y8t10T1DA2mIIE53Tkg1kmj4LyraBQv1Bk/J/cNfuM8dGt
         PGKurUgWrAksHfEUd08cwgJibi8UrtoJ4QAAWNFmtgAX1V8+W4NKDi3rUPuYSRZjjkIb
         Iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igfQ1RetbgHAAuHNfFj/g8fEnXKwtVyqbTA8fDE/yUQ=;
        b=LoUEK0avoEld3E5ag3AR62U7v4mf4es98coUJIsrschrws1rRTZeivLy7TTvDN6h3V
         u1grBnZ2dkccRRbpJwGH0atrc88+PYjCf2/7uElM8W+QQlMRRcz2U79y1X6NvcVvOFQa
         MBi5Nof8oCkjGJoi9WCB2wyzkHGvUyHt8FTtyMrIaBdQWYpxqoNv4w52Ie54E+0xX3Ix
         aaLHREY58fO0oHdGozOodYj+FqeVhwytVdAsclxoxW9iUy7JmFY7HD9Hsbq7q4BJ1ZAP
         30WGqP+TWYjXrY05x3AwzTVMgalF4Wa7tW2GvY6vSCWhZWNDSGoFEYC7qtS+PvkMF6By
         FBog==
X-Gm-Message-State: APjAAAXjrIbcau84WmiiSbTW1wrAQ3/uwA4GK54n3UnsPkaUXaRnaMdl
        3hnAo5jqstzg0V26kHfZDK5yWZ3Z
X-Google-Smtp-Source: APXvYqxDhIqRsg3MSzikSUDbt47DbhhVA9bdwjviZ6+MzOGPFc8wxoZmcmMiNC8ObvicmZLkb7IguQ==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr51194118ljj.225.1578274497366;
        Sun, 05 Jan 2020 17:34:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/20] usb: host: ehci-tegra: Stop managing PHY's power
Date:   Mon,  6 Jan 2020 04:34:15 +0300
Message-Id: <20200106013416.9604-20-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use usb_phy_set_suspend during of driver's probe
because now PHY driver enables hardware during of PHY's initialization.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 32483bef046b..1eb94205a5ac 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -480,12 +480,6 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	}
 	u_phy->otg->host = hcd_to_bus(hcd);
 
-	err = usb_phy_set_suspend(hcd->usb_phy, 0);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to power on the phy\n");
-		goto cleanup_phy;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "Failed to get IRQ\n");
-- 
2.24.0

