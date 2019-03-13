Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E720693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552454489;
	bh=7aYs8wPuNCRGCcYMxBGPDmeCp6CVn9hgtBl2ArEeXkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gcugxoGgGSp1POlqawUROUeX5TwMB/r+Qp0JQrCJX7jfqBDgYxwAbiuJZOSxpt34O
	 WljCN+/H8rL5VWCxkPLbyBvibZUpVT+Ca/zBKsYuheoyfvAyrgnnP3ehxyVhF++AU0
	 dw6QpyAcjts143ADLkoWL1LjjRO2jHDmviRFUQOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCMFV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:21:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35931 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfCMFVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:21:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 32C5F38BA;
        Wed, 13 Mar 2019 01:21:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 01:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5/G8rkra1PA9yXaI4RJCelywIsswxA8Yq4jhZqugh54=; b=BIdKKQ84
        puIE8JiP3C10giQIRAAGXWMTSyOOJZwUWGn+oYQuU5RbdWp3FcAaZzwKODB3mziB
        81SXV9l4IYnPWxoEtNI/QmGYbCxKyBMZ4QZx+UMMhBpc/Ky5OnKv+i8Jd3w9+Rl1
        wPSr6W+u+bgFYSbUTrxIuyTNqYzsPqo/7UMg49LDlIctpXQHMJRWKVAMea1ZtGRU
        2lsnNz1pqWSeH0rf+qch8GyvmjswpadElzUfIw/KPhS/Ug1EwzfekSvZtBwtpvpE
        Z2jxMNfqLlXFyiMemrWJ64aPSg4mgtYITFr+N4IKi7+Vcxhv/h/Cl5LaJsatiAtl
        ZK9+dauRWkZ0oQ==
X-ME-Sender: <xms:U5OIXEoAQJ0VZauhADwEbcpZSgcR_NoBYpG1TXBEQqjl04c56XBqUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeeg
X-ME-Proxy: <xmx:U5OIXFGpU66pafwJGKzjwD7Yx2cytRviFezQqZjfb1BeuzqW0sB3-g>
    <xmx:U5OIXAtc1AqHZ6TW3e4bM3MAS1XB14Ajy7-zh88LE1l2aYdYauJqjA>
    <xmx:U5OIXDY0MUj11yd8rmDxVBmygK_7QN4lzGr1Ja6URIk6IrfwLW7Gfg>
    <xmx:U5OIXIP-QXHlaqcw74yAQS-1jj7C3ZgTf_I0aQpbGU5Z3PxAYfTVJQ>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BC0BE4580;
        Wed, 13 Mar 2019 01:21:20 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mm: Remove stale comment from page struct
Date:   Wed, 13 Mar 2019 16:20:30 +1100
Message-Id: <20190313052030.13392-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313052030.13392-1-tobin@kernel.org>
References: <20190313052030.13392-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now use the slab_list list_head instead of the lru list_head.  This
comment has become stale.

Remove stale comment from page struct slab_list list_head.

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

