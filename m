Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E7C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81642217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1U98WMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEYHe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 03:34:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 03:34:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so5041258plm.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JvzE9AyV74L/dTo6OIidUVMz2Tg/YkysokYHJ1eyAEI=;
        b=W1U98WMIUt2Y1NL0+hUD6ifWc5gAad3cySCvCzhQ4hereZF6+1LqJFJGAVKOVG60UI
         9jXSo7SC3PVFYkEeh7Rs5UXtH4GFFHc/841cpx3R0dnSILiIiWuKwJQ/MG63RvtGZa2R
         iTKPOYS+ozX3dyowPA10b/Hw2WrcOsbhX9QvGe1w3X3eGJtxUDHVgn+fYMEUwNHjV1QN
         Cd6Y1AHaTelpT8Xp+x9wxyKuD8cbq1+wOWtlARrWfdoCoWgA1ff6yY3YkEf5cG2s9r4S
         8SjwdmHPVxdqFaxlxDrnwPqV2D9+MlJtT4RLt5b6gVhpbYTvIYPCxmOm50bsVb2esdIK
         QA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JvzE9AyV74L/dTo6OIidUVMz2Tg/YkysokYHJ1eyAEI=;
        b=afM6nq9gTmj5fK3ckvA2NtswzCqZsBuTxHOmzRbT3vjtL22A4OaKW1oWufNi8KQHaB
         V3DaAgz8RcmFPQLUFk4mK0vV5u7345R+qUqQECxzPjdrZ4Arcffe0TPTg0Aab7xxxcnj
         edcB4WC86ooNEOMivEGg3BQSIMSmuUNmP4wokTN3OlkI58SbHg5K60ujVq2/UUnjggTE
         YLVeU2ywluOEJJTSHuhUis64fFtsfqZMpmvUfIMK/lPvfrau8+3E8xNLL4gOmGhMcF/r
         E7c2tGL6EoHO/Uo/CSeM1Mt48v/lBatSPUglaPfCom8PLegOEMsEPhVHGGU4lr9hNJEJ
         OqEg==
X-Gm-Message-State: APjAAAWTVp1jfo+fphRNBjIvv+J+c6g7N9ujavbK0SQObe93HmJifXrc
        galGV370/eaDASNiykewdZo=
X-Google-Smtp-Source: APXvYqzuwCZTB4XD4UxzRtNwZzdpVIiEv9uj7w5oO7kYYG8sg+hiUzQaOw5wFZIZoT7DFcvcOlrvdA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr112122498plp.180.1558769696584;
        Sat, 25 May 2019 00:34:56 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id v93sm4512115pjb.6.2019.05.25.00.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 00:34:56 -0700 (PDT)
Date:   Sat, 25 May 2019 13:04:49 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        hersen wu <hersenxs.wu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525073449.GA7278@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:1057:1-3:
WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1d5fc5a..1b1ec12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1054,8 +1054,6 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
 	ent = debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root,
 					 adev, &visual_confirm_fops);
-	if (IS_ERR(ent))
-		return PTR_ERR(ent);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(ent);
 }
-- 
2.7.4

