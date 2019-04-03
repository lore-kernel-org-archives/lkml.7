Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE13C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC60120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265869;
	bh=Au13uthtBTxdLXt18wPgrDh4hPRGQEFmSBEnyh8jQW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjWO+MryeCMvVLE45/7TieYnCReowqSd60rHxn0Hpz7NQ5QXBUF1nLd5lzbHVT+D6
	 a4IxAua670orVID0TGi4dzAty8KDuROcGtk0GtejzbNTzyY2dE2OC+OhRRptZkV6WV
	 4GZjdE01yXLG2kbB4mgA3UawW54YxO8fFMqnGaWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDCEbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:31:08 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33459 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728655AbfDCEbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D808121F01;
        Wed,  3 Apr 2019 00:23:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rfKadsTflryLW7911DaQh925XQ0k2Bp3gi/G7eAxyJQ=; b=mTY6Adzl
        61j/HX4/u8pVRmeDhbPrC5pgYVGektr0Ftsd0SvT2OiwWBG1APy9EJGh9fp48NnB
        EkghxIwUbm2vc5eGdfY6Ri7B1WZ7dFE83Q8KjoMLauPYrqMiBsUm7PfnTkFi1GJ7
        AMMY5EutgtgXsI8Nvo/RteIagRpivu78gCb49FFY6+o+kHO1NKoRklIllmfpv7kv
        SmuTEtJ/ShiCV989LSfZZTOhLMZ4ZXsflOqw1ZbkGS2U53evb8jOl/5M8KsC23VZ
        L9h53+Lc1hmENNQehrHIUgnv+MsJH0r7Z+r+aKzB9oSnGpEq2VNsYTck9ArRnnLM
        jI2WmSnybJjAnw==
X-ME-Sender: <xms:OTWkXHGylsvalQWAMl5izWKjp4SQsxX7i8zbv0Gt1Pi54edrArVyDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeeg
X-ME-Proxy: <xmx:OTWkXAptUlOecLp18o9rOj3H6Qc0RMCCM_Vc8n-CxnNusPQhx7hVAw>
    <xmx:OTWkXL5yRsgWF8ZOUGBuBDSEmatk0_8KTrJBx0tyMb9XR1oLjdY58Q>
    <xmx:OTWkXG4u0fTnZFapaXlc1smb9_kzGNJGS_gGQGox0sYu1dr21mdkhQ>
    <xmx:OTWkXP85nocoI_hqxskrB9-fo-G2-eq8L-wtCB-AM1GemyZa1r1eQg>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D044100E5;
        Wed,  3 Apr 2019 00:23:14 -0400 (EDT)
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
Subject: [RFC PATCH v2 05/14] tools/vm/slabinfo: Add remote node defrag ratio output
Date:   Wed,  3 Apr 2019 15:21:18 +1100
Message-Id: <20190403042127.18755-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add output line for NUMA remote node defrag ratio.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index cbfc56c44c2f..d2c22f9ee2d8 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -34,6 +34,7 @@ struct slabinfo {
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	int movable, ctor;
+	int remote_node_defrag_ratio;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
@@ -377,6 +378,10 @@ static void slab_numa(struct slabinfo *s, int mode)
 	if (skip_zero && !s->slabs)
 		return;
 
+	if (mode) {
+		printf("\nNUMA remote node defrag ratio: %3d\n",
+		       s->remote_node_defrag_ratio);
+	}
 	if (!line) {
 		printf("\n%-21s:", mode ? "NUMA nodes" : "Slab");
 		for(node = 0; node <= highest_node; node++)
@@ -1272,6 +1277,8 @@ static void read_slab_dir(void)
 			slab->cpu_partial_free = get_obj("cpu_partial_free");
 			slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
+			slab->remote_node_defrag_ratio =
+					get_obj("remote_node_defrag_ratio");
 			chdir("..");
 			if (read_slab_obj(slab, "ops")) {
 				if (strstr(buffer, "ctor :"))
-- 
2.21.0

