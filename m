Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D184C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C7B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkseK9Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfJHHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:41:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37306 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfJHHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:41:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so8021355pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WTWm04ar4+VkLYYNXw2JS14xdDugNow5AHMpBwOh98U=;
        b=kkseK9Vv/63Pcw3Emd7eqBn53F3b4We5nz6/fDgoQNdiN3fgUkxvOKFHoT2YFXZ4tq
         yloarZHbOjJV0z8lMzK2iJYo/2s27a19LC/k1SZEAuz6JeeHWY7cXtGGH268aqlI96Cd
         GPZ9Qp8MBZhZbPHx2EaaIQSLcO52SfdzquSdT67ZUgsfbxg0Y3uMQvG8jCAcPkrqis69
         ET6BfuZJl1+S8Z8YxMfqE6TcltUE50uZqna8+CBaJx7a7QCw4Sw1sQi89JfO9fo7YKsq
         D95B/g8SkqPm8/Fpl+hpPui8bm141HHbMtC5fjXxHsu+w5eYB8X/6k2AMpsPRsu9GrdX
         aEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WTWm04ar4+VkLYYNXw2JS14xdDugNow5AHMpBwOh98U=;
        b=RzooPJtFo0IuaKlZPNZ5iSC3K2M8kHcI7F5J4wWlU/XvuTbHVxf5Jm7e8XtoucTpFj
         JoBqw4M2fZktmfh8Hj8MJhWXsJ7HOXtyCax7RhHN7LS0Em3cJL9Rt8h23XALwEHbSKvq
         ARLSWp/B29G1Pg50DrDyCY4fFhQzTX07kjCCjkLn807JUT59MA5q2oTR51I+TfQvJA+A
         hw6J4NCu1+M9AyJB3eQNj0JyxwpDv0Zs48ixdxikwoxRyVqevkxrAWnpFqiwKdybiuOt
         0RJsT7a6HZU2lKoTCH179YXa2XqdgVSHsRoKzvvnw2+/GvBzTnroswpZQbA0LeCYiP2x
         0aUA==
X-Gm-Message-State: APjAAAVjXIYNRhMyo7/oRAzPo1gZj/Q0UI7eEQX1z34//r88VU9CHf0l
        u/TEmKqeGrn1mh99CsrVUs1Gjg==
X-Google-Smtp-Source: APXvYqwASYWwYOQfFYehr5RojrWBRZDWtlku7FUHwl7oUX0ZGAYD7Q1pRY66aoJa85L8+Ww750zZPg==
X-Received: by 2002:a63:e54b:: with SMTP id z11mr34734641pgj.226.1570520515806;
        Tue, 08 Oct 2019 00:41:55 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y8sm18231363pge.21.2019.10.08.00.41.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 00:41:54 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
Date:   Tue,  8 Oct 2019 15:41:38 +0800
Message-Id: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().

Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add fixes tag.
---
 drivers/clk/sprd/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 9d56eac..7ad5ba2 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -46,7 +46,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
-		if (IS_ERR_OR_NULL(regmap)) {
+		if (IS_ERR(regmap)) {
 			pr_err("%s: failed to get syscon regmap\n", __func__);
 			return PTR_ERR(regmap);
 		}
-- 
1.7.9.5

