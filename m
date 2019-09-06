Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99255C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AF92082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567774583;
	bh=ci0VLJsqFc20h3RtHoImONItgBZDbL9G5DhfnR1hlZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZG6T8PipQlZW6dUlcFqbSY6bd9ABUmK/GzDgdNxYOP23KafsOPtmRQUSKxHgGEek
	 zgFG9vATCtVbt3rBXhrX8oOIIsEmKo0qVYn0JN85uBbdNkZhSTAcFXITByaaVpW0zk
	 4vmqydN1Gk4O1VAylhnGZ039yt7Nq5H5bIAUnkmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404882AbfIFM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:56:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43387 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404675AbfIFM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:56:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so1746615wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAjHIagsRRHyupjWSf9UQV+X2LhOhwuLxez5EfbJ9Gc=;
        b=E/2Y3U26zTm6MloPMorTfa0eFgCBIVhc1Q+y1ZoP4/kw3EouII+lY7UWI0O8tnnSDw
         YW4m/AJeTzPjGLefSMjl/V/rNc7T7FNrYpH0Zlrzlj7PEB1Qu0sv+WYHaT+l3M4VorAI
         fXx92W0wcfBSBd9d3Ki6LU+/shD54LnYQh0RJ+L39l/diwkOh6kwBSlbvJ3S86l/guDs
         SK9haSLkQrUe9wX5TVpa29W46h4HjjaytMz3iADbfIWRKBYCpAk8TdYW4pr24NrwAtxS
         OI9qRYAG6jC7aOkiDzi0/CFrjLRslPZSel/NflnZTjf393pccUAcUfRuDPCXEkwpCzSj
         KfKw==
X-Gm-Message-State: APjAAAU0nzfQ/3wRdt/C3hvD96XXPbRk54ChdQr54cNdpsxaOaGdKrXz
        3SbDFD6wTtClWOb6GWuMRf4=
X-Google-Smtp-Source: APXvYqxHDddb05bzvKYM6vP+xcTed1Tqk3XGL/aFRgnuzD0a7I0HjnpbWbAjRx3SGmT/JLtA8Uzm/Q==
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr7245641wrn.121.1567774580242;
        Fri, 06 Sep 2019 05:56:20 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-143-50.eurotel.cz. [37.188.143.50])
        by smtp.gmail.com with ESMTPSA id v11sm9324303wrv.54.2019.09.06.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:56:19 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
Date:   Fri,  6 Sep 2019 14:56:08 +0200
Message-Id: <20190906125608.32129-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Thomas has noticed the following NULL ptr dereference when using cgroup
v1 kmem limit:
BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
PGD 0
P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 16923 Comm: gtk-update-icon Not tainted 4.19.51 #42
Hardware name: Gigabyte Technology Co., Ltd. Z97X-Gaming G1/Z97X-Gaming G1, BIOS F9 07/31/2015
RIP: 0010:create_empty_buffers+0x24/0x100
Code: cd 0f 1f 44 00 00 0f 1f 44 00 00 41 54 49 89 d4 ba 01 00 00 00 55 53 48 89 fb e8 97 fe ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
RSP: 0018:ffff927ac1b37bf8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: fffff2d4429fd740 RCX: 0000000100097149
RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9075a99fbe00
RBP: 0000000000000000 R08: fffff2d440949cc8 R09: 00000000000960c0
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
R13: ffff907601f18360 R14: 0000000000002000 R15: 0000000000001000
FS:  00007fb55b288bc0(0000) GS:ffff90761f8c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000007aebc002 CR4: 00000000001606e0
Call Trace:
 create_page_buffers+0x4d/0x60
 __block_write_begin_int+0x8e/0x5a0
 ? ext4_inode_attach_jinode.part.82+0xb0/0xb0
 ? jbd2__journal_start+0xd7/0x1f0
 ext4_da_write_begin+0x112/0x3d0
 generic_perform_write+0xf1/0x1b0
 ? file_update_time+0x70/0x140
 __generic_file_write_iter+0x141/0x1a0
 ext4_file_write_iter+0xef/0x3b0
 __vfs_write+0x17e/0x1e0
 vfs_write+0xa5/0x1a0
 ksys_write+0x57/0xd0
 do_syscall_64+0x55/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

 Tetsuo then noticed that this is because the __memcg_kmem_charge_memcg
 fails __GFP_NOFAIL charge when the kmem limit is reached. This is a
 wrong behavior because nofail allocations are not allowed to fail.
 Normal charge path simply forces the charge even if that means to cross
 the limit. Kmem accounting should be doing the same.

Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ec5e12486a7..e18108b2b786 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2821,6 +2821,16 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
+
+		/*
+		 * Enforce __GFP_NOFAIL allocation because callers are not
+		 * prepared to see failures and likely do not have any failure
+		 * handling code.
+		 */
+		if (gfp & __GFP_NOFAIL) {
+			page_counter_charge(&memcg->kmem, nr_pages);
+			return 0;
+		}
 		cancel_charge(memcg, nr_pages);
 		return -ENOMEM;
 	}
-- 
2.20.1

