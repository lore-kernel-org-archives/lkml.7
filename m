Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3398121874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrutjWIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCVT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46591 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfCVT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so2213143pfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mImFMbhCHodcPD8tuoeuMvwnd7gMT7u95+QPPj0cJdk=;
        b=BrutjWIrqVq8fS9IwFez6xhg/ZeoKaGTKib9e797fWolyBQL90yaUE69exRi1QgcAn
         4hDweS/jcaBYC3x9wHinOQsrNM03nXXF0U9jQOpFyp1DyZJ0GjD5FfAQ72rWrCr1sdoH
         30BsVsU3cGCvMwIkrASGF4G3H7YzxH3nunS/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mImFMbhCHodcPD8tuoeuMvwnd7gMT7u95+QPPj0cJdk=;
        b=SFTwfYWZP+n9qBBc4lwSGiHB+G8tX4rO92K+LSvLnj3gxLAd7D9pEFz4xKTY71MQNG
         G9xpVFTA+z7Gtn1bJs+SWVhAAw8Vhj+nOOuYiYlx793cgop1TfWWyEYaDng6aV5uNAG2
         nuAhdmvwZy9ndNbLedHaMs7Ihuu22s56MpmEDvcTUO6/5ylwUYFTRiBdYjrp5elaEerK
         0aYLP/Mjl9J1lVP4EvIghnoYLEJ7u3KzDfEuCdGzizu8KPiKHOYXZ/f3nyvy2E4sJ1Se
         9nUNPqiSNJchbAbiZldaJgfN8lIayrJRRO87+NvvJrEsu0lCRgyd8BJz5ORX2QIMLkxf
         p0+Q==
X-Gm-Message-State: APjAAAUBxIjOVZpIS0o5pdy1PtAYnEmVk3LXVIDQhKFuDga/Gge15MC4
        mq3NUTuq8d4iR8f4gJUm7xHuhQ==
X-Google-Smtp-Source: APXvYqz9gmPC5cLEhCN1XAbo/QYh+to6EwOHmI83JseUaCKzcQq5aP4M9Tvm6QCfXfULQyhuDnTN1A==
X-Received: by 2002:a65:43cc:: with SMTP id n12mr10232679pgp.218.1553284773470;
        Fri, 22 Mar 2019 12:59:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n65sm27637990pfb.160.2019.03.22.12.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:59:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: rockchip: Add rk3288-veyron-jerry rev 10-15
Date:   Fri, 22 Mar 2019 12:59:24 -0700
Message-Id: <20190322195924.70448-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190322195924.70448-1-dianders@chromium.org>
References: <20190322195924.70448-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell/remember rev10 was originally created to support
making a SKU of jerry that had a different LCD.  rev11-rev15 were
added to give some wiggle room for future builds.  Downstream has a
separate device tree for rev10-rev15 (compared to rev3-rev7) with the
expectation that differences relating to the LCD would be accounted
for there but nothing was ever added to the rev10-rev15 making it
identical to the rev3-rev7 one.

It's likely nothing actually shipped with rev10-rev15 but they are
listed in the downstream kernel's device tree and it seems like it
should add a little safety if we match them here just in case
something actually shipped with one of these revisions and that device
will break if we don't claim support.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jerry.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 2ba89895c33a..517c6999a978 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -11,7 +11,10 @@
 
 / {
 	model = "Google Jerry";
-	compatible = "google,veyron-jerry-rev7", "google,veyron-jerry-rev6",
+	compatible = "google,veyron-jerry-rev15", "google,veyron-jerry-rev14",
+		     "google,veyron-jerry-rev13", "google,veyron-jerry-rev12",
+		     "google,veyron-jerry-rev11", "google,veyron-jerry-rev10",
+		     "google,veyron-jerry-rev7", "google,veyron-jerry-rev6",
 		     "google,veyron-jerry-rev5", "google,veyron-jerry-rev4",
 		     "google,veyron-jerry-rev3", "google,veyron-jerry",
 		     "google,veyron", "rockchip,rk3288";
-- 
2.21.0.392.gf8f6787159e-goog

