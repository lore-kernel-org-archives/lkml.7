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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66FC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BB121775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCWSsV9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgAFBfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42045 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgAFBe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so34956309ljj.9;
        Sun, 05 Jan 2020 17:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdRgeWTtviiIWS4YZZN2UoUeCEyNPX48xbOaYwnMDFE=;
        b=VCWSsV9p6paoScf47picv2GV0/m9s9ui2clBeNluJeQyhsCVfUGWzyXl6/btVamdi1
         j9dQ6YqYb+iM5lGs34b3WZbPjuD6zFdLhO+NCHlMtKxZuGwZo6DMhkXLCemtE+PhZa9o
         Is3fWSqW7+y9revc/MuOSVgnReMgWQSckW7mMzTlc/zDYEiEVzlZzm53qKsdqNRl+oG4
         srV7d0wkqs2Oy6qQkjNT2xDXpm+AsROsUyAcXt31mrcweL5udZ71RYnXA/I2EqOcgcI2
         IfWgcHl6/vxfVroeP0uIjkDmqT3Wda+BwML7OnX1h4qXj/DWF0P4/KS0qhNIjfPw81y/
         i1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdRgeWTtviiIWS4YZZN2UoUeCEyNPX48xbOaYwnMDFE=;
        b=QYehijyK4N/Y4NLS9dkSu5k7kWkMnPVQIxThpQNKzn3JcTqjd8cx5haZxaHIQJSLdi
         u8vqD4Uii+QnURYtyCSTXsbwUXjoepA7T5JXR3j3rfyi/Xk8XQk5RTkBJQ8XlACRtzzC
         U4FsX2hQdoZ0XYlPRVfzCMwMIZ4dMJbFI807QqB7g9DvTKM8CPPhhtkT+kAfdXpR8kvz
         Q2ztMzXMsEazJiNauKxgQScV3/L1v8zUZYKmrlJijTQR9vduhyTXLY8AGus8efXCjuKE
         LYfVwxlGbM9x2BZLRfzdC7tPGJvj33JM2PuwcLzUNCE9oA64cwSjtVTGO/Yl/l10KPpZ
         ny4Q==
X-Gm-Message-State: APjAAAWkpm7DRlZT9oo4LeJKlGEuq087X3J6OyioaO9FYv+0I8s362FH
        Zfgr4KaWxG2n4tu/kBwMY/g=
X-Google-Smtp-Source: APXvYqzHEdlUrxRnvmi3zmqHLyUKH7nYxSyXMjbS/oTk11srVGo8tTw41DlI83BkiMhsGQE5+5I07g==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr57818053ljj.178.1578274495720;
        Sun, 05 Jan 2020 17:34:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/20] usb: chipidea: tegra: Stop managing PHY's power
Date:   Mon,  6 Jan 2020 04:34:13 +0300
Message-Id: <20200106013416.9604-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra's USB PHY driver now provides generic PHY init/shutdown callbacks
and thus the custom PHY management could be removed from Tegra-specific
part of the ChipIdea driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 0c9911d44ee5..7455df0ede49 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/*
-	 * Tegra's USB PHY driver doesn't implement optional phy_init()
-	 * hook, so we have to power on UDC controller before ChipIdea
-	 * driver initialization kicks in.
-	 */
-	usb_phy_set_suspend(udc->phy, 0);
-
 	/* setup and register ChipIdea HDRC device */
 	udc->data.name = "tegra-udc";
 	udc->data.flags = soc->flags;
@@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
 	return 0;
 
 fail_power_off:
-	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 	return err;
 }
@@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *pdev)
 	struct tegra_udc *udc = platform_get_drvdata(pdev);
 
 	ci_hdrc_remove_device(udc->dev);
-	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 
 	return 0;
-- 
2.24.0

