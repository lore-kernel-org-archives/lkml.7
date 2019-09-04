Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F300EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA243233FF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620288;
	bh=ovHGuXpziaMuM8GQ3V3dazv7Z54p5bDTPpOVQpyIElk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQvDzXttvg0PTqaqhoKhplzjq5NRdUOgmKMk8qhIGbAs/ZbFnzE+14ovUCBbIra61
	 ffclrQfQt2lKleOODJzWD/Hk/LOg0pwdgWztUmadcLu9dxMu5gVhnGLT/a+9+nj6MZ
	 mKjisHfgZwrtCp3vcwVMCtRzNP0YaOLKEkH+2Tkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfIDSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389128AbfIDSEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4B322CEA;
        Wed,  4 Sep 2019 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620283;
        bh=ovHGuXpziaMuM8GQ3V3dazv7Z54p5bDTPpOVQpyIElk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez0Qi4zLTABs2QldD4JqkdZc1RXzVCzqq1/CGceCWdkcKXsE/o0qFmMODO87TpqIz
         y3bQS77Koyuktv/y5NAwDbluHQBLtmMxTp3+2fk7JeRVjZ3WlaptW7wj/DlncbCQq4
         vgm9ewMwSfhFctXNZokOvhij6IYfIwdTB3WeXtpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiong Zhang <xiong.y.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 44/57] drm/i915: Dont deballoon unused ggtt drm_mm_node in linux guest
Date:   Wed,  4 Sep 2019 19:54:12 +0200
Message-Id: <20190904175306.366483408@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiong Zhang <xiong.y.zhang@intel.com>

commit 0a3dfbb5cd9033752639ef33e319c2f2863c713a upstream.

The following call trace may exist in linux guest dmesg when guest i915
driver is unloaded.
[   90.776610] [drm:vgt_deballoon_space.isra.0 [i915]] deballoon space: range [0x0 - 0x0] 0 KiB.
[   90.776621] BUG: unable to handle kernel NULL pointer dereference at 00000000000000c0
[   90.776691] IP: drm_mm_remove_node+0x4d/0x320 [drm]
[   90.776718] PGD 800000012c7d0067 P4D 800000012c7d0067 PUD 138e4c067 PMD 0
[   90.777091] task: ffff9adab60f2f00 task.stack: ffffaf39c0fe0000
[   90.777142] RIP: 0010:drm_mm_remove_node+0x4d/0x320 [drm]
[   90.777573] Call Trace:
[   90.777653]  intel_vgt_deballoon+0x4c/0x60 [i915]
[   90.777729]  i915_ggtt_cleanup_hw+0x121/0x190 [i915]
[   90.777792]  i915_driver_unload+0x145/0x180 [i915]
[   90.777856]  i915_pci_remove+0x15/0x20 [i915]
[   90.777890]  pci_device_remove+0x3b/0xc0
[   90.777916]  device_release_driver_internal+0x157/0x220
[   90.777945]  driver_detach+0x39/0x70
[   90.777967]  bus_remove_driver+0x51/0xd0
[   90.777990]  pci_unregister_driver+0x23/0x90
[   90.778019]  SyS_delete_module+0x1da/0x240
[   90.778045]  entry_SYSCALL_64_fastpath+0x24/0x87
[   90.778072] RIP: 0033:0x7f34312af067
[   90.778092] RSP: 002b:00007ffdea3da0d8 EFLAGS: 00000206
[   90.778297] RIP: drm_mm_remove_node+0x4d/0x320 [drm] RSP: ffffaf39c0fe3dc0
[   90.778344] ---[ end trace f4b1bc8305fc59dd ]---

Four drm_mm_node are used to reserve guest ggtt space, but some of them
may be skipped and not initialised due to space constraints in
intel_vgt_balloon(). If drm_mm_remove_node() is called with
uninitialized drm_mm_node, the above call trace occurs.

This patch check drm_mm_node's validity before calling
drm_mm_remove_node().

Fixes: ff8f797557c7("drm/i915: return the correct usable aperture size under gvt environment")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/1566279978-9659-1-git-send-email-xiong.y.zhang@intel.com
(cherry picked from commit 4776f3529d6b1e47f02904ad1d264d25ea22b27b)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_vgpu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/i915/i915_vgpu.c
+++ b/drivers/gpu/drm/i915/i915_vgpu.c
@@ -100,6 +100,9 @@ static struct _balloon_info_ bl_info;
 static void vgt_deballoon_space(struct i915_ggtt *ggtt,
 				struct drm_mm_node *node)
 {
+	if (!drm_mm_node_allocated(node))
+		return;
+
 	DRM_DEBUG_DRIVER("deballoon space: range [0x%llx - 0x%llx] %llu KiB.\n",
 			 node->start,
 			 node->start + node->size,


