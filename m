Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F82086D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zqb+cgi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfHHDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:42:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41215 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfHHDmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:42:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so43284840pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sYG6cpuEWkiuiZSTjJ/tkE2X/s2syaTjG0yfloKLSE0=;
        b=Zqb+cgi2hDsfXgHlecgHReUK5105u+oAXv7BB+DCZY/hMGx1sxb1+EqfxhA1eSd4nU
         T8ave2YfqpukyF0QuRTjjIMXAFtg8LiYpJFs4gEXLcC3R7aRfBBZ9lVDN5XTHA7eWeAS
         SRt87N9Rucv13ptk0JnoNbOxRZx/Oixb5iacg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sYG6cpuEWkiuiZSTjJ/tkE2X/s2syaTjG0yfloKLSE0=;
        b=A+pfEBh0Y6sx9Ee0P8+BdfJ2mk5sen1lTsYTzO30TsRMpni/y91cpuQ5vDRblXDgFT
         VOX5YgaDHvQ7qPGTIJOxJuHRnQO+44ftGveh6MWk6IVk7OWoxtp7HfRbpr71nLtO63V2
         RRsiWxmOGojtP68rZvK/RpwqUwJiz6OlqsltL9Im6RkdnAYRtC4b4rLQBSFVq4LeXwXN
         H2r7FSwhvP5Gq/K7xlJiEYGy/mz9BjRaqDSatXTqx4SC/KkMtyjED97DCrQhIyAsmLw0
         pERG65drHFAoMTwBI3bwb9cx3PfHNIyTp/M3YbvMR+26gaJC7MJ6p6f7hiWlOMI9PtoD
         gMug==
X-Gm-Message-State: APjAAAWOtZA9U1geRgZoOJ8oXFuSU+KZJPageByuyltmi2MUKW+CL34i
        H3JDnuAuRk1pFIhDpMTTg/jpWw==
X-Google-Smtp-Source: APXvYqw0VyrLw6SijXdgxWzGrWGwlkTeqgHtcpsU3gz31hb34TRSE0lX0YnaKNOSEsTbHd6OT+XIfw==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr10684315pgr.206.1565235734462;
        Wed, 07 Aug 2019 20:42:14 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y14sm46425482pge.7.2019.08.07.20.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 20:42:13 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>
Subject: [PATCH v1 2/2] i2c: iproc: Add full name of devicetree node to adapter name
Date:   Thu,  8 Aug 2019 09:07:53 +0530
Message-Id: <1565235473-28461-3-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
References: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lori Hikichi <lori.hikichi@broadcom.com>

Add the full name of the devicetree node to the adapter name.
Without this change, all adapters have the same name making it difficult
to distinguish between multiple instances.
The most obvious way to see this is to use the utility i2c_detect.
e.g. "i2c-detect -l"

Before
i2c-1 i2c Broadcom iProc I2C adapter I2C adapter
i2c-0 i2c Broadcom iProc I2C adapter I2C adapter

After
i2c-1 i2c Broadcom iProc (i2c@e0000) I2C adapter
i2c-0 i2c Broadcom iProc (i2c@b0000) I2C adapter

Now it is easy to figure out which adapter maps to a which DT node.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 19ef2b0..183b220 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -922,7 +922,9 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	adap = &iproc_i2c->adapter;
 	i2c_set_adapdata(adap, iproc_i2c);
-	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
+	snprintf(adap->name, sizeof(adap->name),
+		"Broadcom iProc (%s)",
+		of_node_full_name(iproc_i2c->device->of_node));
 	adap->algo = &bcm_iproc_algo;
 	adap->quirks = &bcm_iproc_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
-- 
1.9.1

