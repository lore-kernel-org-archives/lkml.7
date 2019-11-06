Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AACC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFD52173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="aW0Lfvil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfKFRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:29 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:22474 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfKFRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059664;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZF9PBe9PbqZZmxK16qT8PcTXHq8abB445im8/YC08sA=;
        b=aW0LfvilxfO0M2fa2Iwv2yHLMyhSj24/6rXYMQNwtFrBTcH0IW9hLfgojJIaxys2Xe
        cK0MOFRLa/TeeYsOZb4v+CkeULoZJeyfMuK/uxUfbAAw9/dIU3e0qXf/IzYCuY4hGSJB
        1bzmy0rrFHcbNVMyn0xVsP6k5AhmvZcmrWKC2MOXRDUdP4lzptMLRv/MxuhNbygEd3u1
        zO6x81hT2HHX5sYLei+TaG/Mm9+ddarpzUdDyNQAan6JD22+GOiMr5TVpzQhyHFxWPT7
        DJj8YnoDlcsfwSbEmS6HZfK5CHyCM66Rgv+Z6ics/+9ZXIDXAHfuCcFfsyd28FgHMsSF
        qRNw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H14hLt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:04 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/7] drm/mcde: dsi: Make video mode errors more verbose
Date:   Wed,  6 Nov 2019 17:58:31 +0100
Message-Id: <20191106165835.2863-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triggering an error conditions in DSI video mode only results in
a very generic "some video mode error status" error message
at the moment.

Make this more clear by adding separate error messages for each bit.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_dsi.c      | 22 +++++++++++++++++++++-
 drivers/gpu/drm/mcde/mcde_dsi_regs.h | 10 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index ffd2e0b64628..c7956c92b51b 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -124,7 +124,27 @@ bool mcde_dsi_irq(struct mipi_dsi_device *mdsi)
 
 	val = readl(d->regs + DSI_VID_MODE_STS_FLAG);
 	if (val)
-		dev_err(d->dev, "some video mode error status\n");
+		dev_dbg(d->dev, "DSI_VID_MODE_STS_FLAG = %08x\n", val);
+	if (val & DSI_VID_MODE_STS_VSG_RUNNING)
+		dev_dbg(d->dev, "VID mode VSG running\n");
+	if (val & DSI_VID_MODE_STS_ERR_MISSING_DATA)
+		dev_err(d->dev, "VID mode missing data\n");
+	if (val & DSI_VID_MODE_STS_ERR_MISSING_HSYNC)
+		dev_err(d->dev, "VID mode missing HSYNC\n");
+	if (val & DSI_VID_MODE_STS_ERR_MISSING_VSYNC)
+		dev_err(d->dev, "VID mode missing VSYNC\n");
+	if (val & DSI_VID_MODE_STS_REG_ERR_SMALL_LENGTH)
+		dev_err(d->dev, "VID mode less bytes than expected between two HSYNC\n");
+	if (val & DSI_VID_MODE_STS_REG_ERR_SMALL_HEIGHT)
+		dev_err(d->dev, "VID mode less lines than expected between two VSYNC\n");
+	if (val & (DSI_VID_MODE_STS_ERR_BURSTWRITE |
+		   DSI_VID_MODE_STS_ERR_LINEWRITE |
+		   DSI_VID_MODE_STS_ERR_LONGREAD))
+		dev_err(d->dev, "VID mode read/write error\n");
+	if (val & DSI_VID_MODE_STS_ERR_VRS_WRONG_LENGTH)
+		dev_err(d->dev, "VID mode received packets differ from expected size\n");
+	if (val & DSI_VID_MODE_STS_VSG_RECOVERY)
+		dev_err(d->dev, "VID mode VSG in recovery mode\n");
 	writel(val, d->regs + DSI_VID_MODE_STS_CLR);
 
 	return te_received;
diff --git a/drivers/gpu/drm/mcde/mcde_dsi_regs.h b/drivers/gpu/drm/mcde/mcde_dsi_regs.h
index c9253321a3be..b03a336c235f 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi_regs.h
+++ b/drivers/gpu/drm/mcde/mcde_dsi_regs.h
@@ -248,6 +248,16 @@
 
 #define DSI_VID_MODE_STS 0x000000BC
 #define DSI_VID_MODE_STS_VSG_RUNNING BIT(0)
+#define DSI_VID_MODE_STS_ERR_MISSING_DATA BIT(1)
+#define DSI_VID_MODE_STS_ERR_MISSING_HSYNC BIT(2)
+#define DSI_VID_MODE_STS_ERR_MISSING_VSYNC BIT(3)
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_LENGTH BIT(4)
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_HEIGHT BIT(5)
+#define DSI_VID_MODE_STS_ERR_BURSTWRITE BIT(6)
+#define DSI_VID_MODE_STS_ERR_LINEWRITE BIT(7)
+#define DSI_VID_MODE_STS_ERR_LONGREAD BIT(8)
+#define DSI_VID_MODE_STS_ERR_VRS_WRONG_LENGTH BIT(9)
+#define DSI_VID_MODE_STS_VSG_RECOVERY BIT(10)
 
 #define DSI_VID_VCA_SETTING1 0x000000C0
 #define DSI_VID_VCA_SETTING1_MAX_BURST_LIMIT_SHIFT 0
-- 
2.23.0

