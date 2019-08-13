Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D14C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E7F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzc6OCIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfHMH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:56:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44117 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfHMH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:56:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so50836667pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySbFRSRhjN5b4tewwLozQfn/M6TkVOpMU+eKIobgSxI=;
        b=Kzc6OCIlSbW5uhC0ITl/JJN6yGT9klz8O2PK9RUSDHPE/h2vlJLDzR9PXOe1vfeKFa
         NX7eRh0MO1Vt6L4fEcnbLzxyLIfW4OpFlAiqUtaLXXzCD/kDmUgcZ1eGVIjZeqN55XIR
         wWppQKsYdBmXVz/uBFHRCEm1+UzlYMwMmNffVm1IHHYihf/YrLHY9GAVnTOJ0ni9Kybw
         MYUzogR/d5dIjiG9IME4rF7jjI+PM7vV9wqVF/FAsqVmt/tVEvfn8CPBDuD8MR6VTRAl
         MkcrnkrKGllTVvi7J4c5SqqtDDFa5rrVVI6w3zXRtEpYsd76ejDfFecPBlP2+nPjKhes
         D3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySbFRSRhjN5b4tewwLozQfn/M6TkVOpMU+eKIobgSxI=;
        b=svQKaXVvoY4Q/OyQS6RfgmV4zzgTGhUG2pXPejb6NVQfqI+V8FlTXhsbzaVobE7bDB
         QYTctyjK7/g+Ev5K5gT39bTYO7BqiblKx+h/Job+6Vt4wnUKeJoioeJVtust6jHmTuY0
         2QbMwHEpohTTgjqODZeO099lvQ/CbxOCgp5yw4+iFzThmkHiwxMvaJUnZQR3YqysRq1D
         CzhwoJfJE0WUL/UVg0KpzddcKWaitWhKab7NzxKMgVMh41QUGnwuugaxNsa13ztSIiJu
         6f8AZxgGWGiw7uNYebOC5/e0KTQMKA5vk5ClPMh98TaFhnzYOXgUI5zsvnk3o6Nba3dJ
         ro1w==
X-Gm-Message-State: APjAAAW1EpW3yYIs3WTLJAr6RwiA0j2W9IqyRTV2ukBmBwVbj9M4o78j
        TkVxHgh4jn9fQ3UEzzImN0JkR83K
X-Google-Smtp-Source: APXvYqw6jR6K2m0V7mYccLFLYTLE1JeBo3JSTbgII1IOEq67UGhbnWghrdQxzFPH9xCVCEZ/Vn9WCw==
X-Received: by 2002:a63:b346:: with SMTP id x6mr33708006pgt.218.1565682969284;
        Tue, 13 Aug 2019 00:56:09 -0700 (PDT)
Received: from localhost.localdomain ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id y16sm10713834pfc.36.2019.08.13.00.56.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 00:56:08 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tony@atomide.com, rogerq@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v3 1/2] bus: ti-sysc: sysc_check_one_child(): Change return type to void
Date:   Tue, 13 Aug 2019 13:25:52 +0530
Message-Id: <20190813075553.2354-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190813071714.27970-1-nishkadg.linux@gmail.com>
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of function sysc_check_one_child() from int to void
as it always returns 0. Remove the now-unnecessary return statement as
well. Accordingly, at its call site, delete the error variable that
previously stored the return value.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v3:
- Remove return statement in sysc_check_one_child().
- Remove braces at call site.
Changes in v2:
- Remove error variable entirely.
- Change return type of sysc_check_one_child().

 drivers/bus/ti-sysc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd8305d..9c6d3e121d37 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -615,8 +615,8 @@ static void sysc_check_quirk_stdout(struct sysc *ddata,
  * node but children have "ti,hwmods". These belong to the interconnect
  * target node and are managed by this driver.
  */
-static int sysc_check_one_child(struct sysc *ddata,
-				struct device_node *np)
+static void sysc_check_one_child(struct sysc *ddata,
+				 struct device_node *np)
 {
 	const char *name;
 
@@ -626,20 +626,14 @@ static int sysc_check_one_child(struct sysc *ddata,
 
 	sysc_check_quirk_stdout(ddata, np);
 	sysc_parse_dts_quirks(ddata, np, true);
-
-	return 0;
 }
 
 static int sysc_check_children(struct sysc *ddata)
 {
 	struct device_node *child;
-	int error;
 
-	for_each_child_of_node(ddata->dev->of_node, child) {
-		error = sysc_check_one_child(ddata, child);
-		if (error)
-			return error;
-	}
+	for_each_child_of_node(ddata->dev->of_node, child)
+		sysc_check_one_child(ddata, child);
 
 	return 0;
 }
-- 
2.19.1

