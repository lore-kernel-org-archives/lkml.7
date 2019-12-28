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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A06C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D300321744
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgvhZAjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfL1Ug4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35977 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfL1UgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so22914761lfe.3;
        Sat, 28 Dec 2019 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtvNWQIIgNujxF0UbnLdOzZRP0ryhhpviPXJN6IRJFE=;
        b=RgvhZAjG/CA4JZaWr6jP6enJu/2TFPwFj/5jxQstR8IZwSIKornNnOmHpQkZJB72w9
         kLdSpBHxsJwUOHzPq1BZf2mYmfxBBwarS8Or9p5NHBzu+LiluwlHDB2v34+CQauZ0Ey/
         hzpoua6Y/ZFJQ81baDe9bdTzC09Yb7+aCzBeC4v1gwPv3Z+zPBzZHwIrQV1Zxefdjc7y
         yBsWxvMJnW/ymBQT2ZbIemnak/RG/SOMw07LZcH5ojxLxoeywXbRjWQNNuOwMDuUdE+X
         oEguIIGBePj1cVpNFTELXGLWb8vPj78QFutaYf963vvWzdkjaylWZRko1yqPVGfKPn1u
         HqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BtvNWQIIgNujxF0UbnLdOzZRP0ryhhpviPXJN6IRJFE=;
        b=klI41jEMNK76VUJ1IK4VhUBAC65KHaxAQdGxEJ/2oP7jsSDQdUPEeueOfJpcTK5jc/
         ucDwyqJVHtLLEnaeYJ6FZv81UihZV5lIc/SQ6Wn+CKTdu2t3pv+fiSGX6SX34n6l0ffb
         yVyluJ9hQpBL6G5uP6V3taAOyksXSHNv3Y5FcbZQoVSvClBQLZmSezGt+6bXqfa9FH7m
         UYC85POM73tVXLdR/QKm6Rg3uwtNTBP+6K+LAzA1iamNF/ibSnaDVAnH5hCMrI+/1cYa
         ybq0MRhahs6vVfZYE3JJnx7ObVNxfuLgplRWYTkZMF2+7jETyW0kl4AihgmyqSN9kDfw
         YN8Q==
X-Gm-Message-State: APjAAAVmnKA+KdrTsI6tQXAF6qsCBTHNsTkj52OW1WW8ZcOp5N14VDKv
        mP8EEdUeWBu/2nhxSAm1dQI=
X-Google-Smtp-Source: APXvYqz/8j4xb3Lcz3LL0NOo0Ak8aVfgfKE2IkVPEMuJZlerVEKnGZ7JtyfM4QBVNycYs9FsQhWhcA==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr33194802lfq.46.1577565367474;
        Sat, 28 Dec 2019 12:36:07 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/16] usb: phy: tegra: Assert reset on ULPI close instead of deasserting it
Date:   Sat, 28 Dec 2019 23:33:51 +0300
Message-Id: <20191228203358.23490-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently ULPI was meant to be put into reset on PHY's shutdown (which is
active-low state of the GPIO), but there is a typo in the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 0845fc0fb3f8..1ecd9f7900af 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -308,7 +308,7 @@ static void ulpi_close(struct tegra_usb_phy *phy)
 {
 	int err;
 
-	err = gpio_direction_output(phy->reset_gpio, 1);
+	err = gpio_direction_output(phy->reset_gpio, 0);
 	if (err) {
 		dev_err(phy->u_phy.dev,
 			"ULPI reset GPIO %d direction not asserted: %d\n",
-- 
2.24.0

