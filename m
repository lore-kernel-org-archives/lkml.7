Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45507C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED47207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ro6DrO1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfJNHIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:08:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35336 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfJNHIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:08:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so9869507pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=c0QsMwW5/HlkG+EyBzY3CChBE/BthJe1X9zmk8IUDUw=;
        b=ro6DrO1FSFrjgnEbuCTFqXVAOUVvaYpkPhUpMZ3QcSfsKg7mJYalOmP12P9nqpUs1I
         ZzuRB2eVsqibk7k7fhjPHQwKoppJIb1DZz+fNE1uUnjV4+53EarSuH/nZTTMHXOHonEq
         IF/3wnllpGOFgEpK3auT7PifBwXLm3WxU3JdX13f0ZzF0I+8e/iaVMUK6Q/DBL2cZu3n
         1g9EkexgpyNk8xDpuzMejRk99CzovZpYavY0EmELdxHBrs9m1SDjcHjfeEWkID4Ip4+Z
         QBtdkzX4/mq7v5Q7tCDLp3N0nXHtiKzUqfQavPSMs5E/ja8WQ3MUEKkamc6pEW/+e3Lw
         05Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=c0QsMwW5/HlkG+EyBzY3CChBE/BthJe1X9zmk8IUDUw=;
        b=Ycy7B9nLWxsYBzMe76AufPPIWit44U67aSRjyQvJLTUVgLkKIhuygogMS9j0HRUcUi
         TehSmCo2UlMTMFC9E1STuEBHp4OgWjSIifYZ/MPejSxsy5xeJGx3blKyePVZv5erN37b
         T4SskcbwUKX+BdT99J98SS4CUoMvzy+WQ+k07SNsM+p0SJGz4LDhIEkaxYCUm/qYxqkP
         tlfXwncRVN1gnhuplmjeyKECVpsxqlusDClIcnXy2FWvIrIVNGtP52acJgxmBgCpW9Jp
         9sDy2VQcOhgHXwcVsOmofanFpnSzFeaIK+f/JvZAux6IcHRsWGmYZfgRWVb8SasehoDd
         zZ7w==
X-Gm-Message-State: APjAAAWq/B1oqWtHYuc3JWsfPtSi2Uju3o32KCWS9sKp8uS+oNH4DkU+
        a/OL5qexvatdwNdc0FKowlSuyg==
X-Google-Smtp-Source: APXvYqxpj08mz2lldyLGGjWvshFVJheqS7LJzHgtZNqHz5/AArf3lNTOgLpoag2/XVvFk3uStAaTBg==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr32096865pgs.145.1571036901879;
        Mon, 14 Oct 2019 00:08:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p190sm20619948pfb.160.2019.10.14.00.08.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Oct 2019 00:08:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, baolin.wang@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwspinlock: Let the PM runtime can be optional
Date:   Mon, 14 Oct 2019 15:07:44 +0800
Message-Id: <6c03ca84b19f0e3a4bd60b4d5ea70fd801ed7555.1571036463.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now some hwspinlock controllers did not have the requirement to implement
the PM runtime, but drivers must enable the PM runtime to comply with the
hwspinlock core.

Thus we can change the PM runtime support to be optional by validating
the -EACCES error number which means the PM runtime is not enabled, and
removing the return value validating of pm_runtime_put(). So that we
can remove some redundant PM runtime code in drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index a22e252c..fd5f5c5 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -657,13 +657,15 @@ static int __hwspin_lock_request(struct hwspinlock *hwlock)
 
 	/* notify PM core that power is now needed */
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
+	if (ret < 0 && ret != -EACCES) {
 		dev_err(dev, "%s: can't power on device\n", __func__);
 		pm_runtime_put_noidle(dev);
 		module_put(dev->driver->owner);
 		return ret;
 	}
 
+	ret = 0;
+
 	/* mark hwspinlock as used, should not fail */
 	tmp = radix_tree_tag_clear(&hwspinlock_tree, hwlock_to_id(hwlock),
 							HWSPINLOCK_UNUSED);
@@ -820,9 +822,7 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
 	}
 
 	/* notify the underlying device that power is not needed */
-	ret = pm_runtime_put(dev);
-	if (ret < 0)
-		goto out;
+	pm_runtime_put(dev);
 
 	/* mark this hwspinlock as available */
 	tmp = radix_tree_tag_set(&hwspinlock_tree, hwlock_to_id(hwlock),
-- 
1.7.9.5

