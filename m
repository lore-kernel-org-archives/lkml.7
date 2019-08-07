Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59630C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A92421743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aj9oX8mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHGClA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:41:00 -0400
Received: from gateway36.websitewelcome.com ([192.185.184.18]:35030 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbfHGClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:41:00 -0400
X-Greylist: delayed 1220 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 22:40:59 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 138C8400DD465
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 20:45:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vBZ6hGNKy2qH7vBZ6hH9GX; Tue, 06 Aug 2019 21:20:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pUxBPsNGWxsRsB7NDgN9eNAS2Hr1pQIZdhHSWzXdg+w=; b=aj9oX8mRps4i4Vhhlaip9MvCwH
        n2TJQa2tPHp0yCeXUx7ubaJqt3ATHJtoTvFuL15E4IgEQMGX/PUeO4iP2SW4oYPRJz4KKxuJEZdSb
        sRxpyrEXo+RfUuXFO88hjlGQaiccBvOoaFSfdwUU49SrzJPQINVdQ5IV6DnsvV/0j6EluduHYoxlp
        iDhS4kdR+KGwXgABQZOCgh9Q/LiCk64Woy0YKhLO6A1C0x1NQMdvxcUU0op67QdgkTtP7ayZCBHCt
        OF1DBsN5XDVz5WAqzoMDYhuq1E2CKQzs2DzEd60lRzXakFzJc2RUogetxMCSFhJoS2JMGE5IaXAFS
        hrNBd60A==;
Received: from [187.192.11.120] (port=51758 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvBZ4-001ybs-Ge; Tue, 06 Aug 2019 21:20:35 -0500
Date:   Tue, 6 Aug 2019 21:20:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiong Zhang <xiong.y.zhang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/gvt: Fix use-after-free in
 intel_vgpu_create_workload
Message-ID: <20190807022033.GA22623@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hvBZ4-001ybs-Ge
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:51758
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_free() frees *workload*, hence there is a use-after-free bug
when calling function gvt_vgpu_err().

Fix this by storing the value of workload->wa_ctx.indirect_ctx.guest_gma
and workload->wa_ctx.per_ctx.guest_gma into automatic variable
guest_gma before freeing *workload*, for its further use.

Addresses-Coverity-ID: 1452235 ("Read from pointer after free")
Fixes: 2089a76ade90 ("drm/i915/gvt: Checking workload's gma earlier")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 32ae6b5b7e16..c8cdb4a309f6 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -1525,9 +1525,11 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu, int ring_id,
 			if (!intel_gvt_ggtt_validate_range(vgpu,
 				workload->wa_ctx.indirect_ctx.guest_gma,
 				workload->wa_ctx.indirect_ctx.size)) {
+				unsigned long guest_gma =
+				       workload->wa_ctx.indirect_ctx.guest_gma;
 				kmem_cache_free(s->workloads, workload);
 				gvt_vgpu_err("invalid wa_ctx at: 0x%lx\n",
-				    workload->wa_ctx.indirect_ctx.guest_gma);
+					     guest_gma);
 				return ERR_PTR(-EINVAL);
 			}
 		}
@@ -1539,9 +1541,11 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu, int ring_id,
 			if (!intel_gvt_ggtt_validate_range(vgpu,
 				workload->wa_ctx.per_ctx.guest_gma,
 				CACHELINE_BYTES)) {
+				unsigned long guest_gma =
+					workload->wa_ctx.per_ctx.guest_gma;
 				kmem_cache_free(s->workloads, workload);
 				gvt_vgpu_err("invalid per_ctx at: 0x%lx\n",
-					workload->wa_ctx.per_ctx.guest_gma);
+					     guest_gma);
 				return ERR_PTR(-EINVAL);
 			}
 		}
-- 
2.22.0

