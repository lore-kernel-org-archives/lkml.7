Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0BE20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752777;
	bh=bYD0X8shc65cQyWWgd2mplLd3b7elQqoBA9LQVHfwyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cR51Rwuk9J7zDqT/ZGv4YJLx14mLMpZnxdmZveDNkxDL9JEO3mWTr82LpzQlP9wOe
	 UKY2bOX43x6RdTnSWl27mu8+4JbwA7F0OAXnysIRIW2ByDSOB4mgsHW01OxPazJ3mu
	 BjOaRSbSnyfGi6UTkwjtTectr1mm0cDlgole+Ck0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfHBNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394003AbfHBNXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:23:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BEF22186A;
        Fri,  2 Aug 2019 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752219;
        bh=bYD0X8shc65cQyWWgd2mplLd3b7elQqoBA9LQVHfwyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/9c0V5KcwbHHu/Eg0IBlgNCmJ6IqAc/h5wCcBPXKf/Sg4RH3NE1kBQai179tmg12
         ta7RjoIfPjnLXQ/w94L0yL6l8xaisUv9mmonjCzbTwwib4bfYfZrS1HbdZDOxEXo/I
         EojxzhAyg3tc4wZZ7im/pZL9m+2WB1WOOyKsUiSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/42] allocate_flower_entry: should check for null deref
Date:   Fri,  2 Aug 2019 09:22:35 -0400
Message-Id: <20190802132302.13537-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit bb1320834b8a80c6ac2697ab418d066981ea08ba ]

allocate_flower_entry does not check for allocation success, but tries
to deref the result. I only moved the spin_lock under null check, because
 the caller is checking allocation's status at line 652.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index f2aba5b160c2d..d45c435a599d6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -67,7 +67,8 @@ static struct ch_tc_pedit_fields pedits[] = {
 static struct ch_tc_flower_entry *allocate_flower_entry(void)
 {
 	struct ch_tc_flower_entry *new = kzalloc(sizeof(*new), GFP_KERNEL);
-	spin_lock_init(&new->lock);
+	if (new)
+		spin_lock_init(&new->lock);
 	return new;
 }
 
-- 
2.20.1

