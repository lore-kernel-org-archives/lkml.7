Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A068C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E7E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CJgG6CBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCMEmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:42:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3770 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCMEmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:42:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c888a1e0000>; Tue, 12 Mar 2019 21:42:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 21:42:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 21:42:07 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 04:42:07 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 04:42:07 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c888a1e0002>; Tue, 12 Mar 2019 21:42:07 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/2] bus: tegra-aconnect: add system sleep callbacks
Date:   Wed, 13 Mar 2019 10:11:59 +0530
Message-ID: <1552452119-6574-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
References: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552452127; bh=WRR71hPkQmLgshcD1yefwbv7DJo8tZeixRl5XRTixtI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=CJgG6CBAkr1TuyIPCSR7hganvb2VrlfjfeQIYQo2qzUT5B7KQwP6Oc84Y8ri13EWR
         P6ssfDUztQPnIKT4aullzZ9DQ3VKq1qtdjinJNcwUFHwXyaRwjqD5ShXbiMVcTe+Lt
         JRsu6B6ZGtFODekRO7KmCM2RMeRt7kQsIjPRgxHkwEq+JwJMJK6xMh3Vci3BCVqc4B
         Yd8uAAuqsbP1wsJPMXvGQ/l8YvzTUo9VMTkmdq7frgXq/poh+cSzrl6Q6DW2wikD0N
         /mrqtArpeG5prLOGF1dpFTljEze12N7g9s/pALJhr0vPwuHsw14pwwEnoo778FHfkE
         83W+9Rs+gXRng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_force_suspend() and pm_runtime_force_resume() are used as system
sleep noirq suspend and resume callbacks. If the driver is active till late
suspend, where runtime PM cannot run, force suspend is essential for the
device. This makes sure that the device is put into low power state during
system wide PM transitions to sleep states.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/bus/tegra-aconnect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
index 9349157..ac58142 100644
--- a/drivers/bus/tegra-aconnect.c
+++ b/drivers/bus/tegra-aconnect.c
@@ -94,6 +94,8 @@ static int tegra_aconnect_runtime_suspend(struct device *dev)
 static const struct dev_pm_ops tegra_aconnect_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_aconnect_runtime_suspend,
 			   tegra_aconnect_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra_aconnect_of_match[] = {
-- 
2.7.4

