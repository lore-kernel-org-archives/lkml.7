Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B09C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8960213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="2T3WeEUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDGJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:03:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40196 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDGJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:03:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so5523436plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XXM3GeLPuVMzumOR8J4tWNFz9su+dy5d7UIVkudMqnQ=;
        b=2T3WeEUp9RDLtXS/AsDKxPseUoXTElW5DsdRv1XFNsfnjan/6K7CqiHLShankvUniQ
         cW0cxLj9yOVm9k953a7IEEJpE+VFLWZqylQmhUyErUxZOvbQtleYm28KZsKnuovAms3C
         19Ht4GIPxT8o17X8Xa8MtDzcC0huyutlDJTVQmV9F3xuZToRIwF4piFJMXjDN1mZW/qU
         vPo2RaVYRWjiTMYmXy7NBpmgwZ4uU/LVVpTfEGYiqXTAcfxeOxwLtDertX15wbcrbjjp
         pY18fSBou6kkijADRNHsiM/RpP+xprZkQnhgQFktIs8fZjY4qL5wjl8E2Pl6jnSrhpnq
         A+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXM3GeLPuVMzumOR8J4tWNFz9su+dy5d7UIVkudMqnQ=;
        b=pKHZ4pKojnVtTWR8f0B4T8q1we6XcuvuBiCkQ9HTnt5UGk62u6s7NiRWsVCjxUen/E
         GLQgPi64xN2PfEXs1QV/z6epwzNgUDxHarFEVooAaUk9QjQEuLXT/sR8/juxynddqGRS
         fC/0MeBpo/zmyFwF+7AoCWzN/8UA4/DHRiuXDhDjYUvkInwytRA+KdBLw6NRpz7/hmO2
         E9DhRCA72qWBuy8Qn45lr4w2F04msY50EZ0iMKLNR+wwtAsX81OuuA2eQrXAJ3QvVUr6
         /FPnePcn5hf3e9COdGJlnUlJ/igXQoJ+k7rpvCo51pL49qh1SGe+pzHBtUWY37r3IY+Y
         olNQ==
X-Gm-Message-State: APjAAAXWuZrFvfOMCJrrR4wBV/CML3qbjrbPDJmBfT9qF/ZK3+SN7oxh
        YBrm1tLK4fOYw32mDfioR9qhhw==
X-Google-Smtp-Source: APXvYqx5vbgim8uB1bAbv+C1vujhXBCBpHJUC7laorTfyl876HbN7aExGzKbhBrDa5JXs+DXs64nEA==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr23407676plr.254.1554627796507;
        Sun, 07 Apr 2019 02:03:16 -0700 (PDT)
Received: from localhost.localdomain (118-171-136-45.dynamic-ip.hinet.net. [118.171.136.45])
        by smtp.gmail.com with ESMTPSA id h20sm19031156pfj.40.2019.04.07.02.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 02:03:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Angus Ainslie <angus@akkea.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd718x7: Use rdev_get_id() to get regulator id
Date:   Sun,  7 Apr 2019 17:03:02 +0800
Message-Id: <20190407090302.10918-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev_get_id() instead of directly access rdev->desc->id.
While at it also remove unneeded init for ramp_value variable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd718x7-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b2191be49670..fde4264da6ff 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -27,8 +27,8 @@
 static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 					   int ramp_delay)
 {
-	int id = rdev->desc->id;
-	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
+	int id = rdev_get_id(rdev);
+	unsigned int ramp_value;
 
 	dev_dbg(&rdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
 		ramp_delay);
-- 
2.17.1

