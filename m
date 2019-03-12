Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA87205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413875;
	bh=zS+o/Ak2pbRc5HuR858ZcOCRhoY/hOpwuPOTTaoBeC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZ6zy9NWkZr/0L4Ub6AFlyKQ4LvZq0yR4uJ3kRE/qv5nNLCZYSxIH1yW5w8APs214
	 vyS3bfJ+hwcFOuNPIFypUcJF2NKtw8qri27SnAHRZriYdyMGBxKDzdHK+BejMwR0hk
	 lACGPFvNch1GXOOF84vHZLVWc2YFjhbkPB0sO7VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfCLSEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfCLRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:47 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5402171F;
        Tue, 12 Mar 2019 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410767;
        bh=zS+o/Ak2pbRc5HuR858ZcOCRhoY/hOpwuPOTTaoBeC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zurva/IxZ1Di/c3qwJzfxcOo/pqKGAOhDKVCGAOU5hJWsM+a1yelvuA6yjORwqlBT
         YqGIRKiMfSL1P7rlnT6H2ZlsErlafOLROZgZm0GRrjoOGGAXx+vgnXbrCciOQcpt58
         omMi/HIyXYjBrtsa6jXOdbcGUQPLc7HqxtGwz/pY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 101/171] drm/amdgpu: Add missing power attribute to APU check
Date:   Tue, 12 Mar 2019 10:08:01 -0700
Message-Id: <20190312170356.770786892@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 59cc678de8c1..bbac15fd8caa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1671,7 +1671,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
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



