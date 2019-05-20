Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DEA20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354702;
	bh=0hTxHl1kJ3+akPh22gjCFxb1A6uokxdaj6uPddAfjao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ozFC+9zFmpC2B9zFgLdL9CAXmqtHGrWuezNivdkl1OZsm+O+kmQfNkKPSRN8llOSP
	 KHhar0gmqK/iysbdMC/erC6hZAkpN4uin+juey2V8EFhpvsPQCrTqgoEhNM1fDhqU2
	 BgKnUqGG2e9Au17+q/Vtd7pKSYZsOwd80tUrI7lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfETMSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387699AbfETMSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:18:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFB621479;
        Mon, 20 May 2019 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354692;
        bh=0hTxHl1kJ3+akPh22gjCFxb1A6uokxdaj6uPddAfjao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zL+zCJOQjkFx8FTsASz1EvG2GwaJGJcQwWW7YEwf4szSG6O1piyvsGRIpJk1Isthp
         zZsMcBWUYcmBzjAI4k1ch8AsmQVBIzIxkCZ7DHMEMU72SAaqhoMlpxvBoV8hp3FN/I
         bOum6NzSacYSuC7k8d4TPH0ysgpsYvMt/Rmn90e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/63] net: core: another layer of lists, around PF_MEMALLOC skb handling
Date:   Mon, 20 May 2019 14:13:40 +0200
Message-Id: <20190520115231.392707901@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
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
 include/linux/list.h |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -285,6 +285,36 @@ static inline void list_cut_position(str
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


