Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE64C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0320673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J04EU7N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgAIJGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:06:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAIJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:06:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so6497849wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zvs7upA5ST9iH9y58rIMpyEvi1MZi0JpLUdAR1ZZjv4=;
        b=J04EU7N5mB/4+pCmu7qYm5pyqbOHuRKiLdWEthWFky5yKEOMLnmWn3UChdYUOEj0+z
         +g5LVegzXsgMDQTHClEXeKTk+396cD1vzA3Q3ntLIzhmItD2uTHYRU/x6CP4RH18qtsw
         aNJlgOamXNGXtGtRb09LPzu/evodvs+4+1KYdWXItxbMIFc6h7uGsyRHsUynx9aOiruO
         jAhJj9/U6jGn999SULhsKPwUkDh1NF3qULIaCi+ggBYef4WkKaPhWCzP/2DVowTN35ms
         Ws2xU16k5ju8010Cri/2yN4WAT6YZb1QMi0f435m7h6K06c0iiQlozEhzl7/ayX/JOdc
         Tylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zvs7upA5ST9iH9y58rIMpyEvi1MZi0JpLUdAR1ZZjv4=;
        b=gCEtX/CqcKyVQX4Jckq9uri51EZIhwYtXr3GB4+z4j8wvhvCCzwLhhe/fseyWINkET
         b1tyu3XhCikxCq9DTA+ucLs0lc7MKGTxGvbC2/t9LY6fEz9zoF27HJ4l7+lapovif4N9
         1a6LMRQTgtjNKpNheXbQsMvuq1S1+QW1TcoiBvKWotD0gVwPoTJwVVpKi7QEDGW1UEBe
         51xlfS5ggYGmSZ/6LNSoiGff3Wx33i8OdXMigqphitxIM+UW5UzD508YWJuzsjJLN3QA
         TjWRcxTkevJVGxeCi8bLoMexDhgiE1PpwP2Zk/OLEW2lpSasSdGqdaRbOGiaHZ7MjRrV
         kXCg==
X-Gm-Message-State: APjAAAWj2Kfeyr7+fa4hFfRsF+k6R18f/YcXfu9f0N8I1XW2RZpdvgwE
        0Zo5kjGxpXCRXiPyHW6LA68=
X-Google-Smtp-Source: APXvYqzFnRY1rdg3WglfybykLqtsi2X6MMl6GIUxKs/xV7llS00WQXe95gPzHvQ0TQlzZnEP3hqQ3g==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr9342456wro.51.1578560811960;
        Thu, 09 Jan 2020 01:06:51 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:06:51 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Use new logging macros in drm/i915
Date:   Thu,  9 Jan 2020 12:06:41 +0300
Message-Id: <cover.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset continues the conversion to using the new struct
drm_device based logging macros in drm/i915.

Wambui Karuga (5):
  drm/i915: conversion to new logging macros in i915/i915_vgpu.c
  drm/i915: conversion to new logging macros in i915/intel_csr.c
  drm/i915: conversion to new logging macros in i915/intel_device_info.c
  drm/i915: convert to new logging macros in i915/intel_gvt.c
  drm/i915: convert to new logging macros in i915/intel_memory_region.c

 drivers/gpu/drm/i915/i915_vgpu.c           | 41 +++++++++++++---------
 drivers/gpu/drm/i915/intel_csr.c           | 24 +++++++------
 drivers/gpu/drm/i915/intel_device_info.c   | 25 +++++++------
 drivers/gpu/drm/i915/intel_gvt.c           | 13 ++++---
 drivers/gpu/drm/i915/intel_memory_region.c |  4 ++-
 5 files changed, 64 insertions(+), 43 deletions(-)

-- 
2.24.1

