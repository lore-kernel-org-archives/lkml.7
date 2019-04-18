Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7853C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD40218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610320;
	bh=Wp9HFVpCPvkH0jPAss366Yc/j16eP2Ww9+UJdbU3oOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aU063ve7jQh2S7u8yyeIqdOF36Io8iCAak+3T7fV/deAqXMRI4Xj7kQmKlqnbazlC
	 RqDpwOGnTNXE9a50xDuEieT9d2CEC07QGtU46toIboHzmWC4CQ+CZPJ2HNgXvrXveU
	 NuA86D7mfqY7650k9NSoWVN5KP/FAylRlt9c+g70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbfDRR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389833AbfDRR6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AAFA217FA;
        Thu, 18 Apr 2019 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610310;
        bh=Wp9HFVpCPvkH0jPAss366Yc/j16eP2Ww9+UJdbU3oOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffQkXKbdSxt+vo2vYfl6A72/9joejEgDOPub3O1sVrJnTPaexTsFcaLCryGmY9eRD
         Abr2aQPe77tZtG1qsPymW22L6oQdF+N3dK6Kr2HUvieGJfXJlj3YbP0rt4ZLAntQHW
         iz25l/0eFnDGzuTrHKw/mCNikjmf8kfFujU1SD+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/110] drm/udl: use drm_gem_object_put_unlocked.
Date:   Thu, 18 Apr 2019 19:56:01 +0200
Message-Id: <20190418160438.571813202@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



