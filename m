Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7240F20896
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867436;
	bh=okhfCEX2YYuUtMt3M2x4fFzFNy/awNAjuDbozlZm+vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fifSrLEqj66wEqx5gIkPk8RP2+rIM0Y8PnUZ/TJeaoV22sOHgFT3kqLYfgsC47Mul
	 Yacd+4wAxCUZdb0GtONr8Z0oYrUlIQk2gBHwWw5ltVFG8aNJqVFST3nMM+9fEQWtag
	 rqKhe6jSbPYlOWciFCn6xsVB6LTT5MGoxgAvrORw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCRADz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:55 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38393 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727765AbfCRADx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D72E2210A8;
        Sun, 17 Mar 2019 20:03:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BFIyNbFQfvFKfyZUHijpqSaVm8ggK3M3/XYK2FaoXEA=; b=KOAmRspW
        zBQVWYQ7vICgKRiQqNhAMtncIDQke6ig3Hz+sdddxUlCSTlcQT1rCLx5IszqwTh7
        JebvNswcv0GRgndUA3DVZVYb84T+t/L2RHTx+BGPq+Hydz1wdannzgYxtSLOSQJ0
        hwp/WX4SJWXnGVtZnVFeVJxsoEHjYOH8WnLLcm4vqnRCSzg2BFzJiU5D5WaPjqwv
        QNezb8UZvFW2/fvKBcqWtiuUOkm1Zu0XqKTAVALxQYKfBYmpseslQb6wMpaeSAAs
        Y59viX8Gu+BcUOaar/P+dMz5U3L1T5bzMsEvdWPDKkpj9HEeFzMMqoLmp5Oi12Qk
        q4QxuDgpnAzhqQ==
X-ME-Sender: <xms:aOCOXIXGvKZG3G-RbHqHN8nBpLKDwPqsvEyrGhwu2jLjgD85evxSXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepie
X-ME-Proxy: <xmx:aOCOXA36fJJx7e90odDYP9HIN0QWUFw-YLuyfuFIpXqZsltBtilWbw>
    <xmx:aOCOXHYShTMv6GNSSXvbkyutxBMU5Z9ZVZXDL5HeQSrCYSFXh2qTRQ>
    <xmx:aOCOXLrpBeY-uqgrwaqgcPSTVSuEIzjvqA3avHlPWubb-u5ls6kgaA>
    <xmx:aOCOXHw4MVrmOtdaJtn_tlSWzXbeYCU4HcsdLd05aKKvc0qSpombCw>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70051E4684;
        Sun, 17 Mar 2019 20:03:49 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] mm: Remove stale comment from page struct
Date:   Mon, 18 Mar 2019 11:02:34 +1100
Message-Id: <20190318000234.22049-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318000234.22049-1-tobin@kernel.org>
References: <20190318000234.22049-1-tobin@kernel.org>
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

