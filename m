Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB725C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEE920896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140302;
	bh=ZIrhhXaCNl5gzscCrXtwjgbAjsRxESRUiblV3VoyBbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rwml0BnT/EzM8lqy/rhhYUsgIPCDaumDwWR2xTDv4/6pDEbw1XCks2y3qCvk9gjKS
	 ZzDIfcVMXdBkQ1/ovMGF0xYRi/uHf0qgYvH1wx50ID+YejnjwZIdwEDiYWJ6B9ccuU
	 u3HnNm+Jr7aEnkGvWerxeYYwDx4dulzureaa19GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfDARiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfDARiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:38:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6C021473;
        Mon,  1 Apr 2019 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140296;
        bh=ZIrhhXaCNl5gzscCrXtwjgbAjsRxESRUiblV3VoyBbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1mg6iwlcx8ENB+HjHJL2bb8i4Y/iWfCZ7R66L1dO9GLmlFVBa6Ucex+sRu0xq7rq
         posu8zo7Lm352o4MTv6JCilDQFJ4nGKgIIkD0W6yhr4wD03jz9xmpOC9728Pi9YT0O
         yEOkTWZCmRp96uZk7S1mSvh+PkARU3DaqpPHgcls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 32/50] Add hlist_add_tail_rcu() (Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net)
Date:   Mon,  1 Apr 2019 19:03:15 +0200
Message-Id: <20190401170044.717738887@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David S. Miller <davem@davemloft.net>

commit 1602f49b58abcb0d34a5f0a29d68e7c1769547aa upstream.

[This commit was a merge, but it added hlist_add_tail_rcu(), which is what we
 need in this stable tree, so I've changed the subject to be more descriptive
 - gregkh]

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/rculist.h |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -405,6 +405,42 @@ static inline void hlist_add_head_rcu(st
 }
 
 /**
+ * hlist_add_tail_rcu
+ * @n: the element to add to the hash list.
+ * @h: the list to add to.
+ *
+ * Description:
+ * Adds the specified element to the specified hlist,
+ * while permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_add_head_rcu()
+ * or hlist_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.  Regardless of the type of CPU, the
+ * list-traversal primitive must be guarded by rcu_read_lock().
+ */
+static inline void hlist_add_tail_rcu(struct hlist_node *n,
+				      struct hlist_head *h)
+{
+	struct hlist_node *i, *last = NULL;
+
+	for (i = hlist_first_rcu(h); i; i = hlist_next_rcu(i))
+		last = i;
+
+	if (last) {
+		n->next = last->next;
+		n->pprev = &last->next;
+		rcu_assign_pointer(hlist_next_rcu(last), n);
+	} else {
+		hlist_add_head_rcu(n, h);
+	}
+}
+
+/**
  * hlist_add_before_rcu
  * @n: the new element to add to the hash list.
  * @next: the existing element to add the new element before.


