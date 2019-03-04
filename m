Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E36FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF052075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6xZhFo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCDNKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:10:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:10:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so4189901edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDm9S0w4XYlJG6M4zuuR5LRAwCszL3P1crVHuvGsoC4=;
        b=d6xZhFo7xxx5JYSYw0t1ttLnQi2ToExQPHoFfDKezrb/oA3x+dKVLPkoeO5f25eIdk
         psgrbGRg//0d1Scr7tB0nnQ+XdUmZaSXFlGVKfQtzozJujNdkiAIiB3cr747XSIdMe2h
         JismlR2nWgiLZn2t5A9siMmNOnDAQfPAUF66qBuanB+vyowSWZRtqg5ST4YCuTjIfSRj
         CbWtFGslluuCo1uIjV/VEegNSZ1MlJHtnkRatod5AdQRV6lIPI8QwXgzK5eWXs9V7c0D
         ugsY4wZXwrHO+KXZfNvwC/D2SWK0RN8sWUfxfQMU9OPONVCu9z13EbBPUW2ti51MIPCt
         3MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDm9S0w4XYlJG6M4zuuR5LRAwCszL3P1crVHuvGsoC4=;
        b=Pze+vvWgZCK0/eoTdJk9XQyxlMz0mwswpQDORjgaqfNcpMXRaGyOm7+d9RVIQiqwhs
         2Ndbaxa6dSd8OZ3DLuIxj7L2hi56zXRD03/XeDEezRYy19K3O/gKk/8cmbaWc3wt0J/H
         +PpMS+OwPxfg5C+ozJTKx5kibdhUaN+ZANf8xuBqN/xcnretgw/PEhoCUpAD3SrqLX31
         wgyYndWULLwVgDcSko0Lzgd6SC7G6JWHHMAtS0eISOdg4kdHtrxMzYQb8rcd/yDkS57s
         2B/RwgAYV33zecPwkGrnOacB7NJnu4m3uLZfFDwNA3a9+jM9QHg31hjQBOezVt9+jJyA
         UHRQ==
X-Gm-Message-State: APjAAAVjI0MDx7t9dfI5ZOhGAbCNOAYxvLm/Pd0a93mcmHdGSgcngysU
        K+TaUDpGmSv5RRPAupW5aPU=
X-Google-Smtp-Source: APXvYqwR91+9Gz90DAXgsIhvflXpfHqveOczskY4ue7e2n2QziP+L1ocZdBWJ4/IwhV9TonuNRPovw==
X-Received: by 2002:a17:906:caa:: with SMTP id k10mr12434025ejh.113.1551705049696;
        Mon, 04 Mar 2019 05:10:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:4034:3c00:d125:9f50:8119:d83e])
        by smtp.gmail.com with ESMTPSA id fx9sm1177968ejb.51.2019.03.04.05.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:10:49 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Emily Deng <Emily.Deng@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/amdgpu: fix typing in amdgpu_virt_ops::trans_msg
Date:   Mon,  4 Mar 2019 14:10:00 +0100
Message-Id: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method in struct amdgpu_virt_ops::trans_msg() is defined as
using an 'u32' for its 2nd argument (the request) but the actual
implementation()s and calls use an 'enum idh_request' for it.

Fix this by using 'enum idh_request' for the method declaration too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 722deefc0a7e..3e9aec6f2795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -56,7 +56,7 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
-	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
+	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req, u32 data1, u32 data2, u32 data3);
 };
 
 /*
-- 
2.21.0

