Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C9EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18C42070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iST9y/tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfG2Igy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:36:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45386 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfG2Igy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:36:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so27241387plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hx3TEgY39elQOvRZKIYlQACZaQ3s3d5tMJmYsbA0qFg=;
        b=iST9y/tlbMyiCwmbhHY9FWNkXPObO3xF30WMu+ksVmee+SRojWEPUfrXP+0RzqxskY
         RaRdvHnCaN9Uhnu3AgkBcArypuRqsoEF02Nae/zIr/OIDROVrQAoicdpMpLzT/e0QPh2
         Y/FEu/KbEDb19WdXexYIYZ/YBWbhvx3Sf7WQhDoWwIdjucrP5qt1FWEyGsaGx/8fLYDR
         S5fIwvTmk8gk2FEwDKIs7SQat2v7w9fI8HMlnwrF+1Z/nKVnB1UvdMW3wlbk358O29cZ
         /x4zWC4Ihp96LgkcYWKNXui8P/lCcO1vsgqT+OasJ9I8Eq28/7uJUNT/tS9mcyjYhd57
         7bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hx3TEgY39elQOvRZKIYlQACZaQ3s3d5tMJmYsbA0qFg=;
        b=HTp1Y9BII6J/X2hiZpTmBLgbFREzvpOZIUl2WPpBX9ppMhuW+srGkT1OhMaDoHjfgS
         HH96a2Blk1LOAPfzY4MVVZ0B2TWZvT2RkJwjQgXnvCdE0RFStoYNgt60HnSstxdICIz4
         82AHrh14jS/1FXRblyvgd6E8laDEvVjZt1YfVNMFwmYQ0Z1v0WvsCdYudLuyiUGToLGE
         VjbQbwrG/MkUUPfabUHh2HsZbCwSa6L4Kzc1Oiu3dIVdq1GyBgSGYtXMMnT31do3WJOP
         wi2r3Zsu8Eo+edd7Ri1wHM+n1R3ZgbDwBZ6DGZgf04DKx1Mpkv5Dj2lMxatgpShn/Zcx
         l81Q==
X-Gm-Message-State: APjAAAWqxgdh2Taxs+xGWDAU0uh1aiGusBTzy56Dir74asl2qTNRmJCl
        e8rdUOdrl2GZPxle4IfptVU=
X-Google-Smtp-Source: APXvYqz0jP2Bf6pvAx3SlTHB23BYM2WveDGGVsJhaXd3i0zzdponpYcgg/rEwUJhrPR9XGrPRwJVDg==
X-Received: by 2002:a17:902:2929:: with SMTP id g38mr88476612plb.163.1564389413648;
        Mon, 29 Jul 2019 01:36:53 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id z19sm52920862pgv.35.2019.07.29.01.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 01:36:53 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: Fix a possible null-pointer dereference in radeon_connector_set_property()
Date:   Mon, 29 Jul 2019 16:36:44 +0800
Message-Id: <20190729083644.29160-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In radeon_connector_set_property(), there is an if statement on line 743
to check whether connector->encoder is NULL:
    if (connector->encoder)

When connector->encoder is NULL, it is used on line 755:
    if (connector->encoder->crtc)

Thus, a possible null-pointer dereference may occur.

To fix this bug, connector->encoder is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index c60d1a44d22a..b684cd719612 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -752,7 +752,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 
 		radeon_encoder->output_csc = val;
 
-		if (connector->encoder->crtc) {
+		if (connector->encoder && connector->encoder->crtc) {
 			struct drm_crtc *crtc  = connector->encoder->crtc;
 			struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 
-- 
2.17.0

