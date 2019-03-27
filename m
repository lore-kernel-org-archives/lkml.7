Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7381C21734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709805;
	bh=/OrhX40uoCv//Taquhv0DUoCnp3Ps4eZLZUMj9J5PKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0jGvIAImYMYT0tdEF+EgZQAoaPKuDbcNHiY+zr799Gfn+zzW25LRDFocbSMy7Cr9
	 xtuKBEV2Ar25e9szbT0KA3NOOldOVfxpTISFtCIMSZWbGpsdoazHbN7BC9Nxzgjnq2
	 YM+ZquU0WSdZui3wdLUcvOzQjaMuOiDRBCagRXBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfC0SDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbfC0SDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BBC2183E;
        Wed, 27 Mar 2019 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709797;
        bh=/OrhX40uoCv//Taquhv0DUoCnp3Ps4eZLZUMj9J5PKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckFSKj7Efvr0Y/dMQiVQG9H4pN/brD7uqiPzHTfI0nCqsdZbT3QG6rVW4X51HwKtg
         tUvsR56vycVtugknMHoQPvQTkIAh/O7e258/y9LgdgCOKo7PYDSP/ZiAuIiJEq5A5o
         ImzMlsgZ3itxWr4xMSWy1OVfrOyXuWUZePrsYt1g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuriyc Chu <sureeju@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 043/262] fs/file.c: initialize init_files.resize_wait
Date:   Wed, 27 Mar 2019 13:58:18 -0400
Message-Id: <20190327180158.10245-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuriyc Chu <sureeju@gmail.com>

[ Upstream commit 5704a06810682683355624923547b41540e2801a ]

(Taken from https://bugzilla.kernel.org/show_bug.cgi?id=200647)

'get_unused_fd_flags' in kthread cause kernel crash.  It works fine on
4.1, but causes crash after get 64 fds.  It also cause crash on
ubuntu1404/1604/1804, centos7.5, and the crash messages are almost the
same.

The crash message on centos7.5 shows below:

  start fd 61
  start fd 62
  start fd 63
  BUG: unable to handle kernel NULL pointer dereference at           (null)
  IP: __wake_up_common+0x2e/0x90
  PGD 0
  Oops: 0000 [#1] SMP
  Modules linked in: test(OE) xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter devlink sunrpc kvm_intel kvm irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd sg ppdev pcspkr virtio_balloon parport_pc parport i2c_piix4 joydev ip_tables xfs libcrc32c sr_mod cdrom sd_mod crc_t10dif crct10dif_generic ata_generic pata_acpi virtio_scsi virtio_console virtio_net cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm crct10dif_pclmul crct10dif_common crc32c_intel drm ata_piix serio_raw libata virtio_pci virtio_ring i2c_core
   virtio floppy dm_mirror dm_region_hash dm_log dm_mod
  CPU: 2 PID: 1820 Comm: test_fd Kdump: loaded Tainted: G           OE  ------------   3.10.0-862.3.3.el7.x86_64 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
  task: ffff8e92b9431fa0 ti: ffff8e94247a0000 task.ti: ffff8e94247a0000
  RIP: 0010:__wake_up_common+0x2e/0x90
  RSP: 0018:ffff8e94247a2d18  EFLAGS: 00010086
  RAX: 0000000000000000 RBX: ffffffff9d09daa0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff9d09daa0
  RBP: ffff8e94247a2d50 R08: 0000000000000000 R09: ffff8e92b95dfda8
  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff9d09daa8
  R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000003
  FS:  0000000000000000(0000) GS:ffff8e9434e80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000017c686000 CR4: 00000000000207e0
  Call Trace:
    __wake_up+0x39/0x50
    expand_files+0x131/0x250
    __alloc_fd+0x47/0x170
    get_unused_fd_flags+0x30/0x40
    test_fd+0x12a/0x1c0 [test]
    kthread+0xd1/0xe0
    ret_from_fork_nospec_begin+0x21/0x21
  Code: 66 90 55 48 89 e5 41 57 41 89 f7 41 56 41 89 ce 41 55 41 54 49 89 fc 49 83 c4 08 53 48 83 ec 10 48 8b 47 08 89 55 cc 4c 89 45 d0 <48> 8b 08 49 39 c4 48 8d 78 e8 4c 8d 69 e8 75 08 eb 3b 4c 89 ef
  RIP   __wake_up_common+0x2e/0x90
   RSP <ffff8e94247a2d18>
  CR2: 0000000000000000

This issue exists since CentOS 7.5 3.10.0-862 and CentOS 7.4
(3.10.0-693.21.1 ) is ok.  Root cause: the item 'resize_wait' is not
initialized before being used.

Reported-by: Richard Zhang <zhang.zijian@h3c.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index 3209ee271c41..a10487aa0a84 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -457,6 +457,7 @@ struct files_struct init_files = {
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
 	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
+	.resize_wait	= __WAIT_QUEUE_HEAD_INITIALIZER(init_files.resize_wait),
 };
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
-- 
2.19.1

