Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C31C2D0C4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF67205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIjyedjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLITbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:31:46 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:43974 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfLITbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:31:45 -0500
Received: by mail-qv1-f73.google.com with SMTP id z9so5236598qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=prB1mk9zvmGsCm6yR+oUx6Ow5sTMlrAQcgGbY8ED3/U=;
        b=KIjyedjy8nKNq/kpAMbwxkGMECaIvC3qdOkXTSD8uZOSbIA1zqIMm+d3v2GbyU9CsC
         cewFDS9udMTcBDkUKZUS6p0AzmHYec6yPjkNtBiJZWVnBSF29uq9nXNAZDuzByhgHKGI
         ud9yyn+iZ2S5WHgMw26FIeid04csehS+Fyof2aQAmzeurrobWJFSe1wjhKgN98C+hUsq
         +em5TRFqHNGUupbBoZEuGtb1MxxLbu7ZE5qh/qvhG83X9bXVs4NUhouWhSvPe9WStWxm
         JzpxqaZiGGvDXbAfO+PtALH4PaAOqAlVhkJqJJNAqh2Fx2P4mXyhyZfE24NwwRNXHjBc
         4Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=prB1mk9zvmGsCm6yR+oUx6Ow5sTMlrAQcgGbY8ED3/U=;
        b=JE+rWTlmp/VE1PRsV6ylwjrR/V4Q1xxTNae8BuVNaquRVKxQCoRN1rTY6P5nCNYS4S
         uj6uUkwKO2WUYym0cok7DKkxXYyfjATPEPhzJdZgO56RM63tNlra4WBPf5aS36mQtEal
         t3sgi20kkq3B9qeIWRjIr9AGgyze5vLowWd8i0kVCDnX/BdAVMv3UhiIT4jehr3g9KAI
         Mo3zYsDx5Wx+NA9Zm82ugDHtHBRyXzgMhsfOFEgQT6kvUiwK5092OumSQHJqaHb8htLq
         sB1+D5OzwMkt1sgzUkFFaPIgddGufhyXSt9Nxqx6rWDH07B0DcmVVLEypQFiJhB12q4Z
         p8VA==
X-Gm-Message-State: APjAAAXPxgXZyttE7pV9m8y3lsgG2NX8tj/JkdFXH04aLrj/Odkm8KRv
        ZN10i9X/DW+a/wOQIrX/GXOjoTIU4DN6SKs=
X-Google-Smtp-Source: APXvYqw9GHdPYoc93yCyiJKvU4kxnAKjk+GlfxyVvVSYOkfPpKh49jd7LxoXpmTmYo3eAgsuBRRMGKQCgC8Tku8=
X-Received: by 2002:ac8:5155:: with SMTP id h21mr26336525qtn.174.1575919904561;
 Mon, 09 Dec 2019 11:31:44 -0800 (PST)
Date:   Mon,  9 Dec 2019 11:31:19 -0800
Message-Id: <20191209193119.147056-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3] of/platform: Unconditionally pause/resume sync state
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

However, the check for that (of_have_populated_dt()) can change after
of_platform_default_populate_init() executes.  One example of this is
when devicetree unittests are enabled.  This causes an unmatched
pause/resume of sync state. To avoid this, just unconditionally
pause/resume sync state during init.

Fixes: 5e6669387e22 ("of/platform: Pause/resume sync state during init and of_platform_populate()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
---

v1->v2:
- Updated the commit text to address Frank's comments
- Added Frank's R-b
v2->v3:
- Added this change log to address Greg's comments

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

