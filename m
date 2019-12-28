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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D91AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3577E20838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQlgvp4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfL1Ug1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42922 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfL1UgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so15515856ljj.9;
        Sat, 28 Dec 2019 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdRgeWTtviiIWS4YZZN2UoUeCEyNPX48xbOaYwnMDFE=;
        b=BQlgvp4+h+4P6TeNq6CG7AvdJCeEk0tHNz+NYb5Tuapc06JzLccU16f31SIzcIFO+G
         Toz+8EzL8hyAMTsHESfGWgcssRgw1tHMfx/1+P/slf3tjTKVOx9O3zw4c0pvHdbxzwE9
         k/rxMD11e1t7v0h99RG/7szgWP2e/1vlnLtq5PM5tz5flIWy1Jw4RNjYSXmTeOqP2y78
         R0k5MTzqljN8R9w+VtArs9Cum0phF0acEm3b+OhKJuPBXdu+mjJooGTynUa+LHsVTg1x
         piStwSqHXGdrMr9L4ISV+Qgl3IpWgNL3WiDqtSpzrnxxvoB6Mo8uyDjQ/d3+1cs5RdW9
         nj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdRgeWTtviiIWS4YZZN2UoUeCEyNPX48xbOaYwnMDFE=;
        b=ZrXSZIU64BCWNweAZowoGJPaIXRU63bvJvNJivBAEdp5PZ6aCZSCY+REzJv7i+7Qem
         N7PEX/KuMz2uNf0WfRR8z7Pv/X0x6s/JkDqIp/EwqtEcUGk1AVqWyVCTREROsYbQrQbq
         aRX3JGqA/Fpqko/HILZuQIWf9AY9qkM/kPiufvWkWCJoSKPOiW7o1L9ARwSKmb5wboBC
         fpSwkj8ooryzaFV62as0oBj+GzUwU+gvoMvLYEcxs52TCC1+RK5xAfgkNQgZXMPT7hb8
         f4qzC7unYmPdKU5p7UMKgtAKHCwVPX9xnRAFt6o2qEIRKfoTmvQq61R77wyOSa1OQRam
         crTQ==
X-Gm-Message-State: APjAAAWq71GrJlhKzHwpjTbO7tXu824/IqEN3J+g9WplwhbAlrkPADo3
        G3mot/P0qKspXCF2ArnrvSG1wx2W
X-Google-Smtp-Source: APXvYqxsOEdudsc0NUs5bkj2iAUJ8nKrxsiUA79PgL8QO/Oa57kSdF+Uo3CRYniuUreMYOpAgT956g==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr16099016ljk.27.1577565371815;
        Sat, 28 Dec 2019 12:36:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/16] usb: chipidea: tegra: Stop managing PHY's power
Date:   Sat, 28 Dec 2019 23:33:56 +0300
Message-Id: <20191228203358.23490-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
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

