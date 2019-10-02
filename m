Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5DC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 05:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF35215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 05:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBqzpDZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJBFSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 01:18:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfJBFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 01:18:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so9717272pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=swe25t+lxOEruvSVv2ts6lHoxHEk7rNBAWMV8cWmjOc=;
        b=HBqzpDZYcZjgpRunc6y7IF170eXNXKl5Ah2zEIFOrmB+v84x5h9heqxCGMrLY14bPA
         p9LLfOakNoGxZKVJdj/F+/ZAtyw/IwcdRW5HT8dslzClmxCXnuDQhXjEILUiw9Z6x+ea
         ucuoSHQ/xGLko3fbtGk9BWC6e103EHwk14EPFI+57U8jFYqa/8D8INeK6FW39VAm0D9G
         D3osVnpOVbveO4DQmS7dpi4oo1v3PtYls+unfAKKYwqP+yj2P7v9QXpThYoTVhi/WFdW
         na2seGZoK0FH0+i5rPn4EKewzrUgJ9e9b31mau6rSixIaPFVzAkMB2MiUQtsS/gqB6PO
         /kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=swe25t+lxOEruvSVv2ts6lHoxHEk7rNBAWMV8cWmjOc=;
        b=U2DA28Wh5yjVXDQy1NGXkn/MArQKI9EUggq34i5gHcwSYbIDYdqm/zlmeCLgf3M9T/
         Xhl8O5Mb37taX2pxrR4s3S/Nbv1psbRrlEMDCQdG0MX58jTZDcQC4y5fwJlzzbkyWGVY
         3T5MKzgzB8gjxnFSTVki5mFEoMF2mh/BW1WcPaLN15je4y7G5dpiFGexRQ6crovxbgX5
         Ttg909q8R7deEYt+oBLStxHfAAGZuKUWvtfePcdDyXcZApGysyaA8lqVxjAdF1T4IKET
         v4HPRxD0f6xS73A+e2o7om4njxvnDXZgQ3Bzxk46tK5OCuwlU/a83aAH4VxESYgqrUdl
         wOFw==
X-Gm-Message-State: APjAAAW3gxObm71SQVXMCSsjeDLMeUVp+KVM+dKOprdvK8HYc8Q70ZhG
        QIW1ybp2TkFVYQGVK3WL6PMVgh4pgJhv8Q==
X-Google-Smtp-Source: APXvYqwpKJcblMq0mpI/hveU2vbjEWJo6IKKvou0p5GSYWDur1xu05LUEKTdioxnw+g3ePGUQ4C4aA==
X-Received: by 2002:aa7:81cb:: with SMTP id c11mr2438922pfn.251.1569993485244;
        Tue, 01 Oct 2019 22:18:05 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id z13sm18228362pfg.172.2019.10.01.22.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 22:18:04 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:17:59 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     alexander.deucher@amd.com, evan.quan@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] drm/amdgpu: Drop unused variable and statement
Message-ID: <20191002051759.GA161133@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though 'smu8_smu' is declared, it is not used after below statement.

   smu8_smu = hwmgr->smu_backend;

So 'unused variable' could be safely removed
to stop warning message as below:

   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu8_smumgr.c:180:22:
   warning: variable ‘smu8_smu’ set but not used 
   [-Wunused-but-set-variable]

   struct smu8_smumgr *smu8_smu;
             ^
Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 4728aa2..7dca04a 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -177,12 +177,10 @@ static int smu8_load_mec_firmware(struct pp_hwmgr *hwmgr)
 	uint32_t tmp;
 	int ret = 0;
 	struct cgs_firmware_info info = {0};
-	struct smu8_smumgr *smu8_smu;
 
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
 
-	smu8_smu = hwmgr->smu_backend;
 	ret = cgs_get_firmware_info(hwmgr->device,
 						CGS_UCODE_ID_CP_MEC, &info);
 
-- 
2.6.2

