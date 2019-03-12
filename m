Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C11A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413062;
	bh=y65EJ3JNMl9LFnKobiDtG6W2gFhgJovHgL0IGEZBQNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNk8JKETWXjqDX6d5h+odl9qalFoI4j7hl6hGgZU0oJX3uxcbmWj/qDYkJKrvwOdT
	 SQ08iCLBIEleuagNKcZzCLIz5A3oU+NB3AxqCxoFYNlB+HTnjd6yvTEryKJNdelXF8
	 kDuBksVJ2yO3hIgEXaf7hWOs+PKmVTV/d9yX8s2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfCLRu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfCLROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:40 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C9321850;
        Tue, 12 Mar 2019 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410879;
        bh=y65EJ3JNMl9LFnKobiDtG6W2gFhgJovHgL0IGEZBQNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9A6cHw3oBMTbxiWj+Z0ekIrbKNjGUDbv17xR5Yr+LoMCvvhX1X5ufY72ZeIyZt+X
         lZPcssrsPY1hMlbQ044ICa7tDGsjRoDpijM9yPkPUQGbi3Kaxa4o3t3Yta2S+UGTYG
         frPuOnQ/BmJHxFrtuzIw6xaK7zbu1XoAQ6KivCoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/149] drm/amdgpu: Add missing power attribute to APU check
Date:   Tue, 12 Mar 2019 10:08:23 -0700
Message-Id: <20190312170356.868660175@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dc14eb12f6bb3e779c5461429c1889a339c67aab ]

Add missing power_average to visible check for power
attributes for APUs.  Was missed before.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 7b4e657a95c7..c3df75a9f65d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1443,7 +1443,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		effective_mode &= ~S_IWUSR;
 
 	if ((adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
 		return 0;
-- 
2.19.1



