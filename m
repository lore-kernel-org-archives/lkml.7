Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E444C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F22240A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ETA60fcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKTF12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:27:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43512 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTF11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:27:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so13612387pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 21:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keeeAI8Pfb2Kl/duSqjRgQqa9JjQMfYjDPW+Gc6NiSs=;
        b=ETA60fcELFjS0/dp+tEDXlPTgLHu0VCA+6gi/m26QCLsKVI9NeLreJsiENSgm490K7
         HenX32cYW4BqKOvK5kA+ikHaaXx+39I9CBeGin2VPl+EbXwqeCpNDEIpIW/ofL5uqOGu
         cQw8f7NbiEFUkz8iADA8AFhwiHS0850luWSxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keeeAI8Pfb2Kl/duSqjRgQqa9JjQMfYjDPW+Gc6NiSs=;
        b=UxHXrjjAv9L23EVjTgkFL07r5AQ/gDAQSEbM6DWhbnfZ36RqTXvUHa+dVCQ+9bIbcw
         7SKH5ELbUv74c7zsZOnMCa8Pqk29mW3MbvO5CmM3U74Du0EO6pMYLYHcduHKQieob6CK
         xLDe95CFHDOE6WPiATpgyJrmsqU0W4ytHMBJNgM0PS64n5YGjZy5Al2dxJbYUgwElOPH
         A46VcLeIaH8rJ5oalYSWxY4nOSyTgAOG6h8p0F8g1vIOB2I5ye2xlP6dgrskT+7q1EZE
         oLv05z54Qj9rgJq4yGa+ARkQZlOYFtgRilyQBn80TMp0zC0nQm0NlV5eZ3hXto7S8oh/
         8whw==
X-Gm-Message-State: APjAAAXNisT0eawZLlqixsk/aW0nokGtdPZcIpr19vbE5bVBT5zpqVr3
        Ew8X9kz2uJEPB36Yl8fPIQOn5Q==
X-Google-Smtp-Source: APXvYqwcRLpDJrGouMn4i7sCtVLz0VNrB2qc7pZkb01u8+Jad37R3CCkjURA8OcbGckvxot+GTdxzA==
X-Received: by 2002:a65:67c7:: with SMTP id b7mr1058249pgs.339.1574227644988;
        Tue, 19 Nov 2019 21:27:24 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-9c57-4778-d90c-fd6d.static.ipv6.internode.on.net. [2001:44b8:1113:6700:9c57:4778:d90c:fd6d])
        by smtp.gmail.com with ESMTPSA id w15sm22333601pfi.168.2019.11.19.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 21:27:24 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        akpm@linux-foundation.org, urezki@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com, cai@lca.pw,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH] update to "kasan: support backing vmalloc space with real shadow memory"
Date:   Wed, 20 Nov 2019 16:27:19 +1100
Message-Id: <20191120052719.7201-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031093909.9228-2-dja@axtens.net>
References: <20191031093909.9228-2-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This is a quick fixup to patch 1 of the "kasan: support backing
vmalloc space with real shadow memory" series, v11, which you pulled
in to your mmotm tree.

There are 2 changes:

 - A fixup to the per-cpu allocator path to avoid allocating memory
   under a spinlock, thanks Qian Cai.

 - Insert flush_cache_vmap() between mapping shadow and poisoning
   it. This is a no-op on x86 and arm64, but on powerpc it does a
   ptesync instruction which prevents occasional page faults.

Here are updated benchmark figures for the commit message:

Testing with test_vmalloc.sh on an x86 VM with 2 vCPUs shows that:

 - Turning on KASAN, inline instrumentation, without vmalloc, introuduces
   a 5.7x-6.4x slowdown in vmalloc operations.

 - Turning this on introduces the following slowdowns over KASAN:
     * ~1.82x slower single-threaded (test_vmalloc.sh performance)
     * ~2.11x slower when both cpus are performing operations
       simultaneously (test_vmalloc.sh sequential_test_order=1)

This is unfortunate, but given that this is a debug feature only, not
the end of the world.

The full results are:

Performance

                              No KASAN      KASAN original x baseline  KASAN vmalloc x baseline    x KASAN

fix_size_alloc_test             662004            11404956      17.23       19144610      28.92       1.68
full_fit_alloc_test             710950            12029752      16.92       13184651      18.55       1.10
long_busy_list_alloc_test      9431875            43990172       4.66       82970178       8.80       1.89
random_size_alloc_test         5033626            23061762       4.58       47158834       9.37       2.04
fix_align_alloc_test           1252514            15276910      12.20       31266116      24.96       2.05
random_size_align_alloc_te     1648501            14578321       8.84       25560052      15.51       1.75
align_shift_alloc_test             147                 830       5.65           5692      38.72       6.86
pcpu_alloc_test                  80732              125520       1.55         140864       1.74       1.12
Total Cycles              119240774314        763211341128       6.40  1390338696894      11.66       1.82

Sequential, 2 cpus

                              No KASAN      KASAN original x baseline  KASAN vmalloc x baseline    x KASAN

fix_size_alloc_test            1423150            14276550      10.03       27733022      19.49       1.94
full_fit_alloc_test            1754219            14722640       8.39       15030786       8.57       1.02
long_busy_list_alloc_test     11451858            52154973       4.55      107016027       9.34       2.05
random_size_alloc_test         5989020            26735276       4.46       68885923      11.50       2.58
fix_align_alloc_test           2050976            20166900       9.83       50491675      24.62       2.50
random_size_align_alloc_te     2858229            17971700       6.29       38730225      13.55       2.16
align_shift_alloc_test             405                6428      15.87          26253      64.82       4.08
pcpu_alloc_test                 127183              151464       1.19         216263       1.70       1.43
Total Cycles               54181269392        308723699764       5.70   650772566394      12.01       2.11
fix_size_alloc_test            1420404            14289308      10.06       27790035      19.56       1.94
full_fit_alloc_test            1736145            14806234       8.53       15274301       8.80       1.03
long_busy_list_alloc_test     11404638            52270785       4.58      107550254       9.43       2.06
random_size_alloc_test         6017006            26650625       4.43       68696127      11.42       2.58
fix_align_alloc_test           2045504            20280985       9.91       50414862      24.65       2.49
random_size_align_alloc_te     2845338            17931018       6.30       38510276      13.53       2.15
align_shift_alloc_test             472                3760       7.97           9656      20.46       2.57
pcpu_alloc_test                 118643              132732       1.12         146504       1.23       1.10
Total Cycles               54040011688        309102805492       5.72   651325675652      12.05       2.11

Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 mm/kasan/common.c | 2 ++
 mm/vmalloc.c      | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6e7bc5d3fa83..df3371d5c572 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -794,6 +794,8 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
 	if (ret)
 		return ret;
 
+	flush_cache_vmap(shadow_start, shadow_end);
+
 	kasan_unpoison_shadow(area->addr, requested_size);
 
 	area->flags |= VM_KASAN;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a4b950a02d0b..bf030516258c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
+	}
+	spin_unlock(&vmap_area_lock);
 
+	/* populate the shadow space outside of the lock */
+	for (area = 0; area < nr_vms; area++) {
 		/* assume success here */
 		kasan_populate_vmalloc(sizes[area], vms[area]);
 	}
-	spin_unlock(&vmap_area_lock);
 
 	kfree(vas);
 	return vms;
-- 
2.20.1

