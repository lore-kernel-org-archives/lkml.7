Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AA421670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613650;
	bh=nh/3v2ElB1tqMgx5Gp81v0Wl9FeaXSNQX7v1Xmc/0dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S27sa82Ftz8welr45IR4sPAyNGvNZOe8zuZaamU4yc0DrZOfJ/Uyi7thxWSvSB4/p
	 Yv/sy88sgoGzrlQg+IUgoygoWGd7zIiWOaelL3wreYMbUUX1+AC5g60i8I7oE5FpcM
	 dpMTZYK/nl9Dq/m+y+nFkbvTXVHzG9xsO0o8qkp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbfIDQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbfIDP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1175422CF5;
        Wed,  4 Sep 2019 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612790;
        bh=nh/3v2ElB1tqMgx5Gp81v0Wl9FeaXSNQX7v1Xmc/0dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anxarW/Qg+i/27CddBY6L55MRACCXfGYw4I3yEQosJYm5PWiKqHkO7laf7+VlBeFh
         wcTcIhedJRrulON8dXtj7W529fiXkK68wURcu4q/N7kXo/4NDWkvdJ6GrDxQqXA8wo
         G5bzXhRopzkQlcwd7uYIQAtl57gsuBAKs/BB4VCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 85/94] tools/power turbostat: Add Ice Lake NNPI support
Date:   Wed,  4 Sep 2019 11:57:30 -0400
Message-Id: <20190904155739.2816-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit d93ea567fc4eec2d3581015e23d2c555f8b393ba ]

This enables turbostat utility on Ice Lake NNPI SoC.

Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index de76bf355120a..9b0f35dd8c200 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4586,6 +4586,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_NNPI:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
 	}
 	return model;
-- 
2.20.1

