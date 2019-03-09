Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82248C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA420866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VB3i/RKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfCIEIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:08:07 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59638 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfCIEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:08:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 0E132D3E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YHud6iJAL4mn for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:08:04 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id D5BF5D35
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:08:04 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id 9so13467584ita.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bgVM79Hmai3Iu8b9DNl79F0V+bI+5hG7ryZqiB3RTSo=;
        b=VB3i/RKXuXwoQsgtHXlpxAxp8SfZUE7emiaZ35PxLqz9jvyyCkjzXMUe/pXpZjofLW
         HmaVMbWmJw4V7bEaSnbV3wkkLO1ie94vZO6rer3il7ClmWvoOyZUe5STvzsitl+MMz2s
         B4E7LzdY4zt27KCQSouf+Lt/6q152dyYsM67CQdqjJvMPQ/42of1Rr428MB05g2oXpTk
         BO529kQhveIyLI8inFf4K8NTD/iKlQ86kFI+4VmBkAXHRm0LJvY7e9xTGHEWe34gzVRh
         LMxJRc1PMjit045FRg/tPBDQ7sL8SL08yPVAABaOLgNVvFULOVlmT4bT0PTMeNEpmoM+
         uJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bgVM79Hmai3Iu8b9DNl79F0V+bI+5hG7ryZqiB3RTSo=;
        b=Cc6GCTSLLDdfg038kYwAuKqPS72aExL8e5nH5Xc+ByBoCNI8lPouV3knaDuBB1ON7a
         zlCnUPafsBzfqpbaS2Az5q1iXukcwH5XfxRUxD3n6l67ToUdE/hzOdrI6MYTVbUEt+0j
         xtcWgCZCYJHqm9W+F05sxmh/eFEecTw3n2EfVcH0XTzAzp2vfR7Av/CiJ7z4o+MH39O+
         DmgQQAKwWZvrIoQ1jGq3CISuMerZUHyi7t6nWDIv+M1ePY3gbamsASGq62VTnksmCO5f
         9wxdO2Fvkj7gaaY2wYecbmzQFjghRDXVsvO4M7/1R1rrlZWp6LfZ9WE00p6B6nB7dSJk
         FGYA==
X-Gm-Message-State: APjAAAXim81HvXy0cqr/Jnr7Z6ICfZJPwjwh6aj/xzyBzD0CNXu5DhVP
        DiElpZbpHIvNEf96OTbnUpom+/D/Gz56imvBuah9AI8pRyLbBRzfAFqbee1+LmGiNOqdl/ohDGt
        XUdp9p2gs9J9rkV9IOl9XvXfvXYav
X-Received: by 2002:a6b:6007:: with SMTP id r7mr11287614iog.124.1552104484437;
        Fri, 08 Mar 2019 20:08:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyH2t5CWD8IVr+dyZ070j2QsNJ3RB7wn0omz9W7Ka/xluHc+jtA9n82oyrFUWPu8nziEI+hOA==
X-Received: by 2002:a6b:6007:: with SMTP id r7mr11287610iog.124.1552104484203;
        Fri, 08 Mar 2019 20:08:04 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id r70sm4985570ita.42.2019.03.08.20.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:08:03 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: add a check for the return value of ida_simple_get fails
Date:   Fri,  8 Mar 2019 22:07:57 -0600
Message-Id: <20190309040757.924-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get may fail and return a negative error number.
The fix checks its return value; if it fails, go to err_destroy.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpio/gpio-exar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 0ecd2369c2ca..a09d2f9ebacc 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -148,6 +148,8 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	mutex_init(&exar_gpio->lock);
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0)
+		goto err_destroy;
 
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;
-- 
2.17.1

