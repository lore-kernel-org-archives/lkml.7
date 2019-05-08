Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65496C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3828C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AObE5Z8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfEHHdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:33:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42618 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfEHHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:33:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so9732929pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDsrcSSMgKGSHP0Nk2ne2DJD7hpeUAFwPm0h/OfCnfA=;
        b=AObE5Z8+K0moA2ZDjDuuVYvjyFV8h5J1tWcLuUJBcmiP/jFRjCim4AgJX0Nca0aIPX
         EypRszSAUAWGvknuUsSwSlHu8TWCt1PWuSqCE5eNuSgzXtrbVcSeOWbvgsUU1UVdolnE
         dfDbBe8Icbe2pSeTEhAANpRG20bTjfj6NIgbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDsrcSSMgKGSHP0Nk2ne2DJD7hpeUAFwPm0h/OfCnfA=;
        b=lBTMhFnr7tsCINZHujtYaAy1ysZXq8JHreVhHWEGUY/Tjbf+kH8NnaXZjH2saYlKxS
         P+sEIXMBuu9Bw4jyCLI/7k6t8nVw8RvvlJcsrHVQwdaRPnkKjsvAfMM1RYWgUc5QiheB
         fpRvsMlQBmyDJZtihDc3plWMxBzCzXvQYRLBAUJjG5UwNRsA58sB9SM/90sJnwZBTtla
         LddShgoWIenKQmMNmgF71/s20mpFzxyxiWe7mBDFcyGxapRvv9xHC+3stFlQOA0zKodl
         t88brMIsamqKsBUW6wyrtxDQohJtxsXgCr29HGTtslPwsV2cjKKGM+fKkXVUDDsXlxAx
         hX5Q==
X-Gm-Message-State: APjAAAVHZskD5iUqKLVU5GhhB4KW7tTZTbAm/TKN7qbxVuKCIjU/hxXC
        IyFR2lCMyM9WkCxivIP0YEDZcQ==
X-Google-Smtp-Source: APXvYqwWepJc8Vx1tWBJxhjhsou707KRMm7b8Hle1JQuHz0nesKvf5DEHLJ8HVvOxV5wR8OOx+46Mg==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr47328035pff.55.1557300821684;
        Wed, 08 May 2019 00:33:41 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n26sm29539047pfi.165.2019.05.08.00.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:33:41 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH v2 2/2] pinctrl: mediatek: mt8183: Add pm_ops
Date:   Wed,  8 May 2019 15:33:31 +0800
Message-Id: <20190508073331.27475-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508073331.27475-1-drinkcat@chromium.org>
References: <20190508073331.27475-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting this up will configure wake from suspend properly,
and wake only for the interrupts that are setup in wake_mask,
not all interrupts.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 2c7409ed16fae9c..9a74d5025be648d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -583,6 +583,7 @@ static struct platform_driver mt8183_pinctrl_driver = {
 	.driver = {
 		.name = "mt8183-pinctrl",
 		.of_match_table = mt8183_pinctrl_of_match,
+		.pm = &mtk_paris_pinctrl_pm_ops,
 	},
 	.probe = mt8183_pinctrl_probe,
 };
-- 
2.21.0.1020.gf2820cf01a-goog

