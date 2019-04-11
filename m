Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F59217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946567;
	bh=KmUiynWUvzX1AGA6hKWXMi0UzG+E6PNVUghW6sPUh0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pyM3SHRnqsq9swyhJZgGe4fYPTvGPW5I3urh57ElVtJHnb55m8gQ6MVoZPRnoMQfx
	 giKae2JIEaIFWCB32VIn7+F9hD/00xiIElLNkZCCfRHqDAG4XVy4CQ0UjM1/xXHaEZ
	 7umD7zLZv6+lA/0AGBfe5uFEyOJXRTR2Yykd9esg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDKBgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:36:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41235 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbfDKBgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:36:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 04F6A147EC;
        Wed, 10 Apr 2019 21:36:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Apr 2019 21:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oAX6zCohmPiQ74kYACc2QgeImmemzleYDH4h+URdt/s=; b=bU4QAIg2
        NWnEZDK05i97TTDWVBgITU4BwEoq16Q/a6w1aStUqIWQNenRpyAOgNq3Nla8uF94
        DDZCcbxgIEdcuw6BpW6tG8X7B4VbY+UvprRvIs5H99Wo1H3hLTIkNOqnvvRec4O8
        4GB0Klrr2CCXKs0w5zY4PHUaMhYhpW+cfxDDVCppFNu8l2rluP694CqwuBL4r55e
        epQf57pWCIqDvmDijy2LU4HpNI7ExugUEQESWRu/y9y+6w7zeGKwMDHVcl4GvzBw
        1Mtc4t4AhWbTNTvOeO5tCgpnCRzvsj1PUpPd6wA1mgEB+Afot2S7cVXJ2ZUSkTx5
        SVaiAaTtGdgl6w==
X-ME-Sender: <xms:A5quXF21ca2stwI5jdRG0xP8JhvI8uJqkAZBfi4ZXu2kKsvdNkD6Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:A5quXAG3qhyZxlNst_PXnNIOcBMJu9oJAn74cUGfS0xgYt5VTH_5tQ>
    <xmx:A5quXGgGt_tTGicmDty1E_gqgPM5CszeW6W0fuQIyUVnuvdIiHf-wQ>
    <xmx:A5quXCt4kknYI0F4wITCDwJtiN4ZF9TOmTr4wzzyyle_AKy93S-dDg>
    <xmx:A5quXGlC-OYQKBm7v5DbpIAaNWx0rHhj8RhkEfx-r7dNM_Twbp1hMQ>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 540ACE409D;
        Wed, 10 Apr 2019 21:35:55 -0400 (EDT)
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
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 03/15] slub: Sort slab cache list
Date:   Thu, 11 Apr 2019 11:34:29 +1000
Message-Id: <20190411013441.5415-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411013441.5415-1-tobin@kernel.org>
References: <20190411013441.5415-1-tobin@kernel.org>
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

