Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114B9C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC0E2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556408952;
	bh=mau7XiwHeqwmv91EpKjmWP86gY3AVEE1OgZ3906IiWI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2gPbjaEYyO2De+dtyp87dIq6vMHXxyMQebgk61YVDuKXOYj+yWEpnv6xRS0nq8Mfz
	 HpLOFbFqLZt6/buzlqHr/P/eNNfSd1hV22AaDtO0UGaIPuOX9B+YhsRPSH29WqQ/U9
	 d61edFaI5g55m2Jm7tuF3AoACHN9YLgJnMR3ztfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfD0XlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 19:41:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51337 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfD0XlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 19:41:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B94E21448;
        Sat, 27 Apr 2019 19:41:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 27 Apr 2019 19:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jmuzgn2qTwOZmaWMM
        rvylpYaoQfaw7rrRV6d+SYFgtc=; b=gAwdxj7a4OFG119tyqRF80dXmpgeZjX/X
        D+xqe9Iptje2ETPSOVUowRM4r2BvmHZcZMx0sFENa2FdCDc3d1TUxdpzlGbk88U+
        Ys1wwttMZFyPMJuCF/7ZB+pdpNEnSr3q70vOJFVOiDlgfgB3V6rMzM2NCKNjkGE7
        0GfSJEel3NlT1/YWfmv3fawsSvxXxJUj83hFsXWVTVunK3sK7RgQrzxJVyqiFK+e
        pyU9oXdfRj9ChbyADD2HDCmfPutFKud4aaEHX5/TsZ9vp45DkBKZ0L1c0JYYy4vR
        2NsbiyVZZkhOHtW3kP8kPYX+KN4vWdSs65t0ue0U9K/e6fch0ZPVA==
X-ME-Sender: <xms:i-jEXAnJmXQS6YMqUPH4uKDrzI5UGrVowPzFL53b6ARv7z4fDuuPYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dukedrvdduuddrvddttddrudeileenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:i-jEXOU2zxEVfXxz2eHnGnrG8Ez6IycrxObWyH0AT3RZMxkga0lt8w>
    <xmx:i-jEXKJcxo-XpIWftArJGCByMwRIuYXdbb9AtLMYAadYLzgNSbcQuw>
    <xmx:i-jEXGuQgjLP7dpiv_3zvCTWfDPD-IhQtjzbR2QM4A2ru_bos4NCxw>
    <xmx:jejEXMbb-lgbwv7rPYjNTsg4MYV-7WWl7tpH68fN3Fp6J3DlBSD3Cw>
Received: from eros.localdomain (ppp118-211-200-169.bras1.syd2.internode.on.net [118.211.200.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE348E4176;
        Sat, 27 Apr 2019 19:40:56 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix kobject memleak in SLUB
Date:   Sun, 28 Apr 2019 09:40:00 +1000
Message-Id: <20190427234000.32749-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently error return from kobject_init_and_add() is not followed by a
call to kobject_put().  This means there is a memory leak.

Add call to kobject_put() in error path of kobject_init_and_add().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d30ede89f4a6..84a9d6c06c27 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5756,8 +5756,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
 
 	s->kobj.kset = kset;
 	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
-	if (err)
+	if (err) {
+		kobject_put(&s->kobj);
 		goto out;
+	}
 
 	err = sysfs_create_group(&s->kobj, &slab_attr_group);
 	if (err)
-- 
2.21.0

