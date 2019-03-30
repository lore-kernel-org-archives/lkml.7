Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654962184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909986;
	bh=wFBjDRC1cmKCA36nkAYZ/nKjJl0ch7eCLOt4oToGhmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZOVEQqJ7A29x9/EgM+YCHvn/HRtF5T5c1JTrsEOj+vgjeO+8BLupOyuDAJFiVpHH
	 IuHvMWOo05f6RbMLYYLFow5jWW9GTt8PcccBs3VazaxBCPE+vIrEJ2k5bEl8JB9Cx+
	 IR7FqYRnNrkoGGgNND2HY0pvbwkqpSq62pTDI2wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfC3Bjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731245AbfC3BaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90BA218D9;
        Sat, 30 Mar 2019 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909399;
        bh=wFBjDRC1cmKCA36nkAYZ/nKjJl0ch7eCLOt4oToGhmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fd+7FqUqClrIup5dQP43QuMTluC0F7FWpG5k8NgoehBhwL+3Mw4VWdys0tDpd8UOZ
         cgYXlOsqVWHuMf4oU0BkNwJUzUmwekxr2LCcXgQUHW0miOD+9hvC2tfiYRVf0OROqF
         YCM4ayym3330d72jTA7N2QPZNlgk2rmJICN8yp9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trigger Huang <Trigger.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 29/57] drm/ttm: Fix bo_global and mem_global kfree error
Date:   Fri, 29 Mar 2019 21:28:22 -0400
Message-Id: <20190330012854.32212-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trigger Huang <Trigger.Huang@amd.com>

[ Upstream commit 30f33126feca0fe16df9e9302ffc28a953e2eb37 ]

ttm_bo_glob and ttm_mem_glob are defined as structure instance, while
not allocated by kzalloc, so kfree should not be invoked to release
them anymore. Otherwise, it will cause the following kernel BUG when
unloading amdgpu module

[   48.419294] kernel BUG at /build/linux-5s7Xkn/linux-4.15.0/mm/slub.c:3894!
[   48.419352] invalid opcode: 0000 [#1] SMP PTI
[   48.419387] Modules linked in: amdgpu(OE-) amdchash(OE) amdttm(OE) amd_sched(OE) amdkcl(OE) amd_iommu_v2 drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi pcbc snd_seq snd_seq_device snd_timer aesni_intel snd soundcore joydev aes_x86_64 crypto_simd glue_helper cryptd input_leds mac_hid serio_raw binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace sunrpc sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 8139too psmouse i2c_piix4 8139cp mii floppy pata_acpi
[   48.419782] CPU: 1 PID: 1281 Comm: modprobe Tainted: G           OE    4.15.0-20-generic #21-Ubuntu
[   48.419838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   48.419901] RIP: 0010:kfree+0x137/0x180
[   48.419934] RSP: 0018:ffffb02101273bf8 EFLAGS: 00010246
[   48.419974] RAX: ffffeee1418ad7e0 RBX: ffffffffc075f100 RCX: ffff8fed7fca7ed0
[   48.420025] RDX: 0000000000000000 RSI: 000000000003440e RDI: 0000000022400000
[   48.420073] RBP: ffffb02101273c10 R08: 0000000000000010 R09: ffff8fed7ffd3680
[   48.420121] R10: ffffeee1418ad7c0 R11: ffff8fed7ffd3000 R12: ffffffffc075e2c0
[   48.420169] R13: ffffffffc074ec10 R14: ffff8fed73063900 R15: ffff8fed737428e8
[   48.420216] FS:  00007fdc912ec540(0000) GS:ffff8fed7fc80000(0000) knlGS:0000000000000000
[   48.420267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.420308] CR2: 000055fa40c30060 CR3: 000000023470a006 CR4: 00000000003606e0
[   48.420358] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   48.420405] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   48.420452] Call Trace:
[   48.420485]  ttm_bo_global_kobj_release+0x20/0x30 [amdttm]
[   48.420528]  kobject_release+0x6a/0x180
[   48.420562]  kobject_put+0x28/0x50
[   48.420595]  ttm_bo_global_release+0x36/0x50 [amdttm]
[   48.420636]  amdttm_bo_device_release+0x119/0x180 [amdttm]
[   48.420678]  ? amdttm_bo_clean_mm+0xa6/0xf0 [amdttm]
[   48.420760]  amdgpu_ttm_fini+0xc9/0x180 [amdgpu]
[   48.420821]  amdgpu_bo_fini+0x12/0x40 [amdgpu]
[   48.420889]  gmc_v9_0_sw_fini+0x40/0x50 [amdgpu]
[   48.420947]  amdgpu_device_fini+0x36f/0x4c0 [amdgpu]
[   48.421007]  amdgpu_driver_unload_kms+0xb4/0x150 [amdgpu]
[   48.421058]  drm_dev_unregister+0x46/0xf0 [drm]
[   48.421102]  drm_dev_unplug+0x12/0x70 [drm]

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c     | 1 -
 drivers/gpu/drm/ttm/ttm_memory.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 7c484729f9b2..268f5a3b3122 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1445,7 +1445,6 @@ static void ttm_bo_global_kobj_release(struct kobject *kobj)
 		container_of(kobj, struct ttm_bo_global, kobj);
 
 	__free_page(glob->dummy_read_page);
-	kfree(glob);
 }
 
 void ttm_bo_global_release(struct drm_global_reference *ref)
diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index 450387c92b63..df73d5ff84a8 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -216,14 +216,6 @@ static ssize_t ttm_mem_global_store(struct kobject *kobj,
 	return size;
 }
 
-static void ttm_mem_global_kobj_release(struct kobject *kobj)
-{
-	struct ttm_mem_global *glob =
-		container_of(kobj, struct ttm_mem_global, kobj);
-
-	kfree(glob);
-}
-
 static struct attribute *ttm_mem_global_attrs[] = {
 	&ttm_mem_global_lower_mem_limit,
 	NULL
@@ -235,7 +227,6 @@ static const struct sysfs_ops ttm_mem_global_ops = {
 };
 
 static struct kobj_type ttm_mem_glob_kobj_type = {
-	.release = &ttm_mem_global_kobj_release,
 	.sysfs_ops = &ttm_mem_global_ops,
 	.default_attrs = ttm_mem_global_attrs,
 };
-- 
2.19.1

