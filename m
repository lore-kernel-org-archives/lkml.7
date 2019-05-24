Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38A220863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfEXRPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:15:39 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:11639 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbfEXRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:15:38 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id C4B6CEE8B
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:15:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UDn7hZ2rl90onUDn7hd2MU; Fri, 24 May 2019 12:15:37 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=51588 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hUDn6-002Ami-S9; Fri, 24 May 2019 12:15:36 -0500
Date:   Fri, 24 May 2019 12:15:36 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/nouveau/mmu: use struct_size() helper
Message-ID: <20190524171536.GA20883@embeddedor>
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
X-Exim-ID: 1hUDn6-002Ami-S9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:51588
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
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

sizeof(*kind) + sizeof(*kind->data) * mmu->kind_nr;

with:

struct_size(kind, data, mmu->kind_nr)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/nouveau/nvif/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/mmu.c b/drivers/gpu/drm/nouveau/nvif/mmu.c
index ae08a1ca8044..5641bda2046d 100644
--- a/drivers/gpu/drm/nouveau/nvif/mmu.c
+++ b/drivers/gpu/drm/nouveau/nvif/mmu.c
@@ -110,7 +110,7 @@ nvif_mmu_init(struct nvif_object *parent, s32 oclass, struct nvif_mmu *mmu)
 
 	if (mmu->kind_nr) {
 		struct nvif_mmu_kind_v0 *kind;
-		u32 argc = sizeof(*kind) + sizeof(*kind->data) * mmu->kind_nr;
+		size_t argc = struct_size(kind, data, mmu->kind_nr);
 
 		if (ret = -ENOMEM, !(kind = kmalloc(argc, GFP_KERNEL)))
 			goto done;
-- 
2.21.0

