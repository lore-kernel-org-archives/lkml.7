Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE10C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96703213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Nsudj+AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCRXbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:31:37 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:46830 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCRXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:31:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6ABA8AFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X_jAtkq27GoN for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:31:35 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 349A6954
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:31:35 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id p17so14685355ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zgRFhLxzpJ7c1cVSurud7qrZsU1/Dr6blkVH1A1cauA=;
        b=Nsudj+AC3bbNXtGkXBvwiKIj0ap1adZAgF3Y9Worm99pAbWxUvZHFAjez+WO8QhnBU
         DbAFOIzagqfBpLXlJIoM1DOeZ/HmdLbbu0yIL7JxL1jxwFeHWXo3xLEL3FmoW/HNGko3
         q5do/0QyFGRzOmuI1anFHeUqEvHDxiSuu1Gkb7e2ZS51YMjcEW5RD1aeHSzVfqfV39SK
         i477Jnd6K+0GbHpZ0eHm7VsV9IXWdMo4s6XgwUxTgDh6pjCrOapR6aQL7bQNhm/zrFuV
         fj4YXGM6Tn43wk/JPCcoVw3lV5vapD3OpKyTuHrFQ9DV5TV+ouWgUCiRxCk0cICSaE2T
         lw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zgRFhLxzpJ7c1cVSurud7qrZsU1/Dr6blkVH1A1cauA=;
        b=Z5DwJP7ioYUICdJQAQcwiE/q2uYaWmCmqtAVVBaFlMC6It+i2EzbH4p2XYcix/8u6a
         UTMwbX8HFe6Bi2q83CDZSuy1LQFUHSCj7uHy55DOaxv1z+vXsRCSYAdJmOa1lL0efbal
         DvW0K64CRmW2JEwLv7MjllI9FF1+Z6U/CNadjB4bhRRMISvMr+m+XJyZL/VmF2feMSq5
         38Af4mXMvhxfMuslJMzQKtz+qRpLKFJdF6wyHW8QhaznXgnBDDgl1S+i+VuexRmM4hsD
         BiHPB32eBwCqj3JgAqj82P6n/BCNpPO9oJt137lacsVdjSz99Nv9wGoV95b0PlU4Ub26
         li8Q==
X-Gm-Message-State: APjAAAWIEet0lF3iVM5l47U20/anjz70ePdx7ntxiv/Pv+V2tGhRH+dT
        UgG3ROXKyc3z39/uwrrOu6QiJCaDdk9MGc9cC8bGNSosOPcyDy79NEV5jpm2lscYaGqnh32ISLS
        u/VE1uyjibQRr5gcgE5moYet0NA+6
X-Received: by 2002:a02:393:: with SMTP id e19mr13223757jae.95.1552951894873;
        Mon, 18 Mar 2019 16:31:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6xAt+OjTK7+lkfE0k2tfqiTEHUEtixtb/oi3fVAgQ8Dxpg4GJkEEo6LeCkxmwkjRWUPZTgA==
X-Received: by 2002:a02:393:: with SMTP id e19mr13223749jae.95.1552951894708;
        Mon, 18 Mar 2019 16:31:34 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id o141sm476991ito.14.2019.03.18.16.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:31:34 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: berlin: Fix to avoid NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:31:29 -0500
Message-Id: <20190318233131.9642-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return a NULL value when the matching device is
not found. The patch avoids a potential dereference in such scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/pinctrl/berlin/berlin-bg4ct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
index 6a7fe929a68b..2d5e82938ef9 100644
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -456,6 +456,9 @@ static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 
+	if (!match)
+		return -ENODEV;
+
 	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
 	if (!rmconfig)
 		return -ENOMEM;
-- 
2.17.1

