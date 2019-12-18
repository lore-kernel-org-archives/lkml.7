Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD7CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03572176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LBGI1dSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLRQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:15:12 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50658 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLRQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:15:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47dKq34Qn0z9vZKK
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cP9ctpI1q9vi for <linux-kernel@vger.kernel.org>;
        Wed, 18 Dec 2019 10:15:11 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47dKq3353mz9vZKR
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:15:11 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id d198so1629885ywa.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOckGjyMkemghi3Y5ghPJ9HepPoz/TI4eTpGQv8uuB0=;
        b=LBGI1dSL721DXiRMdlxO9OgIC+cHa4/bWDIWiGuVIsT9SfjGy0VWgwRkdoaO77FrRk
         kjevZwS20wMMcfEN20PAYvJW2YQeRONsrBRBtYO0XtSYHVYkNlxfgDHzXUQArkqQHStA
         lYclFosKI7BEg3XeENJCDP1nAD9G3FRBAu/fM70AukXjilg141GzlehLzKwUPOW6xHxv
         mXbFx+I4D1C0YITIcmwCFM82yUQiOY4DMj9u8gaHO7GdDgQ3E9cbSSIKc9C0SE8M+G9N
         9PUAPWPEdhJLBESLDgy9ddw6/RUav14ZuinIuXrCUxemaXie9FsYBGEwjdahpeIXcetP
         xx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOckGjyMkemghi3Y5ghPJ9HepPoz/TI4eTpGQv8uuB0=;
        b=ntVMvpb1oqDaVfUjD9im1epMdQZGs60o6y+WweyHbKCT4IkNm3NDENtWi661HKamKm
         yWheovo+LaMKqArdHtxwpLM6ZZc2QhMv1nBGw0blOTF8FmTV7eu9e91KrRVFHHwqAJY+
         xCKngR/v4zfGES3zFJLeZCfrH79KshsE4jYvrJ27DJVUr3P05DbQlZgnIH+NseK8BMYb
         p7ES365ckuzbXbAt9Zzi6ai/3ViOfvgYcIdwCOTZSNDPQoekS67xvjWa7uUdfZB/shb2
         46Fs3b3YBE+eTDrhC39V40b1CimCcmKJYCc2nlYT2Krt5H5v4qMq3QXHNE9dSfqK7SIp
         YH6A==
X-Gm-Message-State: APjAAAW3G1ZmnWIxLp1w3TBBGZf2/iAoZG8kZqwHGvRCj9SPah1AI0EY
        NsEPvWFDzD0xL+UkLe6/1AXbYAPgzrDkF8ce0POnTXUx6jAPGrZ/djo4E5XrkCX2dvHZNsZTwP5
        ZLoLdDmeRRKureYa4rtlbioHd519K
X-Received: by 2002:a25:33c2:: with SMTP id z185mr2694550ybz.477.1576685710902;
        Wed, 18 Dec 2019 08:15:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXNkytcdMy0zBtt0dCkZST2hQpkfH7TiOeIocMwvlZuJgokwWfh/oIOnlpTBiFOFnKN+CPNQ==
X-Received: by 2002:a25:33c2:: with SMTP id z185mr2694522ybz.477.1576685710626;
        Wed, 18 Dec 2019 08:15:10 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id m16sm1034836ywa.90.2019.12.18.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:15:10 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: replace BUG_ON with WARN_ON
Date:   Wed, 18 Dec 2019 10:15:03 -0600
Message-Id: <20191218161505.13416-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In skip_modeset label within dm_update_crtc_state(), the dc stream
cannot be NULL. Using BUG_ON as an assertion is not required and
can be removed. The patch replaces the check with a WARN_ON in case
dm_new_crtc_state->stream is NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7aac9568d3be..03cb30913c20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7012,7 +7012,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * 3. Is currently active and enabled.
 	 * => The dc stream state currently exists.
 	 */
-	BUG_ON(dm_new_crtc_state->stream == NULL);
+	WARN_ON(!dm_new_crtc_state->stream);
 
 	/* Scaling or underscan settings */
 	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state))
-- 
2.20.1

