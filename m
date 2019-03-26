Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAEA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UnRUcSI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfCZPnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:43:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41983 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbfCZPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:43:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so15090913qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xPwO+VfBDlBl+yGZj+3rGMuEeXiQlCjRxp+hpH3Hq0A=;
        b=UnRUcSI4TZIx2r78mB5JigJyEu6np6Ud0wXDTFslg5/OmfzMRXniVE4SYCONHcDC8y
         tMMLUKfmTGK3huEJJ36MrE7QswyLaZU+qXbNMvpmrjMu8S0Nupb/xdxL0+NRuMJL9CAG
         vFgxFzh/865BZvaIKY2fmmfEIQY/oLpQMueoAcMThpgZJiCAZtgZs8Vh7yF5dwOqvABO
         0g57MnHGvalTW98+FNHl9MpnGuv1g2kkB9VOAW5f59Pitfdnep4R+ZtywZNVtdgDtC/n
         XILDCURc37mtovGtcED9cavYh91iZ1DcRowoKJ6YAUpwMUNi/zRI6Od0qBIKw2QZjxlX
         5dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xPwO+VfBDlBl+yGZj+3rGMuEeXiQlCjRxp+hpH3Hq0A=;
        b=MGJntlj7iae+hhneeiD1ONQFAgBEh2lgXntlSoYmwOJpTdJLqhKi1MLUGihyS7RXzd
         508iAHuYg4Ukgt0BLsDeK3T2MmPZ4WMBhW2BOco9I/kEpcyUEDh7BgGqJQhz5KqGBjxZ
         1N9zYXQHt2KoUdRbny4vLSOUYTozbqkVdpabPLFVXwM+Ia3HD6rdRxNUcYnOfzogwR9n
         Gq+b7P72nOQNrLkiVUFlcCIKwXq7Ba64z4bqbHuYCVfjFNOncY6RajLIUfdcdJW1C+pR
         r10gQJst+MmaSYDf0wkA2VeNaeodosHi1ntlhKLq3D6h9PDsd63g1oj9n5ZOs8V/5DDE
         W4vw==
X-Gm-Message-State: APjAAAX7UDcXJ0lQriC5XzzVPFqotBnuWtM3DSzPC5C9DBDQoEjeC0xc
        2P8Qim8KM6E7eYJF25CqoFr19g==
X-Google-Smtp-Source: APXvYqy045SWSJFO/BHLfG05yG54W7e+a05pC6xI7btFS93LrCM/yf9exjaxjN8VsQFaqDmh6vYDfQ==
X-Received: by 2002:ac8:2ed4:: with SMTP id i20mr25830138qta.52.1553615032240;
        Tue, 26 Mar 2019 08:43:52 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j93sm7528547qtd.82.2019.03.26.08.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:43:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, mhocko@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] kmemleaak: survive in a low-memory situation
Date:   Tue, 26 Mar 2019 11:43:38 -0400
Message-Id: <20190326154338.20594-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could quickly fail to allocate an object structure and then
disable itself in a low-memory situation. For example, running a mmap()
workload triggering swapping and OOM. This is especially problematic for
running things like LTP testsuite where one OOM test case would disable
the whole kmemleak and render the rest of test cases without kmemleak
watching for leaking.

Kmemleak allocation could fail even though the tracked memory is
succeeded. Hence, it could still try to start a direct reclaim if it is
not executed in an atomic context (spinlock, irq-handler etc), or a
high-priority allocation in an atomic context as a last-ditch effort.
Since kmemleak is a debug feature, it is unlikely to be used in
production that memory resources is scarce where direct reclaim or
high-priority atomic allocations should not be granted lightly.

Unless there is a brave soul to reimplement the kmemleak to embed it's
metadata into the tracked memory itself in a foreseeable future, this
provides a good balance between enabling kmemleak in a low-memory
situation and not introducing too much hackiness into the existing
code for now.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Update the commit log.
    Simplify the code inspired by graph_trace_open() from ftrace.
v2: Remove the needless checking for NULL objects in slab_post_alloc_hook()
    per Catalin.

 mm/kmemleak.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d894d3de07..239927166894 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -581,6 +581,17 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	unsigned long untagged_ptr;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+	if (!object) {
+		/*
+		 * The tracked memory was allocated successful, if the kmemleak
+		 * object failed to allocate for some reasons, it ends up with
+		 * the whole kmemleak disabled, so let it success at all cost.
+		 */
+		gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC :
+		       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
+		object = kmem_cache_alloc(object_cache, gfp);
+	}
+
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-- 
2.17.2 (Apple Git-113)

