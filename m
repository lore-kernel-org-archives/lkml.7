Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750AFCA9EC5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365B20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxs0uwpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfJ2JTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:19:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfJ2JTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:19:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id 21so9094871pfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VQh5oRSrn/jaJpLx3QrkWsF+eR7SZm+MJ/X6BG8VNCk=;
        b=uxs0uwpFgkNBtfpybCdyu7Hxl0sazaEpDe6OVN/XLuv0QfEAaizwFdoXk1N8Ez4U77
         FWXhlodBqy63DTFmodqIUg8GsY+BXuMK4A2ShaSNKw/bpOsSxazJtpa0y9ytv6Fmj/t6
         93eMignZ/0T+J7QCTWiK4lILtBJ3NiiYtqP1bbYll/OKeLuuUPPyVEMabcMuJ8Qo5VxC
         XIgTX+YaO1ynvmNWoIUuCmggyj22t/k4mAJ1wSO19GmQ8MoUSxoGiCNSlqrAPHI3BZ74
         Kbwnqjww9rwrpPHjsy02EJK8+AMmunuWrZydY70UaPJYSDYg7I4AI79wc89tc4m+FXgj
         /gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VQh5oRSrn/jaJpLx3QrkWsF+eR7SZm+MJ/X6BG8VNCk=;
        b=Eexfb8Erjfp5b9K4oj3aA1cAcTyFuPN3xFgytebBqwyVJIn3/+n3R9NKCvE+070QS4
         wbqJyK72cnLxjmQPc7LkuyXAJkmR8gMb2hn5bEuezzc1E8OVYN9249wLk+vTUQ+P1gt3
         VKs0jTROG18oT79AxY89BY1n/cSb+9s2dNbNrouf4T/WARuK2L7wElJVJSa5jyxwkFz3
         lKO5Xch22tyZCocT+h71h/86zgB0QVrUcJEbecv0tW8eqoheICF3JfX7+pdDC4Bwyvtk
         eyWPHVG1IcouKf61a9mgb3OGnMDdt5nUAQxg+OiAfU8RIzYb7W5yI9A8YnCfUN9xsoR+
         I+Iw==
X-Gm-Message-State: APjAAAUAptRwslFH0Knw+1OHNoR7wV7u9hNBfeVlq4YNKguqN0p2YogY
        lMw7FnSt6MMWgOXMPZB9gLkvMlehAT0=
X-Google-Smtp-Source: APXvYqy1UQHX5TYjIfx2Ppc5n9sA+ugVLJUG+NpLME8hrS1nyMrwsO4VWwFQqfXlPEwYoDneY4FW4A==
X-Received: by 2002:a62:6411:: with SMTP id y17mr26055073pfb.158.1572340791899;
        Tue, 29 Oct 2019 02:19:51 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id i7sm1691256pjs.1.2019.10.29.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:19:51 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:49:43 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        tom.stdenis@amd.com, xywang.sjtu@sjtu.edu.cn, Jack.Xiao@amd.com,
        sam@ravnborg.org, Kevin1.Wang@amd.com, saurav.girepunje@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] drm: amd: amdgpu: Remove NULL check not needed before
 freeing functions
Message-ID: <20191029091943.GA10258@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded NULL check before freeing functions
kfree and debugfs_remove.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5652cc72ed3a..cb94627fc0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1077,8 +1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
-	if (fences)
-		kfree(fences);
+	kfree(fences);
 
 	return 0;
 }
@@ -1103,8 +1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }
 
 #else
-- 
2.20.1

