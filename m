Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D07C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBED22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ehqEcPmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKD1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:27:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKD1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:27:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so5563685qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/apWTUDfLE14eiwDE8NHXqEFW8ik9G3/ldVR45xOjqM=;
        b=ehqEcPmdEw/fasU+S3bHYOoDj6Bp/wjHEQbKzeZq0TnchS3/O9jW9fbqEpFuiuxOa2
         XHmKwdN7NftxEHFUeQVes21mTseJ4mH4YP3WFLbyQl2GON2pS57574KYEgbhFSpsxWCJ
         hm3EBL4iSDbFaQAUmsjrzywM+ylpxuqVjQmisD8qRH2uI1HgL15lvVbl7h0S9r0K7olj
         gLecOPnJvFKFtehdAPw/pI5nQguQrbc6k/NEsn2dsfWyvsF4abHGdM7oezcR0gfUPphm
         KW74NiUHSPLbpWgE22ClJi8PIjGmO04YvuBdQQz/JAiWioxpEGYwcVPCtohT+NBbOVbD
         1VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/apWTUDfLE14eiwDE8NHXqEFW8ik9G3/ldVR45xOjqM=;
        b=LMlbLWqeHc4lNt7MNOABC5icPv1k1ZOLbpvkInW3PGL0TXA0luk3FFEEVQi7K10IH2
         sP2WVUR0hOrAWrtNdOfmyo8v/d+h/pmoIBL0phUTIJhOhE9RM7PO+ePEl2GA9BrJZwlP
         xLm8qL0xybPOCvKgDVAgcSSc1s6Ub478bzAvW5r6AW12//G3Cp1YU0JptsTfFD5rZvV4
         5PYBHz/GnRMM/P43DDl+CVYOoEFRp/4HGl+DQDeQyK2Lzsc1nGRMCxXNPqXvYBHvwmbE
         I36c1vcw06NVgiRMgUXSLjlTWo1kAvYlggGyShbLSMec1TUMw53Dq61Ua0usc6LTLxOh
         HOFQ==
X-Gm-Message-State: APjAAAVdhdWgLCzL+GNyQpf0CvV1LpTKcB77MmHFO6B/rqP+5t2q0H9d
        g9TjHRaNoUGeQtbT5x/E3fGQoA==
X-Google-Smtp-Source: APXvYqxVJ7tRUPThUH+2r8lt5p44t/U32Pk0aH2RDMvZhVaD7ENk1+3Z7JYaTQSZ0j3TDg0ysNSAQA==
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr39368172qta.261.1554953222242;
        Wed, 10 Apr 2019 20:27:02 -0700 (PDT)
Received: from ovpn-120-242.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a47sm26484490qtb.79.2019.04.10.20.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:27:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slab: fix an infinite loop in leaks_show()
Date:   Wed, 10 Apr 2019 23:26:35 -0400
Message-Id: <20190411032635.10325-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"cat /proc/slab_allocators" could hang forever on SMP machines with
kmemleak or object debugging enabled due to other CPUs running do_drain()
will keep making kmemleak_object or debug_objects_cache dirty and unable
to escape the first loop in leaks_show(),

do {
	set_store_user_clean(cachep);
	drain_cpu_caches(cachep);
	...

} while (!is_store_user_clean(cachep));

For example,

do_drain
  slabs_destroy
    slab_destroy
      kmem_cache_free
        __cache_free
          ___cache_free
            kmemleak_free_recursive
              delete_object_full
                __delete_object
                  put_object
                    free_object_rcu
                      kmem_cache_free
                        cache_free_debugcheck --> dirty kmemleak_object

One approach is to check cachep->name and skip both kmemleak_object and
debug_objects_cache in leaks_show(). The other is to set
store_user_clean after drain_cpu_caches() which leaves a small window
between drain_cpu_caches() and set_store_user_clean() where per-CPU
caches could be dirty again lead to slightly wrong information has been
stored but could also speed up things significantly which sounds like a
good compromise. For example,

 # cat /proc/slab_allocators
 0m42.778s # 1st approach
 0m0.737s  # 2nd approach

Fixes: d31676dfde25 ("mm/slab: alternative implementation for DEBUG_SLAB_LEAK")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 9142ee992493..3e1b7ff0360c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4328,8 +4328,12 @@ static int leaks_show(struct seq_file *m, void *p)
 	 * whole processing.
 	 */
 	do {
-		set_store_user_clean(cachep);
 		drain_cpu_caches(cachep);
+		/*
+		 * drain_cpu_caches() could always make kmemleak_object and
+		 * debug_objects_cache dirty, so reset afterwards.
+		 */
+		set_store_user_clean(cachep);
 
 		x[1] = 0;
 
-- 
2.17.2 (Apple Git-113)

