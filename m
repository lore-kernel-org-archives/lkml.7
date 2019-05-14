Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A70C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881C92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nDY82R10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfENOsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:48:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35833 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfENOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:48:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so18492024qtk.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9eQGAXN/pUrwyhsEw4eGQ0SnWi81FsI3CN7zGHdMUY=;
        b=nDY82R10ZFExPQ1BFRb0cIsRXMz1+Mbb5gLhwYj+P7wenw+vz2PGDVO3MW1ll4xmEs
         gzrdZELS8S8hCF9KgzMJiVhBrijLGGB98FkA8+R5fQM4kS6TCVEKcnjnmqEENZNN2g1i
         MIaN+82TeYtLkyYogEUBZJs5wC36oh/Lrj/mtbiGyb+InmfWr6WcxZ5AUVWPFFlrvyBG
         4/pj6sdMf1+RGHBtb7Fzr/WKYFSZbUrM0e04VzB3MN1farriSoCrf2lrxWkXLgFkKwSI
         ++gDxtWGnByHUiyi82arM6CP8Kw0joJB6gqMxBIk3ySoeP2uvbbsfusBhTd61y/daTbz
         mYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9eQGAXN/pUrwyhsEw4eGQ0SnWi81FsI3CN7zGHdMUY=;
        b=SeRyGlB7hKzI+Q57+vZGkg5pYRV2jNUz1SdVcduGloHUlv4tzWAq6+xH0BSQfQxcB0
         x2N2lSRkKDttf8qIXy6iq5wgzIbH019GZmpfBQtCgnyZkdKj4bFrWC2mUxakUAIYVuyB
         MRoVjUzGsbFLpgFfQP25L87Cc+kgmQku7DRbnkL5oErd811cPawiarOrDO5ig59jI4EQ
         4+ad2Ci/+njwxx5Z08XzlyRGGBfNn864Du2QbMsxLI5RgG0gF26OGDAFQ6JntsgFbKN9
         lXsr/tjvtABdbUVdyoHPXlTYxFSJzdwU4zk7xWr3an3YawbPTLUhyetNXrxCv7XJCtfn
         J0UA==
X-Gm-Message-State: APjAAAU31lbOBj1m4Og2JKHl47iMtEOU7RMXVtxMZ3b1EMa9VXHWxKNU
        GB0/Kah9Fk9GEl3axoXDcUChRA==
X-Google-Smtp-Source: APXvYqzApoMig2QGgNA/X1ddscMp17wEIujDVgwIUcQLacZ1b7Qm2pChC9VvoBo44rkmkDMamq2H4Q==
X-Received: by 2002:ac8:2e38:: with SMTP id r53mr30002293qta.192.1557845286967;
        Tue, 14 May 2019 07:48:06 -0700 (PDT)
Received: from ovpn-120-85.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 124sm7905551qkj.59.2019.05.14.07.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:48:06 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] slab: skip kmemleak_object in leaks_show()
Date:   Tue, 14 May 2019 10:47:41 -0400
Message-Id: <20190514144741.39460-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running tests on a debug kernel will usually generate a large number of
kmemleak objects.

  # grep kmemleak /proc/slabinfo
  kmemleak_object   2243606 3436210 ...

As the result, reading /proc/slab_allocators could easily loop forever
while processing the kmemleak_object cache and any additional freeing or
allocating objects will trigger a reprocessing. To make a situation
worse, soft-lockups could easily happen in this sitatuion which will
call printk() to allocate more kmemleak objects to guarantee a livelock.

Since kmemleak_object has a single call site (create_object()), there
isn't much new information compared with slabinfo. Just skip it.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 20f318f4f56e..85d1d223f879 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4285,6 +4285,15 @@ static int leaks_show(struct seq_file *m, void *p)
 	if (!(cachep->flags & SLAB_RED_ZONE))
 		return 0;
 
+	/*
+	 * /proc/slabinfo has the same information, so skip kmemleak here due to
+	 * a high volume and its RCU free could make cachep->store_user_clean
+	 * dirty all the time.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_KMEMLEAK) &&
+	    !strcmp("kmemleak_object", cachep->name))
+		return 0;
+
 	/*
 	 * Set store_user_clean and start to grab stored user information
 	 * for all objects on this cache. If some alloc/free requests comes
-- 
2.20.1 (Apple Git-117)

