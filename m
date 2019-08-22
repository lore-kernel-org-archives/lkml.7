Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A5C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3D2377B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566462090;
	bh=X1W8O7WR9KJI5jwenMWm+UPsfIL6Rn9a3Bmw4eKTkjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q3SZHtmTNGRJUF+wy2hCakFOkE6IrYvdnZCzjaiCTmmd+D0UY6ooBq0nQ78alkm2I
	 w4YUYMl5Fr7E2O8Gy3nGbLyhyqsZRS3Skol67QuVFTK/MN70oYQf3eDr4BSy1i2WHj
	 l5Qe1aTUbQYtLpCtyEkpy236UZ9LFkF+J2ZxW9Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfHVIV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731236AbfHVIV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:21:27 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8451223784;
        Thu, 22 Aug 2019 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566462087;
        bh=X1W8O7WR9KJI5jwenMWm+UPsfIL6Rn9a3Bmw4eKTkjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXG+h0ygYU/OM0uPrNe7bXBWBMAAFGZBCOHDrAw0DhEWSF+roxgbNC1j/GLC7nIfA
         brxaYgkVlGjubIROsEywRIQeexoE3+8xXHpjlp/w4ZKANysYHdlyDSQPK6xKS+e6PL
         tHTJK6CsE9nZPNQfp5oIbYRaMz+8H53J0e5KG7BQ=
From:   Maxime Ripard <mripard@kernel.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v8 2/5] media: sunxi: Refactor the Makefile and Kconfig
Date:   Thu, 22 Aug 2019 10:21:13 +0200
Message-Id: <f4405c0a9df53580904c91a1655cb13a35fd3b95.1566462064.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.85d78dd1a3b44fe4cde1b65a9b1eb3b95daea7cc.1566462064.git-series.maxime.ripard@bootlin.com>
References: <cover.85d78dd1a3b44fe4cde1b65a9b1eb3b95daea7cc.1566462064.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Makefile and Kconfig for the sun6i CSI driver are included in the main
Makefile / KConfig file. Since we're going to add a new CSI driver for an
older chip, and the Cedrus driver eventually, it makes more sense to put
those in our directory.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/Kconfig        | 2 +-
 drivers/media/platform/Makefile       | 2 +-
 drivers/media/platform/sunxi/Kconfig  | 1 +
 drivers/media/platform/sunxi/Makefile | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/Kconfig
 create mode 100644 drivers/media/platform/sunxi/Makefile

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 89555f9a813f..2fda8036d11d 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -146,7 +146,7 @@ source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
-source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
+source "drivers/media/platform/sunxi/Kconfig"
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 7cbbd925124c..6ee7eb0d36f4 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -100,4 +100,4 @@ obj-y					+= meson/
 
 obj-y					+= cros-ec-cec/
 
-obj-$(CONFIG_VIDEO_SUN6I_CSI)		+= sunxi/sun6i-csi/
+obj-y					+= sunxi/
diff --git a/drivers/media/platform/sunxi/Kconfig b/drivers/media/platform/sunxi/Kconfig
new file mode 100644
index 000000000000..1b6e89cb78b2
--- /dev/null
+++ b/drivers/media/platform/sunxi/Kconfig
@@ -0,0 +1 @@
+source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
diff --git a/drivers/media/platform/sunxi/Makefile b/drivers/media/platform/sunxi/Makefile
new file mode 100644
index 000000000000..8d06f98500ee
--- /dev/null
+++ b/drivers/media/platform/sunxi/Makefile
@@ -0,0 +1 @@
+obj-y		+= sun6i-csi/
-- 
git-series 0.9.1
