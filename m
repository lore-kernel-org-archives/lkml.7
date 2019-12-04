Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F337EC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910B20659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482739;
	bh=lm4JUrKaHoWWUev9vI4Y+B/zYy7vn/Rm5z1uWi8gAJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/u9a9cZDEQvC5B27AcwyAH+IBXs7bgQ2a7mnAJjmT9vzAN+rL15xfidjnw6JfG+7
	 xcHkjhTIW3g/qFva0n9P9+HB16tTy86tvxNTAS7+auUlMpcRBoxSw1rJyr4pq6U64d
	 H7Bo4n8kZF2JCgtWIHjCxTrKfXI3J8A6dU/XlqVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfLDSFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfLDSFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:33 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A492720833;
        Wed,  4 Dec 2019 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482733;
        bh=lm4JUrKaHoWWUev9vI4Y+B/zYy7vn/Rm5z1uWi8gAJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHnusgb1kgvbmhFk1r9I9oFnlyYBLwyiZekhzxFpH2KhPFJidSMJ7FqWzl/GdRpsE
         XV8GEVL/ohQgRh+IcWS1Jzh0RWkqRqcHUGbEWsDnw6AvBhifqpUWVLl95iYC9XaM/m
         zPkEW7c12pzniO7wI/FsWUbk3kzmofIMoDsFq+dA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 113/209] net: (cpts) fix a missing check of clk_prepare
Date:   Wed,  4 Dec 2019 18:55:25 +0100
Message-Id: <20191204175330.787733040@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 2d822f2dbab7f4c820f72eb8570aacf3f35855bd ]

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index e7b76f6b4f67e..7d1281d812480 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -567,7 +567,9 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_PTR(PTR_ERR(cpts->refclk));
 	}
 
-	clk_prepare(cpts->refclk);
+	ret = clk_prepare(cpts->refclk);
+	if (ret)
+		return ERR_PTR(ret);
 
 	cpts->cc.read = cpts_systim_read;
 	cpts->cc.mask = CLOCKSOURCE_MASK(32);
-- 
2.20.1



