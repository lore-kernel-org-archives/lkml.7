Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA16ECA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96320862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeVxXAqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfKAGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:54:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41738 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKAGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:54:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id o3so11785224qtj.8;
        Thu, 31 Oct 2019 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcGqjrsVYd4m1KPrxn+0lQoybxEDVr6kOaUDeRE6zmI=;
        b=YeVxXAqVWVDIPdLaehRkoXfjySSQfTzBU/ZBCLkDK28tHxsHSRsfrINkW3yjNGBmun
         hG9hZ1Znj3jgqaoZJ2bep3bT4/jiin/tFz5WtYzdyEjtqOBdJN0Xe/bKRNKHv6VH7/7x
         RgM8qqPz9l2xbeayjvxsmu2ugv9F2QbBFOv0W79xJ4NimVanGI8SrdpEXHDTlXBD9QjZ
         Z5/L5HuopLPx+LH4Ipubnn2fXsIsCk8vijciSI9Z6nDuXMa4cx5Lo13aynE423+zuqQP
         Q8e1nOv5mqq4T1L+q7XVK3sm8VSJUUSh68UYnK+iO3YRoCdjTIFQ1Q23j7vjRs0dloKS
         qpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcGqjrsVYd4m1KPrxn+0lQoybxEDVr6kOaUDeRE6zmI=;
        b=d1+hAzapErpCNSVdGnjoj2SrBa7k/OJnLDUUpb9sUi7ZoDq/S5awuAS+Qbu+5S9X0W
         2cJSI+kupOC/N0X4bN7TUeXbDsBWHwGh7Jkp9rFDtYvlvcy6NSihTkcFwDanSo63+I3M
         LDhwes+RbRo4nsp02hxcDMZrwmGO5mF7Otahhv0xkHT19avcoe9Z3vuPZdrzXHr63P/4
         Ninp+Z36w/LR445+oH6AB0Xj/g7gQ3xMGVXElw/RsVaPVl7SvdBJiHObwd52GaFxCwT4
         ZiWBtxLwfXaTNj7KD/imWsvDOq5WCElI27dgnnFcOXZfqrtT+IT8d8pfoOxKwG1Okxps
         mmkQ==
X-Gm-Message-State: APjAAAX+H8cox9/XQgR8Ob+eeZE+/hHRRTvwFqRORqsdgTtLFO1NZSrd
        6yllTeLl3SXnVO6z9C2BQrQ=
X-Google-Smtp-Source: APXvYqzWB71qt7jFB3h9cadZxz2r7DadcHLtG6Q1EeWOKfkO7sZShn+DY0xNr/yn0PX/qv8L6m+Y7Q==
X-Received: by 2002:ac8:67c1:: with SMTP id r1mr8955296qtp.83.1572591278529;
        Thu, 31 Oct 2019 23:54:38 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id l93sm3203382qtd.86.2019.10.31.23.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 23:54:37 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Milo Kim <milo.kim@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] backlight: lp855x: disable enable regulator when remove
Date:   Fri,  1 Nov 2019 14:53:33 +0800
Message-Id: <20191101065333.7004-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lp855x forgets to disable enable regulator when remove.
Add a call to regulator_disable in remove just like what is done to
supply regulator.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index f68920131a4a..4fcf9ec18868 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -499,6 +499,8 @@ static int lp855x_remove(struct i2c_client *cl)
 	backlight_update_status(lp->bl);
 	if (lp->supply)
 		regulator_disable(lp->supply);
+	if (lp->enable)
+		regulator_disable(lp->enable);
 	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
 
 	return 0;
-- 
2.23.0

