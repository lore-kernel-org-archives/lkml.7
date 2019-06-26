Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47767C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA942147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="A4YV1AYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFZNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:30:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43999 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:30:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so1364009pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5R4cVsFQhVLyF9g0s5F5bSwZCcKKR3zf71PxIEJQzg=;
        b=A4YV1AYuev65t9O8i13Iz9GKtesF0kQkFF8xnemsBQgTSBBNxQ0/OJlBp1ofJaurdj
         Xhlq9lh59M5eSYNpXhGtrsZQNSTAJBnKbbEdwQkPRtkdhy9vcJrK3snmg6e7SEH/NCLf
         QgG3JoNVuz4+GUGHpsmJwskByurOxSygX/tRVu8mXhyo9230l5NpqLMqO2AXYohb/8nj
         ErQIam/nUEVzuZ0kDayWXMxoh9IqEUtynyI0KTKNm3vJlH9nvASZ52b9IbkFs5wanjYF
         9JQT0YAOYfL9Zo8HSgbU1zcfC43jGSBIhP/pFGyvq5XpBKXRURf6m6if8eHp8ELhijMo
         8gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5R4cVsFQhVLyF9g0s5F5bSwZCcKKR3zf71PxIEJQzg=;
        b=CrJb16Q+A3jPAtWU2p+kxkw4TAIgXvEA/IzMnJzG1ulnUNztQUKtmfiflgd/pIBBnF
         3nART3ETPKLGFpBGMubN0l9bzg1pzg/3ZravPvdBE8RlfmM7GMIHtugqgVf3ebE0sSgy
         zgTRPLq11w3x/CwGZ5v6rrIjb8qrXs/DHX0iYrLwSKDhZ1GZUqb/xsIP6dDU56aODyTn
         B8hL1Kji8uf8v+JhazONRFf+gIATiltbVN82QlAtX/uBp2n/w+ftm9WC7BfgJsjyZzgj
         ZRKRkyucNVKk4DK1nAWF7d3ScRItaofB60AmZJ9SbXE/4tSDmcIPZwMhbMpNZuM1nlr3
         XQKA==
X-Gm-Message-State: APjAAAUHW16WmSEQwXQzfLAcBAR1BAy5PjxwPa7ORgv1Bq7NCb59xwXf
        f8h2e9m92q9F6afwzPUpaiYKlDYh/fw=
X-Google-Smtp-Source: APXvYqyGBdlAFXL+jdoO8YDY8WniTXXIViIKNkoW6LgRXfG3sCmaqyXNFGhyYQJubRIn8DxBuPUyuA==
X-Received: by 2002:a63:fb4b:: with SMTP id w11mr2957370pgj.415.1561555815761;
        Wed, 26 Jun 2019 06:30:15 -0700 (PDT)
Received: from localhost.localdomain (36-239-239-167.dynamic-ip.hinet.net. [36.239.239.167])
        by smtp.gmail.com with ESMTPSA id q1sm26970827pfn.178.2019.06.26.06.30.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:30:14 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen Feng <puck.chen@hisilicon.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] mfd: hi655x-pmic: Fix missing return value check for devm_regmap_init_mmio_clk
Date:   Wed, 26 Jun 2019 21:30:07 +0800
Message-Id: <20190626133007.591-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_regmap_init_mmio_clk can fail, add return value checking.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Chen Feng <puck.chen@hisilicon.com>
---
This was sent on https://lkml.org/lkml/2019/3/6/904

 drivers/mfd/hi655x-pmic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 96c07fa1802a..6693f74aa6ab 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 
 	pmic->regmap = devm_regmap_init_mmio_clk(dev, NULL, base,
 						 &hi655x_regmap_config);
+	if (IS_ERR(pmic->regmap))
+		return PTR_ERR(pmic->regmap);
 
 	regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic->ver);
 	if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
-- 
2.17.1

