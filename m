Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F68C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBB92077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3b4d/7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfLKUcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:32:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46981 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfLKUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:32:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so22169pjq.13;
        Wed, 11 Dec 2019 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+ZNbiTOOC7n+yoMJbbexSm1sD8dYoDxAphQh0Gx9Wk=;
        b=d3b4d/7L2CRwAcKwGLpCgZrLZuRldlGySqCDYcmTnmibFchSRNNwAe7x7V6NddqiPJ
         5NFe62AAv65r+m12799xKg1D3Mh1FE8rlX4zHOv20aiXeTHZY/+33M1hdRr2WOaty65b
         qG/302JAWhNiUoRLmvPzejIC/SGjfeTnftDEdJ9BRtM20rdVBgdoa1DBS3rozw64+JXa
         pfkfOB7g4AeaG3GkIwCswaU2qGHUQDzfe374bAtDVaTfsRQeE68qBUYVKjvyvy/VzRC2
         EdiqMeu8hGJXgENSI31l/9Ihsh05XnY6GJ8GF8C4xaNoVqIE2S+r3H06obBppYHud4G+
         nTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+ZNbiTOOC7n+yoMJbbexSm1sD8dYoDxAphQh0Gx9Wk=;
        b=nMLv6gYP+ctXF6sF5tfYqrbzhaFcYUcBQuqgMSnUHRmhaGlu/2LRBL/I55sIjgBS9j
         Rfm+YjqsULDoYMOqCUxDQvvdkBleKOF/Km1XNQFk3YEumIwe/m8Ta339Cz//U5yAXaPF
         U44P/EGHNVRobsK0uCTZnM0Ze3peQeuW07gdJrXb/iV2LrGTca8iH+9yz8Pl7DcwLGdZ
         4JYtBE2gT7WD63vFbyqpUrmcDnknvKjciG3HS/otjzJqcDY1TtBtW+kYtixMgcYiJKCd
         dy4Gvjk7uWrRttpNteVaVHRaLodSoN2F7U1RV+QvL0xqNdunZCu6f7zU/ms31Na1428J
         TsuA==
X-Gm-Message-State: APjAAAWAKhIeYlsvf8bFsfb8OP88W+/5eF/podyKMDq/5wuc3qDjgXMp
        LSqFC4uS0pZ4c011uNO41/k=
X-Google-Smtp-Source: APXvYqwoG0SV8AaTyS0uTCKYn3q7bdAhdrRAzF28+g5XNW0W8G5/JNPvA8EVwJ6sRjadcY5I6QQaSA==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr5308114plc.117.1576096321068;
        Wed, 11 Dec 2019 12:32:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:32:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] thermal: brcmstb_thermal: Add 16nm process thermal parameters
Date:   Wed, 11 Dec 2019 12:31:41 -0800
Message-Id: <20191211203143.2952-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the 7216 compatible string in order to derive the correct 16nm
process thermal parameters to obtain correct readings.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 68f89f7c7e7f..74d94f01b1b9 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -292,12 +292,18 @@ static const struct thermal_zone_of_device_ops of_ops = {
 	.set_trips	= brcmstb_set_trips,
 };
 
+static const struct brcmstb_thermal_params brcmstb_16nm_params = {
+	.offset	= 457829,
+	.mult	= 557,
+};
+
 static const struct brcmstb_thermal_params brcmstb_28nm_params = {
 	.offset	= 410040,
 	.mult	= 487,
 };
 
 static const struct of_device_id brcmstb_thermal_id_table[] = {
+	{ .compatible = "brcm,avs-tmon-bcm7216", .data = &brcmstb_16nm_params },
 	{ .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
 	{},
 };
-- 
2.17.1

