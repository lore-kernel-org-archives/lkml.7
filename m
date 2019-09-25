Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE2C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDXySTkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfIYEiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:38:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44871 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIYEiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:38:17 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so10163458iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5BDuZ4+Y3X5laJQOvw+qSCT7xhGoru1+k46cwYao5zs=;
        b=mDXySTkDaQZsdqKg5+tkUpytcg3n00Lh6czbxsojHEwUp/Jd/Z26hPuo8nvxOck/EP
         I5hHoTiv4HuWD4+eMmDb1xEVFPDc/3H3RESpudOWjFsM8piowjdRO7XbTiF/sjHBjAXZ
         usQmXob+UkL9ysO1USfkRgoN7EzuYamxCMNxiMkOnIUmstzaW6Fw7orms/3Yq70boRl+
         BI0jEaXeJ4PHupSRsujX1ZF/68hTpmEVh3UpAdYli410sqwNEsJP/FKmvgyhCxJqyFq3
         cqnC3WaK/+zLvqCVRCSX2Ie3+6uVJyTxl72LKAwSjM3ZYavhs0N8WRtNVwUVosfpEiMi
         Ml/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5BDuZ4+Y3X5laJQOvw+qSCT7xhGoru1+k46cwYao5zs=;
        b=OyU3WjQz24faRSKiGeSPMOxa8GFYYusnLFPq4SBnKAF1p4WGe2mwUpe4tghYXlZs7d
         6BM/Z6Ij6A1RHlj54aHzAZEXlOw/IV4M2xrDDXzne3ziUYRAw5Oj5ySuCV/T7DL13uAh
         coG83+1xpmA2g+cXQSfIbG1eyjqfqZ+WfmEYbIHYCJtSjicCPz5087P2dxoTTuGeHKpI
         cCBbOFg23l1oAcNgrnBF4d1x/pIURIKdr5h7E+pOb/bHPE50/FXEymim4M3OxIXabodp
         9jyLJqIQ3qB3Iq6rZXB9W0pJ7jBJ1/yZ0O0l6s9MY1BpaZ8P//dJS641NFvo4rDwKKgc
         5J6g==
X-Gm-Message-State: APjAAAWHQKpTBMf6Xn/El9WMNW3qsyGlDUrYkdMTFW2uhjGaEmbyCO0x
        O0qbf8id3ricskDEQdNMuHToDgdmZyc=
X-Google-Smtp-Source: APXvYqzXt01BRxpe/Gpokn+Qqg4SqkmVtkWH3lUoq+gLxw/pva1ap3tM1cq/kabrKnKblef4yAbfsA==
X-Received: by 2002:a5d:8ac4:: with SMTP id e4mr8009350iot.185.1569386295248;
        Tue, 24 Sep 2019 21:38:15 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id g68sm33489ilh.88.2019.09.24.21.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:38:14 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add
Date:   Tue, 24 Sep 2019 23:37:58 -0500
Message-Id: <20190925043800.726-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vmw_cmdbuf_res_add if drm_ht_insert_item fails the allocated memory
for cres should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 4ac55fc2bf97..44d858ce4ce7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -209,8 +209,10 @@ int vmw_cmdbuf_res_add(struct vmw_cmdbuf_res_manager *man,
 
 	cres->hash.key = user_key | (res_type << 24);
 	ret = drm_ht_insert_item(&man->resources, &cres->hash);
-	if (unlikely(ret != 0))
+	if (unlikely(ret != 0)) {
+		kfree(cres);
 		goto out_invalid_key;
+	}
 
 	cres->state = VMW_CMDBUF_RES_ADD;
 	cres->res = vmw_resource_reference(res);
-- 
2.17.1

