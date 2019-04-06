Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F9C282DE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A20F213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 22:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YzlnuhjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDFW7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 18:59:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42894 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfDFW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 18:59:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so11439754qtc.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dB4pAQEYeJLbgCkf7uLDDCPVAJv3hzEyEmEQnyQak1Y=;
        b=YzlnuhjHbnZtedtq9lxZSt102ihZxwGY6KhGVHTYQpl1ocdqALUzh1MEQwS/iLKqjd
         zMwRC8Mnk/JnfFW7AZnk4brmtvbqcZQf5W1S5leTjf3yAWM8Jrxg9XnRlOovcdepkF38
         CNfeDQI2jY9RndX4zcACJ5kpx+r3fMfc4r6f7ooGiP06k/AXelK57LY+U9VGyR6H3i5d
         CPTfuJXP8lUNaLxmmhwG+FYMT2M/G03NNp1dW4Ne6XI5caxttElS683d42XEHLGk9N4y
         ZUwkjKAVKdcyXCjA9hJO5DWGfETJ63J1cTIAIWBPF/QT9XFjpgRxn8X0XrQyc4mpxuLT
         NdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dB4pAQEYeJLbgCkf7uLDDCPVAJv3hzEyEmEQnyQak1Y=;
        b=hUPo07YgXEdmaQqqA6XxTFLMyDuSMiclgWhKt0UvXxI37H2yc18m9/tCngXJnTcT6S
         A08XbmMjBNDOkXM7Ayw4RVlEhJWZwZ8Frh7MVycQw497+TTuQPwKo8sJ/7S2wBMGpAmS
         c51UIbw0U/O5vZlBInLUkF7Y1WpndUXv/myOWKE2t6wzS7gs5Oc1XbxfUJu+AWEMuxK6
         48At/l5rKQn36Fj+IJojRJFQhuiuZ2LoENfhY45m5euIMs2EzqfCYOJEYXdK2ol/e1RI
         l+ObFXtk89dNW1Hs9mWwVhq6ANhLCLNtWpBy2himfvakG4YkisGwVyKNnM20dYJ42AqC
         Lt0w==
X-Gm-Message-State: APjAAAX0E2Ie2VcZAP9Jr1dl4t5enpvdmJfspIiYzSCrG3DlgttoJkU9
        0Mwh2TbkEKlFzuPYvfd+/aLFMbt4XQA=
X-Google-Smtp-Source: APXvYqz3wcIgBwJUcDYOSjnelbMxOwMXqTVTHmB+Mkh/cuW1JsK3pbfE+G7JmIbpLGXPu2kLclGA3g==
X-Received: by 2002:a0c:c950:: with SMTP id v16mr17520467qvj.204.1554591579347;
        Sat, 06 Apr 2019 15:59:39 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a47sm17785002qtb.79.2019.04.06.15.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 15:59:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, tj@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slab: fix a crash by reading /proc/slab_allocators
Date:   Sat,  6 Apr 2019 18:59:01 -0400
Message-Id: <20190406225901.35465-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 510ded33e075 ("slab: implement slab_root_caches list")
changes the name of the list node within "struct kmem_cache" from
"list" to "root_caches_node", but leaks_show() still use the "list"
which causes a crash when reading /proc/slab_allocators.

BUG: unable to handle kernel NULL pointer dereference at
00000000000000aa
PGD 0 P4D 0
Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 3 PID: 5925 Comm: ldd Not tainted 5.1.0-rc3-mm1+ #6
RIP: 0010:__lock_acquire.isra.14+0x4b4/0xa50
Call Trace:
 <IRQ>
 lock_acquire+0xa3/0x180
 _raw_spin_lock+0x2f/0x40
 do_drain+0x61/0xc0
 flush_smp_call_function_queue+0x3a/0x110
 generic_smp_call_function_single_interrupt+0x13/0x2b
 smp_call_function_interrupt+0x66/0x1a0
 call_function_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:__tlb_remove_page_size+0x8c/0xe0
 zap_pte_range+0x39f/0xc80
 unmap_page_range+0x38a/0x550
 unmap_single_vma+0x7d/0xe0
 unmap_vmas+0xae/0xd0
 exit_mmap+0xae/0x190
 mmput+0x7a/0x150
 do_exit+0x2d9/0xd40
 do_group_exit+0x41/0xd0
 __x64_sys_exit_group+0x18/0x20
 do_syscall_64+0x68/0x381
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 510ded33e075 ("slab: implement slab_root_caches list")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 46a6e084222b..9142ee992493 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4307,7 +4307,8 @@ static void show_symbol(struct seq_file *m, unsigned long address)
 
 static int leaks_show(struct seq_file *m, void *p)
 {
-	struct kmem_cache *cachep = list_entry(p, struct kmem_cache, list);
+	struct kmem_cache *cachep = list_entry(p, struct kmem_cache,
+					       root_caches_node);
 	struct page *page;
 	struct kmem_cache_node *n;
 	const char *name;
-- 
2.17.2 (Apple Git-113)

