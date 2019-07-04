Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C3C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBE221882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP0ka/sE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGDFwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:52:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35164 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so4252219edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Zhm68nrjPNXV8ta4ASMn+FRqbc2t3yxMdtkIvDKOc4=;
        b=XP0ka/sEA27+gCnCWLm1dzKrtk8lbVrGn2ZqYcTDK970tQdXsahKOmYbZZu4yHj/Ke
         boIp5FcbSeZb2/4yhYbjzrLoMPv0ZsNYmI3KY16LXqN28g6binjQioaU9NfEDcLcIUYp
         h+DV2KXYyLEQBT+E22CCvvC+vrkVyvsB+5cS3YEME2cH3cw+WcaKQk57KAzt2ulrQKhG
         gg0z3fN6SlI1akvG5k4ad/2Mc4S5cqRrlU6k5iAhXswD4+4uCcwHhFDyJDX4+XGXGQoD
         lfFCzhvYQNoSjuIp6l6ZfPl4zHGXgM+OXKtn5mmi51TiCbcpDeS7ax7+/G0iDHH9bFY6
         78jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Zhm68nrjPNXV8ta4ASMn+FRqbc2t3yxMdtkIvDKOc4=;
        b=LBzWYMkRWVvYaHYlBAJfMRSeDOZuFkPU61C7BXI2HAvVIdgU2UvCfLPCMrzSpMDshd
         GNHfX/cKEoaYmZ0/JUo39EkB1vmCMdk5PKa3jcXbSzTYJNFjn1GhuB8AM7aSSH/brQcu
         fa9KJu/FWrXQ2d+Gad9Vcn6mhK/AtmvrlgnRAh+oF1St0pPlJQGzSgX2NCf4t3H0DGRu
         +3Pf8RFs2qAYNPCb0K794k6If2S08K8ZfiZkPoJhFV3STpW8LrIKoWsTHzmBfBGeymI3
         l/qWD0AgwD+C9wPUHKMeGMQQ7/OM7SW30DsSsuQJ6YtjdM6M3uQWScyavG8jO1ofenEt
         UQpA==
X-Gm-Message-State: APjAAAXXflCb7ZpZvzjuc5RQtUBXa/IBpWwJumCvGkWLwdcL2osmdqlr
        6vrlUKSR21un2/wWNE30Gj8=
X-Google-Smtp-Source: APXvYqxQFUEDOhnvVoNZ0Db9O7mkDNsW7TSFMGzjisOwln697QwuYMDcDmma0VLRiSkvPfE9Lc/vGQ==
X-Received: by 2002:a17:906:74e:: with SMTP id z14mr36613416ejb.310.1562219565387;
        Wed, 03 Jul 2019 22:52:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu/mes10.1: Fix header guard
Date:   Wed,  3 Jul 2019 22:52:12 -0700
Message-Id: <20190704055217.45860-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

 In file included from drivers/gpu/drm/amd/amdgpu/nv.c:53:
 drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:24:9: warning:
 '__MES_V10_1_H__' is used as a header guard here, followed by #define of
 a different macro [-Wheader-guard]
 #ifndef __MES_V10_1_H__
         ^~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:25:9: note:
 '__MES_v10_1_H__' is defined here; did you mean '__MES_V10_1_H__'?
 #define __MES_v10_1_H__
         ^~~~~~~~~~~~~~~
         __MES_V10_1_H__
 1 warning generated.

Capitalize the V.

Fixes: 886f82aa7a1d ("drm/amdgpu/mes10.1: add ip block mes10.1 (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/582
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
index 17b9b53fa892..9afd6ddb01e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
@@ -22,7 +22,7 @@
  */
 
 #ifndef __MES_V10_1_H__
-#define __MES_v10_1_H__
+#define __MES_V10_1_H__
 
 extern const struct amdgpu_ip_block_version mes_v10_1_ip_block;
 
-- 
2.22.0

