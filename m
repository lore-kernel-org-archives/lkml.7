Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B73C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38AB207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="pUlWm1y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDBXmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:42:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:42:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so7042543plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mLzsyx4nTmX/pdfIDCyts1CTO0ez0xa3yKfaDcBxC5M=;
        b=pUlWm1y/79aUh+vZ4nFp1WLcRQDFSTPFwlCVRTcYTPVKNIT2NDyc6/n66ry2cmDXXI
         NpF/RfFeZ815a0HgG5tgx3RT7+AeuMfMRtVoidJroK2q5vt3yM8PzyO1ALS1vhKxiaGg
         7rawIExM/DUJzb8KIdw4KTqbTG3kMH4oIphyxBQ3344uvvuxhdhFa6l8+NzQhbO+6fST
         eL6t3MDtwDESkgcc3XpVbPe2hUy3iBE7wnr81zFXQR1g23zAgTe/lG7wJFpLI/KD73+8
         x2TZYnLwm6H6mYGvcsxqXB6zgnSH1x1+BorOLG/9f5bggt51NoA4X1Fu7G3AvH1I2H6Q
         /N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mLzsyx4nTmX/pdfIDCyts1CTO0ez0xa3yKfaDcBxC5M=;
        b=h1VjrkRn5E3ae7t7203z1HuH5OEL5FXInlo3vF7ImrMfGiFWBRc/+KsdMws5M+p5uS
         Wdf23BrRdjPHY2XTXXUf7Pdk6Ew91ODyteLvKmOkTzPgAoSoyliqBz4NL+zNUC19FyiX
         peTql+JzT568ExKxiEPMvI2l1BOsWI+G2yOY+2HALqOR40q1YlW+57syY4LvI/PTl2B4
         s8jIb70xGHYgHjL3fycUlpyCg5pDTEoELQZSxhOSDLoQzwv6rCTRJLLLKJgRHjQAmAC2
         6ZGnMqPZbSqN0vgGvbev150Vz659gCvHG/MRedYbmPthKfIxxASpQQ+2WQeGwwk4gM+h
         yCaA==
X-Gm-Message-State: APjAAAV4v73BdK/QYtHw7s0LIJDh2CtADhCBoA85PSTcxXb5rsxFJ6vt
        TaToXZhQj7CMmthRSBPEgAE818S5E34=
X-Google-Smtp-Source: APXvYqwLTNchLLzFUu3iac8c+h0TnBH2WjwlgDA777VZTl0gyXnMYsZ70OWbDe5TAqy6iXxsgwY5zA==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr8502975plc.175.1554248528635;
        Tue, 02 Apr 2019 16:42:08 -0700 (PDT)
Received: from localhost.localdomain (36-239-229-248.dynamic-ip.hinet.net. [36.239.229.248])
        by smtp.gmail.com with ESMTPSA id k14sm15430836pfb.125.2019.04.02.16.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 16:42:07 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: twl: Constify regulator_ops
Date:   Wed,  3 Apr 2019 07:41:54 +0800
Message-Id: <20190402234154.22800-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 402ea43c77d1..cdd81e1985ff 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -392,7 +392,7 @@ static int twl4030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl4030ldo_ops = {
+static const struct regulator_ops twl4030ldo_ops = {
 	.list_voltage	= twl4030ldo_list_voltage,
 
 	.set_voltage_sel = twl4030ldo_set_voltage_sel,
@@ -430,14 +430,14 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 	return vsel * 12500 + 600000;
 }
 
-static struct regulator_ops twl4030smps_ops = {
+static const struct regulator_ops twl4030smps_ops = {
 	.set_voltage	= twl4030smps_set_voltage,
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
 /*----------------------------------------------------------------------*/
 
-static struct regulator_ops twl4030fixed_ops = {
+static const struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl4030reg_enable,
-- 
2.17.1

