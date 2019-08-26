Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85466C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E2B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0qgYTMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfHZUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbfHZUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so770058wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DL5ho5ogXD9UU1gNrTmxuX/cRnYC/JufDAd8jnPhLU8=;
        b=O0qgYTMBwQgISyOnTTu06pp+uxRjjHN8r39V5SZVrkDdNLsdPnMnXwN5T1gqRlZp5d
         SlRu4MC/nQwItKF5a2ZP6iAljVTtQOxK1/4Uc7sh9aMSFPD/d7N4sBpCPlCrzR9MKnw+
         g9TfXAriI1TEk3k44Of9sLU5LrKO1kZchuhTu4HA8D7o5owIdcAa8cqJqenGtE2e7Vgt
         BC2ieLh5ZjlLV/3UubHuWhYRcKOD9QsNTCIjx9TZMDmfD7cVWYJsIL5XGMdqWu9dB84s
         OjGc6kgV3RlDdmx3zx4GbHWLo37auTyivHNW4wEC68FtaeUF2LSoJT6b8cDQMRr4yMUV
         958A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DL5ho5ogXD9UU1gNrTmxuX/cRnYC/JufDAd8jnPhLU8=;
        b=VclR+SSJPklxwyJzRQXx88leYrMP8X3CbjHSeCuDjoVCuUniNtFeivP8Dz3RuTyq59
         S/S43B+XnODRScwRRgt/zbHQjyZmFHrmX12gmB9/FvMTODgyn4rlWthBgJuU2k3ybmKf
         yhmldhG4Hum2C85Vf2xt7yWzWhmAR7afe6j4E4OX1YLPI0bfgTXr+ioPWg5cz0RphAz1
         FoxCH4CfOFdhZUgZN5X8yQ0nMYIo4lb5YF5sKnSvTGHiPVl71HrWt82/RXViiziym8RM
         Pc/Is25lGH9EcfNE1F6KjZ6jFO7+tsYaMokCXhNzraDgseEw3Vns2gG26GgACJZM6NZA
         BrKg==
X-Gm-Message-State: APjAAAXrxNKvAGoO+R+k1jxIJ0odJeuXYdiQSBTfcJ5J3AQLUeIGQG87
        rG5VwFnIWaX821L9S9o7LqaIsQ==
X-Google-Smtp-Source: APXvYqwvMDn7GHtZGeEzp8t7Bk2Fe6PGRPZArX8nXTqlQyaxOyIQtsmluVYq0ZX6FKWdP6Jy/UVNFQ==
X-Received: by 2002:a1c:4c04:: with SMTP id z4mr23868325wmf.1.1566852325877;
        Mon, 26 Aug 2019 13:45:25 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH 20/20] clocksource/drivers/sh_cmt: Document "cmt-48" as deprecated
Date:   Mon, 26 Aug 2019 22:44:07 +0200
Message-Id: <20190826204407.17759-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the CMT driver to mark "renesas,cmt-48" as deprecated.

Instead of documenting a theoretical hardware device based on current software
support level, define DT bindings top-down based on available data sheet
information and make use of part numbers in the DT compat string.

In case of the only in-tree users r8a7740 and sh73a0 the compat strings
"renesas,r8a7740-cmt1" and "renesas,sh73a0-cmt1" may be used instead.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index abf5e7873a18..ef773db080e9 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -918,7 +918,11 @@ static const struct platform_device_id sh_cmt_id_table[] = {
 MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
 
 static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
-	{ .compatible = "renesas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
+	{
+		/* deprecated, preserved for backward compatibility */
+		.compatible = "renesas,cmt-48",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
 	{
 		/* deprecated, preserved for backward compatibility */
 		.compatible = "renesas,cmt-48-gen2",
-- 
2.17.1

