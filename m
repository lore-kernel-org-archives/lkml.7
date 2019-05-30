Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A0DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16E7218A0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191943;
	bh=s0wBWtgYE318EaqqrCjsUgJ0uwxKN+S1DPkUv/m9A20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsyZ8tZkDF43b2pkElJD5ACbwJHGEd85NsGYugh5x83w64tW5rvrpuvk3jNPnLVLc
	 tzB6Pjhg8RV0NovQ3h6C957B2Ode+dqIm0iIWXEVXLcwz6KjOAkckoRMIqxf/yj20y
	 zKm1cWPG5XCBY5kKXPiKRIQbPhcY3h+x3jofVoKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfE3EwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfE3DKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:49 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D378124481;
        Thu, 30 May 2019 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185848;
        bh=s0wBWtgYE318EaqqrCjsUgJ0uwxKN+S1DPkUv/m9A20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fx5P+u5xWyrN7cVD5GmC1FEXFwmgEo0DeHxqtwabfLJWT7ttCYYIlXXCv+DL4ixKk
         WaD1sXPRd/WFjKS+bRPGEIao8a3A0ZR1wF530dZfQYhPRlKFVeGqTer38LMRBmYfKD
         1Z7X8x4y4tKpogRFvuVLQnsQL8tCh5BCL7zPKpqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        kbuild test robot <lkp@intel.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 171/405] staging: vc04_services: handle kzalloc failure
Date:   Wed, 29 May 2019 20:02:49 -0700
Message-Id: <20190530030549.777012849@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a5112277872a56017b777770e2fd4324d4a6c866 ]

The kzalloc here was being used without checking the return - if the
kzalloc fails return VCHIQ_ERROR. The call-site of
vchiq_platform_init_state() vchiq_init_state() was not responding
to an allocation failure so checks for != VCHIQ_SUCCESS
and pass VCHIQ_ERROR up to vchiq_platform_init() which then
will fail with -EINVAL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reported-by: kbuild test robot <lkp@intel.com>
Acked-By: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 3 +++
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index dd4898861b833..eb1e5dcb0d529 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -209,6 +209,9 @@ vchiq_platform_init_state(struct vchiq_state *state)
 	struct vchiq_2835_state *platform_state;
 
 	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	if (!state->platform_state)
+		return VCHIQ_ERROR;
+
 	platform_state = (struct vchiq_2835_state *)state->platform_state;
 
 	platform_state->inited = 1;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 53f5a1cb4636e..819813e742d8a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2239,6 +2239,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	local->debug[DEBUG_ENTRIES] = DEBUG_MAX;
 
 	status = vchiq_platform_init_state(state);
+	if (status != VCHIQ_SUCCESS)
+		return VCHIQ_ERROR;
 
 	/*
 		bring up slot handler thread
-- 
2.20.1



