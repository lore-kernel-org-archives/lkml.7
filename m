Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F78C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEDA20838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3VuUrCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbfIFTX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:23:57 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:35458 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388818AbfIFTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:23:55 -0400
Received: by mail-io1-f46.google.com with SMTP id f4so14532794ion.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2yelZaQQgNOeM3tNL1ucPE8YNMsnU8lMoKbAm8AChY=;
        b=B3VuUrCPXYpqko0QYumGcNMUcl2LhhNpt8HxgSsn0nP4Qj3gxIGutfehwIrE/9CNMq
         Y/x74jvwoJ5LfLkSBRpe9Ody0Qe/J7PVA5YgG84CwXB6883006LkjTHM/BKvJ5Ghkbp8
         cqFcByfJzSDo8FoE6q4ujiKJd2RwGPWB9kUNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2yelZaQQgNOeM3tNL1ucPE8YNMsnU8lMoKbAm8AChY=;
        b=jMIGVNEyDpAeHchnmXOrZPmusVHauFfjnF+oI5/vJ/OEDNKCwtDrKAv3Qqa0tGvdBg
         NcnhevEcZwpUDa1qOtREcgGpAd1baBrZeDLFADrD8qgsEQ1wSahoiJFcYc0TJrWN763S
         zGieF6ngB/J9MqWHTXRTAnSzZpeJdwv2b8ppHjne5iayY55rC5FtnMDf+zRCfXfO4Alq
         bLxsZfsvZZxahI2eGMXMi+p4EtKgqeAmk3e0tLJhnWhRdGeaEGQva6Ln/uWibtRW4ImR
         ttdjoMBLZxOZk6ZxMkMQaBT8jyiCWc/j2D5r2LOiBweXuXYKNPAWEuWAPv55MI3w/z4H
         5Msg==
X-Gm-Message-State: APjAAAXBLeEnDgoZsITSUBlYXrGWA7w8HHYC6Ugd9DNTAOPDzB7SMBBu
        H7kQm+TO7pAxx3N4laKwr3wJJQ==
X-Google-Smtp-Source: APXvYqyY9z+bVXK367r0PSgo655xMFstBXHta7tC6uhSnr685D0+632U3Kq50X7yvcGVAdjr9dTt6w==
X-Received: by 2002:a02:b882:: with SMTP id p2mr11801092jam.16.1567797834689;
        Fri, 06 Sep 2019 12:23:54 -0700 (PDT)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:0:92f:a80a:519d:f777])
        by smtp.gmail.com with ESMTPSA id h70sm10931804iof.48.2019.09.06.12.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:23:54 -0700 (PDT)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Bruce Wang <bzwang@chromium.org>,
        linux-arm-msm@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/6] drm/msm/dpu: Remove unused macro
Date:   Fri,  6 Sep 2019 13:23:40 -0600
Message-Id: <20190906192344.223694-2-ddavenport@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906192344.223694-1-ddavenport@chromium.org>
References: <20190906192344.223694-1-ddavenport@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 4c889aabdaf9..6ceba33a179e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -139,10 +139,6 @@ struct vsync_info {
 
 #define to_dpu_kms(x) container_of(x, struct dpu_kms, base)
 
-/* get struct msm_kms * from drm_device * */
-#define ddev_to_msm_kms(D) ((D) && (D)->dev_private ? \
-		((struct msm_drm_private *)((D)->dev_private))->kms : NULL)
-
 /**
  * Debugfs functions - extra helper functions for debugfs support
  *
-- 
2.20.1

