Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B42C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8EB2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fIKUsLLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFTT2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:28:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37677 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:28:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so4406067qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ujGIfxzGY9TqzTdiMJZwFKl+HRckfQJ/fxLK/7Xde4k=;
        b=fIKUsLLL1MF2v80JU2je+8J7L2Nt4JjusUm14K96ynmC9h8yQcDP+CWa+pNInBcPDY
         mpSjs0inZeZZPvHMH2gacj+1NcWVml5C5CQn+RYQOnsiyzutGoQvLsdg+h/o1Mxle/gC
         +zxz9RT1EMbg9fs03F3LH67K/qDWNmM2AVV9kyZ2rnm209V1aohx1Mp0J7jfnB6XYi/N
         /yfeND/KniGKCv3UdbYsq8UpH6xX8JatBcKCWsBd5WA+bSJZrhWPpGvc68pkOTki3P9W
         vMet0fULUI2fbLlMHiEbMxv2zCB9PeRZGW6Ay7mvsGIbewgkcsKkc8NsCmB1bdz8HZMC
         d7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ujGIfxzGY9TqzTdiMJZwFKl+HRckfQJ/fxLK/7Xde4k=;
        b=ZhS79E3fknCPO6PMmn7FXHLIMOTG85zedvn80pkYCavFOQraAgW0uS8PPX3Dyx4etn
         WWTyZ89xHBR8miBYvYUDl/7wMcyrMN0HFAhfBSGddiqHEarYe07BjNFs1o3mopvYnImx
         Co0jgqvFLQyF0BAyAaoWqrO+5A3JPcnF8BtaT5rmsptIZXPZNTbS6JTr0cli8qLbprlU
         +xt9yK70TUaZJ1glAOvO6F06yN/7ute7qt7Cw9pVqVaUlkXngM1qQ1Lo4X4HKG6d8jSY
         yZm5N//l0JvfU/ucZgKztRXTFvv6fUq8jPz9PZsJe7eotugLHsIsEPXP93sWO0yiNoRL
         mUqw==
X-Gm-Message-State: APjAAAVdsxk+17NvEw1kT+xCaqyhN5xjfRZpZ8TIv+KItNA0w8IG/m6P
        sAhTOZxBatk4mK4KDufXe5phaQ==
X-Google-Smtp-Source: APXvYqyGY5XC1WwDU2nKXLWGekQDUBaB26hL6bvlH72MC23nrdvked0HjHIA0MltVRW9gfSUq0Mn5g==
X-Received: by 2002:ac8:17ac:: with SMTP id o41mr41040317qtj.184.1561058902552;
        Thu, 20 Jun 2019 12:28:22 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n184sm214597qkc.114.2019.06.20.12.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 12:28:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     glider@google.com, keescook@chromium.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] slub: play init_on_free=1 well with SLAB_RED_ZONE
Date:   Thu, 20 Jun 2019 15:28:01 -0400
Message-Id: <1561058881-9814-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "mm: security: introduce init_on_alloc=1 and
init_on_free=1 boot options" [1] does not play well with SLAB_RED_ZONE
as it will overwrite the right-side redzone with all zeros and triggers
endless errors below. Fix it by only wiping out the slab object size and
leave the redzone along. This has a side-effect that it does not wipe
out the slab object metadata like the free pointer and the tracking data
for SLAB_STORE_USER which does seem important anyway, so just to keep
the code simple.

[1] https://patchwork.kernel.org/patch/10999465/

BUG kmalloc-64 (Tainted: G    B            ): Redzone overwritten

INFO: 0x(____ptrval____)-0x(____ptrval____). First byte 0x0 instead of
0xcc
INFO: Slab 0x(____ptrval____) objects=163 used=4 fp=0x(____ptrval____)
flags=0x3fffc000000201
INFO: Object 0x(____ptrval____) @offset=58008 fp=0x(____ptrval____)

Redzone (____ptrval____): cc cc cc cc cc cc cc cc
........
Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
Redzone (____ptrval____): 00 00 00 00 00 00 00 00
........
Padding (____ptrval____): 00 00 00 00 00 00 00 00
........
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
5.2.0-rc5-next-20190620+ #2
Call Trace:
[c00000002b72f4b0] [c00000000089ce5c] dump_stack+0xb0/0xf4 (unreliable)
[c00000002b72f4f0] [c0000000003e13d8] print_trailer+0x23c/0x264
[c00000002b72f580] [c0000000003d0468] check_bytes_and_report+0x138/0x160
[c00000002b72f620] [c0000000003d33dc] check_object+0x2ac/0x3e0
[c00000002b72f690] [c0000000003da15c] free_debug_processing+0x1ec/0x680
[c00000002b72f780] [c0000000003da944] __slab_free+0x354/0x6d0
[c00000002b72f840] [c00000000015600c]
__kthread_create_on_node+0x15c/0x260
[c00000002b72f910] [c000000000156144] kthread_create_on_node+0x34/0x50
[c00000002b72f930] [c000000000146fd0] create_worker+0xf0/0x230
[c00000002b72f9e0] [c00000000014fc6c] workqueue_prepare_cpu+0xdc/0x280
[c00000002b72fa60] [c00000000011b27c] cpuhp_invoke_callback+0x1bc/0x1220
[c00000002b72fb00] [c00000000011e7d8] _cpu_up+0x168/0x340
[c00000002b72fb80] [c00000000011eafc] do_cpu_up+0x14c/0x210
[c00000002b72fc10] [c000000000aedc90] smp_init+0x17c/0x1f0
[c00000002b72fcb0] [c000000000ac4a4c] kernel_init_freeable+0x358/0x7cc
[c00000002b72fdb0] [c0000000000106ec] kernel_init+0x2c/0x150
[c00000002b72fe20] [c00000000000b4cc] ret_from_kernel_thread+0x5c/0x70
FIX kmalloc-64: Restoring 0x(____ptrval____)-0x(____ptrval____)=0xcc

FIX kmalloc-64: Object at 0x(____ptrval____) not freed

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index a384228ff6d3..787971d4fa36 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1437,7 +1437,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		do {
 			object = next;
 			next = get_freepointer(s, object);
-			memset(object, 0, s->size);
+			memset(object, 0, s->object_size);
 			set_freepointer(s, object, next);
 		} while (object != old_tail);
 
-- 
1.8.3.1

