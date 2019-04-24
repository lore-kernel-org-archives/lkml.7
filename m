Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12088C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B9A21909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126035;
	bh=GSYMZxK0y/BAsiCUrBWRSv70SfsotYItdUj8S54sI/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y96zcaQGwL2YDK3KwRtjYdpGGgb3RoL3eYdN1clHn5nBPA5/TBQswUr0Z5VehAIZl
	 K3LQ0kzWUjF5u50dh5jl3FaV2PKE/MlSJr5k9XAwyPqsaWCfhCLRtfTzgmhvGo+O/8
	 Z8h9PZ0DtpZisDz2EiOOgTaEPJgKQREwZh2vhyAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfDXRNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbfDXRNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A877421907;
        Wed, 24 Apr 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126031;
        bh=GSYMZxK0y/BAsiCUrBWRSv70SfsotYItdUj8S54sI/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrNF9o28q6iDcz7MrJb7rXoHsBN6a6Bhti82hilkxmT50tY5MF6SdX6r0vPSH7Mio
         njocsjM1pQncZ/pAbbreSpNmZI4QgY3yJM29eZvBXVaEwi1n4PVDhE21Om4h2BZUj6
         X5FEkZrB9Fqplg6Hksx0goRrchONdhcnUFn1K4+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 068/104] thermal/int340x_thermal: fix mode setting
Date:   Wed, 24 Apr 2019 19:09:25 +0200
Message-Id: <20190424170905.116475724@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
index edc1cce117ba..7b96b20e939a 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -208,10 +208,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
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



