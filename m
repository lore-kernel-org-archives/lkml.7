Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C620715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418788;
	bh=ON1L6FHRZCSgyfc+YX7cNsYgDakQmYbouwjMn0KnQBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CU5ixFfDCPAth2fZ7m2xwkgBLD/hugd/PcGoWuuhc+fo64mHi5bgJlCpIAoeyhR1u
	 WW6mpsG74mguZMQYguZ54HMhEXOXVuV3wU2gdJdbcX7akekPB+sX6hrQHWpGd6eree
	 yMfAfF68HgsvTipy2IeuPb9CRkTV6+V3FEfly87o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKVKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfKVKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8605520708;
        Fri, 22 Nov 2019 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418777;
        bh=ON1L6FHRZCSgyfc+YX7cNsYgDakQmYbouwjMn0KnQBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/I7/hHmjJsxkt2YOfX6lOV3sCmVw/jQBWht/McL6ZRZ/cxZX+ZHvRc2icjaV42iT
         GTz7azdJG1I/dqSTHdAjfc6yIuoOvuerVXIlfoohDcwd5abxQhxxChuVK0WxFW8etp
         8LLXvSyVXdTja1bC7B4BkS1gD9cvYxZ3YhfH9qvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 048/159] llc: avoid blocking in llc_sap_close()
Date:   Fri, 22 Nov 2019 11:27:19 +0100
Message-Id: <20191122100740.546114454@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 9708d2b5b7c648e8e0a40d11e8cea12f6277f33c ]

llc_sap_close() is called by llc_sap_put() which
could be called in BH context in llc_rcv(). We can't
block in BH.

There is no reason to block it here, kfree_rcu() should
be sufficient.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/llc.h  | 1 +
 net/llc/llc_core.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/llc.h b/include/net/llc.h
index 82d989995d18a..95e5ced4c1339 100644
--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -66,6 +66,7 @@ struct llc_sap {
 	int sk_count;
 	struct hlist_nulls_head sk_laddr_hash[LLC_SK_LADDR_HASH_ENTRIES];
 	struct hlist_head sk_dev_hash[LLC_SK_DEV_HASH_ENTRIES];
+	struct rcu_head rcu;
 };
 
 static inline
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index e896a2c53b120..f1e442a39db8d 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -127,9 +127,7 @@ void llc_sap_close(struct llc_sap *sap)
 	list_del_rcu(&sap->node);
 	spin_unlock_bh(&llc_sap_list_lock);
 
-	synchronize_rcu();
-
-	kfree(sap);
+	kfree_rcu(sap, rcu);
 }
 
 static struct packet_type llc_packet_type __read_mostly = {
-- 
2.20.1



