Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC1233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494247;
	bh=6ZRKZTDtFpcHuGYbyiowH588bgrykE4wVjMA0sDld/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yrr7b1Wt51GGOwEY3BOEoeMlRVw5T3XTmBvEWtjehy7/59Dxi8st5kDGLIK4yeeMK
	 6tZHLqZFzywl3Kb8chvf9oKDRHZbJ2+Wmiq67RxE+t2f066/Z+QMY8rEzS0Cq+/yBp
	 n+XgJKHZYzX0Mx4n4Nf/B8gUSRRURp0kzgpDyLnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfHVRRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390336AbfHVRI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:28 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C677F2341B;
        Thu, 22 Aug 2019 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493707;
        bh=6ZRKZTDtFpcHuGYbyiowH588bgrykE4wVjMA0sDld/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQkHWtETU03TKiVl4Z5lITjU//Ti6wxQvFkPzHh5/1Ljyxu/qTioIU9mo9jhUdrJP
         TBLryTeM+iP5OmLMNnNzzFOy43/hxmii+MMnWJhmoCQ9RVFBSWcYVMprziRWaVZGXz
         a/GX5X2k56GmzHx/wAhxX21C6vZiNLd8WAvIgSPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 023/135] ALSA: hda - Let all conexant codec enter D3 when rebooting
Date:   Thu, 22 Aug 2019 13:06:19 -0400
Message-Id: <20190822170811.13303-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 401714d9534aad8c24196b32600da683116bbe09 upstream.

We have 3 new lenovo laptops which have conexant codec 0x14f11f86,
these 3 laptops also have the noise issue when rebooting, after
letting the codec enter D3 before rebooting or poweroff, the noise
disappers.

Instead of adding a new ID again in the reboot_notify(), let us make
this function apply to all conexant codec. In theory make codec enter
D3 before rebooting or poweroff is harmless, and I tested this change
on a couple of other Lenovo laptops which have different conexant
codecs, there is no side effect so far.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_conexant.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 0b0f24d24f8fd..14298ef45b21b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -163,15 +163,6 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
-	switch (codec->core.vendor_id) {
-	case 0x14f12008: /* CX8200 */
-	case 0x14f150f2: /* CX20722 */
-	case 0x14f150f4: /* CX20724 */
-		break;
-	default:
-		return;
-	}
-
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
-- 
2.20.1

