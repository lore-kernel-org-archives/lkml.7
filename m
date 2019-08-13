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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224EEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02E22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcq9+SRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHMHRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:17:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35462 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfHMHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:17:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so48902612plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABFk1VVN2+tYrAgZCuaw8jGQd4qxZFJF28vCQ16qWa8=;
        b=Mcq9+SRH5Jr0zj3hccEIi/qUAI6EFwpUlzHHuNPqDDVsZTZtOfD/fLoLkqqPMas1LI
         CNvUjWke0WOsol/avZM1ae2NsxhvTsZz6t3CZDaRNffDToXdf3x0Bfl7OQB10VfLZDuu
         chpVw/AuxB0CRicL0OkbZ7oUcWOfk3coKgT1pGITJJ7mHjG88680684HLbes00M2hhe+
         sOnx+BTSAYnaZMW2cwJuDvr779F+z+fEK/WKge/C7hg1NtvSjLETGzr34U0qFiHQMVOl
         Sk4eYQOHB97hSj8SYWbcdycpluEMGbKEdKD45YXwKDt+Q1O9KyZUe/RCt/UzrSvkrAZE
         egWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABFk1VVN2+tYrAgZCuaw8jGQd4qxZFJF28vCQ16qWa8=;
        b=tbs/yKnJNwm5HBxqRYPdk2SaxDj3q5uDBz8Be0bCKE4Z77p6W0SR/hSuMF28W0CNkF
         nRnk6mLPXFaSFNjGfXrWlk8/LBglzl4TVr3rLyCY2cCLsmtOg/JGDJN8A30p1wKI9Uhn
         xXDJfers2/CyiWt6rqjegIw3CJH94fxPSEeR17YYXxnaJfuc6bcE1YjgWxMtViE6QVg5
         eQx0FPiU5gNYUiitzYxcSgmCIAVAxa07FZBXDQM3G0nd8Q8Rf7XKdbyhar9sunyyGslT
         Ic3+vDKoDcGn6J6KJV3MQNco9rmJ60424yTRorutrkFjZEiei47jX8vAwo5d8qsvUng9
         IMsw==
X-Gm-Message-State: APjAAAWxvWsGA1NQ5rq5PwAtdSecYwT5Uir1Zl7ZgRJruIX6Azg2ZGdA
        f/ZpwXNB/F2OKdBrJBS2W9E7iJAg
X-Google-Smtp-Source: APXvYqxH22f23FX5+kNjd+tbi4byvCNgbQmc0uu1QuR88t1dcOPw+Nxw+HgvrIfHg0L7DhzmRHPNTg==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr37755840pld.41.1565680650652;
        Tue, 13 Aug 2019 00:17:30 -0700 (PDT)
Received: from localhost.localdomain ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id a128sm126273901pfb.185.2019.08.13.00.17.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 00:17:30 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tony@atomide.com, rogerq@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] bus: ti-sysc: sysc_check_one_child(): Change return type to void
Date:   Tue, 13 Aug 2019 12:47:14 +0530
Message-Id: <20190813071714.27970-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of function sysc_check_one_child() from int to void
as it always returns 0. Accordingly, at its callsite, delete the
variable that previously stored the return value.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Remove error variable entirely.
- Change return type of sysc_check_one_child().

 drivers/bus/ti-sysc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd8305d..1c30fa58d70c 100644
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
 
@@ -633,12 +633,9 @@ static int sysc_check_one_child(struct sysc *ddata,
 static int sysc_check_children(struct sysc *ddata)
 {
 	struct device_node *child;
-	int error;
 
 	for_each_child_of_node(ddata->dev->of_node, child) {
-		error = sysc_check_one_child(ddata, child);
-		if (error)
-			return error;
+		sysc_check_one_child(ddata, child);
 	}
 
 	return 0;
-- 
2.19.1

