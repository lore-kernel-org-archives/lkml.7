Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08921848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aNmCJr6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKHFPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:15:19 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:27224 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHFPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:15:19 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xA85E4kr007705;
        Fri, 8 Nov 2019 14:14:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xA85E4kr007705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573190046;
        bh=yfawSp5OIyMMuGnL0XInEnRM8aE3vEYt+IwcZoO4q/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=aNmCJr6koHmis2nuJdLfb3+XwQWcIpir1IDHuLudT0cr/gACI4RFc3IjJELzW+wrg
         a9ks+0WXkxNw8amIYzuFWHvrY8GX0fEm0NDrbtRfvkhTJm4OeI6S71j5Lv0qc576mY
         EubDXOlmfGJlzH4IjEFlHiVf3y/ZSQi99auKspI3aGlzOFNUntmkSSKXCqjZdtm358
         k0zdFx5bTPtscvMPpA9S/vODh00rPq9cSIyuoRx9Ojqy0MDVp+qFetISWVlgRG+5pR
         9qnV/2wGazP2s+zxP32BRSDWClq7E0H9SgwKcrkAmCwYlfEQdLuSnbl6xZ8d6yadGt
         O0/qw0ZxeyXOQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/i915: change to_mock() to an inline function
Date:   Fri,  8 Nov 2019 14:13:55 +0900
Message-Id: <20191108051356.29980-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this function is defined in a header file, it should be
'static inline' instead of 'static'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
index f0f8bbd82dfc..22818bbb139d 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
@@ -14,7 +14,7 @@ struct mock_dmabuf {
 	struct page *pages[];
 };
 
-static struct mock_dmabuf *to_mock(struct dma_buf *buf)
+static inline struct mock_dmabuf *to_mock(struct dma_buf *buf)
 {
 	return buf->priv;
 }
-- 
2.17.1

