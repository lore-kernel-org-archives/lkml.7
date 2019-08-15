Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C611C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B7A2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmihRYqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfHOFrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:47:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34204 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOFrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:47:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so847829pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 22:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qx+bTus8H/5o/5xA7fQ3ydksr074e4hjTy2v2zgX6NE=;
        b=jmihRYqzFCaXHd0O7hYq4FhhMpJ7OyQpW0FlsqLB6uoW734yRBkUb7YT44W5TVaKbB
         j5gzrawNLbb08s7rSPqjO9Fyu2ctOYXlbJJAvLOOuYmuv9AEmLpMGEpf+DJyg8mvQqqv
         GhYNP1bpK93gG5H9UpoUeDDn5QJF5IqAq64SxHgJTV/2mtsj7mUnqbJCOc8TXcC3LGoJ
         FhNx77yNEiJhtj3bUOcSE+ky9H9aGZmJObygmVO8TK2YY1VHqvTXN6u718pkvgalGaZc
         JjUaHXwIlsUXvjD2m6ROmeONxq+WguQoaLz3MjqQadpopfhKkCMM0J1D9tE66ADclArL
         pGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qx+bTus8H/5o/5xA7fQ3ydksr074e4hjTy2v2zgX6NE=;
        b=Bg05n2iVet7RHwp5mxumtoRD1pIQoXarxKPmyOIGp8J3OB2ILc+4+nykCT69lseaJp
         q7WbYfXvqhy/BGihgVhysgVpRIeV58/71HK+P1eKzDCiF8x8DcX1/8QvsCnj4vUXonTo
         /WBHmGFmDSY5iYk7tehmyi5fW7SRzQY6U7uuAB2CYbAzqsLSyFmeHDSZLqg41qicWA5H
         hSsbQjpSF0zl/eBGuw4uo96VyIuOLNuqDhmYfG1c4t+cgD2+ojVJhKWZUsZexdisygnr
         vhVOKND8HqyP1Ow7JNizk85hyPKi8AL2FErJT8JFm6UbUG0/venRLK9eZt1TeXdOaOX9
         Cjug==
X-Gm-Message-State: APjAAAXv2oVnhJtoULrGVTrmsJ9NNl9bIRnhuxTHPGnbVltQ4Pip4hmF
        6+BI7hy1vUoXeGVvxRwldQQ=
X-Google-Smtp-Source: APXvYqyc+xw3QvhtMUQ5hW5iJDMiK04MQyZ7ZY1z7GkfPAskOkjqMKECo+SdxqhIegmyztO89Zx+bg==
X-Received: by 2002:a63:b11:: with SMTP id 17mr2164239pgl.283.1565848020605;
        Wed, 14 Aug 2019 22:47:00 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id f6sm1168191pga.50.2019.08.14.22.46.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 22:47:00 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tony@atomide.com, rogerq@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v4] bus: ti-sysc: Change return types of functions
Date:   Thu, 15 Aug 2019 11:16:47 +0530
Message-Id: <20190815054647.32750-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190813114256.GR52127@atomide.com>
References: <20190813114256.GR52127@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of functions sysc_check_one_child() and
sysc_check_children() from int to void as neither ever returns an error.
Modify call sites of both functions accordingly.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v4:
- Merge into a single patch the two patches for sysc_check_one_child()
  and sysc_check_children().
Changes in v3:
- Add patch for sysc_check_children().
- Remove return statement in sysc_check_one_child().
- Remove braces at call site.
Changes in v2:
- Remove error variable entirely.
- Change return type of sysc_check_one_child().

 drivers/bus/ti-sysc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd8305d..a2eae8f36ef8 100644
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
 
@@ -626,22 +626,14 @@ static int sysc_check_one_child(struct sysc *ddata,
 
 	sysc_check_quirk_stdout(ddata, np);
 	sysc_parse_dts_quirks(ddata, np, true);
-
-	return 0;
 }
 
-static int sysc_check_children(struct sysc *ddata)
+static void sysc_check_children(struct sysc *ddata)
 {
 	struct device_node *child;
-	int error;
-
-	for_each_child_of_node(ddata->dev->of_node, child) {
-		error = sysc_check_one_child(ddata, child);
-		if (error)
-			return error;
-	}
 
-	return 0;
+	for_each_child_of_node(ddata->dev->of_node, child)
+		sysc_check_one_child(ddata, child);
 }
 
 /*
@@ -794,9 +786,7 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_check_children(ddata);
-	if (error)
-		return error;
+	sysc_check_children(ddata);
 
 	error = sysc_parse_registers(ddata);
 	if (error)
-- 
2.19.1

