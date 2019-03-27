Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663944;
	bh=35XsTnpkCZfNNHRKKbJsd0pf1ZZzHI7LoskmGtubpCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smnTvTyDOad26jOcguwCvC38JsXq2QNAE7fiCt1CtOYRN9pWJ/ofkzTkeGx4cjFW/
	 96jEaop4YDj46PWBUoAChUCnwxBklEJ2QFYvSXWnY7ykjo520HlaogctIYvCIOSzVV
	 wok240HM7KeAbSiiGeRqiKnhsgSrCj4fOvzJjCaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfC0FTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45697 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 19A48221C7;
        Wed, 27 Mar 2019 01:19:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=EI2kvjMYxI9NZT6jazAG4/C7CRPm9Z9KWaXkTfQAzGE=; b=U9sWw1nU
        +9jg6Z+Z1sT49a23SvLI+2rRRTiMFJEI1gaZklRjLH+X6hEToIubfXX6UxTaa7Dx
        HhXfWYg0khODYbznp2vvrSoGBZfC3kCoe7aLOdSIi3nanv7QZGEcYmXZDsjXWvdr
        8cuEPIGungynqNWB3/zO4UeULGpeFL7461OJE1p8Vd580j2IujrkOqBX+/DNxmZu
        Nl3cM+BsSddIdF4S92oylwCa5RET5janxwkN+uuJmOrCWNG+YMHf3JJa0Y2YiZ2o
        leN1Ny/ikJYP6Ba9KMeVv0We43+sxqXsUeRr8H50dMButjGQVbnZYfIH4jQhpFmu
        1huOVLo9p2r66g==
X-ME-Sender: <xms:xAebXGOM4GyV5vq-q3El9FeMveF4Vnnof-oCX12Qr5TobB715pSYSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepke
X-ME-Proxy: <xmx:xAebXMMFeCZycl7bS1RxVKverYD7kes-VW6CkVQuDuMAWHp3Eqmr0w>
    <xmx:xAebXILti9DemC0uScgBjSBPqShhmVUEfCyCPxNkS6hoKpITk729Rw>
    <xmx:xAebXGp0OVKKtJqUseHw3iH7rgGQrP5Rrc-5dz3QRrZGS_geCksJ2Q>
    <xmx:xQebXBOWTQ-6M0_t7vQh9d-DRgqB2LvJTRKQsa6IPLiK_pHlmAT04A>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id A02E2E4210;
        Wed, 27 Mar 2019 01:18:57 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/24] dcache: Fix i.e. usage in coments
Date:   Wed, 27 Mar 2019 16:17:02 +1100
Message-Id: <20190327051717.23225-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct abbreviation for 'id est' or 'in other words' is 'i.e.' not
'ie'.

Use correct short form: i.e.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7bc7cf9b8962..9fc13c574bfb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -366,7 +366,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
  * LRU list _and_ the DCACHE_SHRINK_LIST use.
  *
  * The DCACHE_SHRINK_LIST bit is set whenever the dentry is
- * on the shrink list (ie not on the superblock LRU list).
+ * on the shrink list (i.e. not on the superblock LRU list).
  *
  * The per-cpu "nr_dentry_unused" counters are updated with
  * the DCACHE_LRU_LIST bit.
@@ -408,7 +408,7 @@ static void d_shrink_add(struct dentry *dentry, struct list_head *list)
 }
 
 /*
- * These can only be called under the global LRU lock, ie during the
+ * These can only be called under the global LRU lock, i.e. during the
  * callback for freeing the LRU list. "isolate" removes it from the
  * LRU lists entirely, while shrink_move moves it to the indicated
  * private list.
-- 
2.21.0

