Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9121C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3B62073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tD6THbMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKOWe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36056 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfKOWeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so6633664pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JeAIVfldLUVTvSXCSoIJcdwhrHS7EelSGWycmLvcpHo=;
        b=tD6THbMUpRjMLKRy7mjdFZRPWf6FlQ9n8BkmlAuG3KvMrw6+4glewlNU998SaSVKF8
         K1uXfh+VqFX7pN5G1dMZ+PDt3sdSRJUjziV9sIlmfI6iD8wG/dc3DBFAZQvyjct+zTae
         JDTIYU6eMfFwrytgreUfC0TJi6nwhYOUbr1NUKRqk7A/JJCsETttQq2N/aTbs7oVKz/B
         5ePF67K4RWaW231sXOBynfpzKnZ6ZoDkZIG30ycvhJ8hI5uGb0Ulrf+yNIWs61bJjyiw
         PC/6KEg/oqocsQ5/U1x6oZnJpoTwp0Y67DPWOBkJQ5DYuPj8gJIctO4Awi8svthRg6rH
         TAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JeAIVfldLUVTvSXCSoIJcdwhrHS7EelSGWycmLvcpHo=;
        b=tjyxMBEtBzHipmoz9YJ33og0kmRJ8J080svR3q6u+sRPTzUGqDMPzYk23pN6XGKLZl
         AiFHAtN0CBXtWBAGnSi3ihLaITiXpP5LVHhBHiAGJ8T5VYx0DDAaFwL4snaf8UG+WLy9
         cFgzvR6gF6ZlTl1KgWzZ2LYhEtcgBPTSl+3KcM4Bszlxk478/fugzUCSDIyx7x9Vskfm
         vCyxkjBojrVNU83zyPjdeKVF6wjr7WYqxatIXZ6qi95ENUam2IQoF3QGb2euR9Wz8s83
         7iUU75igJe1ShG/eHrhwD5p9Aq5vKM/kjGaOtp5tZwuwA9jrYpAM0fo8xN9Y8YhypwJt
         b+yA==
X-Gm-Message-State: APjAAAUY9FICFUrHvkTD2gB2Sqfk+TIY2pDLwuHD4EEnd1mkhYrxeGvg
        UaEqDVaee/P2BmXdXYRRZt7nRQ==
X-Google-Smtp-Source: APXvYqxEuvWJPe5IPrGR1qUJFfqVEooRRTzfUt59swIGQbMJtrGOpHkD3l0yKEsEFfb7ErCC6auxCQ==
X-Received: by 2002:a63:6c4:: with SMTP id 187mr19457722pgg.421.1573857246083;
        Fri, 15 Nov 2019 14:34:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 10/20] clk: stm32mp1: fix mcu divider table
Date:   Fri, 15 Nov 2019 15:33:46 -0700
Message-Id: <20191115223356.27675-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 140fc4e406fac420b978a0ef2ee1fe3c641a6ae4 upstream

index 8: ck_mcu is divided by 256 (not 512)

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index d602ae72eb81..851fb4e9ac44 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -269,7 +269,7 @@ static const struct clk_div_table axi_div_table[] = {
 static const struct clk_div_table mcu_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
 	{ 4, 16 }, { 5, 32 }, { 6, 64 }, { 7, 128 },
-	{ 8, 512 }, { 9, 512 }, { 10, 512}, { 11, 512 },
+	{ 8, 256 }, { 9, 512 }, { 10, 512}, { 11, 512 },
 	{ 12, 512 }, { 13, 512 }, { 14, 512}, { 15, 512 },
 	{ 0 },
 };
-- 
2.17.1

