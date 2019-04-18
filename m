Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD474C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59E5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610844;
	bh=nG4pVa9jMLB6NoMhhciXMQjdQm5NXSzrGTo7He0y9yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=twj3ORkzUPPyhc/B+Fg1uulyGyJDgA6wbdLbZcJBPu+1N/k4lxIHAOiHOqXKsZtvr
	 ZprmNNClj0rYAc8TB/iGDwV0b914+CHHIC/UngQeNtk7b/ZUKYsFxPB0CtsXwL2ckH
	 M/530DCxDBVgG+BZPesXy0s8izOHihQL9G1qQa9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391627AbfDRSHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391591AbfDRSHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE6E218A1;
        Thu, 18 Apr 2019 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610839;
        bh=nG4pVa9jMLB6NoMhhciXMQjdQm5NXSzrGTo7He0y9yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOZs6qTqqwjWeeMKYAkyFnZ/CV9zZpKsmZ7Fx3m8SxBuJM4MBbubExZneydqcMm1m
         QUpSb6tCJTwGfnlI+7Zx7kCbxoo5OH/Fhr7X0MUgR0zGEwzW74R4NKZVqQE4hg0WoB
         8DrT7pD2ZMoeV8kLne9EDhcib2J2ZC/xDBvbwkug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 11/50] thermal/int340x_thermal: fix mode setting
Date:   Thu, 18 Apr 2019 19:57:22 +0200
Message-Id: <20190418160424.145484894@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 396ee4d0cd52c13b3f6421b8d324d65da5e7e409 ]

int3400 only pushes the UUID into the firmware when the mode is flipped
to "enable". The current code only exposes the mode flag if the firmware
supports the PASSIVE_1 UUID, which not all machines do. Remove the
restriction.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 0beed2899163..d4c374cc4f74 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -285,10 +285,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
-		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
-		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
-	}
+	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
+	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
+
 	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
 						priv, &int3400_thermal_ops,
 						&int3400_thermal_params, 0, 0);
-- 
2.19.1



