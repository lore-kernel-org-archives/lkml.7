Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67DAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9017F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfEXROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:14:42 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.212]:36236 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbfEXROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:14:42 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 0799E400C9F2B
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:14:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UDmChalYp2qH7UDmChpTPl; Fri, 24 May 2019 12:14:41 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=51574 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hUDlt-002A7a-UC; Fri, 24 May 2019 12:14:39 -0500
Date:   Fri, 24 May 2019 12:14:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/kvmgt: Use struct_size() helper
Message-ID: <20190524171421.GA20808@embeddedor>
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
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hUDlt-002A7a-UC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:51574
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(*sparse) + (nr_areas * sizeof(*sparse->areas)

with:

struct_size(sparse, areas, sparse->nr_areas)

and so on...

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 144301b778df..9674738b89df 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1306,7 +1306,6 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 		unsigned int i;
 		int ret;
 		struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
-		size_t size;
 		int nr_areas = 1;
 		int cap_type_id;
 
@@ -1349,9 +1348,8 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 					VFIO_REGION_INFO_FLAG_WRITE;
 			info.size = gvt_aperture_sz(vgpu->gvt);
 
-			size = sizeof(*sparse) +
-					(nr_areas * sizeof(*sparse->areas));
-			sparse = kzalloc(size, GFP_KERNEL);
+			sparse = kzalloc(struct_size(sparse, areas, nr_areas),
+					 GFP_KERNEL);
 			if (!sparse)
 				return -ENOMEM;
 
@@ -1416,9 +1414,9 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			switch (cap_type_id) {
 			case VFIO_REGION_INFO_CAP_SPARSE_MMAP:
 				ret = vfio_info_add_capability(&caps,
-					&sparse->header, sizeof(*sparse) +
-					(sparse->nr_areas *
-						sizeof(*sparse->areas)));
+					&sparse->header,
+					struct_size(sparse, areas,
+						    sparse->nr_areas));
 				if (ret) {
 					kfree(sparse);
 					return ret;
-- 
2.21.0

