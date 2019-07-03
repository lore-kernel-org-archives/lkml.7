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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B333F2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq4qRUeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCQ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:27:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:27:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so1515793pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JOAvBtD07sBYTenk1Ld3G0gRN0kgMIcIX/hXrBaiC48=;
        b=Cq4qRUeKmmr6VHzShTIBP5uJdaJ5TP3JSbHewKTET6tPfxhELWCppMDSPBfKFYw7mV
         M9V5TcaxpMI/wVTiVQAqgxwxxWMDpeplHLUPLaYn3kMptcKJZ0XHLsECdmeOSgxF50Wm
         +JFZWhFhw2Wa5At3DmWjdnIcPlKxzCoi3apzdrjDGrvmknCMiUdNbOYTXfr+oC26T9On
         2UCPiVYl4pCPue6kkDo2ldm3SAAA7WSpp4fIjbQRStZVhe+NIz52SArH+KT+oJewTNSQ
         MipHAVbq6krLiAnSl5FIdAhyHJ8mOnwQj7WrldWPg2sItR1hTk2DBqOlYZIBiudSb4AW
         DYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JOAvBtD07sBYTenk1Ld3G0gRN0kgMIcIX/hXrBaiC48=;
        b=Ks3Elp8j7dTEuHma2XQn/oFKXXXjD+HmIV4m51PnA4OKmaR9gaXHEgibh5zlFzBeQO
         Rqsk9c0wGScIKNaddta27uOJT+mqP1kWJBose0J40WOIoTMBKyJtVeBSMAtt8V0AqQoW
         HpbsESc4XJ3/ozDJaivy5QArsLdFfR09CVWra4WaB8JQXHGA8O06O24JB22deyeBJH08
         pyvmIl6L/raSmaCcfaZAyGjPgfg0YNek9u4C/y03iOeFYdOvmULsvOwOZSmlBc3gq6Hm
         xBBoydoKyw1fxzzGxZF/YLgTlUo1ZmRJYWHyoxWPWbxW0G0MBOoDGSfIVmsf68FCSKB0
         KupA==
X-Gm-Message-State: APjAAAVRol7C847Lz7nlFfaO7FscX6Cz1q5MB5tII7SENrXJifG2zo4t
        HeR5hod6wWqWIMHZg1E3t7I=
X-Google-Smtp-Source: APXvYqwxisxAz70mUIcuNaWqws+r7Wyj6eH5XkoIzyb8MeIIkv07CAMI7ekDa2eTOk8igLTIOUxdPQ==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr39207542pgl.59.1562171258154;
        Wed, 03 Jul 2019 09:27:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h1sm2499433pgv.93.2019.07.03.09.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:27:37 -0700 (PDT)
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
Subject: [PATCH v2 08/35] drm/i915: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:27:28 +0800
Message-Id: <20190703162728.32230-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

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

