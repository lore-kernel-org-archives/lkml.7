Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51235C2D0C1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289C9217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2jC46By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLGBDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:03:14 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36719 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLGBDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:03:14 -0500
Received: by mail-pg1-f202.google.com with SMTP id v10so4761752pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+IdXMXYjVavqAmN5NgAIFvnwk1QJqhlOL+roypy9i6k=;
        b=v2jC46By43DMIdJPFUpvxJi38u0+6Ud+FT3hnKjofkUJ1cL0JcKAkG8HkYj6T1WPjr
         C+3NBCz8mongITTYdonNJkUT5dqkf3tWpf0FshwsFrkHPBfUsPsTz3+MxsvnQ2B7p9T9
         p4QLAAFut7cfUi8l4+FkTHgR21v3mRvaSePnkPs/lKNT6MSyhlLPQPP8r8X7NQwz0e/m
         34crDb0LpLcn8FZw9PyHZX+7Y6LS9yQFJcLz0jqkMi5lRHjc5+xrGo7u5ClmBZBAxyOF
         ONwviFt8Sp5DzAkyW2bblGfMamWlqmeOZAMhYe/bDGtQAPll8SJpOHDV6y4ixMQGOoTk
         OZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+IdXMXYjVavqAmN5NgAIFvnwk1QJqhlOL+roypy9i6k=;
        b=KHIipKknsco0OsEMDVnuxpJD7VHSYpeGn8W1nqRIjMFu2kqMSzj9NIU2LX8Dh9u97i
         682MCyOwcabFCaQ0pslc959s/j3FItFZH+VcH6e3FVbiVs2xLwD+vwxfvE6OViwMU5KA
         GGxAWYEI5dhNngLWCnyGin/co55QgceqCZMFgC/ZpjG1Ym0Wuzu7gI2iprrCW/cKGfTo
         0dzEUpSeLW9wo4QuwdR6vnMeFxGZMWpYMQOTRUghJ/aVmGIU8ydoPKBOh4bME0D2/qXW
         HcApw4K28uMbOaqQAuQzbdpc06vSGmNc6Xp4tNqZNF0OzFB7ZcFvdwT3Ph5l2oCthAZM
         zUQA==
X-Gm-Message-State: APjAAAV0tK4KIfR4f6bbzykAyDjHTuzyqV23tvNBIIeLMPaWgEXToA4L
        aTe1YbI9LEhwcrzn7kczYWAF/Gxf0vTceZw=
X-Google-Smtp-Source: APXvYqxwWy7sqK7tv5i8D9ZMa79QuWpIcSb3RUe18BuHysKPVcr81Jh11Mv3m1W0IyXBAdKC+0pyAT7PnrWQSnU=
X-Received: by 2002:a63:e30a:: with SMTP id f10mr6545728pgh.331.1575680593512;
 Fri, 06 Dec 2019 17:03:13 -0800 (PST)
Date:   Fri,  6 Dec 2019 17:03:07 -0800
Message-Id: <20191207010307.56529-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v1] of/platform: Unconditionally pause/resume sync state
 during kernel init
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel test robot <lkp@intel.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5e6669387e22 ("of/platform: Pause/resume sync state during init
and of_platform_populate()") paused/resumed sync state during init only
if Linux had parsed and populated a devicetree.

However, the check for that (of_have_populated_dt()) can change between
initcall levels when device tree unittests are enabled. This causes an
unmatched pause/resume of sync state. To avoid this, just
unconditionally pause/resume sync state during init.

Fixes: 5e6669387e22 ("of/platform: Pause/resume sync state during init and of_platform_populate()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index d93891a05f60..3371e4a06248 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -518,10 +518,11 @@ static int __init of_platform_default_populate_init(void)
 {
 	struct device_node *node;
 
+	device_links_supplier_sync_state_pause();
+
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
-	device_links_supplier_sync_state_pause();
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
@@ -545,8 +546,7 @@ arch_initcall_sync(of_platform_default_populate_init);
 
 static int __init of_platform_sync_state_init(void)
 {
-	if (of_have_populated_dt())
-		device_links_supplier_sync_state_resume();
+	device_links_supplier_sync_state_resume();
 	return 0;
 }
 late_initcall_sync(of_platform_sync_state_init);
-- 
2.24.0.393.g34dc348eaf-goog

