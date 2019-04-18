Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611698;
	bh=Wp9HFVpCPvkH0jPAss366Yc/j16eP2Ww9+UJdbU3oOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1ovc/vR1UwnyKGLBeXWAvi0VC7Y8F7+xhAoSl1XOBRETujuvdVuoKN32YF1kCAy1
	 bYpV525wQ6BHfQAclcc76M+JxByDzLrkRmHqNvGWjPt79d82uWNU+GIrtPT8bOQPZh
	 Kr5hmHnSfG6fNd/6Cx7q4XzS2s0CCVHG1nUshecQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfDRSVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391610AbfDRSJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806B82186A;
        Thu, 18 Apr 2019 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610980;
        bh=Wp9HFVpCPvkH0jPAss366Yc/j16eP2Ww9+UJdbU3oOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNdbeW3oKK2QhOkzFrcXQudx7gFDY5l2xVZAHP1NnCPcxdZi/tJ9N/RWNm14eb8up
         v6CCNcc41FnfPDuseWwuwdwW452hhpvcJUdDTHEOgQC/Dg2U/8Kw/5ciHds7Rr7J/s
         w6h9qtffLhIlCqtn9YU2ikPpPZk3R9aE0SPuaoVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 13/93] drm/udl: use drm_gem_object_put_unlocked.
Date:   Thu, 18 Apr 2019 19:56:51 +0200
Message-Id: <20190418160438.213533035@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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



