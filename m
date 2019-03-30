Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D49EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBA82064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908287;
	bh=ClFW02Yg+r/zz+F4SmUdivedqWVlgy5NqK02UBOTaXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mgjLxe7o9StxT5MPVXPE1el8HY0wK4EIQySuDTpIrDsGYXfarXjT7cr2Q7hpUJ5r2
	 CzbgqvGF7gWXeKL5LVKNdjpgCFAlm1EyPfg9KBL0mfRfmjibLRVtn4zZx9SRGGeee+
	 TLjPRMwGN1ViUHDyn8qcv4h2hH4mMVJovSOBgZj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfC3BL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730584AbfC3AvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F2C206DD;
        Sat, 30 Mar 2019 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907065;
        bh=ClFW02Yg+r/zz+F4SmUdivedqWVlgy5NqK02UBOTaXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4yAnYdxhbTnres0SBYwCut7udZUi0+/0EKvbV1FC9QdWODgMJXnFIYCki36SgwlB
         P5bQUuwYFvCKqFMoFBd13ga/nvJbhxLFtcOoBSytUfXcqRoDH9rephSUBlDsgpz3Jl
         PgJ3mZer9sm0+SrG8MwkzrsBvuynRjjpl5NacAmE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 13/67] drm/udl: use drm_gem_object_put_unlocked.
Date:   Fri, 29 Mar 2019 20:49:53 -0400
Message-Id: <20190330005047.25998-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 8f3b487685b2acf71b42bb30d68fd9271bec8695 ]

When Daniel removed struct_mutex he didn't fix this call to the unlocked
variant which is required since we no longer use struct mutex.

This fixes a bunch of:
WARNING: CPU: 4 PID: 1370 at drivers/gpu/drm/drm_gem.c:931 drm_gem_object_put+0x2b/0x30 [drm]
Modules linked in: udl xt_CHECKSUM ipt_MASQUERADE tun bridge stp llc nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t>
CPU: 4 PID: 1370 Comm: Xorg Not tainted 5.0.0+ #2

backtraces when you plug in a udl device.

Fixes: ae358dacd217 (drm/udl: Get rid of dev->struct_mutex usage)
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/udl/udl_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
index d5a23295dd80..bb7b58407039 100644
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -224,7 +224,7 @@ int udl_gem_mmap(struct drm_file *file, struct drm_device *dev,
 	*offset = drm_vma_node_offset_addr(&gobj->base.vma_node);
 
 out:
-	drm_gem_object_put(&gobj->base);
+	drm_gem_object_put_unlocked(&gobj->base);
 unlock:
 	mutex_unlock(&udl->gem_lock);
 	return ret;
-- 
2.19.1

