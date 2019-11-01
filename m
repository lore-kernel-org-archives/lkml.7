Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218ACA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59998208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbHXVYhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfKAHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbfKAHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so8821307wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BF4ZzyUEGnGEiyqA1v3l5l4pjBuYXhzsNNXXOYP8w+o=;
        b=qbHXVYhy5UqqBLj8qTiPohKa/wHistzi1bos518nV9bTNsteO8GyV6wzqHtSV3HuDM
         L2SOVq0KsobRYwXQzm6Dhi9BtAveaD3ISRF3m6M/ZDS1J3WuAV64hWlBbBsnoNjOkCUK
         Nbr2QDhq21lEZDWQWAPGh8ymfd/spSRc11zEeIX+Rd5tJknLhiLYpw156XiJc7n9nob1
         UX1ZwMymHYKPyB61tOF9yGHL4CSezawT6ynfWSJpnXp2HLYjFprBeL49Q/4snQusirgI
         akUFjZspQxQTHfoDAbT/W+7pHIOCA9CqSmwWBDFOAxYLMeuANTYzqIQkUvKDJjjyGIvP
         e+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BF4ZzyUEGnGEiyqA1v3l5l4pjBuYXhzsNNXXOYP8w+o=;
        b=L/mOkL9zrcBARZPaETyunc9D8sAPCwsl1Wg6bEzAh1v+Qy9AdGqzZ+ND/kpzykw7Yl
         W98qWv2rjlH6YbDTpgHjOr+J+y4z9/LZ3UThqow4Y0RCBTr4+3KS/9xoswL2M7BQaur6
         6jU7qStCi6bLjH2RzKunYxrqn8l5scWuPu/AdMi+pv2El/UyCfrVycsIwT1M3uBlppOf
         H+tJng6nRXtOOVlyzAb/IZCIennE2kHH8b/iytcaay8IpWUJA9OdEUOxn5Z1bdDUg1ZU
         Zck4n0GXhPHgq45Ez4Un6U0bMaw+JWvzxjnR1Dq7Y4aM/jR95MUDKnNBAVSbf8aajtjC
         sCFQ==
X-Gm-Message-State: APjAAAUYemy5GB1rxqDf+SXcD7JecErHhidZUS87Fs9wxNNonCpZxGIO
        bZwiEW8HGwjOCHtPiZRPOZMwxg==
X-Google-Smtp-Source: APXvYqwvChONErf1MGvp3rwWM4e47/N3o1hXnkEwYm9gxhom71/bEau2KdWY0ksYlxUM0IhOu12U4g==
X-Received: by 2002:a05:6000:1601:: with SMTP id u1mr9321793wrb.214.1572594330472;
        Fri, 01 Nov 2019 00:45:30 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 08/10] x86: olpc-xo1-sci: Remove invocation of MFD's .enable()/.disable() call-backs
Date:   Fri,  1 Nov 2019 07:45:16 +0000
Message-Id: <20191101074518.26228-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO regions are now requested and released by this device's parent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 99a28ce2244c..933dd4fe3a97 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_wakeup.h>
-#include <linux/mfd/core.h>
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
@@ -537,10 +536,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
 	if (!machine_is_olpc())
 		return -ENODEV;
 
-	r = mfd_cell_enable(pdev);
-	if (r)
-		return r;
-
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
@@ -605,7 +600,6 @@ static int xo1_sci_probe(struct platform_device *pdev)
 
 static int xo1_sci_remove(struct platform_device *pdev)
 {
-	mfd_cell_disable(pdev);
 	free_irq(sci_irq, pdev);
 	cancel_work_sync(&sci_work);
 	free_ec_sci();
-- 
2.17.1

