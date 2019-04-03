Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B922146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265936;
	bh=KmUiynWUvzX1AGA6hKWXMi0UzG+E6PNVUghW6sPUh0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JEq2KHcqMJQq1EyI4AhOE9Ag60nHUvhpELq20i65ntIaCf3DWOiOMM0W1UHcEbETI
	 x9KlBSnfjvvYQFK6WOONucf6RRVa2zLtPhmkQQSvEgJJlYxZF+MCS/lOf0m6N3ZfDk
	 J5MJuRCYZ0E/5iY+0ODbG+qY/G5xKbtK6OzZBY3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfDCEcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:32:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60923 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfDCEbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 57E9821B2A;
        Wed,  3 Apr 2019 00:23:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oAX6zCohmPiQ74kYACc2QgeImmemzleYDH4h+URdt/s=; b=FC9CRiNy
        /A2QACAxPg4m3dmOCUdhhqa5feWxuaX7P0DN1cHtAGYWp1mGWP79PKIKnCk61N8b
        HJ+e0qEBWAWBOZ8aIklqcS6HduIcqSzhR2lHIemxwotBmC58QMnVTGS32LM3UIt+
        6qp1Xg1tEinuIHZtRcvmbN2JKESdUCciDey+5yqaPvwCkJ3TRgHkUAnA+MXn7aKv
        JIremYOdC/D8Zo9iexYBt+p91801gl7QHym/o0JuDzUYmYJMhU+7p0rN4tFvmNGt
        qdleqeBuW4FoFEBbAUdh3EXUMNNhPut1FvkVUfwRAj9AenIa0OO01aO3RbaLsYPo
        fSbc5pRf/Vpe6w==
X-ME-Sender: <xms:KjWkXAMAadFEKSji-jKpD65Pk5MCBTa69LGYjRUyDXr3NKHeHWW7bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedv
X-ME-Proxy: <xmx:KjWkXBNmOykh5jksjMZXXL3SRPbWLG97p95FiIAdlXfAyB8-TF_jZQ>
    <xmx:KjWkXMsjrBxDY92haktuDCCZN3U4tBtwqA4VcLqmUzCJJ7Wv0kmGRg>
    <xmx:KjWkXO--NjFTy9UKSOvKrEdX0FuExPWlG7a1ZFMTXvyJu6k5AMTKvw>
    <xmx:KjWkXJakolUOLXLXS-GgxSlXzBcuiKvaEnY5ABAZpxIA1X85q__9JA>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43DB310310;
        Wed,  3 Apr 2019 00:22:59 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 03/14] slub: Sort slab cache list
Date:   Wed,  3 Apr 2019 15:21:16 +1100
Message-Id: <20190403042127.18755-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is advantageous to have all defragmentable slabs together at the
beginning of the list of slabs so that there is no need to scan the
complete list. Put defragmentable caches first when adding a slab cache
and others last.

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slab_common.c | 2 +-
 mm/slub.c        | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba63e4a..db5e9a0b1535 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -393,7 +393,7 @@ static struct kmem_cache *create_cache(const char *name,
 		goto out_free_cache;
 
 	s->refcount = 1;
-	list_add(&s->list, &slab_caches);
+	list_add_tail(&s->list, &slab_caches);
 	memcg_link_cache(s);
 out:
 	if (err)
diff --git a/mm/slub.c b/mm/slub.c
index ae44d640b8c1..f6b0e4a395ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4342,6 +4342,8 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 		return;
 	}
 
+	mutex_lock(&slab_mutex);
+
 	s->isolate = isolate;
 	s->migrate = migrate;
 
@@ -4350,6 +4352,10 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 	 * to disable fast cmpxchg based processing.
 	 */
 	s->flags &= ~__CMPXCHG_DOUBLE;
+
+	list_move(&s->list, &slab_caches);	/* Move to top */
+
+	mutex_unlock(&slab_mutex);
 }
 EXPORT_SYMBOL(kmem_cache_setup_mobility);
 
-- 
2.21.0

