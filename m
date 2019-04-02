Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF565C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8A720882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246418;
	bh=okhfCEX2YYuUtMt3M2x4fFzFNy/awNAjuDbozlZm+vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQJz+7zIC9a6gDm9eKYGsGCw554B4eJz34bymSTZcdnhZ0F0OALd1focuqBhZS1mO
	 hfKwZU5rpX/WoCbQJ6UiFNeOn2nWSVbg0G6YYRAEgCZoMLL/kzCWlVqRg7z9IyDBf2
	 sBdgVAnVL91mltg30TL0LY7c6ea//Sdq+UQHIVqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDBXG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:06:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56949 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBXGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:06:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D7A872201F;
        Tue,  2 Apr 2019 19:06:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2019 19:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BFIyNbFQfvFKfyZUHijpqSaVm8ggK3M3/XYK2FaoXEA=; b=jFUgvtAn
        ZD44OM9rhEKh8z7rEJ3IOjLZxODs7BrvCHA6A9nZFfJ4LTx2tMN6jsJa3K5fGXV7
        JG0CEUTQLUc0zkavWdhwXnLP2jBJXznd0sZrSJ9DzJCwWfyTaIhawW8j+Fc/aOwL
        dnDekI7NVWb5zJVIM1HuXvsEG3cbBqh4/ikkVFEfWvpcQnmEQhh/lLUuvuhRvm9x
        DRsgG+bDTSQrq0SHLppcw/lsiLLFQ6qjJwI10FN7dae58qTzwu85vyXr7XVlEEuY
        dBeaZvSJtT442FqLK+Rbux04dPrtWeASpm1s+EYiWl7yp6UzRvfPs6tEUwFELSh1
        JxHWOwHuipcqZQ==
X-ME-Sender: <xms:DuujXArJUzFxjNjOvNz_u472fh9cModyLkC1Jz8aGyahX_KPyAA5CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdduieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeei
X-ME-Proxy: <xmx:DuujXK6KqOmMJlt6YmKqst823_3vQlEGdq_4mUmMMSSN3Wf6RZnf7g>
    <xmx:DuujXANNbmc5OO97zUnWbroGMKOSnkZngMp1aCcCXn_1PHhCp56tjA>
    <xmx:DuujXMOF6sr2fm4UddbdBKIwzISOdf4kwVz9RpRUYmYva3pDPAVTcw>
    <xmx:DuujXMXoiFV_nHUVTKcwhFlQ9YLoxn15hvtcAEmgLc75bCMdhG7viQ>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id E3F3010390;
        Tue,  2 Apr 2019 19:06:50 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] mm: Remove stale comment from page struct
Date:   Wed,  3 Apr 2019 10:05:45 +1100
Message-Id: <20190402230545.2929-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402230545.2929-1-tobin@kernel.org>
References: <20190402230545.2929-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now use the slab_list list_head instead of the lru list_head.  This
comment has become stale.

Remove stale comment from page struct slab_list list_head.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7eade9132f02..63a34e3d7c29 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -103,7 +103,7 @@ struct page {
 		};
 		struct {	/* slab, slob and slub */
 			union {
-				struct list_head slab_list;	/* uses lru */
+				struct list_head slab_list;
 				struct {	/* Partial pages */
 					struct page *next;
 #ifdef CONFIG_64BIT
-- 
2.21.0

