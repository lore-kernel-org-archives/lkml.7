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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36972CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F8C20656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgoTtfkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfKAQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:03:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46751 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKAQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:03:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id f19so6739486pgn.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i2tLZxbCCHmnoEpOsO7B5VVDeMXO3toEiyrLWd0A38o=;
        b=ZgoTtfkjNDBbZRIaUX+TdhUiwPA47BigCQVQqtPPwfqU3QeSY1JuDiW/UVtHyZ1Gzr
         cF/ZdGJxwN7J0e5aa+eX5J5fTTL0x8NA+b6Y17qMp58DZd6jH6MzvqXNxVqqg6r+LDOL
         Ne1kQ+1HkcxuS4XQDr7NyJt9V/GbYc+DGDuKBYiXzDUQiOqBnwQXzADqxhtToL1zBiUI
         uaFsm1UrMoebyLrf88ZR6S5vpaC2bnyfrxGaFmC9NmKYkgCuKfKWlpH5lh05WBxbu8+2
         FKVSQ7guXRZ0DrghNiUHXzJIRnhrKUepXvlV0eH1nn/fHnGqud4OAFBFujvakMak/IMH
         kWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i2tLZxbCCHmnoEpOsO7B5VVDeMXO3toEiyrLWd0A38o=;
        b=GAo1We1PCtCEOG0P/MzvSr7SOaFM2sNX4vlA/skbCvKGbls2RmmL7yeGsxG1THqLmm
         PdktVAQ1hzAZRzE92KqTFJv6n1pYAdUcVnoo2nzcUG3I3rstknX9rAU+IkzTnnAdRVf1
         iEVYFH6EN1d1p8Hvwg0kg+V2w3gPh9U4TctgkiXXuWforoj34xTb9ygULqWxYZhIX7kR
         4Jz95ZQT+8OkOid+/uhubsrl1f8eG0AYUoZW4L8FkPZAyEubD0F9I463pBYBnghiV0U7
         rYPZO6W5gyPDsEPUT4dXksUJircbPy+jxLvhOKj4tehqAEX4VqmYpI91WZV4Wv7P5dkl
         5pMQ==
X-Gm-Message-State: APjAAAXIpZNsQOKCutCZIYVNfs4j03IKa7qK13Y+RJqpSFXQOYCeRcof
        Z8KjKAgqLP+1MAGYE6gktcvO7YRthpzjTQ==
X-Google-Smtp-Source: APXvYqzp2gT3KgISCliS31Ttoh4B4VoKcz1N1xyVB98zOypkWYgNP6dKvs8v8O5KoOoq5K1+ysCY+A==
X-Received: by 2002:a17:90a:62cc:: with SMTP id k12mr651068pjs.142.1572624199710;
        Fri, 01 Nov 2019 09:03:19 -0700 (PDT)
Received: from localhost ([2402:3a80:1386:1fa1:cbdc:7851:d398:f27c])
        by smtp.gmail.com with ESMTPSA id n3sm7541205pff.102.2019.11.01.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 09:03:18 -0700 (PDT)
Date:   Fri, 1 Nov 2019 21:33:12 +0530
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        kraxel@redhat.com, chris@chris-wilson.co.uk,
        emil.velikov@collabora.com, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drivers: gpu: amdgpu: Remove @dev from
 amdgpu_gem_prime_export documentation
Message-ID: <20191101160312.GA11047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function does not have a "dev" argument, so remove it from
the documentation. This fixes the following documentation
build warning:

./drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335:
	warning: Excess function parameter 'dev' description in
	'amdgpu_gem_prime_export'

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 61f108ec2b5c..4917b548b7f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -321,7 +321,6 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 
 /**
  * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
- * @dev: DRM device
  * @gobj: GEM BO
  * @flags: Flags such as DRM_CLOEXEC and DRM_RDWR.
  *
-- 
2.21.0

