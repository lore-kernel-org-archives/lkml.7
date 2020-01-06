Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D4AC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B76921734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diw6i3sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgAFBet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:34:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34457 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgAFBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so44495598ljg.1;
        Sun, 05 Jan 2020 17:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q36Rx1HqG9QFhtgtFtgGy7DR3UMN7/3uy9mm0NXYh6Y=;
        b=diw6i3sV5f3C61XJ4c0ZQke2kiqje9WKIWC1LH1vkGurf+oicKeVbFBa86oH3VPYTQ
         d5cEykx2iP9TSA+NSRJH6jmqBP9lsB0CQPJxErMdTZtR9kfsldoMdRLzqPSN0DjCW+sG
         GzV5NU9y9oTE8Cn3dlXVsyBYpxlKaMzM/j5qvzBi08Y2V93Vyn+RmNFoX5J4DwXF/tBK
         iR7LbShJIqE+4iWDXCPyHqfaEigdNby9qodthiljiHUXtVEQGsgSMNUXkvkdVKKnmAhy
         hZnzBRjFoN386Q7qaOg1neCNSDgk8ObrQtCzr2UY7X9jOAs4yE4vIk8zVsaiHsUx93UP
         vdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q36Rx1HqG9QFhtgtFtgGy7DR3UMN7/3uy9mm0NXYh6Y=;
        b=NWZFYcKPyPXsQyH4+KwEyZzMAA9ezirPGisusAqecaeUBskGxq0aU/G0fFCJQxSONy
         uArsYmJElWPQ5K3y9FaKS5xwqSbWCd+06k51JSSFI3NjYh6RdPSMXTdXFOWkU33uFNTE
         zjzoHYPS/H+pdmVRAXf2goWjE0zfaq00wAqfHQagaw19M6bQKrwrBqufCFS0FCI+hpwa
         XNF4Gr7aAKfhGpNpsn3pSZzJNjWwoCCeUKeMgWeufWy41QGu70L0RKUg584Uo1Q/d5OJ
         RbogZLiiqN26Jdj+Fv+mtyzja68tV+VEHUp/gq7yxIuiaenkKC6rakOXLfxSsRWDNbD+
         LWag==
X-Gm-Message-State: APjAAAUts5I2nUY0/PSo9lqNa+9qP+3uj5TPBeU+LJno5Ecz6ShtDJNf
        PHFGQPH5TCH/Sm/FBWmAoXA1pe7v
X-Google-Smtp-Source: APXvYqygDStSxl8jQemf3oG0no8vmjdUwOPne9jsXKqjtxqJHmaFhFXcVUD6lptxDJUXTN59/PeTRQ==
X-Received: by 2002:a2e:9248:: with SMTP id v8mr52711104ljg.189.1578274482705;
        Sun, 05 Jan 2020 17:34:42 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/20] usb: host: ehci-tegra: Correct teardown order of driver's removal
Date:   Mon,  6 Jan 2020 04:33:58 +0300
Message-Id: <20200106013416.9604-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that PHY's enable refcounting was broken and after fixing it
I also found that machine started to hang after EHCI driver module
removal. Turned out that the teardown order is incorrect because HCD must
be unregistered *before* PHY's disabling. Note that it is also not correct
to assert the shared reset during of driver's removal because PHY takes
care of resetting shared pads and thus it's better to remove that part
from the EHCI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 4d2cdec4cb78..32483bef046b 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -521,16 +521,10 @@ static int tegra_ehci_remove(struct platform_device *pdev)
 	struct tegra_ehci_hcd *tegra =
 		(struct tegra_ehci_hcd *)hcd_to_ehci(hcd)->priv;
 
+	usb_remove_hcd(hcd);
 	otg_set_host(hcd->usb_phy->otg, NULL);
-
 	usb_phy_shutdown(hcd->usb_phy);
-	usb_remove_hcd(hcd);
-
-	reset_control_assert(tegra->rst);
-	udelay(1);
-
 	clk_disable_unprepare(tegra->clk);
-
 	usb_put_hcd(hcd);
 
 	return 0;
-- 
2.24.0

