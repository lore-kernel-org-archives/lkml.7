Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00626C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA05E21744
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7wKPIdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfJNMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:53:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42685 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfJNMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:53:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so16481176lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VY1HJeXOWBTSxDIpEf1BQUQwWK9Qg2h3vXazbHlYNs8=;
        b=S7wKPIdyT6ici7ZYTf/lSrUqOiypj53THCy9xqoVLl2+oYnyF8hXL+jli9skZrXLPh
         EZf0a0DWqeSE2padGXd3BMjokHsjWKf8ekTeEYnkaBX49QaeU+Oomt/f3Rxtps9xhAXY
         zsvVvTPKTPfExH7oomu1w1xpAv/R5EyQ9N/D5jSgfKKnj9eeydyQv+h/erdcYzOtV5QA
         Z0y19YpoqfU/dASwNjVLToraMbFxd5VKkpskHeQkjUP0X4E1WNtkOB4nC5GVAu/t6Qk1
         lDsh24E2W8HzJcMs3VMQSzo6MRdBMkl/OsGxTK+4HAfEVex7vzYS9UGXkesvsiZ5p4vA
         Kt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VY1HJeXOWBTSxDIpEf1BQUQwWK9Qg2h3vXazbHlYNs8=;
        b=c9yAal6ybUlf4HPMWNrGszjn2hmBJpldnF717VFEBDcAQRiPaglEIYoFPBVpKw+vSI
         AZtrHyxqFjaHSPjPEXkphHR0vbKHLmgzkSvfbu3ckKSvziM6BU/iHomYsg4TdY/hFo8M
         yb7DSPDKF1W+ut41OWGO5FqgUkZmKEFL1IGggUs7XL89GjiR6C1UqkK8wK8qQuz0ULg4
         FRf7qguInBN0n5YfOY4bX/VNCrQd17GBGLRfL67GDvp4ouJgg+CEHIg/uz3Mu/6uEJos
         488d2aCYmRbQMVSKhqJOjFVLAQvegixBAXmPWNEXnBXyF51SKf4uJZ0Wo6dItfcLEbQW
         oXoQ==
X-Gm-Message-State: APjAAAUalyDPuPhaC33XJfJfbOtTnSMjGJDnwMlOraPpAVons9G0X2td
        wOdvAyeIHxukveGjmmjwKNZZEg==
X-Google-Smtp-Source: APXvYqwcR6rJM0wrezHoQV9+aMKDlUkrWkgLeTTn4JrT5XvG8xafVe86yzBDLcqtbkKsYbGoL+/pRA==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr11807766ljg.202.1571057589040;
        Mon, 14 Oct 2019 05:53:09 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id c16sm4296623lfj.8.2019.10.14.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:53:08 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel.vetter@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/dp-mst: remove unused variable
Date:   Mon, 14 Oct 2019 14:53:02 +0200
Message-Id: <20191014125302.21479-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'dev' is no longer used and the compiler rightly complains
that it should be removed.

../drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_atomic_get_mst_topology_state’:
../drivers/gpu/drm/drm_dp_mst_topology.c:4187:21: warning: unused variable ‘dev’ [-Wunused-variable]
  struct drm_device *dev = mgr->dev;
                     ^~~

Rework to remove the unused variable.

Fixes: 83fa9842afe7 ("drm/dp-mst: Drop connection_mutex check")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 9364e4f42975..9cccc5e63309 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4184,8 +4184,6 @@ EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
 struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
 								    struct drm_dp_mst_topology_mgr *mgr)
 {
-	struct drm_device *dev = mgr->dev;
-
 	return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(state, &mgr->base));
 }
 EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
-- 
2.20.1

