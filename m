Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076B5218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMtCA6al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGCNOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:14:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37744 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:14:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so1276105pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X6GDzktbtJ+VqVECtvxe0dHO4mFvJx9Nj4EzNU7DPGw=;
        b=ZMtCA6al7suQi26fqBMax2hJdFeqaPpONJNbcH+S93TSY01pPyOP9s7HifnrW8VYhv
         bsgu4M2GWMz10qI4MQ7WTg8+TyD1Nchequ/U6pqQ3nqu+UDgfcpIw+fRtPU2nt4SsIia
         w8pAuIrJqEq+aEfXux6x2Xs17EyBd6X0BdsiH0UIz2igWAtUFmYAYzp62JlKvfV/dNQs
         YIwTTIFMosX/jEM/pQFLWrOlZc+S0qCCSzruIVFF4Nmxox962RythsWk498NbXvmj/fe
         9+7OrIpqlQzdA2rkZ0XiInHmZo1MheBVSW4VUjYNpMznUiMTdOyI1BLFLO+l9sglu/EG
         2thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X6GDzktbtJ+VqVECtvxe0dHO4mFvJx9Nj4EzNU7DPGw=;
        b=ail9akThe9YUbqtVyuhkY4Gl1wihCIwMzrtvWowhC2+0xNyLM3UA0oVnui1SUmEBJn
         3xCCGSrtikn8NqIYWyqMb8RW9t6yJj6j84tqGONJhOir4k3s5iVWIH/OZsZiK/19pAnR
         uFXd3mk5LuTiIZRsXrdXOvsxZDRFOnLGuhVW9HJH0X0jdejVhXBj17RceviRRj8pZ78d
         3tA5nmq6ilUEqR0jj91fhcp+Ub8yPW8IEfGKsUud5yUM2ki2wj0sVh/ahIspjxmGACe6
         xKr5QMTltUvxtmTlcRdvtspZhW6wL4UkqFfEpFZjKUrHreAE/QBMWZzqPBL+E40U+qfh
         MWDA==
X-Gm-Message-State: APjAAAWIkLuAKaQH5JKNabLbMu2lgK9sHC4g05O7gFpjSEqRMKdIYHV4
        RAyMn+GZpZg0z0hcBT9sEtUx2/ZsfPE=
X-Google-Smtp-Source: APXvYqzu5gmEESyUNZwvYG2VbKFqz1Zzy9LdbFGjMWscl9/DLNVf7tLVBbQLx9ycrNljkAMf+YgGXg==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr12402173pjq.69.1562159678447;
        Wed, 03 Jul 2019 06:14:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h11sm2292897pfn.170.2019.07.03.06.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:14:38 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 07/30] drm/i915: use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:14:26 +0800
Message-Id: <20190703131426.24993-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 41c8ebc60c63..fe6fa979f22a 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -411,14 +411,13 @@ int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args)
 		goto out;
 	}
 
-	dmabuf_obj->info = kmalloc(sizeof(struct intel_vgpu_fb_info),
+	dmabuf_obj->info = kmemdup(&fb_info, sizeof(struct intel_vgpu_fb_info),
 				   GFP_KERNEL);
 	if (unlikely(!dmabuf_obj->info)) {
 		gvt_vgpu_err("allocate intel vgpu fb info failed\n");
 		ret = -ENOMEM;
 		goto out_free_dmabuf;
 	}
-	memcpy(dmabuf_obj->info, &fb_info, sizeof(struct intel_vgpu_fb_info));
 
 	((struct intel_vgpu_fb_info *)dmabuf_obj->info)->obj = dmabuf_obj;
 
-- 
2.11.0

