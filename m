Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA7C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DB02085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGUWjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 18:39:55 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.155]:44778 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbfGUWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 18:39:54 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id A939F400C9A81
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 17:39:53 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pKUjhLfYzdnCepKUjhqVvm; Sun, 21 Jul 2019 17:39:53 -0500
X-Authority-Reason: nr=8
Received: from cablelink-187-160-61-189.pcs.intercable.net ([187.160.61.189]:12335 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hpKUi-000rlS-I2; Sun, 21 Jul 2019 17:39:52 -0500
Date:   Sun, 21 Jul 2019 17:39:49 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amdgpu/gfx10: Fix missing break in switch statement
Message-ID: <20190721223949.GA13591@embeddedor>
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
X-Source-IP: 187.160.61.189
X-Source-L: No
X-Exim-ID: 1hpKUi-000rlS-I2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-187-160-61-189.pcs.intercable.net (embeddedor) [187.160.61.189]:12335
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statement in order to prevent the code from falling
through to case AMDGPU_IRQ_STATE_ENABLE.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1675d5837c3c..35e8e29139b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4611,6 +4611,7 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
 		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		cp_int_cntl = RREG32(cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
-- 
2.22.0

