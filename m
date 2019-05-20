Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC3C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2347520862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354570;
	bh=2Y742oHnH+HGTWCwRcOZUm06XA9gz/E0XA7OEu+zDac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIHsRwTL6oKgi9CEPZbymNXyyz9wPHYok4NSJxF9wIgj/QCalOzxRtKfjZnTdsMTE
	 Xp3nqtE8pz3Hs18C7baJV5Cd23g3HLqB/4a/Nu75riK+ZDPnRLGV33yhtreMM3uDop
	 XENnffJXUifA0PrhDj4SUn/DF64yFaInk7U0b9c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfETMQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfETMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:16:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4563A20656;
        Mon, 20 May 2019 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354567;
        bh=2Y742oHnH+HGTWCwRcOZUm06XA9gz/E0XA7OEu+zDac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnGqP2CuxK66tz+AQ6P/4j3TUtGxsGXphUzv2W6nZj8AwUfEXrtNpTMNdEgnrRBvo
         LafqO69AdsLGw6Inr4u5/r6NsaxEq9Ekm3fozHSrJY+iHUP3DdtCcwXLFn1/sJosBT
         dbozyA63j1+7TSlV/9f9XUZyiKVmC/JbvzCayeiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/44] net: core: another layer of lists, around PF_MEMALLOC skb handling
Date:   Mon, 20 May 2019 14:13:50 +0200
Message-Id: <20190520115231.080664115@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115230.720347034@linuxfoundation.org>
References: <20190520115230.720347034@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 78ed8cc25986ac5c21762eeddc1e86e94d422e36 ]

First example of a layer splitting the list (rather than merely taking
 individual packets off it).
Involves new list.h function, list_cut_before(), like list_cut_position()
 but cuts on the other side of the given entry.

Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sl: cut out non list.h bits, we only want list_cut_before]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/list.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5809e9a2de5b2..6f935018ea056 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -271,6 +271,36 @@ static inline void list_cut_position(struct list_head *list,
 		__list_cut_position(list, head, entry);
 }
 
+/**
+ * list_cut_before - cut a list into two, before given entry
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *
+ * This helper moves the initial part of @head, up to but
+ * excluding @entry, from @head to @list.  You should pass
+ * in @entry an element you know is on @head.  @list should
+ * be an empty list or a list you do not care about losing
+ * its data.
+ * If @entry == @head, all entries on @head are moved to
+ * @list.
+ */
+static inline void list_cut_before(struct list_head *list,
+				   struct list_head *head,
+				   struct list_head *entry)
+{
+	if (head->next == entry) {
+		INIT_LIST_HEAD(list);
+		return;
+	}
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry->prev;
+	list->prev->next = list;
+	head->next = entry;
+	entry->prev = head;
+}
+
 static inline void __list_splice(const struct list_head *list,
 				 struct list_head *prev,
 				 struct list_head *next)
-- 
2.20.1



