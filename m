Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE22173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzX0fpNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfEQSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44231 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEQSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so8123940wrs.11;
        Fri, 17 May 2019 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QRWDFkVz3xUnUzR3+DHbkRCIRl8pbjmxCa/vhR9hvo=;
        b=IzX0fpNh7WWzngetTRMHcGGlBKa4/Y10ND0MNxVowv35ASa6AyO+qLIiBx3oorQdoE
         gIMiRRTn12Vsg2PSpAtRil1uUy8xkxChgYigzhBilxkZX68upC2GKDNyLfBUb7Z2bHUQ
         l3UW0QKhlFhotuDCigGjT0urbWePYMe8D/Pqzy4lHHDPtWu2SCcAKN5A52dsJNj3f/9u
         wkbw9NIvOfWOihlEVc51Vd3gqhyPPlvGT64PX4ziAJrrUtqwzN1IUvq1Nm5N1J3wTFtQ
         EAhiuVgi6wE0rGJSFc9r5guK7YM9/7d0ISQhpYx5+RHA1MbYhrZU48H4aCLkI/T/pxBx
         RsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QRWDFkVz3xUnUzR3+DHbkRCIRl8pbjmxCa/vhR9hvo=;
        b=Rvz6DzQVr2J8tsU5UkMkfv7oR+aJkpbxNzNafZxRZ18Gz5CkN0As3rnBGAqwoBl5Ld
         sNpYbSOzmqmzBwMzLloncCzTB2U5ioC9hc5u9e710IA7syV9eSG2ra6Nys73t/UeEDyz
         VyEvlyifZwkQER8PQvRZDuoJRPZ6eLNOKO5qHNRbyIl0gRANZn1XfwHnFKiUA2Rnut/y
         3Fb5yQycWOJDbriFkcMVhpUTjGi7GsSmFMdIAx7nRaawczOpxJLthtf5/NkHJxH3KU/L
         aFPEeI6LEF18HIhrzdaaeuGDep1LlSCaoY3ablX5fTAkcIe6sUE5t6m8y9K+FVu8bn7O
         VWNA==
X-Gm-Message-State: APjAAAWcJw+A/x9egjJsURByrvyj972fXKzFER0cX5qlkS3HYn8mzxsd
        HppiPBXm5SPFn7ZMT2R1IpBDqQXtBMhepQ==
X-Google-Smtp-Source: APXvYqzQ3Rol+3txTzhDDbnTRdYC6TTbSHhpgNCNWdrgxxOScCII+60hVNsOpiwPvn2YYuVJGvfLtA==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr19937938wru.61.1558118827335;
        Fri, 17 May 2019 11:47:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
Date:   Fri, 17 May 2019 20:46:54 +0200
Message-Id: <20190517184659.18828-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.

Add an optional bus_clock at the init of the panfrost driver.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 25 +++++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 3b2bced1b015..8da6e612d384 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -44,7 +44,8 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 
 	pfdev->clock = devm_clk_get(pfdev->dev, NULL);
 	if (IS_ERR(pfdev->clock)) {
-		dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(pfdev->clock));
+		dev_err(pfdev->dev, "get clock failed %ld\n",
+			PTR_ERR(pfdev->clock));
 		return PTR_ERR(pfdev->clock);
 	}
 
@@ -55,11 +56,33 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	if (err)
 		return err;
 
+	pfdev->bus_clock = devm_clk_get_optional(pfdev->dev, "bus");
+	if (IS_ERR(pfdev->bus_clock)) {
+		dev_err(pfdev->dev, "get bus_clock failed %ld\n",
+			PTR_ERR(pfdev->bus_clock));
+		return PTR_ERR(pfdev->bus_clock);
+	}
+
+	if (pfdev->bus_clock) {
+		rate = clk_get_rate(pfdev->bus_clock);
+		dev_info(pfdev->dev, "bus_clock rate = %lu\n", rate);
+
+		err = clk_prepare_enable(pfdev->bus_clock);
+		if (err)
+			goto disable_clock;
+	}
+
 	return 0;
+
+disable_clock:
+	clk_disable_unprepare(pfdev->clock);
+
+	return err;
 }
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
+	clk_disable_unprepare(pfdev->bus_clock);
 	clk_disable_unprepare(pfdev->clock);
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 56f452dfb490..8074f221034b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -66,6 +66,7 @@ struct panfrost_device {
 
 	void __iomem *iomem;
 	struct clk *clock;
+	struct clk *bus_clock;
 	struct regulator *regulator;
 	struct reset_control *rstc;
 
-- 
2.17.1

