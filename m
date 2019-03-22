Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A386C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFDF2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258561;
	bh=rRl6vW3eD7X++CPve6ht4kHbq2VxlUjpa2WGmh8V9O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhTsWhoSiBx4XS9JFdNNLKXCzFhSDA429IxtI7hjRJLluyMKMR985AZR+UaaivZPQ
	 8QQM7zigJaNs6VNGYDbEVm6R5QkXxys9Wqd56EGf7s0F8Bcye8MsKCpUApC9qYrq9N
	 882vcv8spyh2BjNBqPo4EHCZcMbEHKv/7pFD4Y2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbfCVMEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388141AbfCVMD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF59D204FD;
        Fri, 22 Mar 2019 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256238;
        bh=rRl6vW3eD7X++CPve6ht4kHbq2VxlUjpa2WGmh8V9O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cp8kmXv760ECaMH/CknMIoysFRnuRVOgJyfWFZXPM65+77zUp3v0OF75m66C55RpR
         LRuGpeFCAb16L5FG1rUMxgIjySs8YfgJ5BOD7++7yA3taytjUyHds70Nell8vHXAh8
         Ne2Fj9/zMfTJ6HnFhHNUk/cfe4QVs4wgFW8HMbZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 150/280] regulator: s2mps11: Fix steps for buck7, buck8 and LDO35
Date:   Fri, 22 Mar 2019 12:15:03 +0100
Message-Id: <20190322111320.297117845@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 56b5d4ea778c1b0989c5cdb5406d4a488144c416 upstream.

LDO35 uses 25 mV step, not 50 mV.  Bucks 7 and 8 use 12.5 mV step
instead of 6.25 mV.  Wrong step caused over-voltage (LDO35) or
under-voltage (buck7 and 8) if regulators were used (e.g. on Exynos5420
Arndale Octa board).

Cc: <stable@vger.kernel.org>
Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/s2mps11.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -363,7 +363,7 @@ static const struct regulator_desc s2mps
 	regulator_desc_s2mps11_ldo(32, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(33, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(34, STEP_50_MV),
-	regulator_desc_s2mps11_ldo(35, STEP_50_MV),
+	regulator_desc_s2mps11_ldo(35, STEP_25_MV),
 	regulator_desc_s2mps11_ldo(36, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(37, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(38, STEP_50_MV),
@@ -373,8 +373,8 @@ static const struct regulator_desc s2mps
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
 	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_12_5_MV),
 	regulator_desc_s2mps11_buck9,
 	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };


