Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1988C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3FA206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCAU6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:58:36 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.179]:15178 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfCAU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:58:36 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 66E89B384
        for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2019 14:58:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id zpEogOXVk2qH7zpEogtOrR; Fri, 01 Mar 2019 14:58:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.88.58] (port=60114 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gzpEn-001lUx-0s; Fri, 01 Mar 2019 14:58:33 -0600
Date:   Fri, 1 Mar 2019 14:58:32 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amdgpu/gfx_v8_0: Mark expected switch fall-through
Message-ID: <20190301205832.GA21783@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.88.58
X-Source-L: No
X-Exim-ID: 1gzpEn-001lUx-0s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.88.58]:60114
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function ‘gfx_v8_0_tiling_mode_table_init’:
./include/linux/device.h:1487:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3236:3: note: in expansion of macro ‘dev_warn’
   dev_warn(adev->dev,
   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3240:2: note: here
  case CHIP_CARRIZO:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b8e50a34bdb3..02955e6e9dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
 		dev_warn(adev->dev,
 			 "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
 			 adev->asic_type);
+		/* fall through */
 
 	case CHIP_CARRIZO:
 		modearray[0] = (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
-- 
2.21.0

