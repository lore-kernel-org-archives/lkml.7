Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF132087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552541531;
	bh=Kl9PloiNckNnn8mTr4uIrkVlJzTynYgyFrsKdF9FMDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKpDCJjIzXxZuxToIPZWXnKKhoY577tInraYnf1mqV3jtecCWexOC5oTvT1eLHpFG
	 pyGIq1LOrf9EevQFBqmDOKEOXbVcE2OTcTwuDWR5jNMzHAhVwsC0yzwXUzxLBgmTem
	 nBJZJqG0GqGC++axLxwMKRwnB7k3J4PIQLEELRpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCNFcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47797 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfCNFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9482621550;
        Thu, 14 Mar 2019 01:32:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Mar 2019 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=D6RBo2xA005T3vgh61b+8gQHpH8S5KLC0eS56YqC/3o=; b=jokTLtgM
        Pw26V8ZDtMnDR0czqO17EIIcwvEW/JO0xXkBcGUhyIw+0oppZVFCW8NduwfH/UeT
        1zQvwPnzk8HwOk5PMEqWQZjm06otbVy4h42L25gnq4mFk35xBjibdPCPvVFbeHTl
        n8gfNwLz8mjdCZNblYO1EX3wWWe5vmHY1Qm8cXV27ox/rjwGDt7or3jiSBcPSB0E
        eZSu1ne352wvggS7swjQ23vKAR0wJY2+ode7jQ/hhXFQd4Ub6L5o3kv463FjfzIt
        v+I3lwVjurRoQ5Zt+PwXLQxloGGAJTnCk+lfUvNXI95APCINQjM1mhfwqWtRNkFU
        bDPAdWQ2KV943w==
X-ME-Sender: <xms:WOeJXEurL39Wn7M4NqnAgDGjp7VVGpC7lop4WQN7AT8PeIBuTNlMTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WOeJXMIp-xDfTnXcvsH5nHpwjyr81vC5a40qkb2V6175T36BApu1FQ>
    <xmx:WOeJXGbGDKqc5G_15E3_DAaQYu-cphvi5343CgTCWUsyRTECteUbUQ>
    <xmx:WOeJXCK54Ni_Htqi9TD03s_Za5AHj9BSeqI-0ioIVSJULx87gewbHw>
    <xmx:WOeJXHRfat0peDtsBxFlK_JnN6aEtp-eRXbUw004oEU-PGdpoc0qEg>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4137E41BB;
        Thu, 14 Mar 2019 01:32:04 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] list: Add function list_rotate_to_front()
Date:   Thu, 14 Mar 2019 16:31:29 +1100
Message-Id: <20190314053135.1541-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314053135.1541-1-tobin@kernel.org>
References: <20190314053135.1541-1-tobin@kernel.org>
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

