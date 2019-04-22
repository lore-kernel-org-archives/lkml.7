Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09CC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F8020859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="iJuZ8keP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDVFfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 01:35:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35024 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVFfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 01:35:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so5183250pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NoJ4b8JitT5LeWb9tL/zyjtUCdy+IfTabaoXqmpGPzk=;
        b=iJuZ8kePvp9mGRVZ02oCu9e3pCxklxY5fLZ8fbwm+ORjC3i0xANfGVziDrqXBzT3Qv
         QYIooz3a9BNaGumonSeDzTSSDwz2czkqPhHZ7eojcF3JegiiYNfz7r8K4AepvKF74gUq
         fmVvr3775aP6rskkr+U+xWac07GDMyxmkkfvWjS1LKyP1VGFAtNqYL25WVXOFcgTuCxl
         4NoZdu77uQ1dyPZ1BRO83T6isMEA4516tm/PeyLb7hf3Hh15YiEmVQPb7vA4XeTfzprB
         bfosKznpIhIW60dzM9Ceoa7Rhv7iOEvd4AWbZqQ4NJowgFB5JdZpkh9csLMGMcw3HxNa
         TNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NoJ4b8JitT5LeWb9tL/zyjtUCdy+IfTabaoXqmpGPzk=;
        b=is0xYRtunpie7dYpRpwCasu3DGd2nD747YVLU98cMMEMNRYz1cs5Rih8Wyf8TFmX9R
         ESqFqhnp7x9eUbVHtLpeMikyiP3RSzW6sqsa2V8pDsWZ3SM6dgens7e2Ygj4/MMeDsEZ
         utAJHl15SwkhnpyEgdy46fgr/cg99KJ4oU8wvdDoYLEM3lHh2Er/cVcy2g3yRD9Wsdq1
         OpMNLXcjeYGkjEyGOpXBqiw5p+s79DvyUzvIK6mo8BKVbHfSTob8rwqRJhy3bTpgrMyw
         8ah5uoLoema2QgjOY+WcxM6C3JtvMOlZCuq1U42BDiDja8qD9tmGBT/h/Ih4iKdL5O8E
         Tg7g==
X-Gm-Message-State: APjAAAVvVSt4mNXIz4tS94Ry7WhuQXRPYQj9Tm8k4AzSDRaV8yhE44sT
        s3fsyabfpgfnCZpOCf9zMB9Hbg==
X-Google-Smtp-Source: APXvYqwt6oLbSGakaItvv78L8XMuOfNZdVdMaVv9EbYWBlVFXFIBWCJ3Mc5KEjVSVV/1MN++e6hqEQ==
X-Received: by 2002:a63:e64:: with SMTP id 36mr9332579pgo.127.1555911343126;
        Sun, 21 Apr 2019 22:35:43 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id x28sm12833390pgl.38.2019.04.21.22.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 22:35:42 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Mark Zhang <markz@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] regulator: max77620: Fix regulator info setting for max20024
Date:   Mon, 22 Apr 2019 13:35:31 +0800
Message-Id: <20190422053531.23123-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code always set pmic->rinfo[id] = &max77620_regs_info[id];
It should set to either max77620_regs_info or max20024_regs_info
depends on the chip_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This was sent on https://lkml.org/lkml/2019/2/23/482

 drivers/regulator/max77620-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 1607ac673e44..0ad91a7f9cb9 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -803,7 +803,7 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 			continue;
 
 		rdesc = &rinfo[id].desc;
-		pmic->rinfo[id] = &max77620_regs_info[id];
+		pmic->rinfo[id] = &rinfo[id];
 		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
 		pmic->reg_pdata[id].active_fps_src = -1;
 		pmic->reg_pdata[id].active_fps_pd_slot = -1;
-- 
2.17.1

