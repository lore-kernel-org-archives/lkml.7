Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CD4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946666;
	bh=7IIzJ5j96mHcrlfO5rnfZhFJ3/qUC61ViUb/TqwmoF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohqVJum12DnjTQsdahYT21BQkGE7ssmygBtpZSqgnojpGm2hkCuItpr+8hZWyviRv
	 P8Jmat2HMwOsrrgBqreKhaRwn3/FMql7xA6mzVUtBzw2elQmu6kk29toD/BCWoKs9I
	 2o/qjKk3otpN1LCV50cbS8dAf6UMzOy6O8rXQQhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDKBhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:37:45 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36515 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfDKBhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:37:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3835E999B;
        Wed, 10 Apr 2019 21:37:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Apr 2019 21:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bQrKJO1ca6Jnb6VAVcy4YOcaMtIAYDp36gD1sjc6/M8=; b=yBlNj5Aj
        x0jERAcX2nr8Cd8pENxlZdO97pwvF1NoK6TuCQ1brau0DWTvV1ZSAt1dD+zRVwt1
        f7G5jP181kU6gbOeouIaRF4A6IZLX20cnJ0PCFa/nGlv/IfL6IJWJtdT0N3ZOXBU
        TEj8iyiSmiX8iwAMHX9jUxkgs4KHVBbZL5HdCCorCoHBuh4x0Fr43See53XVlJl5
        vzXXuJUfpxuFmBKCN8ruXW6Q8GiYxgFV1oW8b40DUJ3RHiA+nFIPaSBX6MckJ9W+
        UUSWKB2gpBjc4X76BEUfeXBA9tKmd1n+ZV7ZxbWuO4pxRq1wdrzfVUn39bFzO9sn
        v4xFOp3swHx1Ug==
X-ME-Sender: <xms:ZZquXJCrAVQEDp_0eq0hFxaFtI5OiOF4bIethMS67w2YR9Kdq7_Dbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ZZquXLezwxv2nRBUMSG-riGoxXI303uykE5A8vzzWrl_5OtCCx5O7A>
    <xmx:ZZquXNEuO00nfKwnCztsTH-gnPDWMoTAfPvgDz7HuE_iOP6tDZxdUQ>
    <xmx:ZZquXNXFyubUjW-O0i8GykgVGgog10PVBVThGrr6IJvGV-RRXL4kCw>
    <xmx:ZpquXO5IVF19Ojbcc8e9uXN0JvZAt1FudYX4shceC83MWYKHF_PAYQ>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62D49E408B;
        Wed, 10 Apr 2019 21:37:34 -0400 (EDT)
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
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 15/15] dcache: Add CONFIG_DCACHE_SMO
Date:   Thu, 11 Apr 2019 11:34:41 +1000
Message-Id: <20190411013441.5415-16-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411013441.5415-1-tobin@kernel.org>
References: <20190411013441.5415-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to make the SMO patchset as non-invasive as possible add a
config option CONFIG_DCACHE_SMO (under "Memory Management options") for
enabling SMO for the DCACHE.  Whithout this option dcache constructor is
used but no other code is built in, with this option enabled slab
mobility is enabled and the isolate/migrate functions are built in.

Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
Slab Movable Objects infrastructure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 4 ++++
 mm/Kconfig  | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5c707ed9ab5a..5ef68b78b457 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3069,6 +3069,7 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+#ifdef CONFIG_DCACHE_SMO
 /*
  * d_isolate() - Dentry isolation callback function.
  * @s: The dentry cache.
@@ -3136,6 +3137,7 @@ static void d_partial_shrink(struct kmem_cache *s, void **v, int nr,
 	if (!list_empty(&dispose))
 		shrink_dentry_list(&dispose);
 }
+#endif	/* CONFIG_DCACHE_SMO */
 
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
@@ -3182,7 +3184,9 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+#ifdef CONFIG_DCACHE_SMO
 	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+#endif
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/mm/Kconfig b/mm/Kconfig
index 47040d939f3b..92fc27ad3472 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -265,6 +265,13 @@ config SMO_NODE
        help
          On NUMA systems enable moving objects to and from a specified node.
 
+config DCACHE_SMO
+       bool "Enable Slab Movable Objects for the dcache"
+       depends on SLUB
+       help
+         Under memory pressure we can try to free dentry slab cache objects from
+         the partial slab list if this is enabled.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
-- 
2.21.0

