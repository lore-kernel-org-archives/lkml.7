Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB6C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13E820637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0uoT9B7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfLJWLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:11:11 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42733 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLJWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:11:10 -0500
Received: by mail-pl1-f201.google.com with SMTP id b3so586478plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b73r53Ks39MzD1p7Mnxh3aUtTHdkJg2TG1gTQXCA0JA=;
        b=i0uoT9B7VkzZLco87pN4yTJXrhjzrCyboyzAodwErTl0USjyKxQpB8BzII9F79iW5Q
         StJAIzVxBqZBcrl61TgA0+Xjrodo4IBl2vMz9KUV1XjHxjmrRVLhRZwkNmgun+G2244b
         672pjof/K4JjBwR+7wFlGQzL8CepOAOffo4t9eGjXSsRk+R8pIpb3y3WM1ZGatYVqoh6
         n9ZaZiJ1rnLaTy+QLc6aSkhDKvipXqctmsMdXZM2oYgN3j+BYFQ4mok4xCtYYdVB4pov
         F1gaQm0kN2iKRNPeaCrl+d3NAzFOHghLUAkV7ZA//lAPjircz9IcwetG+vyx9pKIDapk
         WioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b73r53Ks39MzD1p7Mnxh3aUtTHdkJg2TG1gTQXCA0JA=;
        b=mMu56K6zTPO/b1V7unVsQIDVTl+yzB9V7vVVAPH+0OfdfrIZqnTOvDFkHD9ZZaQJs5
         3TbbqkyGLkbffGJZtexL+pMTasNZ5wLmzTPe7bOyA0V1mtqJyCev7RtRJ4KN36bK6ubt
         SsAHN/p+DQ3gKMFJ6Dv/I5WVseRdR/xxe62NQfPGvjTJHt0sJQsiXlPa/3/hfgDpZvb4
         Lc4RqHF4Dahp1oFMRHZMT+lrwBSYlcYVlmz3FtP46h7PFf1RAYIaU+r0MjQSWYXb9cfw
         tF2BJPNYfwh4pETbwD/AcTKmBIB6txCp/lKnqpaQocote9gmg80j7XW+apXqqVlKQFtN
         s+Sw==
X-Gm-Message-State: APjAAAXbNQjyOX+PFd7d/BldyWer66gFIGuYckrqU5ESiXHw4FMgS2F9
        HojPk8bZw55Y+XqVK6vLERuqp062hD45oVe/aVyHoA==
X-Google-Smtp-Source: APXvYqxIkhq83HNF7Fpw49kmXHGQa5sYZO4wUfdhjjk6/E84bpG99rvKGJ2oOA55p8kIVLS2Md1/2sQ489DZZWBwOZ50WQ==
X-Received: by 2002:a65:6249:: with SMTP id q9mr405022pgv.340.1576015869302;
 Tue, 10 Dec 2019 14:11:09 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:10:48 -0800
Message-Id: <20191210221048.83628-1-thomasanderson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH] drm/edid: Increase size of VDB and CMDB bitmaps to 256 bits
From:   Thomas Anderson <thomasanderson@google.com>
To:     "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>
Cc:     Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Pau <sean@poorly.run>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Anderson <thomasanderson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CEA-861-G adds modes up to 219, so increase the size of the
maps in preparation for adding the new modes to drm_edid.c.

Signed-off-by: Thomas Anderson <thomasanderson@google.com>
---
 include/drm/drm_connector.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5f8c3389d46f..17b728d9c73d 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -188,19 +188,19 @@ struct drm_hdmi_info {
 
 	/**
 	 * @y420_vdb_modes: bitmap of modes which can support ycbcr420
-	 * output only (not normal RGB/YCBCR444/422 outputs). There are total
-	 * 107 VICs defined by CEA-861-F spec, so the size is 128 bits to map
-	 * upto 128 VICs;
+	 * output only (not normal RGB/YCBCR444/422 outputs). The max VIC
+	 * defined by the CEA-861-G spec is 219, so the size is 256 bits to map
+	 * up to 256 VICs.
 	 */
-	unsigned long y420_vdb_modes[BITS_TO_LONGS(128)];
+	unsigned long y420_vdb_modes[BITS_TO_LONGS(256)];
 
 	/**
 	 * @y420_cmdb_modes: bitmap of modes which can support ycbcr420
-	 * output also, along with normal HDMI outputs. There are total 107
-	 * VICs defined by CEA-861-F spec, so the size is 128 bits to map upto
-	 * 128 VICs;
+	 * output also, along with normal HDMI outputs. The max VIC defined by
+	 * the CEA-861-G spec is 219, so the size is 256 bits to map up to 256
+	 * VICs.
 	 */
-	unsigned long y420_cmdb_modes[BITS_TO_LONGS(128)];
+	unsigned long y420_cmdb_modes[BITS_TO_LONGS(256)];
 
 	/** @y420_cmdb_map: bitmap of SVD index, to extraxt vcb modes */
 	u64 y420_cmdb_map;
-- 
2.24.0.525.g8f36a354ae-goog

