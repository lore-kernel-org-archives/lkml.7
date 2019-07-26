Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28CCC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AAF22CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfGZJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:26:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfGZJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:26:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE30A344AC963379B5BE;
        Fri, 26 Jul 2019 17:26:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 17:26:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <eric@anholt.net>, <wahrenst@gmx.net>,
        <gregkh@linuxfoundation.org>, <inf.braun@fau.de>,
        <nishkadg.linux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] staging: vc04_services: fix used-but-set-variable warning
Date:   Fri, 26 Jul 2019 17:26:21 +0800
Message-ID: <20190726092621.27972-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190725142716.49276-1-yuehaibing@huawei.com>
References: <20190725142716.49276-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc used-but-set-variable warning:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
 variable local_entity_uc set but not used [-Wunused-but-set-variable]
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
 variable local_uc set but not used [-Wunused-but-set-variable]

Remove the unused variables 'local_entity_uc' and 'local_uc'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove the unused variable
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cc4383d..b1595b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2824,7 +2824,6 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	VCHIQ_STATUS_T ret = VCHIQ_SUCCESS;
 	char entity[16];
 	int *entity_uc;
-	int local_uc, local_entity_uc;
 
 	if (!arm_state)
 		goto out;
@@ -2849,8 +2848,8 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 		ret = VCHIQ_ERROR;
 		goto unlock;
 	}
-	local_uc = --arm_state->videocore_use_count;
-	local_entity_uc = --(*entity_uc);
+	--arm_state->videocore_use_count;
+	--(*entity_uc);
 
 	if (!vchiq_videocore_wanted(state)) {
 		if (vchiq_platform_use_suspend_timer() &&
-- 
2.7.4


