Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB705C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948D820850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF0DxHHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCTRTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:19:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38329 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:19:30 -0400
Received: by mail-it1-f196.google.com with SMTP id m18so6155ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBzzUkM+kI5tIaUeBRyufftLhAJwCdFsTBc3qT1AV/w=;
        b=aF0DxHHdlxvp/4AvGdWIHM9odA/a67EamU1O3P0v8BO+Z0oCePxlslbvPQqNrOKCVn
         B1NzrByxKD0OxPRLBxEFPmknW8D9yJgB2H5D0tSQWVrGCG4OogUnfetBhBoOtR70ZvCs
         bPoAAd0D/c63mYANsP0uOI+frpmB/vAncMIaL9mv6nU5L6ddlLJobFqn0rsYd/mpQ9Pb
         +Etdvk4Ksg0Fsx6Dvib1+rLWUMLzkvQhht4pYY6r/cncYx/uCcbYF/xT1A8mkt7aqpoO
         8Hp4BGLnkkJkTKxAskROcbUNR+3QKHywVHgOv7Hg4WReURs5cJ+GqNmarTteHnYajz9H
         8kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBzzUkM+kI5tIaUeBRyufftLhAJwCdFsTBc3qT1AV/w=;
        b=P8zUmDldvyegDHETch11aMuC9jJbWYrh+lUYzvMfxW6r8opadicaEPDpEmNrqAyCV3
         lbU8n6YBiosNIh/0WcIhLl47+10bPnyPc7CzGS7OvelElPusLe7yqNIK9X9sk5BrEo6p
         wPeNG6fYO8u2YPhToEXZh72eFh61qlhFCx85fer000v0xEwn1E9CXHu+1uF+EdUaURSj
         m1gNyHXX/KmGXGssY0ef/+0Kia/BiOii/gUFGK0PadRZ1B09eYHrHejiq0PUSUkN7jM/
         C7P48DQ3G0eQDBKvBoSu8J0T5xB12chnbgUIpx6adiDzqXNGlySJNwnFyMTSFQ9Pv5Mo
         z9IA==
X-Gm-Message-State: APjAAAUW0XaZOWP88DZwb+X8fQu3xx9DV73rmQJCtD9VpjLna87Be4Gi
        DxWwzuNFglI4CI/qORndpJw=
X-Google-Smtp-Source: APXvYqysOkffaODF2bnPiNm3m/xonGeQ0CbqA5wKyvP9MwyeNTbyUEgB81CugT03ZCsHOzgQSzLaAw==
X-Received: by 2002:a02:241d:: with SMTP id f29mr5643131jaa.30.1553102369434;
        Wed, 20 Mar 2019 10:19:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id z13sm1048015ioj.21.2019.03.20.10.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:19:28 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH] staging: mt7621-spi: Remove references to nonexistent mt7621_spi_ops
Date:   Wed, 20 Mar 2019 11:19:15 -0600
Message-Id: <20190320171915.14178-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct does not exist, and when it is looked up in the
compatibility tree, it returns null.  Remove these nonfunctional lines.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b509f9fe3346..d260b42ff328 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -58,8 +58,6 @@ struct mt7621_spi {
 	unsigned int		speed;
 	struct clk		*clk;
 	int			pending_write;
-
-	struct mt7621_spi_ops	*ops;
 };
 
 static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
@@ -330,13 +328,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	int status = 0;
 	struct clk *clk;
-	struct mt7621_spi_ops *ops;
 	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
 		return -EINVAL;
-	ops = (struct mt7621_spi_ops *)match->data;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, r);
@@ -375,7 +371,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->clk = clk;
 	rs->master = master;
 	rs->sys_freq = clk_get_rate(rs->clk);
-	rs->ops = ops;
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-- 
2.21.0

