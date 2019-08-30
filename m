Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0354C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E812173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqWNiLgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfH3IHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:07:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfH3IHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:07:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id 26so1766336pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MXRSo7Bfbe6lDlHCJm+CIISENbRdG4l7siPy76JG7SU=;
        b=lqWNiLgQRKoeRFx5gu3wvDbkipZoLgcIkAg7cNMOCVqf7X4rfBm+KpoYRqHhu9dw05
         /tNQVj7lqrk15NlFAa6ckxFZo20CEvy/CFkDB5dtBf9F4xxsoJwR2VvIfFH4jq7sl35d
         tvDgUC4x7mgnxniJO4br8Tb1OX9F72mVL1ACp51JPKY4O8T8YB9aXB9hJGVO/ePIDYiW
         ACA1f8zYp9MSxOSCfabML8xqwIKowg2j0VH74y9gJmQ6yK2Mg4QtMCSkM+pF2lxZ8xzn
         h53kiOouU7VOeTv2vs6h3jFgxj+fAp/A/qUtxR09wAGpLjtCU2IJA1KexOSAzixdQf7j
         czVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MXRSo7Bfbe6lDlHCJm+CIISENbRdG4l7siPy76JG7SU=;
        b=bNaGJK3mVaT7ERq+tbFyJn4ig2sJJbgp2ouvYF6vPSHlADBjK+TZpkVWldBwnW4Dvf
         okC8sTJaIjbMsVPfhZJldMEDdxivICq/UKAhtz7tIcn1B3oYbKwKHvTL1ihhjs9R2jKB
         yUULX5R+rIcDuqOdfAlasx6O0CEx0Gf4JjG5rtyc6RNQCgyYK0Sj0jcEKPXmI9I5WcYf
         s20wiQzCSWXK7DBntYojCHl1dvwxE1whIz3IL/dQuTvml/5N0OYhc77a+irmS8YT4tQp
         WWGIBkkyEtvQbt8IjQB9WLdtvofJNu06cwPUq5PckzSspqhcPbIOUs/dsCsohQdsccWT
         /Cpw==
X-Gm-Message-State: APjAAAXCifLuOzLS3xaV6PwqRK/DhjLR7RRfYrWKrPp3ha2y27GGLuG9
        nqZbXq4mdC4rHNIJmjTbliaMfdw5AGc=
X-Google-Smtp-Source: APXvYqxZAHJHRmuCjSumcB6MbQRPwIPCHRCI7QXFZ70Y2QZsOHTv528yreoK++9BGrbefLAeN/Cbhw==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr11617071pgk.297.1567152429453;
        Fri, 30 Aug 2019 01:07:09 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id v189sm5854894pfv.176.2019.08.30.01.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:07:08 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:07:04 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     rex.zhu@amd.com, evan.quan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Move null pointer dereference check
Message-ID: <20190830080704.GA29599@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Null pointer dereference check should have been checked,
ahead of below routine.
	struct amdgpu_device *adev = hwmgr->adev;

With this commit, it could avoid potential NULL dereference.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 8189fe4..4728aa2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -722,16 +722,17 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 
 static int smu8_start_smu(struct pp_hwmgr *hwmgr)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_device *adev;
 
 	uint32_t index = SMN_MP1_SRAM_START_ADDR +
 			 SMU8_FIRMWARE_HEADER_LOCATION +
 			 offsetof(struct SMU8_Firmware_Header, Version);
 
-
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
 
+	adev = hwmgr->adev;
+
 	cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
 	hwmgr->smu_version = cgs_read_register(hwmgr->device, mmMP0PUB_IND_DATA);
 	pr_info("smu version %02d.%02d.%02d\n",
-- 
2.6.2

