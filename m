Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB33C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68E5205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712821;
	bh=VOOaVhvQV8UZAZgHs8B779ToG49weiAhovjtHSlocDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xpGVPiDOIQ5UCJcgzQbzFk6TWrrT8bwl60uBqhI6qvOdYi1rSt7B8MOHjqAaNpu7S
	 msK3Gi8jydBfUQhzScn9KD0gY7ZsQ4Q21REUvmONQgAz0UreA6lHsEEgDtH2O4Z0Hx
	 kfr3yBlf+tIfaDF364v2tklwpEjrA2LY6FR8GMzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfC0Sxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390220AbfC0SRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3922183E;
        Wed, 27 Mar 2019 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710632;
        bh=VOOaVhvQV8UZAZgHs8B779ToG49weiAhovjtHSlocDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+o0ZeAKwv4Gw5Ey7QRMmyABEQszeoR7ak6Cq44X466gOhWd5o2VyUF44RJ3jTiIk
         i7gBMN8gxE98aMbIsqqDrbvFp6BCdHNc0CReRCJVtmYAsA8T2d+Lh/PHmw58PboCuf
         ksR9/tF7RJZJ1eaGMMOQdahW5AiA09vzrDdIblmU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuriyc Chu <sureeju@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 023/123] fs/file.c: initialize init_files.resize_wait
Date:   Wed, 27 Mar 2019 14:14:47 -0400
Message-Id: <20190327181628.15899-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index 4eecbf4244a5..0c25b980affe 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -462,6 +462,7 @@ struct files_struct init_files = {
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
 	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
+	.resize_wait	= __WAIT_QUEUE_HEAD_INITIALIZER(init_files.resize_wait),
 };
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
-- 
2.19.1

