Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA58C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884113;
	bh=brmz5Awo5xDD9CyvzRCYtkw/Mi4q6RDFq2tW986y0/Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jDwlzmnJVNu4l2nLHTAugqSaSIW7tWVdZlv4hgRxxg45k1nPfIh9B2dtqmkNGFIJr
	 i5n+eS0gxArR3Djf5rmfOmci3T4028n+EclZ4w9UBes78wer1dv9fN0Qm2Vr9pd7Jg
	 1oyZSrrKdsoC9z7tQX/Oaxifnd4zNWYwlDU0wB5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfFRSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfFRSzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:55:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520EB206BA;
        Tue, 18 Jun 2019 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884110;
        bh=brmz5Awo5xDD9CyvzRCYtkw/Mi4q6RDFq2tW986y0/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Yk1xdzUdDcJEdRMUHwhxwIujSEVpTBoH7hTe2mwxtaBbcTXBp7V3ZGugSDnzSZDAk
         9qFrssSbZ31Z6XOm2tjuU3pSYD9+XwMGjxLyXLyTSS9ejaZgmQu2T5rFtB6SSD3QKq
         ehTnsQE1CgkTECZ6IBUpA7Vr47lJZJHEpnB0NdiA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] drm/lima: Mark 64-bit number as ULL to silence Smatch warning
Date:   Tue, 18 Jun 2019 20:55:00 +0200
Message-Id: <20190618185502.3839-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark long numbers with ULL to silence the Smatch warning:

    drivers/gpu/drm/lima/lima_device.c:314:32: warning: constant 0x100000000 is so big it is long long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

