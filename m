Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5C020854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018523;
	bh=eWlDmRTqukkyQo94JKFnAE2NMu1IfH2hOphJuR8r+tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MA6+1IvbkOuUH3y0oJ4ub+dekG4sQiaKDja8LLUSV0huDVPjOBT0y9WxRtkP8n8XL
	 UtR68sCDV2k4E8HGgXwLmwcVWrlFv4OyUfec3ueBIUxpUEyMDHdCRaL/QfkTFgV0aT
	 lOlT6IR09L0DLvsZKMA2DtM0PNM+geCh5Z1WZYLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHEPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:15:22 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33537 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfCHEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 170A336A8;
        Thu,  7 Mar 2019 23:15:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7aXu4Ayrrg1lqUVhlvuMknXlREOy+clc066/B0tC+rw=; b=5CgYTMir
        sAHs6VuabE1G9iZrzN0Oi5mXbESfWpoQZyZRGmnw4vSL55ewvT5H4u8AeazvgsMc
        rBbvfmAZdeB25lubI+EM1xiVKSwZeeys5B8eRxi+inmikijvx6nHd/8Tnntb3twx
        7PwPKdTAvpLyCjJGRCGxKIbhsIuh4buEjLuDNfszP6jm+/FrPDmdT5Y2dHQ2QE2i
        KZ7ZmY7za7/dNYV/AxNH19RNfLr5ccEHuVTJNyl4WSYdA93J0yS9d5Lp+2/py9HX
        Jof8yQjdClrJMhbQKcrKin5JiEl59DbFAfiBu+fYq2gyP5artxGvyE9+f6rz6saK
        7xPc5fBThFgsRA==
X-ME-Sender: <xms:VOyBXH0qsqvhr-dhk1uH2Jjg7homNmmhHQMmAA6SD5o_MenLRRn_ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:VOyBXM21B0Ensgjz-kAXWpSp5DKmvWs_sAoMdqB3lTz6ixXV621TCg>
    <xmx:VOyBXJp2Ti_I1qryjFn1xVrKDvWxYSIWvIj3trNCPR-amIA54TlbsQ>
    <xmx:VOyBXIiwDAwY5IgwsfMPW89t7BwprkYHjHfyVYsTL-a-wKHfP4OENQ>
    <xmx:VOyBXDrk1gtI_4psQwRLwknP-oT_PIe5sM6m9IrmgiBYn6PwXxCDTg>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE59DE4548;
        Thu,  7 Mar 2019 23:15:13 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 05/15] slub: Sort slab cache list
Date:   Fri,  8 Mar 2019 15:14:16 +1100
Message-Id: <20190308041426.16654-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is advantageous to have all defragmentable slabs together at the
beginning of the list of slabs so that there is no need to scan the
complete list. Put defragmentable caches first when adding a slab cache
and others last.

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slab_common.c | 2 +-
 mm/slub.c        | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 754acdb292e4..1d492b59eee1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -397,7 +397,7 @@ static struct kmem_cache *create_cache(const char *name,
 		goto out_free_cache;
 
 	s->refcount = 1;
-	list_add(&s->list, &slab_caches);
+	list_add_tail(&s->list, &slab_caches);
 	memcg_link_cache(s);
 out:
 	if (err)
diff --git a/mm/slub.c b/mm/slub.c
index 6ce866b420f1..f37103e22d3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4427,6 +4427,8 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 		return;
 	}
 
+	mutex_lock(&slab_mutex);
+
 	s->isolate = isolate;
 	s->migrate = migrate;
 
@@ -4435,6 +4437,10 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 	 * to disable fast cmpxchg based processing.
 	 */
 	s->flags &= ~__CMPXCHG_DOUBLE;
+
+	list_move(&s->list, &slab_caches);	/* Move to top */
+
+	mutex_unlock(&slab_mutex);
 }
 EXPORT_SYMBOL(kmem_cache_setup_mobility);
 
-- 
2.21.0

