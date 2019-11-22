Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981520637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419658;
	bh=Z0bJMnUiULIar3u4GSZxW0PS+omYKWonl1kytRe6kjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HsaJ9fNFqc2hP31kF7aPtlktcaZBgR8Q/jg9H18B6e66u4kOLzTC0tdwVqVWt/fni
	 1S67yoozuvMWbYEbnVcTj8ECLtXvBkH9rvcL62QK1BrX1enhzXB4g2wZzlXvj0N0L/
	 jf2F5Owd0Yow/71txBGPsHQdOw07SAECohr3I5ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfKVKrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfKVKr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:47:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8FA2072E;
        Fri, 22 Nov 2019 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419647;
        bh=Z0bJMnUiULIar3u4GSZxW0PS+omYKWonl1kytRe6kjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGN2VZNgBIAA+QNcH7nz83JMTO/0KuWTm8R4a+waWtKgqTVGGXHHiJwDG9/2kB/i6
         HfX9ajlVygWPwq+hIBtvn4oTHs6dUQmePadVslfA15woFehlQDK6KMwOEqGn75USXx
         02ZaZIlAEYxtQXQNKDSPcwHh+/S3m0Y2PlVDkHN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 184/222] mtd: physmap_of: Release resources on error
Date:   Fri, 22 Nov 2019 11:28:44 +0100
Message-Id: <20191122100915.626051656@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

[ Upstream commit ef0de747f7ad179c7698a5b0e28db05f18ecbf57 ]

During probe, if there was an error the memory region and the memory
map were not properly released.This can lead a system unusable if
deferred probe is in use.

Replace mem_request and map with devm_ioremap_resource

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/physmap_of.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 3fad35942895c..7a716bed11580 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -29,7 +29,6 @@
 struct of_flash_list {
 	struct mtd_info *mtd;
 	struct map_info map;
-	struct resource *res;
 };
 
 struct of_flash {
@@ -54,18 +53,10 @@ static int of_flash_remove(struct platform_device *dev)
 			mtd_concat_destroy(info->cmtd);
 	}
 
-	for (i = 0; i < info->list_size; i++) {
+	for (i = 0; i < info->list_size; i++)
 		if (info->list[i].mtd)
 			map_destroy(info->list[i].mtd);
 
-		if (info->list[i].map.virt)
-			iounmap(info->list[i].map.virt);
-
-		if (info->list[i].res) {
-			release_resource(info->list[i].res);
-			kfree(info->list[i].res);
-		}
-	}
 	return 0;
 }
 
@@ -223,10 +214,11 @@ static int of_flash_probe(struct platform_device *dev)
 
 		err = -EBUSY;
 		res_size = resource_size(&res);
-		info->list[i].res = request_mem_region(res.start, res_size,
-						       dev_name(&dev->dev));
-		if (!info->list[i].res)
+		info->list[i].map.virt = devm_ioremap_resource(&dev->dev, &res);
+		if (IS_ERR(info->list[i].map.virt)) {
+			err = PTR_ERR(info->list[i].map.virt);
 			goto err_out;
+		}
 
 		err = -ENXIO;
 		width = of_get_property(dp, "bank-width", NULL);
@@ -247,15 +239,6 @@ static int of_flash_probe(struct platform_device *dev)
 			return err;
 		}
 
-		err = -ENOMEM;
-		info->list[i].map.virt = ioremap(info->list[i].map.phys,
-						 info->list[i].map.size);
-		if (!info->list[i].map.virt) {
-			dev_err(&dev->dev, "Failed to ioremap() flash"
-				" region\n");
-			goto err_out;
-		}
-
 		simple_map_init(&info->list[i].map);
 
 		/*
-- 
2.20.1



