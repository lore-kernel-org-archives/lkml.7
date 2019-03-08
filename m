Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C9C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5AA20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018506;
	bh=S88aIX8NLURNv2daglt/ZuDdJmdVJze7QOHSIU0z5NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wamER1nmF6pgDPI43hS77yUonR1jvTA7xvNJ1NIs2cio7c/GU8tK+4RTA0bCNCzqn
	 AjA36kx2JB18iGKSLrE9j2C8CIz4du3QDFoz05Es4JOwxctTTEviY2vWoi1JybWQNF
	 IKUCnxjb4IAu8NpXMBGCihgTkJoHpZoc5Qu2igwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCHEPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:15:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46891 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfCHEPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 24F41173F;
        Thu,  7 Mar 2019 23:15:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YrkkvhKvCcH6zbANtTOO3evnEL/yeR53kt/mCY+Xjj4=; b=OlWWky5J
        7OckGmNFMQaEaOY6sf1Ou0vdYhzjSmfwaHiUVmGSfl5JXRrSck5DtHCtovmRKRTb
        J0ur6QFL9dnuLNJ5Kkxuk3BSAQ2cFa+SrtgSrY7rAUH8ZENrontbrNldEybTAceD
        46/5jJvX19lViao4nLZ7GTkUNu8x6A/fhkIq2As6xYgi2joDCRWfPvdfQXa0YsZG
        Cagk0p6DpL/bTLgcxaVwzEWMVa92noye933XVO8NHRpqeyJkIJrcj8JwQ2yV6cWJ
        maJt388s5hzuw+6WqClq78c5JEBgKJC2JstrjA6BZXICVRc99k8WlnT3jp6xBy/i
        7d2h8zkKlRDxCA==
X-ME-Sender: <xms:ReyBXAncFa5yP66KpUPsSd408Rc3U77ZUFJ8MODTUcHRrnZR4qq6FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ReyBXJ7QNAJGnOaEq2cInc0LekTnomjsyTQctMvWD-vS4WZf27yMVQ>
    <xmx:ReyBXDkTPccY9XfWiwT1383YpwxFZveUs0LVQIPVk3xsExDhbIyPhg>
    <xmx:ReyBXEVIwFTipdEanz2WePYdXVTWfc8haukikBxdG3v-umcz_Yq9Kw>
    <xmx:ReyBXA-82aZXc2Gj6YvkfX55H9XU4NYMcvsHJAxSb7QD79_SP6bo6w>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id A72B1E4548;
        Thu,  7 Mar 2019 23:14:58 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 01/15] slub: Create sysfs field /sys/slab/<cache>/ops
Date:   Fri,  8 Mar 2019 15:14:12 +1100
Message-Id: <20190308041426.16654-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an ops field in /sys/slab/*/ops to contain all the callback
operations defined for a slab cache. This will be used to display
the additional callbacks that will be defined soon to enable movable
objects.

Display the existing ctor callback in the ops fields contents.

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dc777761b6b7..69164aa7cbbf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5009,13 +5009,18 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
 }
 SLAB_ATTR(cpu_partial);
 
-static ssize_t ctor_show(struct kmem_cache *s, char *buf)
+static ssize_t ops_show(struct kmem_cache *s, char *buf)
 {
+	int x = 0;
+
 	if (!s->ctor)
 		return 0;
-	return sprintf(buf, "%pS\n", s->ctor);
+
+	if (s->ctor)
+		x += sprintf(buf + x, "ctor : %pS\n", s->ctor);
+	return x;
 }
-SLAB_ATTR_RO(ctor);
+SLAB_ATTR_RO(ops);
 
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
@@ -5428,7 +5433,7 @@ static struct attribute *slab_attrs[] = {
 	&objects_partial_attr.attr,
 	&partial_attr.attr,
 	&cpu_slabs_attr.attr,
-	&ctor_attr.attr,
+	&ops_attr.attr,
 	&aliases_attr.attr,
 	&align_attr.attr,
 	&hwcache_align_attr.attr,
-- 
2.21.0

