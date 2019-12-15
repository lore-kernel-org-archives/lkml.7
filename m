Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6B8C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AFD206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="k9UFG8SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLOSj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:39:58 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45658 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLOSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:39:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bY9S4fVVz9vZ5m
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b-cHsML4a5R8 for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 12:39:56 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bY9S3F2lz9vZ6L
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 12:39:56 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id 7so4856018ybc.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+KGvwvA/QLzHWvp6n2dKVOBnMZ8T8c04n2Q8O++CA0=;
        b=k9UFG8SIcRKaX4Q2iSTbtora6HGKeDMpq1Gl7bDKhRSLYwEv55fyevMBuftxXYBvM9
         mwVbBP2zzaVpB26jKOLryFH2LUR8U2/ljiWua+dMHn6BfHYt8M5UysZBq7kSkAd0LaHG
         HSZYrpgFyGOcud4VqxASd1VkQpyDyJH2Uz2cd7fJ2NHT6n607isZZfA1In0qDcXD+RGO
         D8j51XSAWRNKTS+9w/dxT6kH/J+Rpq9XxNsRRCvfpVClgOfVhE22ptfPpFv2Wmx7Ajt+
         MTP5ka1ORNG6rL2Z/8hvsXsHl2sE/FwJqGmAPEdnC7J5SMkGfGdD32S+ePhtHxLV/ck0
         wI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+KGvwvA/QLzHWvp6n2dKVOBnMZ8T8c04n2Q8O++CA0=;
        b=Il0+Cno4jmuaegU0M2WwyqFELlXDUUfm0PzsgwCMHzmT0VORUBdap8zn28DwcGbpdn
         0T2nU7PI4u/UQCjzjIYN4kdPBwI3KOXZT+ycYBcsAf0zmF5u1fY+hEwV885TJihR2IKH
         hQXm6/Kl7/m24mgUiV4AnqcKrfDwcj/hHPiG5MB2mHP5VlvU6U74pv8YH+PUCyy9tkuG
         Or4JOKSO8kxu3pxewLncnMonxKWe8soZga8QOVYlP61Ri2A8pYNCaShkCH7L6AnblJk4
         eY+x0osbiX/DhB19pz0LF2+anNyRnV7OMy0cmjnCIWFWDirPp4iFP/bz4YEVAO8TKhH5
         GiPQ==
X-Gm-Message-State: APjAAAWkkniXqmzdokeWIn5/VqPaGV2LMrVg0z+iX2yVXNCDJt6lQ7x0
        GfiRvsxd+a5FAh8XO7dFLPwksBbQNk5dZ+DTYzf/fnTVvDhGSlkdDfrCitP5yPwmPPUj4APGVwR
        9pCacb+QP1ha8HcZDCO0leDfOjvBm
X-Received: by 2002:a81:6084:: with SMTP id u126mr16439883ywb.97.1576435195932;
        Sun, 15 Dec 2019 10:39:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwj2HFxz2fPas9IoLih/XHlVctmKxdKuWBWm3U9W2JlelS+XBP+BNvOtNVMi5xtiygok2RAFA==
X-Received: by 2002:a81:6084:: with SMTP id u126mr16439870ywb.97.1576435195705;
        Sun, 15 Dec 2019 10:39:55 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id n142sm5873159ywd.26.2019.12.15.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:39:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: replace multiple BUG_ON assertions with error return code
Date:   Sun, 15 Dec 2019 12:39:52 -0600
Message-Id: <20191215183952.689-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various register operations check for the validity of cache_ops
struct and crash in case of failure. However, by returning the error
to the callers, instead of assert, these functions can avoid the crash.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/base/regmap/regcache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index a93cafd7be4f..855fa25ae595 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -238,7 +238,8 @@ int regcache_read(struct regmap *map,
 	if (map->cache_type == REGCACHE_NONE)
 		return -ENOSYS;
 
-	BUG_ON(!map->cache_ops);
+	if (!map->cache_ops)
+		return -EINVAL;
 
 	if (!regmap_volatile(map, reg)) {
 		ret = map->cache_ops->read(map, reg, value);
@@ -267,7 +268,8 @@ int regcache_write(struct regmap *map,
 	if (map->cache_type == REGCACHE_NONE)
 		return 0;
 
-	BUG_ON(!map->cache_ops);
+	if (!map->cache_ops)
+		return -EINVAL;
 
 	if (!regmap_volatile(map, reg))
 		return map->cache_ops->write(map, reg, value);
@@ -343,7 +345,8 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
-	BUG_ON(!map->cache_ops);
+	if (!map->cache_ops)
+		return -EINVAL;
 
 	map->lock(map->lock_arg);
 	/* Remember the initial bypass state */
@@ -412,7 +415,8 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
-	BUG_ON(!map->cache_ops);
+	if (!map->cache_ops)
+		return -EINVAL;
 
 	map->lock(map->lock_arg);
 
-- 
2.20.1

