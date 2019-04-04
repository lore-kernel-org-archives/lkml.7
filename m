Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E78206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371469;
	bh=HYp7bDhIYHFvryeRR9r2yTeVaeacht4gl4JypH55vIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HLwo/+UyNT4rY/l+Xnv8aF8EKnUfCrp2CcvdaF7+Vqz2VUkwzcyXivhmAShRn407i
	 LH1igVsOzAnhFEq24s+oWdYnSOlayaPNQtJEU8K0oRhI7j5zoepTSnOALp4iE6enmc
	 r10pXqY8qg/3lrv3MU1Cfd5q0BlChb3jmRcg/QB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfDDJvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbfDDIzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEBED20882;
        Thu,  4 Apr 2019 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368116;
        bh=HYp7bDhIYHFvryeRR9r2yTeVaeacht4gl4JypH55vIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvZXV6F5z/u20xpwD4ntY0YTdRPmx6txLuLGcJ9enSUDEtsYwfSJftZqzAAuxKO0k
         0BqIpzT/2arWkxzqKf34cBjF4KF3cz08hAM3B2uwd+E7tgfQQDHoJTtegNrcTpPYt9
         Gimh/IKgHHKj4V+aNnlaNxkaMkegVSleeUXEhnhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Zhang <zhang.zijian@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/121] fs/file.c: initialize init_files.resize_wait
Date:   Thu,  4 Apr 2019 10:46:55 +0200
Message-Id: <20190404084546.828048505@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



