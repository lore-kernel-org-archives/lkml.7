Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0057720989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="wMVZR6W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCSDgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:36:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43701 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSDgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:36:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so6065457pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ArsrcRe7CLOt873qs8nGbqtofH10olLCxm2Yx/MZW8g=;
        b=wMVZR6W2zHJyCxKdBdY0ceFRbkmSUAlQG2z+Xpo1bP5KmRiglNV9rNJTq5opLRWQA8
         Fv8IsMs53AXr7GhhS+SiSkqzOYhkAU/0XqQTY8JS7GS+c+ueyOLFhDvB/G051XZRwlOw
         jlwBqBIHViKCYxoXhc0Crm7De/4ReeG6fFpJV5O+SHxXWydyGl3+hNDMeRtGGG/Vo39i
         41tYp5aIr2JADWB9jjkXjqaJMywTDQBjxLh/PVatX3euOgvkgzfWcfPjm6UnRb1GIN7G
         UyWavZxRXLOjSdURk2HolQlup3zWaO+FXAWjA6IhNTV5nrFFcWTuZOrrof0JhJc7NEqO
         FBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ArsrcRe7CLOt873qs8nGbqtofH10olLCxm2Yx/MZW8g=;
        b=kgy4l3C3SqjDyYxogUZhh49A7hHbYQi2oIObbXGQt5tymrQ5EoylXEKLGv6RYHFmL3
         vSG63qXSULigWSBnC6fJANgT3DHUqA1t1Pnqmjojzh4TQ3VHMzPA3eNrRvKbKnV7lT6f
         9KYXcNIbG03Zg5Sy9O1hkH4xa0UYBMlAWrO1OUvvhgx5soBRw6agAQQ/ySUERYEtnXuO
         bkIhByvL0zb84aBCzcJCjxJpGV6n8aTdO1EfHW1tIjVCZtjiHdSMOTOnVdeJKGYmN1RX
         WyNO8w3ZJZ4Gyhycbkqpjsaze75SvdkgybcJLah7irxCBh+VhQ+44Of9MEayQo+DnmRa
         d5gg==
X-Gm-Message-State: APjAAAWF7NiGRC1Hq8PMmPk/KZh5orQ/YrUgEva4QZsxfNiJUu3I2Prn
        EWRFRSN+GP2RJ/CB1jPXLKsZWw==
X-Google-Smtp-Source: APXvYqy53Gj71NCVxz2fhUAaYltp8cJq0s+GrMIun8s6SWKybmzN18CszL0QmuyS34rKxgLxFIPKrA==
X-Received: by 2002:a17:902:8693:: with SMTP id g19mr240919plo.157.1552966579241;
        Mon, 18 Mar 2019 20:36:19 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id h23sm15133538pfn.68.2019.03.18.20.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:36:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: axp20x: Remove unneeded NULL test against rdev
Date:   Tue, 19 Mar 2019 11:36:07 +0800
Message-Id: <20190319033608.6363-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdev won't be NULL in .enable callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/axp20x-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index fba8f58ab769..8a366f66208e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -437,9 +437,6 @@ static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
 	const struct regulator_desc *desc;
 
-	if (!rdev)
-		return -EINVAL;
-
 	desc = rdev->desc;
 
 	switch (axp20x->variant) {
-- 
2.17.1

