Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6AF21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmLI6Xfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfKAQjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:39:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39826 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfKAQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:39:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id t12so4605843plo.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jop3Dux9Tb3Ov/yAM9BwP8Zp0TbIeSOkimu79QY77es=;
        b=nmLI6Xfp4DCOu0L6Y0a6idgMpzE/ZCS6AXaU1AX1lBJkSSFLMJJMyEXVX43sofP8BM
         jpb6lCY0BXFwGWAUBFoseAhpp0yqARTfCsjnqJA9xYnkS6S4ljXOCZi8VT3nbPgFaB+T
         oaNDXQZ3C6efLroLoE88iCbEW3/60zoCWd7FzL6fpipnd5Z3qm7QW9X3sxlilgIw8TCQ
         bPkHhNVix3KT43TwaGSq5ed93dFCXDBNHyT8FnTLUNVak1Kbe7sJJnT2r4TUQOPyH4k/
         rCMS4rR9q2RQWxq2qxEPIWyLtpPP5PK7bDvzBDGOOpf2imwnhteMOjPbLHLvUefhj0XP
         oa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jop3Dux9Tb3Ov/yAM9BwP8Zp0TbIeSOkimu79QY77es=;
        b=dnH7MeJhrlR0J0V6AlmPpnELMTPeD9KRFqLP9gCcVBh5EchnlHNVK8jC1y9KLMOQRt
         Yc6rtXvV1K/h6GKkty3476AhnEsIpulXSp+IUWKN6PCIt9/psU7v3f6i5X8fBQikNvfZ
         68fWtoTfnTmotKM198Z8QoXSajJIm+Clh3YbHcb6m6vTJ5cOltsVtdv956kLRfoQ9bnp
         naKjF046/iHoZXnE93m3k1Ed8rM/XnH5A03LBMHEavg76RAlkjGj+1MY7ldPP/NMnXOR
         jUlhsYbe0aPyLkQXDpaJk9lk8YvQsdmrutoVUdkezdkAq1Yi+30rHh4UnHOQfcywajQH
         nHbg==
X-Gm-Message-State: APjAAAUjZGt3Au9VQPkYEk02STz3Q5828n7kCpFp9u43ERGbOs6uqZOc
        67UOud8l/kdzL93Nhat1ucH6ULgZvK39wQ==
X-Google-Smtp-Source: APXvYqwikFR65XxVHQmNND6nn1yvtJkPX4KG/6KXxiGf1DsHPC00SF/oqM0MfFi79t8JfXr2DGcWdQ==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr12645499plb.253.1572626341042;
        Fri, 01 Nov 2019 09:39:01 -0700 (PDT)
Received: from localhost ([2402:3a80:1386:1fa1:cbdc:7851:d398:f27c])
        by smtp.gmail.com with ESMTPSA id m15sm6319676pgv.58.2019.11.01.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 09:39:00 -0700 (PDT)
Date:   Fri, 1 Nov 2019 22:08:56 +0530
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, ray.huang@amd.com
Subject: [PATCH] drivers: gpu: drm: amd: amdgpu: Add @level to
 amdgpu_vm_bo_param documentation
Message-ID: <20191101163856.GA13800@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for this function is missing the function parameter
"level", so add it. This fixes the following warning:

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:821:
	warning: Function parameter or member 'level'
	not described in 'amdgpu_vm_bo_param'

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5251352f5922..6f6a9be11d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -813,6 +813,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
+ * @level: VMPT level
  * @bp: resulting BO allocation parameters
  */
 static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.21.0

