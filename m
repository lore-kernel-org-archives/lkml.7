Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0852184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909349;
	bh=hiFphtc3oFNVlCRFqyYbJSrqUSlUPWP//X1v1toM0M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kzs7bSCeWthrHe5em3N7cC+io9wdULEctb7WEzj3dpZLPFL1lzz1I/is8W5FbJ3Uf
	 OmnDEewSPSv5d9Opdjb1pAsMvwYAR+Rgmke9sUNE6GIzLTcL1Ttuk3EobElmyJrCdm
	 R23YwcTlEIDK1G376ffdcCijRTJpZTTWdpzz44H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfC3B3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfC3B3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B11C218EA;
        Sat, 30 Mar 2019 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909344;
        bh=hiFphtc3oFNVlCRFqyYbJSrqUSlUPWP//X1v1toM0M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6R3zsJKxu0Z4Y9PksOZuNiGBGcalGDO9OivRaczrdLG1JjLzJI+bWQdCpiQ1IRun
         cclzH22yJ76o/N1ZPESwMvri5ktd9a2aqedscLcCkUGPrO9aY5horNIHV3ZzI5ivSm
         OcfTQr5grtnprySJKVQT+pYhLatKmmNhjr5Y90WE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 08/57] f2fs: fix to do sanity check with current segment number
Date:   Fri, 29 Mar 2019 21:28:01 -0400
Message-Id: <20190330012854.32212-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 042be0f849e5fc24116d0afecfaf926eed5cac63 ]

https://bugzilla.kernel.org/show_bug.cgi?id=200219

Reproduction way:
- mount image
- run poc code
- umount image

F2FS-fs (loop1): Bitmap was wrongly set, blk:15364
------------[ cut here ]------------
kernel BUG at /home/yuchao/git/devf2fs/segment.c:2061!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 17686 Comm: umount Tainted: G        W  O      4.18.0-rc2+ #39
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
EIP: update_sit_entry+0x459/0x4e0 [f2fs]
Code: e8 1c b5 fd ff 0f 0b 0f 0b 8b 45 e4 c7 44 24 08 9c 7a 6c f8 c7 44 24 04 bc 4a 6c f8 89 44 24 0c 8b 06 89 04 24 e8 f7 b4 fd ff <0f> 0b 8b 45 e4 0f b6 d2 89 54 24 10 c7 44 24 08 60 7a 6c f8 c7 44
EAX: 00000032 EBX: 000000f8 ECX: 00000002 EDX: 00000001
ESI: d7177000 EDI: f520fe68 EBP: d6477c6c ESP: d6477c34
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010282
CR0: 80050033 CR2: b7fbe000 CR3: 2a99b3c0 CR4: 000406f0
Call Trace:
 f2fs_allocate_data_block+0x124/0x580 [f2fs]
 do_write_page+0x78/0x150 [f2fs]
 f2fs_do_write_node_page+0x25/0xa0 [f2fs]
 __write_node_page+0x2bf/0x550 [f2fs]
 f2fs_sync_node_pages+0x60e/0x6d0 [f2fs]
 ? sync_inode_metadata+0x2f/0x40
 ? f2fs_write_checkpoint+0x28f/0x7d0 [f2fs]
 ? up_write+0x1e/0x80
 f2fs_write_checkpoint+0x2a9/0x7d0 [f2fs]
 ? mark_held_locks+0x5d/0x80
 ? _raw_spin_unlock_irq+0x27/0x50
 kill_f2fs_super+0x68/0x90 [f2fs]
 deactivate_locked_super+0x3d/0x70
 deactivate_super+0x40/0x60
 cleanup_mnt+0x39/0x70
 __cleanup_mnt+0x10/0x20
 task_work_run+0x81/0xa0
 exit_to_usermode_loop+0x59/0xa7
 do_fast_syscall_32+0x1f5/0x22c
 entry_SYSENTER_32+0x53/0x86
EIP: 0xb7f95c51
Code: c1 1e f7 ff ff 89 e5 8b 55 08 85 d2 8b 81 64 cd ff ff 74 02 89 02 5d c3 8b 0c 24 c3 8b 1c 24 c3 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
EAX: 00000000 EBX: 0871ab90 ECX: bfb2cd00 EDX: 00000000
ESI: 00000000 EDI: 0871ab90 EBP: 0871ab90 ESP: bfb2cd7c
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
Modules linked in: f2fs(O) crc32_generic bnep rfcomm bluetooth ecdh_generic snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq pcbc joydev aesni_intel snd_seq_device aes_i586 snd_timer crypto_simd snd cryptd soundcore mac_hid serio_raw video i2c_piix4 parport_pc ppdev lp parport hid_generic psmouse usbhid hid e1000 [last unloaded: f2fs]
---[ end trace d423f83982cfcdc5 ]---

The reason is, different log headers using the same segment, once
one log's next block address is used by another log, it will cause
panic as above.

Main area: 24 segs, 24 secs 24 zones
  - COLD  data: 0, 0, 0
  - WARM  data: 1, 1, 1
  - HOT   data: 20, 20, 20
  - Dir   dnode: 22, 22, 22
  - File   dnode: 22, 22, 22
  - Indir nodes: 21, 21, 21

So this patch adds sanity check to detect such condition to avoid
this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ec50b95c7ea5..442cc9023dfc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2328,7 +2328,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int segment_count_main;
 	unsigned int cp_pack_start_sum, cp_payload;
 	block_t user_block_count;
-	int i;
+	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
 	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
@@ -2369,11 +2369,43 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
 			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
 			return 1;
+		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
+			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
+				le32_to_cpu(ckpt->cur_node_segno[j])) {
+				f2fs_msg(sbi->sb, KERN_ERR,
+					"Node segment (%u, %u) has the same "
+					"segno: %u", i, j,
+					le32_to_cpu(ckpt->cur_node_segno[i]));
+				return 1;
+			}
+		}
 	}
 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
 			return 1;
+		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
+			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
+				le32_to_cpu(ckpt->cur_data_segno[j])) {
+				f2fs_msg(sbi->sb, KERN_ERR,
+					"Data segment (%u, %u) has the same "
+					"segno: %u", i, j,
+					le32_to_cpu(ckpt->cur_data_segno[i]));
+				return 1;
+			}
+		}
+	}
+	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
+		for (j = i; j < NR_CURSEG_DATA_TYPE; j++) {
+			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
+				le32_to_cpu(ckpt->cur_data_segno[j])) {
+				f2fs_msg(sbi->sb, KERN_ERR,
+					"Data segment (%u) and Data segment (%u)"
+					" has the same segno: %u", i, j,
+					le32_to_cpu(ckpt->cur_node_segno[i]));
+				return 1;
+			}
+		}
 	}
 
 	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
-- 
2.19.1

