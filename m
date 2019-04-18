Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B92BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E100020643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612110;
	bh=+0inN8gUe2FylcsDvIjfRKuStoWFDo7sUr9OEPrnYAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q+7xKWj+QWia7iMZeVDe8DcGh3+lnZHfY2bEgTepcR0lHbS1wMKrmkthXjq5TXvoq
	 wg5P02qq7L5oT8z8ruKicLgWoQ+VCRXyrS70wUNwQKC73RvNnH85Wsv/HJzjj/7Az6
	 LBLKZxZlLQDmen/yOVF9cMkxkG6s8rB0WEhSYt/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbfDRS23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390922AbfDRSD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49436218A6;
        Thu, 18 Apr 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610605;
        bh=+0inN8gUe2FylcsDvIjfRKuStoWFDo7sUr9OEPrnYAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqgsU/6O9NxiviuTG1jZdTdnMZgzCmHCqYiFOlm+cq694QgHkYp4lMg2orAM5K6eO
         YSz1TkdATmFXszXAR7qCfC6nWBZZUJrBfI+ksFPbPKrlN5oJQJAwF6dPqLqE3EHZfq
         VttR0yZid/AwYlC+v9YWgqi/6UMBdE5iEEmNDa2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/92] thermal/int340x_thermal: fix mode setting
Date:   Thu, 18 Apr 2019 19:56:33 +0200
Message-Id: <20190418160431.693058597@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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
index 34dc4d6dda66..4a20f4d47b1d 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -316,10 +316,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
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



