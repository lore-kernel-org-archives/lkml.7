Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB10C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3054D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565022457;
	bh=bIJkquuckN/cWKNKddZcFZPC0ZCpRqz2ZZh+yTuo/tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahMpML3+MBxl9e7BjwYNtZ45DtMGHVQmPT1x/elc3QXGIsjjffIp1FW5fl08KOTAK
	 ILYtDosfzIPA8PR3+kJRHD9xl+i4QMuVQoaDckhfclKlY5NNITsMysqj+LwLkwokm/
	 6Qa9w+Z8lS5TUImBAWN6eWssOLgspTpd2CK+qovA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfHEQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbfHEQ1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:27:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BC0214C6;
        Mon,  5 Aug 2019 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022449;
        bh=bIJkquuckN/cWKNKddZcFZPC0ZCpRqz2ZZh+yTuo/tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIgPrNEj+TK7Pbrh4jN8GIAWCfI3X27itlOhzxELCjqom84ddFpBKX1slaa7bI1IX
         AAcXQHHdD2gvzuzjLQ9pjGWpFDIesJZ+rSPQd3cYLsKMzh1XNsEWONZKbAr1EWsm8i
         cpZc4ufYFsUQlECy09mTWVYQjIUzQ9ri63AQM0lE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org
Subject: [PATCH 4/4] pinctrl: samsung: Fix device node refcount leaks in init code
Date:   Mon,  5 Aug 2019 18:27:10 +0200
Message-Id: <20190805162710.7789-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805162710.7789-1-krzk@kernel.org>
References: <20190805162710.7789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions use for_each_child_of_node() loop with a break to find
a matching child node.  Although each iteration of
for_each_child_of_node puts the previous node, but early exit from loop
misses it.  This leads to leak of device node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index de0477bb469d..f26574ef234a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -272,6 +272,7 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
+			of_node_put(np);
 			return ret;
 		}
 	}
@@ -785,8 +786,10 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -797,8 +800,11 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 		for_each_child_of_node(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(func_np);
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
-- 
2.17.1

