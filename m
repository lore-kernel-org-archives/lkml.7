Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3342C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DEB21743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803548;
	bh=opFJpgTClBgfG8Nm64vOfdsYXzGQOp9y9phS/LKcW+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I0pTGKGBHZ13d8WcV9dQGd5HEyc4hCpsBGOOHH5w1QqbJiNtBdqdtBMPTlMqmA5PR
	 /OIKQcUrWnvOZtVJ/NbOMPLkmVnQzJHI1qndek88jJjZdMvgXkq7gQJGsBSFunjGdY
	 WW8Su+5zjWbDUI+QqYmPEjI++CU6usfKwqPY2n7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfHNRFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbfHNRFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68802084D;
        Wed, 14 Aug 2019 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802317;
        bh=opFJpgTClBgfG8Nm64vOfdsYXzGQOp9y9phS/LKcW+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrXMQCjnk3lwLIhBDYKeiqOlMV71DIHM7DyufgU9Kd70+vpY75bpUpbFlJd+H9Mad
         o8babhXR2Sg0xnV7wrr2wg4zCufuppcc2AujUMU4fqR3u9CEDsIMU9nFVG3sqwhxRk
         Pd6e8RUICPJHJ5URbWEOUcJV53EGzlbJzYiLgFSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 078/144] allocate_flower_entry: should check for null deref
Date:   Wed, 14 Aug 2019 19:00:34 +0200
Message-Id: <20190814165803.118010522@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index cfaf8f618d1f3..56742fa0c1af6 100644
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



