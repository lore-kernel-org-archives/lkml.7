Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F1C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368726;
	bh=jHabDNYXQuI6jAvSLpbfQ8BMZOrW0ZTQu6W6fn90SNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1RgdwyFanigtzU4qMcRedIh/ufF0bPkkuhgc4OCevWOqfB9rPw7Iciun1cSSb2n7
	 bCKQm6OkAAcTayJGo8qyJNK28b4X+epOf/RG2F+X2UMp0yMlDiCijFft6gnHYCIPTQ
	 PHq3kz8I0h9DLbky+Qq4N9gOEfSxMlYh6blhtSMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfDDJFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfDDJFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE482184B;
        Thu,  4 Apr 2019 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368722;
        bh=jHabDNYXQuI6jAvSLpbfQ8BMZOrW0ZTQu6W6fn90SNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6KUcS6ufQOV4bwc28qJAQTinnyEaIudTH/3kyk0PXuglGLRYhqyKPVDpf8kE+bpY
         8rag2toUlNLYX5zC0VvMVrhW4H6LccN7eYe5xy+nsvdUk8E58z3CaSCwh8A570oB5f
         ZoWq3Sf0gP9Dzr7uUALaJlLsk8WzNfQFHwbJEmPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Mark Brown <broonie@kernel.org>,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/187] staging: spi: mt7621: Add return code check on device_reset()
Date:   Thu,  4 Apr 2019 10:47:46 +0200
Message-Id: <20190404084609.291595426@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 46c337872f34bc6387b0c29a4964f562c70139e3 ]

This patch adds a return code check on device_reset() and removes the
compile warning.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: John Crispin <john@phrozen.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index d045b5568e0f..578aa6824ad3 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -429,6 +429,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	int status = 0;
 	struct clk *clk;
 	struct mt7621_spi_ops *ops;
+	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
@@ -476,7 +477,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "SPI reset failed!\n");
+		return ret;
+	}
 
 	mt7621_spi_reset(rs, 0);
 
-- 
2.19.1



