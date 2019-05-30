Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB4C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D761E258C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191108;
	bh=xJ8Arp/ag80s7p8RExPV8Tq/H/C6hupbqTYKxTsNmD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTObelVlxwlWRfjoy3vckhbeL7m5m26sdNraxUKoi1ShVICpEzPhsfYRe1++h2K0d
	 ySilJvGoPWOjrzI4038SQcW9VmhBonV7srexrXrsutfL0XYgB6ohUixHBEGBzd4Pgk
	 TvrPNW9vtqmYoZPZbh5a+m5sEXdkPh+DT6nsYh8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfE3Ei0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfE3DMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:45 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DBE23E29;
        Thu, 30 May 2019 03:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185964;
        bh=xJ8Arp/ag80s7p8RExPV8Tq/H/C6hupbqTYKxTsNmD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlb+jcKJlwythqHbS/QTImYz7NDcIb0KUuaJRjhefi6Th9Q+DlJg/KZH6LP65CUhc
         3qH35VTjv6Udyji0XaPtb/7y8kHItrbv7nXk5Wvq+Pu1iCXZbOOrVXgLmf5Hzf3C+o
         mLYNbLidmNUrhvipUfwYqxuJDdvKhvw38UB/U9rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 390/405] regulator: da9055: Fix notifier mutex lock warning
Date:   Wed, 29 May 2019 20:06:28 -0700
Message-Id: <20190530030600.370084234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5e6afb3832bedf420dd8e4c5b32ed85117c5087d ]

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: f6130be652d0 ("regulator: DA9055 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/da9055-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 3c6fac7936585..3ade4b8d204eb 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -487,8 +487,10 @@ static irqreturn_t da9055_ldo5_6_oc_irq(int irq, void *data)
 {
 	struct da9055_regulator *regulator = data;
 
+	regulator_lock(regulator->rdev);
 	regulator_notifier_call_chain(regulator->rdev,
 				      REGULATOR_EVENT_OVER_CURRENT, NULL);
+	regulator_unlock(regulator->rdev);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1



