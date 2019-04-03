Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A70206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265949;
	bh=uDKSjBhq2UlkguBtzx815xoUuTpfEcfDqkmxXLF6m+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mfzgc3r3noEGwdmicc5MFKlrKHlocr8HeqEu38fF87V4AgXeafbtkToBq9uLlYPf6
	 aVQYW0spdq6k5bVzjvOpIKogAM8o5jZJBn4mdV2OLFecJhd6b1//LkTaE+QQ+iLBsm
	 aNBeMlxfpF6ezOO4QsQYIcoam5fDC6u31qpbNJtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfDCEc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:32:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36233 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728526AbfDCEbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:08 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 00:31:07 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DE0121F26;
        Wed,  3 Apr 2019 00:23:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=eB8W4ZifzOOx7n477C9lsHSgteznueDWRYbTVC4RGG4=; b=8g49H2KY
        JPyh5+opdBo9WW/hQaD63ziek5gLUqZ1SJAEGX/UPnwhMGr6q5qStSpPv8+QQxjR
        POc2MSuSFcOpQ9JZVhJXiQ+CsQsAJYapK45RsWHMctm3CZYuKSE6kMSi70ZPCWOX
        sDJ6uFRFKyVqXJFxXTeB78uOR1Uoq647tk4/PcINYiihTDwM4BZa9nbT5K8/3Glz
        PMRpIDbhDh91Nf5jKli946Lb0KAegvU1nuuPBHNX6VPf5srmtyz6QdzcdHCEzha6
        gEZZuskbhtHXFyoOlPvr6z/b3XwxrmRNq2QxqohPy8bPTBFDQFZw1MDSApW4a04l
        vCd/yIyM8PLOQw==
X-ME-Sender: <xms:QDWkXCxRIGyAQgFEXDw9jYYrl90i4NZYxrtv4fpvV7MOWWQT_qA7hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeeh
X-ME-Proxy: <xmx:QDWkXFddG9JMs6HNDwUwAFyy3piaIS6zSSMva7UZW5-8_Hq4PlQi9Q>
    <xmx:QDWkXIveFTJbBvnFQwQgXrkwdL57vf6Xf-zkFXtnLYdD4PACdkLdUA>
    <xmx:QDWkXBMN58V4nxQrZC5mjohKJZSOIlFePO_fBx-vPehtH9stOsd-iw>
    <xmx:QTWkXFfKqIgCqODCa2b7XY5etePIbRSWtnjSo9HhJcTdlttAZjLN9A>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D5D5100E5;
        Wed,  3 Apr 2019 00:23:22 -0400 (EDT)
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
Subject: [RFC PATCH v2 06/14] tools/vm/slabinfo: Add defrag_used_ratio output
Date:   Wed,  3 Apr 2019 15:21:19 +1100
Message-Id: <20190403042127.18755-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add output for the newly added defrag_used_ratio sysfs knob.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index d2c22f9ee2d8..ef4ff93df4cc 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -34,6 +34,7 @@ struct slabinfo {
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	int movable, ctor;
+	int defrag_used_ratio;
 	int remote_node_defrag_ratio;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
@@ -549,6 +550,8 @@ static void report(struct slabinfo *s)
 		printf("** Slabs are destroyed via RCU\n");
 	if (s->reclaim_account)
 		printf("** Reclaim accounting active\n");
+	if (s->movable)
+		printf("** Defragmentation at %d%%\n", s->defrag_used_ratio);
 
 	printf("\nSizes (bytes)     Slabs              Debug                Memory\n");
 	printf("------------------------------------------------------------------------\n");
@@ -1279,6 +1282,7 @@ static void read_slab_dir(void)
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
 			slab->remote_node_defrag_ratio =
 					get_obj("remote_node_defrag_ratio");
+			slab->defrag_used_ratio = get_obj("defrag_used_ratio");
 			chdir("..");
 			if (read_slab_obj(slab, "ops")) {
 				if (strstr(buffer, "ctor :"))
-- 
2.21.0

