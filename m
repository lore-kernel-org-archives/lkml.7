Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00DAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784BC23430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJbidU2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfH3Tvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:51:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38255 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3Tvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:51:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so3836209plp.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+OltO6UTFluXk75cI2kKaBqgm2OdSEnkSbLPyHZRA0=;
        b=PJbidU2nyy0mnYnpYZnN8QjA0xIKXaoPry2J8hHgIM7XSvI8EyUc3da6wHjKqkhaDq
         MGjAkz3w3t66v8CeOj2yFdnJvb+TecJCGiUI3Pl5q6UqCj5Spp8U35s7yWrRt6I78Yrp
         7q9Sfurg+Er1amsDoP8kK5lIi/6g3fQ4863zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+OltO6UTFluXk75cI2kKaBqgm2OdSEnkSbLPyHZRA0=;
        b=fyH1OHAnRCsTJkQ9KwQC1gybljT9yedgklFcgRYH1VrgsgWrbdQNGggb1LN4/5Ph4k
         oSVrCnXBSj+sDZxaxtATAntjGzd8GEvx9/bvqkSf4jlnll6PlVISrzkCTbjLmjaRZBzC
         /J0d+8SOkGySN0gtTQEu2oyE4FEpesGqQYtrv/v5qIkvf8RpUFMO3hfqKx5XnHE6qaWy
         rbb5MZ+1opcrkJNLF+LdnSkALOfsAtxJT/xwOyHYdoXK60DlGlTgGO65Yi2prRrJ32K/
         ffdnBHLBCowgkOX832GgBBBh/qUAVs3DCOx+w1bSwF8F0mGFjOE5saT/08WVQgaeBtWQ
         v9Iw==
X-Gm-Message-State: APjAAAU2e6e3yRF7uFBeu+bHgeSOKIoR/vxS3WNzmvc95AAxetTBxaXi
        rpkXi1TtzwTe0kl4PNlXeyKXjg==
X-Google-Smtp-Source: APXvYqzSyhvD1zTXoQeYEg9/s0z/9tRc6542zFQqz2s1F+7QGeG55Oskqs7e8oj2ckYVb6S6R4BqPA==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr17491002pla.89.1567194704266;
        Fri, 30 Aug 2019 12:51:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d189sm8212904pfd.165.2019.08.30.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:51:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
Date:   Fri, 30 Aug 2019 12:51:42 -0700
Message-Id: <20190830195142.103564-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MMC cards fail to enumerate properly when inserted into an MMC slot
on sdm845 devices. This is because the clk ops for qcom clks round the
frequency up to the nearest rate instead of down to the nearest rate.
For example, the MMC driver requests a frequency of 52MHz from
clk_set_rate() but the qcom implementation for these clks rounds 52MHz
up to the next supported frequency of 100MHz. The MMC driver could be
modified to request clk rate ranges but for now we can fix this in the
clk driver by changing the rounding policy for this clk to be round down
instead of round up.

Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
Reported-by: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I suppose we need to do this for all the sdc clks in qcom driver?

 drivers/clk/qcom/gcc-sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 7131dcf9b060..95be125c3bdd 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -685,7 +685,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_names = gcc_parent_names_10,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -709,7 +709,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_names = gcc_parent_names_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
Sent by a computer through tubes

