Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7E0208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564579771;
	bh=tAYia5FODMD+odiu8UavRmySSPzn+nsY1ywzHUvW6xE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Rt29e2AGapenCnbfMWS8G8t6IIzj1u87kI3g6EyIUOwFbW9qvrcE4nrp9FfBjgOQY
	 Q1Bnde2aDu4GMhXh3J8mYP9QB4nFXjRz1qJT8RO77agacTLIuHtPNpxD9GWwjGOLi7
	 BVn+/EcwRr8l48Pr80evEXewEqqKJQqT9RqHftWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfGaN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbfGaN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:29:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA28208C3;
        Wed, 31 Jul 2019 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564579765;
        bh=tAYia5FODMD+odiu8UavRmySSPzn+nsY1ywzHUvW6xE=;
        h=Date:From:To:Cc:Subject:From;
        b=MQy7yTdwV+w/PATIvuzBfvLkMay1oYYDKzisKEWBb1Zti0BGyQ7PMMp0afuxIfYpV
         CCLkCQ2qspKhSkk5W3+qFrDjgfkt3yFlGNPuy/kgim246kWeI/pOhuS/zT5sRmX1ay
         0d/WyvAEFzlwqHryhS7IwVcCneR2HciARebyysu0=
Date:   Wed, 31 Jul 2019 15:29:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] regmap: no need to check return value of debugfs_create
 functions
Message-ID: <20190731132923.GA13829@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

The debugfs core will warn if a file or directory can not be created, so
there's no need to duplicate the warning, nor really do anything else.

Cc: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 5.3-rc1
    updated changelog based on debugfs now logging errors


 drivers/base/regmap/regmap-debugfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e5e1b3a01b1a..e72843fe41df 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -588,14 +588,6 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	}
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
-	if (!map->debugfs) {
-		dev_warn(map->dev,
-			 "Failed to create %s debugfs directory\n", name);
-
-		kfree(map->debugfs_name);
-		map->debugfs_name = NULL;
-		return;
-	}
 
 	debugfs_create_file("name", 0400, map->debugfs,
 			    map, &regmap_name_fops);
@@ -672,10 +664,6 @@ void regmap_debugfs_initcall(void)
 	struct regmap_debugfs_node *node, *tmp;
 
 	regmap_debugfs_root = debugfs_create_dir("regmap", NULL);
-	if (!regmap_debugfs_root) {
-		pr_warn("regmap: Failed to create debugfs root\n");
-		return;
-	}
 
 	mutex_lock(&regmap_debugfs_early_lock);
 	list_for_each_entry_safe(node, tmp, &regmap_debugfs_early_list, link) {
-- 
2.22.0

