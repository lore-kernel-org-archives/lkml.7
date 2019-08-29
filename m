Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3195C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103526;
	bh=8Dh0VjqQRCbHaTfzo0/ighO2kEf8okUvbAZrdEr+2Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UUeRfPECIPnWc0XS4IOkF1/T3k19e88kGk7cDRTnpsMxylKa69KX6RjqdCDUBpdXi
	 67oO4iBOUFae3fI8fPTuvVLJ7bQcoscZJc9yrgBtP8E/TyMyRsB1dpel9dB0mCsdcN
	 642m6ZG/rNFEVQrMBGdt/+AZBIClWXHBHFWHx6sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfH2ScB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfH2SOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1281233FF;
        Thu, 29 Aug 2019 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102474;
        bh=8Dh0VjqQRCbHaTfzo0/ighO2kEf8okUvbAZrdEr+2Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xITAsaJEXqjstOoDB9xqL8sIFBVfdDLvaI1eI7Eee3/3zztSo1A3//Zlf+/8rksKc
         9EcPrSfLWUJN5PTHLnt7Aq5UiECron0eeCLA3RdheXgB97t1ToDZalJOOihBtt39bz
         iJgyT3gnMeUec+rG/SOBkMlDGaVEYd/vjOZed8J4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 38/76] clk: Fix potential NULL dereference in clk_fetch_parent_index()
Date:   Thu, 29 Aug 2019 14:12:33 -0400
Message-Id: <20190829181311.7562-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 24876f09a7dfe36a82f53d304d8c1bceb3257a0f ]

Don't compare the parent clock name with a NULL name in the
clk_parent_map. This prevents a kernel crash when passing NULL
core->parents[i].name to strcmp().

An example which triggered this is a mux clock with four parents when
each of them is referenced in the clock driver using
clk_parent_data.fw_name and then calling clk_set_parent(clk, 3rd_parent)
on this mux.
In this case the first parent is also the HW default so
core->parents[i].hw is populated when the clock is registered. Calling
clk_set_parent(clk, 3rd_parent) will then go through all parents and
skip the first parent because it's hw pointer doesn't match. For the
second parent no hw pointer is cached yet and clk_core_get(core, 1)
returns a non-matching pointer (which is correct because we are comparing
the second with the third parent). Comparing the result of
clk_core_get(core, 2) with the requested parent gives a match. However
we don't reach this point because right after the clk_core_get(core, 1)
mismatch the old code tried to !strcmp(parent->name, NULL) (where the
second argument is actually core->parents[i].name, but that was never
populated by the clock driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lkml.kernel.org/r/20190815223155.21384-1-martin.blumenstingl@googlemail.com
Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 498cd7bbe8984..3a4961dc58313 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1657,7 +1657,8 @@ static int clk_fetch_parent_index(struct clk_core *core,
 			break;
 
 		/* Fallback to comparing globally unique names */
-		if (!strcmp(parent->name, core->parents[i].name))
+		if (core->parents[i].name &&
+		    !strcmp(parent->name, core->parents[i].name))
 			break;
 	}
 
-- 
2.20.1

