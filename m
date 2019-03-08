Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B35620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018527;
	bh=lchJv4Jy+/gsoNnDQJ5WJgVgvu9R6oyL28xaQPwqBvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X+wUjaz6lF71O3BIffqx4IxE2OcDtYRufR6LmdQHu55eAOGwJdQcb0WggPLsROhjR
	 IPahUCjeJOSLg9y1SNQ30Y2vT1L74SLQnagsOk/BghRcKRw0SjaPDFUhMIO8OE62rB
	 plkFoeT1bQf6lxqjKYK2gK4+AYAP8+fe+EFUoKD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCHEPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:15:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53489 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfCHEPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A63323328;
        Thu,  7 Mar 2019 23:15:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8pAdMmQJ+aEt5aO3NlY8w+BP/DccAEmjq/sdk333X44=; b=SwqL8g6D
        FEedjSAwEi1G9wOQRIytv8jzzsvvSKFGH9BKDQDbRVqSfYc25o9m5aYPY7gGNhDz
        S4V8w7FcdMyO9/s8jimaE/Xbqkk5PGXe6VRIBA6jG2UuuNLf0Z48cm3urAEDkbXL
        uvnYXh8clb9ZbI15b83RrTyi/GTpmw8G4zHg/w1Bw/ZGHlLTvk2wo+cZvGknxOwB
        Pwn64GpwAi2a1IFAm0lhXFamG2wmW0GatncqQ9vbvmf16x76BbVM4AvKyp4w+Jvl
        YLQ6b22uLYq2kXh+JqOQyTxd2RY/S7i1FsCfEsLKpMb7/wNJMR8xV7j8W2D4X8Q6
        md0l6GTR01PM6Q==
X-ME-Sender: <xms:WOyBXEaMtt7j82Aper8n1YMihon8QgmMr8r3UFxWofkGv_PiLeZBlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:WOyBXNOraLOAOvyKsddSjuvp-FfI8gRecJln3Ho9xjylY5e2d4rewA>
    <xmx:WOyBXJbwtXv1qyKK_7h2tNQZF4uoTqNUjSmPB4EyE96mMiB3dc0QtA>
    <xmx:WOyBXL2BfE8DJsulGmS6z6Sdi-WktkdVQALytbpFef8aobdzwQjuUA>
    <xmx:WOyBXA3AmucocaQ3S-Lz6qO5ss5tcjUTtm0Pv0-K2KzVvZM8R5nNQQ>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55EEEE4362;
        Thu,  7 Mar 2019 23:15:17 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 06/15] tools/vm/slabinfo: Add remote node defrag ratio output
Date:   Fri,  8 Mar 2019 15:14:17 +1100
Message-Id: <20190308041426.16654-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
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
index 6ba8ffb4ea50..9cdccdaca349 100644
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

