Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CF2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867411;
	bh=Kl9PloiNckNnn8mTr4uIrkVlJzTynYgyFrsKdF9FMDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tn1+6jQNrp5RMAajFHmTKfV9LDSJWMATfTzYXOk1k6wnZaTCBUzsHV2v8mfqBBNEC
	 pNMgbm5905LJq7NBoaJ2CPhoFEQGOgPYleilItvqzhhYmoYZGxN/3+fQXm57OpFEQ9
	 K+ogZPQ0ifloLdm87jldnEW7Jeb2viZSXViOu39s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfCRADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41609 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727571AbfCRAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 36FB1219FE;
        Sun, 17 Mar 2019 20:03:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=D6RBo2xA005T3vgh61b+8gQHpH8S5KLC0eS56YqC/3o=; b=n7HcCJVl
        z+T1Vd7yrPsV+pLmEJ2EzKDt5uUqwV/vOS5GsWwjehaxoSolfo4W67dv9DOWQPgO
        tYCwPjAKv6oqC4PPRuDJuZbIgk55DuKtSar4a3BJv4s+BvqipULukbB4/6r8XXpp
        9dMxb3UlP3hnc3+PGQqhywF0q2+sNBJlMIfrLgTO/N0817TyyfU1ZylhMbtrdAdJ
        6C809TxyfrsoQVCeFwQfVuQPXbpz+6lZCIz2hOOzgYk9COv0ZmOgGwuhN30EBpF1
        7g9PAuYWVe8iOPfqW4Vx3zRwNeEQFw2bl8sScdDgyu48/YA2OVxhnXvPS+C6iTfG
        gplnsEBPzVMMMA==
X-ME-Sender: <xms:UOCOXCjsmaXUW-TTHz7bxsR-p4QjeQMAr5oRIJWUnOhuYm5d4U6S4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:UOCOXHchi3mvfndjJfTD8MaXCpR9eVL68J4LK9sosgF96B7oACXoKw>
    <xmx:UOCOXG1h5JFMvJPgf8Ic6gLZW37LWWU9CR7bx83ZfDnxvdiOJRaLXg>
    <xmx:UOCOXNM8BTQgQNo4b24PSmoYDPIjVCYAmkFFO8RxJ9Yd2fmN9uvosw>
    <xmx:UOCOXDABzYfHbekKvRhnRId89jVsM9W99iPgNgO6eIQFQVQbS4iNqw>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEB2DE427B;
        Sun, 17 Mar 2019 20:03:24 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] list: Add function list_rotate_to_front()
Date:   Mon, 18 Mar 2019 11:02:28 +1100
Message-Id: <20190318000234.22049-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318000234.22049-1-tobin@kernel.org>
References: <20190318000234.22049-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we wish to rotate a list until a specific item is at the
front of the list we can call list_move_tail(head, list).  Note that the
arguments are the reverse way to the usual use of list_move_tail(list,
head).  This is a hack, it depends on the developer knowing how the
list_head operates internally which violates the layer of abstraction
offered by the list_head.  Also, it is not intuitive so the next
developer to come along must study list.h in order to fully understand
what is meant by the call, while this is 'good for' the developer it
makes reading the code harder.  We should have an function appropriately
named that does this if there are users for it intree.

By grep'ing the tree for list_move_tail() and list_tail() and attempting
to guess the argument order from the names it seems there is only one
place currently in the tree that does this - the slob allocatator.

Add function list_rotate_to_front() to rotate a list until the specified
item is at the front of the list.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/list.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 79626b5ab36c..8ead813e7f1c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -270,6 +270,24 @@ static inline void list_rotate_left(struct list_head *head)
 	}
 }
 
+/**
+ * list_rotate_to_front() - Rotate list to specific item.
+ * @list: The desired new front of the list.
+ * @head: The head of the list.
+ *
+ * Rotates list so that @list becomes the new front of the list.
+ */
+static inline void list_rotate_to_front(struct list_head *list,
+					struct list_head *head)
+{
+	/*
+	 * Deletes the list head from the list denoted by @head and
+	 * places it as the tail of @list, this effectively rotates the
+	 * list so that @list is at the front.
+	 */
+	list_move_tail(head, list);
+}
+
 /**
  * list_is_singular - tests whether a list has just one entry.
  * @head: the list to test.
-- 
2.21.0

