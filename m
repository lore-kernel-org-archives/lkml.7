Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A4620879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="vEETgM2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+oHpI9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDHB7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:59:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49809 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfDHB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:59:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 980632201F;
        Sun,  7 Apr 2019 21:59:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Apr 2019 21:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DLP3NAwsImXCyFEGzPGaWnfGENp
        Kl0W4NenoS/NwlKo=; b=vEETgM2qKwAeqZTyu5/6N8i6o+pHju7yaWcyXNbTvO/
        O3WwO5BSK27gbI86VJd/+r+0QwfY3mCoeh3ZfT7I0D7bD5qJBatarpthEK5nxys8
        7IyhhL7L/UlFf2D0tZxO/r1WAL7ietshkugAcI9nyfqYZq9FdLeiQ3I5ACrCwXpV
        PCfgqZTFl367PEIeolnqmwDvaM6DJx24JiDDNctHIE3uzOyfMVMw6mi4KLQepTib
        9iEsO5xLpNRt0lev7K7KvmQKXco54H9sOX1CN+RCmb7UBKgGNxDOmc62z7AfgMpW
        6wYUQ6fHkubTjveBMeYVi/i6hwLu/CvKONdI4aN7d8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DLP3NA
        wsImXCyFEGzPGaWnfGENpKl0W4NenoS/NwlKo=; b=J+oHpI9r4y1nh7M9QBmbDv
        xM4qwyjPjQwvkoLL3tjVued5Q1vsShVOurokrbqNedL7xt4iOaAnENG7Q+LDmGN+
        bf30Cx2+6/Ij39sGqIGF9VbTFqjPepzUxIWowGWg3Ydgdw4/CgcM0ktbgxd3C8Qr
        WAy8R9N7YIRuMel+FZjSY2NgOYPD/NMtYi5HS8RNd8mHl7nY0q8nCp26NlVEd0Xi
        tPpAIbLtqInrxJX4UGTEMs3AXyj2QAGrE+2pESH8ZXeojPV8cb7KH9R/HIcArnvT
        TIMdE6Dvf8loYpVbMnifwn4340pgzvtYK4L0Nllmpqb9Ryga3FFyx/QNLmgC6LeQ
        ==
X-ME-Sender: <xms:FKuqXGMTKFyfJw4O66k-KwPOzMP3lYeWqM8e7QvlqEgN90EnTvs0QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvgdehfeculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    eftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdforedvnecuhfhrohhm
    pedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosghinhdrtggtqeenuc
    fkphepuddvgedrudeiledrudehvddrvddvleenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FKuqXAXKRxDbPvXwiWVW7xV-CBCyDj6RtRq76UJewYN51rV0J0rJKA>
    <xmx:FKuqXLIGw1jIzCq_TAkHlTaWpLsw9U-qlwpIE52XTGxxrMUmERRgiQ>
    <xmx:FKuqXB1PQjLZTZTK2UixZ6vCPIHVFYNN0PWpY5GmNNkGOFBArPGgnw>
    <xmx:FquqXCLLSKwsdJS02kQVBWJKFGLJCbWEPIQe1aKyvpM6QeCeXLexyA>
Received: from localhost (124-169-152-229.dyn.iinet.net.au [124.169.152.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEA87E4619;
        Sun,  7 Apr 2019 21:59:47 -0400 (EDT)
Date:   Mon, 8 Apr 2019 11:59:17 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, tj@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix a crash by reading /proc/slab_allocators
Message-ID: <20190408015917.GA633@eros.localdomain>
References: <20190406225901.35465-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406225901.35465-1-cai@lca.pw>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 06:59:01PM -0400, Qian Cai wrote:
> The commit 510ded33e075 ("slab: implement slab_root_caches list")
> changes the name of the list node within "struct kmem_cache" from
> "list" to "root_caches_node"

Are you sure? It looks to me like it adds a member to the memcg_cache_array

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a0cc7a77cda2..af1a5bef80f4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -556,6 +556,8 @@ struct memcg_cache_array {
  *             used to index child cachces during allocation and cleared
  *             early during shutdown.
  * 
+ * @root_caches_node: List node for slab_root_caches list.
+ * 
  * @children:  List of all child caches.  While the child caches are also
  *             reachable through @memcg_caches, a child cache remains on
  *             this list until it is actually destroyed.
@@ -573,6 +575,7 @@ struct memcg_cache_params {
        union { 
                struct {
                        struct memcg_cache_array __rcu *memcg_caches;
+                       struct list_head __root_caches_node;
                        struct list_head children;
                };

And then defines 'root_caches_node' to be 'memcg_params.__root_caches_node'
if we have CONFIG_MEMCG otherwise defines 'root_caches_node' to be 'list'


> but leaks_show() still use the "list"

I believe it should since 'list' is used to add to slab_caches list.

> which causes a crash when reading /proc/slab_allocators.

I was unable to reproduce this crash, I built with

# CONFIG_MEMCG is not set
CONFIG_SLAB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y

I then booted in Qemu and successfully ran 
$ cat slab_allocators

Perhaps you could post your config?

Hope this helps,
Tobin.
