Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A6C10F0C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0828B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246393;
	bh=G2a48G7o4UcrioviB7pl/hGFudezjiosWfOqUCHVKZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JuURHxUYRS3xoTRg/EDTFycCvk8yX9o/bnZ1zA/R6la42+OKStG6Cs8EBKq66USyW
	 W0aIEesyuuMLGmVGm4+rXrAnUFsn08vqordRzkjMBw/jVoqXHXrZdyfxugHb4y41mV
	 BGT9DLvi3V3yvEjBpkDir+mM3742dt57XwaXGPPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDBXGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:06:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50801 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:06:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 606BB20B63;
        Tue,  2 Apr 2019 19:06:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2019 19:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WyIL3jAshSjdBFnKxRJVP8UxjvsL3RiIiqvjpUWI/P8=; b=S9YZIJcE
        ioLWYGHJy9xvw0Z+EIbMaGsCAADIx/5Nw2oDC/AowE5OE8MjNuQ+sqBwuY2qyDC8
        s9O9em3R9HRwWRLDyOjBCpdG7ol8zYFeYr1u8ckmdXRFOAWa6mJ4wjPTIIjn2dsx
        38slfK7mNrfaEJaEsOVBy/a16YkhWbK7oMk3K5dqkBSS1EL/wh/1bdrxaDV9vXIP
        WUvdHHuR+EuFQTpeCnFjNzBXZIIbJ+HTdIV8CIJsK1K+uvNSd63Z6UIsK6zzKXJl
        JT79i6i8j8eOx7Jm9xkNMreAop2jfoHI2ra8ZDE2S1ISpOqY/Dw3FAo6z+nqU0my
        Tk2caoQt3XN1mA==
X-ME-Sender: <xms:9eqjXFs9Bv-IY4LgPpq7YJm064ggklAjDR0xPtkV3_3rVftztl44tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdduieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedt
X-ME-Proxy: <xmx:9eqjXCvX0Esioe3qfH7H7YsIIsaaVXXReE23wdARAieZPlAXwM43Ng>
    <xmx:9eqjXDwsi1D-8VESjhnFE3QulC_3so36wdnpmKJP6BTJbiTSn5LQOA>
    <xmx:9eqjXAjHTjMnuvrv3gh_fjEdYLl88hbEfNq_khdewDzPs5XgGwb4rg>
    <xmx:9eqjXEoFxBJ621naImkvkzugKGYfwbpkpIEnoJC_v8o7j89AAYr3rw>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDCFC10310;
        Tue,  2 Apr 2019 19:06:25 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] list: Add function list_rotate_to_front()
Date:   Wed,  3 Apr 2019 10:05:39 +1100
Message-Id: <20190402230545.2929-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402230545.2929-1-tobin@kernel.org>
References: <20190402230545.2929-1-tobin@kernel.org>
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
index 58aa3adf94e6..9e9a6403dbe4 100644
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

