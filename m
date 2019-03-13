Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D800C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB3C214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3UpBKuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCMNiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:38:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39608 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfCMNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:38:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id i20so1405952pfo.6;
        Wed, 13 Mar 2019 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oTIYVxgRadP7tA9ienDvPyYP3wV7wH2D7UNk9dL+6l4=;
        b=T3UpBKuM32YqMVnI4PXfAbufaD0KCMDYhLzJYip3+jx3Ln0gavvUsNHtJAMC9epZ1J
         1cpAe91xgwnzFkGda7IrkEwzYaM7iR8IivYVSEAobDlAkceaub4x7gke4azDb0IO//IX
         YDAO/f5jn0GZB1KQKkErZQTSMWJrxMOcmr4oaLrts/sr7l53X1aOGcAWJGuOh/4RMBf8
         pRa5guGfZKpV3uzLSU3HS6PQT4iQ2OrwpvGEauLAvCQsGSN+PHdJZjTb5jre0ltVTEBo
         dK8buobT6JMF1qx675akCiNsSz/0x68DoxQhavqSWwcANGfBPhQwGfUJWlbjU2hu4a40
         Nu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oTIYVxgRadP7tA9ienDvPyYP3wV7wH2D7UNk9dL+6l4=;
        b=cqdgrcEIlQMsLqV6+Lp0bTGENIMC3Nk4DT3e4tRJq1heDXkh4cakcxlECaJnkPhd1r
         h/6hBf4WvRhSfZ1aoFpovLstRIo4/2nRJ10NQQrl5SE1WBEf5SrpxW8EjGaNqyR/cP+X
         r4bX7vP5qfBLszVNEsyTvtiCHxwYi6WjO3EjvwkSr/5Jps1MhQapFrHBVgMiealjvg3K
         APsHDbk4ReCQUI5l8MAlfHfp+I7vIBqnkQbLpDcgDrwz3RNyAmzL3gCiaQq2AXuaDeqX
         ZGdxRdSej/NP4PMavzWN65sl93QQDm5mMMlPJf2R/6YfKihki/h5bdebfiMdBDF78KOF
         nKeQ==
X-Gm-Message-State: APjAAAWfVrdve/e8XpILARDQW1v91HpNN59Vf5JCFdtpH+V3RWAYYD8t
        hDfC1ziZCOgSWdX3dsmkyog=
X-Google-Smtp-Source: APXvYqxgB7kX6OQwJCjXczNQPHAOD9LxeLWq5p7asudigEV1knXf/B7jdkFTrOdZRA6IMzCQGtPP1w==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr45672522plp.316.1552484299557;
        Wed, 13 Mar 2019 06:38:19 -0700 (PDT)
Received: from upstream_server.localdomain ([123.116.203.188])
        by smtp.googlemail.com with ESMTPSA id i13sm20122103pfo.106.2019.03.13.06.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 06:38:18 -0700 (PDT)
From:   Liang Chen <liangchen.linux@gmail.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        Liang Chen <liangchen.linux@gmail.com>
Subject: [PATCH v1] bcache: fix a race between cache register and cacheset unregister
Date:   Wed, 13 Mar 2019 09:37:24 -0400
Message-Id: <1552484244-3510-1-git-send-email-liangchen.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between cache device register and cache set unregister.
For an already registered cache device, register_bcache will call
bch_is_open to iterate through all cachesets and check every cache
there. The race occurs if cache_set_free executes at the same time and
clears the caches right before ca is dereferenced in bch_is_open_cache.
To close the race, let's make sure the clean up work is protected by
the bch_register_lock as well.

This issue can be reproduced as follows,
while true; do echo /dev/XXX> /sys/fs/bcache/register ; done&
while true; do echo 1> /sys/block/XXX/bcache/set/unregister ; done &

and results in the following oops,

[  +0.000053] BUG: unable to handle kernel NULL pointer dereference at 0000000000000998
[  +0.000457] #PF error: [normal kernel read fault]
[  +0.000464] PGD 800000003ca9d067 P4D 800000003ca9d067 PUD 3ca9c067 PMD 0
[  +0.000388] Oops: 0000 [#1] SMP PTI
[  +0.000269] CPU: 1 PID: 3266 Comm: bash Not tainted 5.0.0+ #6
[  +0.000346] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.fc28 04/01/2014
[  +0.000472] RIP: 0010:register_bcache+0x1829/0x1990 [bcache]
[  +0.000344] Code: b0 48 83 e8 50 48 81 fa e0 e1 10 c0 0f 84 a9 00 00 00 48 89 c6 48 89 ca 0f b7 ba 54 04 00 00 4c 8b 82 60 0c 00 00 85 ff 74 2f <49> 3b a8 98 09 00 00 74 4e 44 8d 47 ff 31 ff 49 c1 e0 03 eb 0d
[  +0.000839] RSP: 0018:ffff92ee804cbd88 EFLAGS: 00010202
[  +0.000328] RAX: ffffffffc010e190 RBX: ffff918b5c6b5000 RCX: ffff918b7d8e0000
[  +0.000399] RDX: ffff918b7d8e0000 RSI: ffffffffc010e190 RDI: 0000000000000001
[  +0.000398] RBP: ffff918b7d318340 R08: 0000000000000000 R09: ffffffffb9bd2d7a
[  +0.000385] R10: ffff918b7eb253c0 R11: ffffb95980f51200 R12: ffffffffc010e1a0
[  +0.000411] R13: fffffffffffffff2 R14: 000000000000000b R15: ffff918b7e232620
[  +0.000384] FS:  00007f955bec2740(0000) GS:ffff918b7eb00000(0000) knlGS:0000000000000000
[  +0.000420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000801] CR2: 0000000000000998 CR3: 000000003cad6000 CR4: 00000000001406e0
[  +0.000837] Call Trace:
[  +0.000682]  ? _cond_resched+0x10/0x20
[  +0.000691]  ? __kmalloc+0x131/0x1b0
[  +0.000710]  kernfs_fop_write+0xfa/0x170
[  +0.000733]  __vfs_write+0x2e/0x190
[  +0.000688]  ? inode_security+0x10/0x30
[  +0.000698]  ? selinux_file_permission+0xd2/0x120
[  +0.000752]  ? security_file_permission+0x2b/0x100
[  +0.000753]  vfs_write+0xa8/0x1a0
[  +0.000676]  ksys_write+0x4d/0xb0
[  +0.000699]  do_syscall_64+0x3a/0xf0
[  +0.000692]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4dee119..ee36e6b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1516,6 +1516,7 @@ static void cache_set_free(struct closure *cl)
 	bch_btree_cache_free(c);
 	bch_journal_free(c);
 
+	mutex_lock(&bch_register_lock);
 	for_each_cache(ca, c, i)
 		if (ca) {
 			ca->set = NULL;
@@ -1534,7 +1535,6 @@ static void cache_set_free(struct closure *cl)
 	mempool_exit(&c->search);
 	kfree(c->devices);
 
-	mutex_lock(&bch_register_lock);
 	list_del(&c->list);
 	mutex_unlock(&bch_register_lock);
 
-- 
1.8.3.1

