Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE28C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42B921736
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIfp8pk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK1Nnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:43:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfK1Nnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:43:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so11725879wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtzLD0tyab7VEFg5K+G3bH3VUcvOhRi/b0o/Pb84uPg=;
        b=tIfp8pk983wWAlUIotSYeqWNg3ZI5ZwNr8gf2fngdwvGRNbPC89oqvVwYbs5HxV5Xp
         jUJ9wSR8H29ha+IAEKJUY7BA6srBV8K2TXitMb0yjTK0w9Ir6AkJCuCxtOtdCkdBbPJw
         fYDpGW59cKqQFb6Q61PO0ksF0XvWW/IeWTDZvbvjlSXC0JE3Et/LvYLs3mope5NEBUuF
         ro3PeFyseq+2RJ9/JpJRqJKLx7wXF44XSH9kta2wYFBpvjuZxJ1Ihz9nDZwUeBmPZFfT
         LOPg6sEsZpP/5eHcFfm+8l23a+QEdgZtNH8B1kZeZMEPLfeaICFCAnS9Oa4K27so7MLu
         aqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtzLD0tyab7VEFg5K+G3bH3VUcvOhRi/b0o/Pb84uPg=;
        b=sc3xmdt5VXE1LhZu375wbhzUYPSTmZ0et2vnpniw0DyWXpKV8gpBGu8oiguv4g1VHx
         KWrQAOo1Unukx6IkJ4I0reofbhzlspxoTHiXb6Vk1xVQwa4gm8aD3RF7zcA8LZ3hMDYW
         vrO7IyrpAnZMZMNoXGZ2fmGzVvwxXzork+pJZyeqFANB4K6cc4vK6R+A05H3CS/+uudf
         DLhcGsoNb5hBP8oXrBCH/a2jtYr4ugw1K0n+sD60VSsu58ik/3uicgLNPyxlsPwwwCtP
         67GeIsQ4bZYIKkxS25jVvd0ERfydgJ9Q2DkWNbqyqjWJ5CRnSs2+zkXeVfFuJyMKe1I2
         8wCg==
X-Gm-Message-State: APjAAAWpBqU4+1f/1ZBViuWsVOEFR7w7BfZRqwmxSQpLMonqlmhMarRy
        uPKn+sYX4mWl93K39/QelN/+KInh5I4=
X-Google-Smtp-Source: APXvYqyf46hZBfKvDKQEzIdpHO2/RKf7J9rYHD3HrhxoRz2Bcmo6J8EHzeVg7tSXozyJK0+Qyq4wGw==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr9015505wma.122.1574948628635;
        Thu, 28 Nov 2019 05:43:48 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u26sm10743407wmj.9.2019.11.28.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 05:43:48 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] usb: common: usb-conn-gpio: Don't log an error on probe deferral
Date:   Thu, 28 Nov 2019 13:43:57 +0000
Message-Id: <20191128134358.3880498-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128134358.3880498-1-bryan.odonoghue@linaro.org>
References: <20191128134358.3880498-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the printout of the error message for failing to get a
VBUS regulator handle conditional on the error code being something other
than -EPROBE_DEFER.

Deferral is a normal thing, we don't need an error message for this.

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Nagarjuna Kristam <nkristam@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/common/usb-conn-gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 87338f9eb5be..ed204cbb63ea 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -156,7 +156,8 @@ static int usb_conn_probe(struct platform_device *pdev)
 
 	info->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(info->vbus)) {
-		dev_err(dev, "failed to get vbus\n");
+		if (PTR_ERR(info->vbus) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get vbus\n");
 		return PTR_ERR(info->vbus);
 	}
 
-- 
2.24.0

