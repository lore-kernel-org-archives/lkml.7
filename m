Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EFDC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024C1208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnsKP2xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfEMHem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:34:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39279 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfEMHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:34:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so12482793wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=haQ6ph677t8ZOscojVyK7EbyIxkmtAMauBV824XBBeM=;
        b=LnsKP2xUW4/hQoqpIysOFuXia9Hapy8nU1BFolQOB8c0yH8K6GH3E9Hw8avty3dusE
         8wi/2YHum+QcZjbajUO8I9CZlBT2k45swDJsrO09WVVCmbZ7ZPcC7Vzm83dE0mbBA6/8
         hejV413jPBLpvIIyts3r7klerRF6MojuEY5BB5ndNPRWOHn/nLWaqMFDcvFpUjM3zcdX
         HsdFfVmYylmD+gSxJ/H/ZpVVZQlff5Ir2Yzt4FG/3JJNZ7GzlaqM/JWe01rwDTUeuo/S
         OPPw5y+eEeiBG+prVSapCyhbw6FJuZ94hDeRiyD3hmPuGIeXbJvcZ/sbVmEbM1VCSuJi
         i/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=haQ6ph677t8ZOscojVyK7EbyIxkmtAMauBV824XBBeM=;
        b=W0LABFGflUoAgv9OjpooOjeLHQSf8kHNpEuRGIP3UYn2dQPfq3hlbKEkemBPHiqBPb
         zBQTnht70F2qIKQ9tVxT8pZx8BhsvgYWcSydAsjAMqVOjXx6rZRqaJ9RClO+UWiw8mSZ
         zZmPDavxbJRa1mv2pRrOgh3igxmZIdcYQIQDnh/PqoPDeY2jguvdpnSj4O0jqrs+3Lgm
         yhsXk7zmKUEjBnhl6/ITIDxlS0Azl/Wil4otKKX5nluRiLTmR1p56vFbWAiK6UZNL9Zj
         L7iC9ZValJ6qvLJQ1FTmO4/vCgr20M+QWLKA7g9NLPWitpYz9j6bmpF4zeOHcVbZ2piG
         8Osw==
X-Gm-Message-State: APjAAAXyKOoFXqk2tL9Bdrzua+Xsoq2E1c8VHgExfBcwQFPdkxypeE6b
        YJHiMSBZgADlhSx8POXJbyoFaA==
X-Google-Smtp-Source: APXvYqyl0TFa/CfFW9dD95CEE4KE/zhIspeeDr2JlDf5B23WXtyzSecGRLezlu0d6oFZsauAreajcw==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr15328423wmu.117.1557732880915;
        Mon, 13 May 2019 00:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h14sm1009883wrt.11.2019.05.13.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:34:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amelie.delaunay@st.com, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] pinctrl: stmfx: Fix 'warn: unsigned <VAR> is never less than zero'
Date:   Mon, 13 May 2019 08:34:28 +0100
Message-Id: <20190513073429.12023-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warnings:
drivers/pinctrl/pinctrl-stmfx.c:225 stmfx_pinconf_get() warn: unsigned 'dir' is never less than zero.
drivers/pinctrl/pinctrl-stmfx.c:228 stmfx_pinconf_get() warn: unsigned 'type' is never less than zero.
drivers/pinctrl/pinctrl-stmfx.c:231 stmfx_pinconf_get() warn: unsigned 'pupd' is never less than zero.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index bcd81269445e..074c8fa3e75c 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -213,9 +213,8 @@ static int stmfx_pinconf_get(struct pinctrl_dev *pctldev,
 	struct stmfx_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
 	struct pinctrl_gpio_range *range;
-	u32 dir, type, pupd;
 	u32 arg = 0;
-	int ret;
+	int ret, dir, type, pupd;
 
 	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, pin);
 	if (!range)
-- 
2.17.1

