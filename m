Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C6CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C241E20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im3j2OBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfKDPt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:49:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53554 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:49:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id x4so6070775wmi.3;
        Mon, 04 Nov 2019 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Gh6ypC21DF1xtMKX6b7wG5FsVhzjCIpzo9aEJOM0Ec=;
        b=im3j2OBbbqi4Fc6j0I3KRw5w3dJD+PpY4wjlEOrP3B2bqWJXjq6Oj32CwXt0fiDWYl
         qkQ/1govBFgqO8lDQVfxIGGJUi49jLWrDdMOuFl8Ei5jLh37feq4/6FWPDec/b+/DSNe
         YGtfjOwAf0mi/fXBruyCTSbdQrwEnefKsA9FwF0BgQxNj7r6tdv2kunbNFtyCMfBONrb
         ddgigulvNajaQblYrKEq59EZYeEP56Me8KgDwW8MahMr17IWkEJp8pp5+iU4T3syzFJD
         Nol9qlrgcq4JSTVIxTz5nZi9+1+SjnMk17x/rwxVBP9cRqHZ/2hxuwOJDGyTNoVjlEmT
         N25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Gh6ypC21DF1xtMKX6b7wG5FsVhzjCIpzo9aEJOM0Ec=;
        b=RkLGuGrNBAi+hQ8Ik7g8DYwbNNlQtLca9gRB0wvd+HBzR4y6NECpPqE1hJdi6YL+zt
         Cm75y53e4YSQUacn/FUazxcOiwxPYb5ukavZ9kw4OlsBQThu+FpofxTq2I8Mki/ea6uW
         MWazYM2e89RwAT37qfL0M7/vMPPm+3jvA/sVX91yYq13kNTwLSDbec3250Gv+1LNG3G9
         tv/9+Urk+2NqcRo0NL+A0wxNMmxqqKsQJXvuNzRLfSqNsfeQ1j7Tk6uMTB8rJdBqFoGZ
         YJbJ0PMy6pCIlaqHsQ3r+fgL9QdUyskzuIqG9MJNrZpzGk9MhMX0D3u8JxATPpIwGFn3
         5rMg==
X-Gm-Message-State: APjAAAXtAGabodINOHUFFp215Lz7ec2SB6MqAxP+14+wtQ5aZKQdxvlt
        0yLaPoUzs2PTcovWouVIKf4=
X-Google-Smtp-Source: APXvYqxBbQ0WXX+4m67jdYFm9J7caqNO4J9KmFZqX9e2cr9tFfT+cfmL9jbMVOp2qFx+BherG9wLoQ==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr16472749wmk.25.1572882597179;
        Mon, 04 Nov 2019 07:49:57 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i71sm23332521wri.68.2019.11.04.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:49:56 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] media: exynos4-is: add missed clk_disable_unprepare in remove
Date:   Mon,  4 Nov 2019 23:49:42 +0800
Message-Id: <20191104154942.8935-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver forgets to disable and unprepare clock when remove.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/media/platform/exynos4-is/fimc-lite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index e87c6a09205b..6748bd96aada 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -1614,6 +1614,7 @@ static int fimc_lite_remove(struct platform_device *pdev)
 	struct fimc_lite *fimc = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	clk_disable_unprepare(fimc->clock);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	fimc_lite_unregister_capture_subdev(fimc);
-- 
2.23.0

