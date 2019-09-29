Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B84C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25A20863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKYoLTLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfI2J5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 05:57:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36637 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2J5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 05:57:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id t14so5690284pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=py9UZ6fHg26Z3EKwoZH74DkrGT/PuZp1Qa/KUENaafQ=;
        b=gKYoLTLCBvpwqIN36Y/QcUBogTLdlIIdlCV04i5hdayySYHhbXgLssrxJWjqk5FsKp
         Sv3LidFbbVOyCtgQa+XV2awDBKajZHCzjb7fQ7qLJT8o0XSGkQbqawQvYlQpvK4xcC6H
         sdsEz0MMivBUt+qafQKDFOgpXwIrfV/UT5V6/0j0uSjzZ+QQLppaa2LH9ic6vaocUZs6
         3ZHOGiQ/0utgcjilA7yfRSg0Jw6r4sZ4v7Qe59ScZRumMgZjoqnI9vq6uNjj6oCDzvll
         hX9YEdGdt4IyYbxQ5axqkEdH3rdW1eEBKvhZXF6+eovvKg5PfIpYn4fscn1hGgcgWP3w
         XahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=py9UZ6fHg26Z3EKwoZH74DkrGT/PuZp1Qa/KUENaafQ=;
        b=s7WZTqK4szbfEcXq5do7lP9avsrYR3Yl2JhtX2Zf7aLaw+PWxSIIkqfZxAPII0SqSk
         ZDR1dNYo5eB5N2s4aSOG2/wg4VuYAeHLsGg5KC+UNju2wqApxzRXEspKIOrzCDkxHDFO
         xK8+Nf2IZ7iynZVGhh1CHbSKL/hc6Gc501pBx7X2ySZz8R8wQvzX2AjLI+CZUdnVQ/zV
         JBa+Wqn1swCa7EHaFxxMs7ilaNd+eWoxslgcbHFBJ1A3lGUwDvD9G9HeYNy00wKhfJGK
         sEqUnm7szBKtzXj/Ld7e5fjwGOaCspv/OSblQvxmDP63LUt0Pe0jaDmtXKyAxnG5q3C6
         wWfQ==
X-Gm-Message-State: APjAAAVyfqGga+fE7nolpd3/jAizGDw6wKGvCOIC7wUgBJ20G13PyBj9
        /g+Nnvt0er8tz3FTp7Z8SfgeyPTH
X-Google-Smtp-Source: APXvYqybNAHVuCOrH/OoOth6FCmBAke9sCo3bHJ9rYnVNTigH4T8gj9GpBeERkbphzcv2J2L4BRzAQ==
X-Received: by 2002:a65:68c4:: with SMTP id k4mr18537680pgt.180.1569751028569;
        Sun, 29 Sep 2019 02:57:08 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m2sm8795407pff.154.2019.09.29.02.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 02:57:07 -0700 (PDT)
Date:   Sun, 29 Sep 2019 17:56:59 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kmemleak: skip late_init if not skip disable
Message-ID: <20190929095659.jzy3gtcj6vgd35j6@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now if DEFAULT_OFF set to y, kmemleak_init will start the cleanup_work
workqueue. Then late_init call will set kmemleak_initialized to 1, the
cleaup workqueue will try to do cleanup, triggering:

[24.738773] ==================================================================
[24.742784] BUG: KASAN: global-out-of-bounds in __kmemleak_do_cleanup+0x166/0x180
[24.744144] Key type ._fscrypt registered
[24.745680] Read of size 8 at addr ffffffff88746c90 by task kworker/3:1/171
[24.745687]
[24.745697] CPU: 3 PID: 171 Comm: kworker/3:1 Not tainted 5.3.0-v5.3-12475-gcbafe18 #1
[24.745701] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[24.745710] Workqueue: events kmemleak_do_cleanup
[24.745717] Call Trace:
[24.745736]  dump_stack+0x7c/0xc0
[24.745755]  print_address_description.constprop.4+0x1f/0x300
[24.751562] Key type .fscrypt registered
[24.754370]  __kasan_report.cold.8+0x76/0xb2
[24.754388]  ? __kmemleak_do_cleanup+0x166/0x180
[24.754407]  kasan_report+0xe/0x20
[24.778543]  __kmemleak_do_cleanup+0x166/0x180
[24.780795]  process_one_work+0x919/0x17d0
[24.782929]  ? pwq_dec_nr_in_flight+0x320/0x320
[24.785092]  worker_thread+0x87/0xb40
[24.786948]  ? __kthread_parkme+0xc3/0x190
[24.789217]  ? process_one_work+0x17d0/0x17d0
[24.791414]  kthread+0x333/0x3f0
[24.793031]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[24.795473]  ret_from_fork+0x3a/0x50
[24.797303]
[24.798091] The buggy address belongs to the variable:
[24.800634]  mem_pool_free_count+0x10/0x40
[24.802656]
[24.803434] Memory state around the buggy address:
[24.805793]  ffffffff88746b80: 04 fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
[24.809177]  ffffffff88746c00: 00 fa fa fa fa fa fa fa 00 00 fa fa fa fa fa fa
[24.812407] >ffffffff88746c80: 04 fa fa fa fa fa fa fa 00 00 fa fa fa fa fa fa
[24.815638]                          ^
[24.817372]  ffffffff88746d00: 00 00 fa fa fa fa fa fa 00 00 00 00 00 00 00 00
[24.820740]  ffffffff88746d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[24.824021] ==================================================================

Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 mm/kmemleak.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 03a8d84badad..b9baf617fe35 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1946,6 +1946,11 @@ void __init kmemleak_init(void)
  */
 static int __init kmemleak_late_init(void)
 {
+	if (!kmemleak_skip_disable) {
+		kmemleak_disable();
+		return 0;
+	}
+
 	kmemleak_initialized = 1;
 
 	debugfs_create_file("kmemleak", 0644, NULL, NULL, &kmemleak_fops);
-- 
2.21.0

