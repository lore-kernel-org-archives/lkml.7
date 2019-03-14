Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB14C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6032184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552541560;
	bh=r5h6JJyUoigSLmyy7jeNy9sNpJ6fC4kUbDU6Vdz0hAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vDSgsWwUVFoKyWvdqb4V65Kn0ZSNonpkTrnVIB8ejo842bisW9xTa0zGq48gf5ZoX
	 h0Q0sfSsTNwF7hjjEsXxvQoKsDoMyLwy6NlIe/jmUYw/bOnaUbKQrqi+PnjDC6d9pr
	 DZeOIe5O63UM2GhSqVHRHKE6Tj5vm//Dla7laYj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfCNFci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57031 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727214AbfCNFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 66CA3213BD;
        Thu, 14 Mar 2019 01:32:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Mar 2019 01:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=x7XzuZHTX79KOo0NhHz+n2DRp/2Ctmdn2rPrkfVwAcU=; b=cq6T20jd
        f0zndyqf3aPS2jJfgynxjjCEtdmIuaFvb3+M+X4uBLKSicfN0ZbZM0HYmeVqdLi9
        1N1WGY/WOfXTzeqzC+x25ACgo7Vrgw+4EXnJ7nzXzGznQ8/HlcT469VKBCSlNN/g
        qv2InpYONKFrKbELh35Z280dplyM9YU99RDBRq/l8j2nNWlB6RPSCilCIOIfE5iM
        wQc3AkR+UbSfjDma9HJuDedIOCx7qNQgK8qeHdUleeB52qFNd53OgYjALmpo3NUa
        0pQdW4p6KH9W02Ysj2EnZM65AbbqpllxuetXCigkwpBFygisNWeormprjdsCBq3S
        gWEETAtrSdpXdA==
X-ME-Sender: <xms:cueJXLTq0x-P9zmPDEUJWqRLBnbqsuhRpZlVVVbN9lo7V5nppyrd2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeei
X-ME-Proxy: <xmx:cueJXJtklfuHIpJHXLLxYzz2tSeWL2DU_WansADc1QuFOVmtQ8XBJw>
    <xmx:cueJXMc1zPRFP-ktJdZn-bl6Bwx5Kmbr9w2Q5tbqhxiJHlwE6iorfg>
    <xmx:cueJXDY-9gAALsJQfx9QrnkSDKL_cmBVNVQqPDmV238y8EIfeWu2Pg>
    <xmx:cueJXDmCt_Ovc6IoAK6ZJtIX1PL6QgxC55jcwnP210Qiuf8RqwuHJg>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCF57E408B;
        Thu, 14 Mar 2019 01:32:30 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] mm: Remove stale comment from page struct
Date:   Thu, 14 Mar 2019 16:31:35 +1100
Message-Id: <20190314053135.1541-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314053135.1541-1-tobin@kernel.org>
References: <20190314053135.1541-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now use the slab_list list_head instead of the lru list_head.  This
comment has become stale.

Remove stale comment from page struct slab_list list_head.

Reviewed-by: Roman Gushchin <guro@fb.com>
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

