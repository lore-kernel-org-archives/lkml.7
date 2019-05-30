Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E946C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13D525F85
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB/gDn1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfE3SZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:25:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44982 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfE3SZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:25:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id c9so1222592pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Lj5sJkyXzswdfKKQsKOyyjcnCowmI0P42DY17LEeBDI=;
        b=AB/gDn1oV3/ItKH83SwUe0OJ7ImMOhnavPB5tK3/AgwaY4iZ8QxtKelbDYhKQbfvpp
         QW9S6bHqK/tlh/llsKuxLiyZtF+JkAUuvKFbwe1MQGDdxXRzo4hzCvdzEWSJkb2bEdEm
         kbRUfxuhF5fzN/n7nNX0vasy/A3f95vThuoeCO32FBXNxzlEdaxBHxfdjQu9e7G3JlTG
         +kiEFzsf28+JqisDCE1CH5v4Lw1Jac0BNEmDSZSL+Aphn+dB6xpXtdmzodJ+bbHgOCA0
         psdCiAPbkR4MdgEfve7lvKXXWYVZs0z9KC7x1kDrAaA5/EXCxL9iVeaV2MOqDcX0xF/u
         e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Lj5sJkyXzswdfKKQsKOyyjcnCowmI0P42DY17LEeBDI=;
        b=CrsliwwinMl2Dr2EDPPVBCZbTVonPHSBF9ZAAZcH9hCtsbcQ86FtAOJB/ukUwRdeJF
         im4ud6f4K0U7s2EqGOR1hbrleILR0ISMlRRWLcs3iyBE4P3185NPBf0pdbcVIxpHsJJM
         gIg/MfNaISN/XzX89UDyDAT2VUdrluFccTzILU1Q6Fx7+1rHpJYYAk7GcCGQcl+lbuyw
         peL3LwzZX9tPmAVpuqy3itrZskf24P1TlpisBTljNxqbQMqoS89jLyewM0/Qd5NjzpSc
         65dcCO0t+XcM4/kuP+5jXFWmNEnMU539txH1EMvbWHMC13q6Zgr66jFT/VA8ONB6eRc/
         h9BA==
X-Gm-Message-State: APjAAAX4ARRuDflEVfqGULMEOS/322t7weooYCBoZjHABTNy/f2PLrxP
        1Qf8uSeS/gUYreaLoniiHRk=
X-Google-Smtp-Source: APXvYqy2EQutgm73jGARD8ECucwV9aFaWJhYHhAIfn80iJdYlyi4qnZUJeJdj655kCVPlJIiYb639Q==
X-Received: by 2002:a05:6a00:43:: with SMTP id i3mr5089670pfk.113.1559240738062;
        Thu, 30 May 2019 11:25:38 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id n127sm2786600pga.57.2019.05.30.11.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:25:37 -0700 (PDT)
Date:   Thu, 30 May 2019 23:55:32 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Remove call to memset after dma_alloc_coherent
Message-ID: <20190530182532.GA8370@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck

./drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:63:13-31: WARNING:
dma_alloc_coherent use in ih -> ring already zeroes out memory,  so
memset is not needed

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 934dfdc..d922187 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -65,7 +65,6 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 		if (ih->ring == NULL)
 			return -ENOMEM;
 
-		memset((void *)ih->ring, 0, ih->ring_size + 8);
 		ih->gpu_addr = dma_addr;
 		ih->wptr_addr = dma_addr + ih->ring_size;
 		ih->wptr_cpu = &ih->ring[ih->ring_size / 4];
-- 
2.7.4

