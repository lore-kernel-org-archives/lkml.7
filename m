Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D6CC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A6C22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LNwTSjV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfHGPuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:50:07 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.200]:44834 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388758AbfHGPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:50:07 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 4AFBF186DFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 10:50:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vOCUhv1D8iQervOCUhIPnL; Wed, 07 Aug 2019 10:50:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tGMQ51Rv13b6vHV2oX8Kb0ED7YORM826dwEjbUekOns=; b=LNwTSjV8My84CdgkaXczARzvrX
        UHAo3XaZryYeWhTPD7qQLqrPm/zUzk5NJ8hESaNYsGKe9v8Non74I1z9UW9YBBmVe9/swYSBzeUzt
        NtWiiAVMXZiwTR6aGfeFgQmp07LMpibLgqHIgTOwghKDLZzabbqhR9J+dtN+MnvDu86vDqPzh2u8i
        WB/5imINiv3daPFrCToZcg3TPtRj6FZUtVKB2tNDzIKLAiZrlO0oOlCOPkFIL2TsQ5fUczGeJGT0s
        CAdWltZNS7YRL026+eRGnVGFTewIQ2hw1fbctkZgAcm/kzt4CdAhYZqZvJ8BiatnLuKLXJQjKL2dS
        80bBHKvg==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:45282 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvOCT-000Og7-9Q; Wed, 07 Aug 2019 10:50:05 -0500
Date:   Wed, 7 Aug 2019 10:50:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/nouveau/nvif/mmu: Use struct_size() helper
Message-ID: <20190807155002.GA25502@embeddedor>
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
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1hvOCT-000Og7-9Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:45282
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct nvif_mmu_kind_v0 {
	...
        __u8  data[];
};


Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*kind) + sizeof(*kind->data) * mmu->kind_nr

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
2.22.0

