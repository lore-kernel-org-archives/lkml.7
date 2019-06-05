Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88035C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7DF20848
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nT9boljz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEB1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:27:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46201 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEB1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:27:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so13784402pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJtfhF/jan9MFN0Fy8lkZ8iPN2kyqz+fwLX3VfG1VbE=;
        b=nT9boljzAsdRdb4xVt+qaiSCFkAJL57bnv8hPY2Cyi3A6FO+premfKjakZH3riLP3j
         4DSOMSPLXIWfU0XP0Xtg+mH/nOELRbcfFdLZS2g5KUaqi/qiYoS8aF4ffPs0JCAKsyzk
         fH9nmwUvSnqSYdU9Zy3B8TqAnFtPl2pQ/4AAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJtfhF/jan9MFN0Fy8lkZ8iPN2kyqz+fwLX3VfG1VbE=;
        b=Dw6+lOEVpLT5kfmJschYFs2BHGec5Urj0jp2kqx+UFjPe4qmWv54T/cYw/3A8CPDJh
         22LJWAUfmVxqq8+61gCa5/UUB87ARQqrSwN+0QekNwAPG9PteGdfz/H4Not7rTmqKVYY
         ONYQeNZXQO2+3e0mSyjVB7wqCIpQYxAZdxwbm2kmYVdhBhYCL0L8G9XpW9SRoc/U3MSL
         wlB5JKV8TIRQND++4xu2A8NRaskreculsbEuYditV0JJPLsSPud0DOF11vLNCaDMdzZo
         US2yiuUx2lp7Ml1SyaM52EXfZjX00LVRCkzabrsQ7op/lg6TVH3slniAo5f4JXX2pd0C
         wqug==
X-Gm-Message-State: APjAAAVWQy7trlK+8qc8peDeELBIV4ogqLjhZCovwtoi4o7xvr+VwxHG
        Eca3IHbBBHeLWV5RJ+Xu2OtW3w==
X-Google-Smtp-Source: APXvYqymN0aygxYP0wHuBAqqZ1M4aTQmZjzWnNa5+ogxdCIiuIlQn3m8FG8z2ePrhGkSd4ca2YXllQ==
X-Received: by 2002:a63:5014:: with SMTP id e20mr772739pgb.2.1559698051803;
        Tue, 04 Jun 2019 18:27:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r77sm24391066pgr.93.2019.06.04.18.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 18:27:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH] dm init: Remove trailing newline from DM*()
Date:   Tue,  4 Jun 2019 18:27:29 -0700
Message-Id: <20190605012729.30770-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These printing macros already add a trailing newline, so having another
one here just makes for blank lines when these prints are enabled.
Remove them to match style of the rest of the uses of the macros.

Cc: Helen Koike <helen.koike@collabora.com>
Fixes: 6bbc923dfcf5 ("dm: add support to directly boot to a mapped device")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/md/dm-init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 352e803f566e..54b78c68bf0b 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -272,7 +272,7 @@ static int __init dm_init_init(void)
 		return 0;
 
 	if (strlen(create) >= DM_MAX_STR_SIZE) {
-		DMERR("Argument is too big. Limit is %d\n", DM_MAX_STR_SIZE);
+		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
 		return -EINVAL;
 	}
 	str = kstrndup(create, GFP_KERNEL, DM_MAX_STR_SIZE);
@@ -283,7 +283,7 @@ static int __init dm_init_init(void)
 	if (r)
 		goto out;
 
-	DMINFO("waiting for all devices to be available before creating mapped devices\n");
+	DMINFO("waiting for all devices to be available before creating mapped devices");
 	wait_for_device_probe();
 
 	list_for_each_entry(dev, &devices, list) {
-- 
Sent by a computer through tubes

