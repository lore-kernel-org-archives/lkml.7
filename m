Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6077C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36C20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeOkVav3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAIJHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:07:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgAIJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:07:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1930799wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srJzvMMQdpxyH00NoNIv1SdEKNzlKV0X21LyZXL6/tY=;
        b=eeOkVav3QtkOQrSyAYP34ttKjtKRxUKJhIuZS0/TC1uLiiy5EpnkIUgVGpyXGCiKPt
         y0rwRvQFOx9fIYvgn7CmD5L54YaTt/zNKp5DfCABveJgki3N46zSurPNPLaXPOHLX8VF
         CH9uC3bE5Ty8npPc4AyAkwYkN84BJzhmq/1cnwn6Z04aqzSH/9c4AZauXO1E4lrkm/dQ
         BFwFDS0W9DbkoQMGul67giCNYsI0hidenVfSl8/2ZeLQ2I/AM/x8Jo3qaT4JvTYrb0fO
         SSx0G6KQzB7gBHDVz0w1SsBk8hOc81svJhFYAQS/DACCT92W6KpJXM3a2AFjKQgrSQTb
         lsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srJzvMMQdpxyH00NoNIv1SdEKNzlKV0X21LyZXL6/tY=;
        b=Vn+NGMJUsbtSE49Ag8+WTPBBvL4bGO1t70eYpCmK8yApygB77qEAz85oK6HZUGEnBM
         OZHjBVkkqQYrZ+J9GiNTwdnBgflYT/AotobXml995FdcIk2r1VO3iB7/dKdUWqVWinQW
         nS2xiMYTNgFCqlgeYLQVfGsK/vqYJ7tGMle0n9LtnQl6e6uhpPNufome+nYiVEklOdzn
         7eh4QmM/Y5ECoaRtj4QqdD43AclG+mGoB/i7OiD8qPagJoHDhpDFeOb5ABxLkLv6dGnF
         VFrGNFc785xjH1WF4QJ8dPW36IkgFtfR1t08T87bw1i7Q79ncmKC1DrmYqV0Zga16CVN
         tOYQ==
X-Gm-Message-State: APjAAAWP2aP0BXSNRNywJOc2oe2q5CCBiIDw9ldH91qiKk01mdzoq18O
        YWEIlwx6olKGKB0DgGGBUFo=
X-Google-Smtp-Source: APXvYqw3p1tNZvJ6wGQcHlYj+kueCXToKBOgAY9fxM9CWd7N+g8KXeUHmFyiTOoSrXAf60CTyuKZYw==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr3398556wmg.74.1578560826373;
        Thu, 09 Jan 2020 01:07:06 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:07:05 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/i915: convert to new logging macros in i915/intel_memory_region.c
Date:   Thu,  9 Jan 2020 12:06:46 +0300
Message-Id: <1bf4d362e72c619843d44aac96c3561f54e4b23a.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
References: <cover.1578560355.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of printk based logging macros with the new struct
drm_device based logging macro in i915/intel_memory_region.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_memory_region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
index d0d038b3cd79..6b5e9d88646d 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -265,7 +265,9 @@ int intel_memory_regions_hw_probe(struct drm_i915_private *i915)
 
 		if (IS_ERR(mem)) {
 			err = PTR_ERR(mem);
-			DRM_ERROR("Failed to setup region(%d) type=%d\n", err, type);
+			drm_err(&i915->drm,
+				"Failed to setup region(%d) type=%d\n",
+				err, type);
 			goto out_cleanup;
 		}
 
-- 
2.24.1

