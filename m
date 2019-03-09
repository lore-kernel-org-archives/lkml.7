Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D661207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="o70jP4HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCIEgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:36:36 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44906 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCIEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:36:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 926C6C54
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id up3SdHqNrerY for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:36:34 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 659B0C50
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:36:34 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id f10so17322991ioj.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5EBNWyDGWnAVj4iLKUewwS1+tz2VaAgfJqux1s/2vVY=;
        b=o70jP4HMLv8o2ZdMnPdJyJG4Juux0D+7xZ8H77QaW0+ANX73lsMiaasD75KkwZeL1i
         rwJiGVR0E1pz7ZXTlLbxi2YmsYycxv9nh8DG2dApw6zWn/o4zDtKKa4c9ggG4zxUGGCO
         3EqKTy9ob7DwzQPdgC8FxfBD04FnhyFfWRtSZ9TyKj9jb+CpXTmEZoxLDHzrJKv1kOFI
         CPPm1j6bloXOjjgy3l1DX82abgcrJ8Sy74EDnQ29tcq0lBeeV1+DJewDWDRTYeVaTeZJ
         Hs0fmZYDuEKJRIHbr1KQmiyyvzf/ncVbRq1412cayHWO+KkcwTVaUaFdzyKR8XUzXlTd
         0U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5EBNWyDGWnAVj4iLKUewwS1+tz2VaAgfJqux1s/2vVY=;
        b=RZ1PLezMbCjLHrrKeZ8+IGkUAh362M+ewAt1DvwOPCSrAlvDttXjuKl3PAyIuY5/+P
         JOrfNMEjxv5OkONnZwjdoDVXQB4uDIu/MhEpTSLuOMvuK5s9xGJTyekM1L1xopCXcDEU
         MXtb2v5kjicNI5Lyc49BEowyd8QqWG1hXLYv04bV8vea9q17dqDhnSfyp5t2zFU3cEyR
         YRcQCRWz1hA6XFgkXSJ/8Q0Gxb0CNqaBMASyl5rx6cgEHEuEXg4kaIQhUhzMcBgKBGOw
         KbLyPnXUGO/LmWmPbG5IKq2yDy7gR5T0nJakId3YgiEshWr41PYIxarFpmfqQ3aQ7D1y
         B7iQ==
X-Gm-Message-State: APjAAAW2mrjRv9jHZXvAEYeT5YCLBnxig60eGMLKe1p+jax7NI8YqJjp
        RNIRswtk0yeonovS4lfqWaKG2DGquvWOSNtswEgEFqB+k2tfVkS4B5h9HQHr5kdu+Xj6zXOlbGr
        UwIV+mvNRa4apQgWmwtp0ADbz0+VJ
X-Received: by 2002:a24:45a3:: with SMTP id c35mr9915124itd.37.1552106193968;
        Fri, 08 Mar 2019 20:36:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJPZ8OafeWWkXOW2wuBXoCOz05yw+Z74MS/ux6YSt8VG6jkAUTy3j/AsjDLlbUTMKVzlUteQ==
X-Received: by 2002:a24:45a3:: with SMTP id c35mr9915118itd.37.1552106193744;
        Fri, 08 Mar 2019 20:36:33 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o9sm5019911itb.23.2019.03.08.20.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:36:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: vkms: check status of alloc_ordered_workqueue
Date:   Fri,  8 Mar 2019 22:36:27 -0600
Message-Id: <20190309043628.6078-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_ordered_workqueue may fail and return NULL.
The fix returns ENOMEM when it fails to avoid potential NULL
pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 8a9aeb0a9ea8..bb66dbcd5e3f 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -219,6 +219,8 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	spin_lock_init(&vkms_out->state_lock);
 
 	vkms_out->crc_workq = alloc_ordered_workqueue("vkms_crc_workq", 0);
+	if (!vkms_out->crc_workq)
+		return -ENOMEM;
 
 	return ret;
 }
-- 
2.17.1

