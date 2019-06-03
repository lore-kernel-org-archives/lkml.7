Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A110C46460
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4296B2724B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559536078;
	bh=a92ImecqWER0y8PD+NrUDpYrUNcEM2LG5MhLIrp4ZbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTQMuvp9ID6KyH9nmfdA+0L4k2n7erF0/GIe547gH8xZbt1QFB1CO95vdS0dlADpU
	 bcBIpBPY8AHuK1zK9BbPSilO9OOI7gANR19CZvso8aZOPc4ZlJs0C/oHnoQlQFQrMZ
	 t/erYGr8uMkIzbh1NuskrgvJVx7MzEuI30wHC3eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFCE15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 00:27:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51493 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfFCE14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:27:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E7B57123E;
        Mon,  3 Jun 2019 00:27:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jGU9saE69a/gfeKWv7WhcnJU8nruwl7/fOnxwG1r6J8=; b=8AcGMewM
        Ndtg4pdRtsPZpOOKqHUApLCaiiXKUPEyBBAaPdJaaMoZ4+B5eR9/1K70X18Cqxcv
        UsCHyzJfIMF1H80xNpYpRnilppJPkHuSiN7XKRXkAkLJxGDpxJ5+AxWk/on2Kj1Q
        4Dgq5Inh5H9ZWVDSXbCwgyxV1G5i+CbiPvRiY6x/sXaOvU84KptkfhMgi2NnGMi4
        7I5PYAJ7yq34ekuIxckmPeilZtbhnrt1WlolEFtEiRgzu/StEyM3hs4sJ0RA0fdX
        oT2kh8XjDLPSLm/nvFzdE9m/Fj/VLX+MNaxFJHKRQiG3KrYdgq8oL73l0Ab+WN57
        LZoMA1Af0XMAwQ==
X-ME-Sender: <xms:y6H0XBSnCvxB5QUBzY_zceAXhFcHrC1UQ8Z8K55zNuaFyueUDtZ7mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:y6H0XCCC5UUlERMcrpuraYfwZAN-prgO0tbUvf1H0Uyz7nhM5ckgUw>
    <xmx:y6H0XPaJrJlFMfhuQTEHG8bvq_oPJps3lPYqAwydSk-1acf8h7nUNw>
    <xmx:y6H0XGZhpdbhd8Hl7FaxP3Wl0N8obYs-EdUdDnV6ksAfr21tQyOCrA>
    <xmx:y6H0XIPjlm1YHg4LXXIIuvdNP7DVeDxZJksUn8T6H_OJrnquwXKEUQ>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id BBC6680059;
        Mon,  3 Jun 2019 00:27:48 -0400 (EDT)
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
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] slub: Sort slab cache list
Date:   Mon,  3 Jun 2019 14:26:25 +1000
Message-Id: <20190603042637.2018-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
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
index 1c380a2bc78a..66d474397c0f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4333,6 +4333,8 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 		return;
 	}
 
+	mutex_lock(&slab_mutex);
+
 	s->isolate = isolate;
 	s->migrate = migrate;
 
@@ -4341,6 +4343,10 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
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

