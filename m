Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215120851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018572;
	bh=pFqw0EnO5I/rtpD+P/DJeHUjyyUm9youWuBY6vQGK1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yDzgSCNb2VAZDMDEpNh+pjxiB/q2RljvHO7fz3dIGl46ZwZhuZmqvhAUWZkzht+GB
	 drjE1t8S7ld4fcQ5lsCsXJroGMOdDZCuPCuyZNZCy9mrsA1HohgtF00RuEPldY7LeY
	 ioo3SJK0xERzwH4BXEiQwLF5HN46C19prcKBpReU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCHEQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:16:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47615 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfCHEP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0A22836B0;
        Thu,  7 Mar 2019 23:15:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4XtFG0o08VP7KrL9BCqmvaLWxmrIynX8gM/X1EsO8JE=; b=FwMcvt+I
        Q6eBIB2iK4dL8TExfycPnlKNVCKTFW8q3Yq/KTCK1JuEko249NK4a1+3yEsOkkhv
        IU3BzXm7+zBA2Gr19tP2teZwKZeTUiseqG/p4mMXXUympNWXRYPPxjwbgTNFmO81
        /SrCZK0JuRHwIiOp5giq/JBqjKQXUi/fkJCgd3lh+shN2aRX2OCHOLiy0NLv3wR2
        AaaeYRe0sTgtPbRvmMgjmzfQMKNWVR7Fn1DFjryvgHD2g0Dpc3MeaTvxykX8z26/
        JZk/i8jxYjkGVQPkPJnW5nWIA4PK6vp3w0SaMp1fgJpYaWm3OFPu7qX/DjlPjAgF
        NeZAV6H54Fu6Og==
X-ME-Sender: <xms:XuyBXIReSHnPqgn7jiprdoGATVYGXBR0VkTHdS6ibslL8jFZtFDaew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepie
X-ME-Proxy: <xmx:XuyBXBoWKIsOw56NC0VVCNX3Kl7szTdOj2fOBXFEsRp9RiVLgxK_Iw>
    <xmx:XuyBXOrVwKHk_gK0_iVYMPy0niO7cgrjHHT4KK-bNd9opOPvtXumNg>
    <xmx:XuyBXE2jyw2K1I_1W3CeAs0tjc1lM2JWLljuy_Y3DRm2Ffdch_8F8g>
    <xmx:XuyBXMeRxWZRjlywgwGRGLRC8eNG-FCBsUDfVDZL5L38k_A9zXYvwQ>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE16FE4481;
        Thu,  7 Mar 2019 23:15:23 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 08/15] tools/vm/slabinfo: Add defrag_used_ratio output
Date:   Fri,  8 Mar 2019 15:14:19 +1100
Message-Id: <20190308041426.16654-9-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
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
index 9cdccdaca349..8cf3bbd061e2 100644
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

