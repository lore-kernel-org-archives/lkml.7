Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD460C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC79C2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="dZCiPvgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCFBmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:42:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36857 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfCFBml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:42:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so7154489pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tS2bXWDg4ZRzYN2TaSTsId/SHA+yEDoDgjlzkfh7n9Q=;
        b=dZCiPvgViaiuT63/bn2YrbX/lynoCDjOPyGWfPOnHeEEiWwIWtt7MIpCkw2XI3lWOd
         uWuojbny7Fij5CcM38LieAgnivVWTrnoIp7oaR5gNhkKHi/tqfZJWTuzOKICMWTBZQ5d
         ouyLM9Nb0YvkAeoBdjsxaSDiMcLApYufBcLKLedGzQ+e10vavlx1FmQEKlZeuaNAYEg9
         N5mSD7MOCjTmduyP9ht7WnxCAOdEUkEVcrpxk2DdmgjovJWU4H+YoWKiqJgXqsULrjZg
         Pr2jfLmJdwlRExz5pGpFzKgu3F51Wjn+yaKcNDPWqvHl1LiGzAG/f9yleNJzoxdmafIr
         CmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tS2bXWDg4ZRzYN2TaSTsId/SHA+yEDoDgjlzkfh7n9Q=;
        b=n8iLuoJ4cu5ObxQoEWqUI1dzDHcscgdaTvoyna4vIUXaFUowDHBIdSlclxS99jOlfA
         5Ir3yRI5z7lufNNTfIU4LO1uPTvwDcjI/PFAvXuunmBHyY2JlQzg6D0/bzqwlWRIhV/W
         1M6MPomfzVtSHx65SSQGkH/Yflfs66my4LtWyzrHFckSdF8OTd8eyK3XR8Q71EqBl8l8
         QyqMhFu9vEXc47bY4FV8mqEbjlA9PRm0RvbdtoE/Xl8I5ld3L1ooeMO8T9MiI+twCXHg
         fePRmt2ts23vQygR0QPwuU//CZMZJMo5vfrMq1MfchSC4l4r9snvKUDAMTasxYdBlnTJ
         1FLw==
X-Gm-Message-State: APjAAAWq2zdYo9DNNlZqpCZjrAFuY9C1oaUuadGYUiBoUJafn4Iv4OQ8
        DqCycS11sIgdG+zMNyc1mkU83w==
X-Google-Smtp-Source: APXvYqyARs2Lb84rvM61EQUdPN0d5fC78T1j9cQuxQ3YSVl8q3cZ6Yh2Y7++AyN16tcEsF5d9QJnYA==
X-Received: by 2002:a17:902:b60c:: with SMTP id b12mr4246207pls.261.1551836560578;
        Tue, 05 Mar 2019 17:42:40 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id m17sm358728pff.170.2019.03.05.17.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:42:39 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max77650: Use unsigned int for max77651_sbb1_regulator_volt_table
Date:   Wed,  6 Mar 2019 09:42:01 +0800
Message-Id: <20190306014201.8645-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 31ebf34b01ec..5c4f86c98510 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -41,7 +41,7 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
-static const u32 max77651_sbb1_regulator_volt_table[] = {
+static const unsigned int max77651_sbb1_regulator_volt_table[] = {
 	2400000, 3200000, 4000000, 4800000,
 	2450000, 3250000, 4050000, 4850000,
 	2500000, 3300000, 4100000, 4900000,
-- 
2.17.1

