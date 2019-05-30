Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9582C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986922456E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186037;
	bh=DVF2BsjhTgYxFfpTkGy6e03bpwNSrsgVjaDEudMpCwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1084swrdbJ5smOjIChRzu3Whw852rYRzI5HqiXhiIvuBKvrUbF+MRUaoANeXPMNN
	 rpqsr1DqvO0ISicGKY7XoR7dDDENEF1t2Cv+vfjqf9hn8nWYU9yUHiglEF3BifXVWI
	 3/8Chqyh87N24Mo1i4LYXdnbUeApxIaJGaDF/L0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfE3DN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfE3DLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:46 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B7424496;
        Thu, 30 May 2019 03:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185905;
        bh=DVF2BsjhTgYxFfpTkGy6e03bpwNSrsgVjaDEudMpCwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKppSilaMNMP6rNJW3pB6IE1Li3ESZcPwOY0V6e6aX8JTdU+4ri6HYML3TwWZFnJW
         eAv0WEjrHEgr60mkN0fGmv1GVeh8iB4A7GsV63lY8nyk1Tt3Jpt/BB4zpSuHDA8361
         oL9AvTr5Hj+EosLRx/sUCZtVQI9flC1Xe6W6NKKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 277/405] cxgb3/l2t: Fix undefined behaviour
Date:   Wed, 29 May 2019 20:04:35 -0700
Message-Id: <20190530030554.904397002@linuxfoundation.org>
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

[ Upstream commit 76497732932f15e7323dc805e8ea8dc11bb587cf ]

The use of zero-sized array causes undefined behaviour when it is not
the last member in a structure. As it happens to be in this case.

Also, the current code makes use of a language extension to the C90
standard, but the preferred mechanism to declare variable-length
types such as this one is a flexible array member, introduced in
C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last. Which is beneficial
to cultivate a high-quality code.

Fixes: e48f129c2f20 ("[SCSI] cxgb3i: convert cdev->l2opt to use rcu to prevent NULL dereference")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
index c2fd323c40782..ea75f275023ff 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
@@ -75,8 +75,8 @@ struct l2t_data {
 	struct l2t_entry *rover;	/* starting point for next allocation */
 	atomic_t nfree;		/* number of free entries */
 	rwlock_t lock;
-	struct l2t_entry l2tab[0];
 	struct rcu_head rcu_head;	/* to handle rcu cleanup */
+	struct l2t_entry l2tab[];
 };
 
 typedef void (*arp_failure_handler_func)(struct t3cdev * dev,
-- 
2.20.1



