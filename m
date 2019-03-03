Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A20C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDCD20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CyqAH2Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCCECc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 23:02:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43551 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCCECc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 23:02:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so1829163qtc.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 20:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RCNw2KIMwYZ8z/Bir+hzxFGurdhMotOPmxl68xnvlb4=;
        b=CyqAH2MwVpMMcWBfDARTWgXdG+e99MAgcovsM0oNbC1EMJJKTAkFdKGc62L8m3SlBb
         +ZqyP95aKFCi6L1DU1Lg9SyL6NSmhtTWEmZBmQP1czS4WKxogdpKfFtowsMa7mMtZI/D
         28Wmtf8fxW/Py1Sjv1dctA58n7/RNvZYqbZm1+mvex9eEhI6iXbepWygQtbRjnFHz9PE
         frVS+TvH27+f7qpDPf/oJii9rcMJo13vkOaHmXHOCzkMVzyWbYwg+enoXir3sW1E5MOg
         EKHW9jNADXOn0d9I+sGmFyyYkzCNr2Spw2rLFbGXlad2nV/zIy3coCVLWp1ceQ3dWGfn
         tzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RCNw2KIMwYZ8z/Bir+hzxFGurdhMotOPmxl68xnvlb4=;
        b=EOEL9nMe3gCrlcfRSiO2L8OBZYrAYKQ6nEqeI/keHfiscY3SPP7dWTAcJLR7fO8jz8
         GPJFiDo0JW8RfwS9sGr4UIpAxAvKaDAXS53p47AwUm00i7WOIOwELfbvWWeQszro4wAh
         rNkSuHBDaheonDLft6o3VOjZs4Tf640+ryU+64184TS2FYVgoV4nj340/NW0clVnicOK
         2ENty3Ysk3HORx7nmyicTl4Z390bkHLmGhKqsljRnOK+FvbzTlOrq0QBoDCXNLcgIeZ/
         q/6P68CTW4m3HzRWlxg1xM4llBdE5oTqACD1b2ixNJD2p/O+GcZpr3mo/rPie18oR8bY
         6GGA==
X-Gm-Message-State: APjAAAVZtew5pFCTIYoGXH7omCdAANkXVs5+ACTWN85AcDdl7Lm4NqhV
        3qwZpzLiYZIJuq3OB5XsbQZ5OQ==
X-Google-Smtp-Source: APXvYqyfwXB0hvGr9HbzBEHHe5HGauMBeaQnfFfQcHo2pydfUWyK7uzruJOIXVYM2Cp/f8YzfIGWww==
X-Received: by 2002:aed:22d6:: with SMTP id q22mr7181322qtc.171.1551585751100;
        Sat, 02 Mar 2019 20:02:31 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k27sm1394183qki.19.2019.03.02.20.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 20:02:30 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     bvanassche@acm.org, longman@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] lockdep: skip debugobjects for lock_classes[] init
Date:   Sat,  2 Mar 2019 23:02:24 -0500
Message-Id: <20190303040224.7666-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes
that are no longer in use") let init_data_structures_once() call
init_rcu_head(). As the result, smp_setup_processor_id() calls
debug_object_init() before debug_objects_early_init() triggering errors
below on arm64 and ppc64le. Since debug_objects_early_init() depends on
smp_setup_processor_id(), so it is not straightforward to move the
former earlier in start_kernel(). Hence, just skip all debugobjects
creations in init_data_structures_once() as a good trade-off by losing
track of some RCU list heads debugging.

BUG: spinlock bad magic on CPU#0, swapper/0
 lock: obj_hash+0xc3048/0x100000, .magic: 00000000, .owner: <none>/-1,
.owner_cpu: 0
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc8-next-20190301+ #1
Call trace:
 dump_backtrace+0x0/0x450
 show_stack+0x20/0x2c
 dump_stack+0xe0/0x16c
 spin_bug+0x200/0x224
 do_raw_spin_lock+0x1bc/0x23c
 _raw_spin_lock_irqsave+0xac/0xd0
 __debug_object_init+0xf0/0x19dc
 debug_object_init+0x54/0x6c
 init_rcu_head+0x24/0x30
 init_data_structures_once+0xb0/0x41c
 register_lock_class+0x70c/0x1454
 __lock_acquire+0xc4/0x235c
 lock_acquire+0x508/0x668
 _raw_spin_lock+0x88/0xac
 vprintk_emit+0x33c/0x53c
 vprintk_default+0x54/0x7c
 vprintk_func+0x320/0x40c
 printk+0x64/0x8c
 smp_setup_processor_id+0x6c/0x84
 start_kernel+0x38/0x8f8
ODEBUG: Out of memory. ODEBUG disabled

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21cb81fe6359..1309a6fe88ee 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -988,7 +988,6 @@ static void init_data_structures_once(void)
 
 	initialization_happened = true;
 
-	init_rcu_head(&delayed_free.rcu_head);
 	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
 	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);
 
-- 
2.17.2 (Apple Git-113)

