Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB55EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC6D206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642059;
	bh=Drohe3c13LJwpE8DxivQc4cKlz2QZ0vz90HB7vIMBqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STAAkQWcvtllparhbjXhHWGs1SYBW6fNtxTtx5glg8X2iPIrvA2q88X/VLu3FJQ8Q
	 1Jh/YVSIao0FJj5G0+i/2v1wNt0Gf3OftAJKIucZEvLV6JRLAMN+DcUledH8eDTD9r
	 g94MI4P6bHKQ/5pcbhr3rUQtmP70mHO/WcotePII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfL2RyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbfL2RyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E85A20748;
        Sun, 29 Dec 2019 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642055;
        bh=Drohe3c13LJwpE8DxivQc4cKlz2QZ0vz90HB7vIMBqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1shSOrU+sbGuIxqVZEuFNZhXXpon2AelE7UPIxHEN5kEOx9eWofqj97MCcLmOctt
         LFQVL9q6NIxyZbR1zS6bO57o7vKCNHmqedyDG3Fdh6UmXPn6GE03GaV0A1F/POK+gy
         dnocSndvfS4x25GoWRKAb+9OKGGGxPv2613GmXo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 321/434] spi: st-ssc4: add missed pm_runtime_disable
Date:   Sun, 29 Dec 2019 18:26:14 +0100
Message-Id: <20191229172723.293182064@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit cd050abeba2a95fe5374eec28ad2244617bcbab6 ]

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191118024848.21645-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 0c24c494f386..77d26d64541a 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -381,6 +381,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	return 0;
 
 clk_disable:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(spi_st->clk);
 put_master:
 	spi_master_put(master);
@@ -392,6 +393,8 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	pm_runtime_disable(&pdev->dev);
+
 	clk_disable_unprepare(spi_st->clk);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-- 
2.20.1



