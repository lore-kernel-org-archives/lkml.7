Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B104C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E845208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561134091;
	bh=i3bOwZCT85Q9yvApyiLHd1cEaAunSmxNvQtZBURK4gA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mVMtBiEpdeFtQbCDLBw3/pvZqxDunDwicUgsUzZEAOYQdpc+P7xeAecCjm+RxAL7y
	 vZFph++/ZuiSaWm6cwhDs3Eg4umtfBPG9JOiz3yIBbDYlf1UtADB/Pfl2qFv2CrN9m
	 8PYkLhthkXhWfw791YwLRCcRrHHLIYTjrjEgKwAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFUQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfFUQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:21:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A322089E;
        Fri, 21 Jun 2019 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561134088;
        bh=i3bOwZCT85Q9yvApyiLHd1cEaAunSmxNvQtZBURK4gA=;
        h=From:To:Cc:Subject:Date:From;
        b=LAovNkRmT7jv/zYTohSOPD5n7AZiXiuDJek2AUQvr38TGR6rgnGIQnNHZfy8QqTr4
         Fusf7Pxnv817IFYu9Ed5oRY38K5+/x77K0K+IQU6X7UqO1ydcAfJSFCYbTY6N4lPul
         Mp/EHpW+d5TLkT2v/pliMtBFEqIyW3l9xnGPZXm4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/4] drm/lima: Mark 64-bit number as ULL to silence Smatch warning
Date:   Fri, 21 Jun 2019 18:21:14 +0200
Message-Id: <20190621162117.22533-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark long numbers with ULL to silence the Smatch warning:

    drivers/gpu/drm/lima/lima_device.c:314:32: warning: constant 0x100000000 is so big it is long long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Qiang Yu <yuq825@gmail.com>

---

Changes since v1:
1. Add reviewed-by tag
---
 drivers/gpu/drm/lima/lima_vm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_vm.h b/drivers/gpu/drm/lima/lima_vm.h
index caee2f8a29b4..e0bdedcf14dd 100644
--- a/drivers/gpu/drm/lima/lima_vm.h
+++ b/drivers/gpu/drm/lima/lima_vm.h
@@ -15,9 +15,9 @@
 #define LIMA_VM_NUM_PT_PER_BT (1 << LIMA_VM_NUM_PT_PER_BT_SHIFT)
 #define LIMA_VM_NUM_BT (LIMA_PAGE_ENT_NUM >> LIMA_VM_NUM_PT_PER_BT_SHIFT)
 
-#define LIMA_VA_RESERVE_START  0xFFF00000
+#define LIMA_VA_RESERVE_START  0x0FFF00000ULL
 #define LIMA_VA_RESERVE_DLBU   LIMA_VA_RESERVE_START
-#define LIMA_VA_RESERVE_END    0x100000000
+#define LIMA_VA_RESERVE_END    0x100000000ULL
 
 struct lima_device;
 
-- 
2.17.1

