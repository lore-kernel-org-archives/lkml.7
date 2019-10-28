Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E9CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39F214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oNO8+LLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbfJ1Sb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:31:28 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41976 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbfJ1Sb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:31:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 1B74CA31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zJHCD8JGeDp3 for <linux-kernel@vger.kernel.org>;
        Mon, 28 Oct 2019 13:31:25 -0500 (CDT)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id DBF60AA5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:31:25 -0500 (CDT)
Received: by mail-yw1-f70.google.com with SMTP id m36so8064020ywh.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tt/VlbO+igImLkepQJBqwL30PnoA8x9FYvcXGMTcDYw=;
        b=oNO8+LLHuVipTV+Rmo33B3yON7KyUc9Xj/Pfe8UT1QPRw01PV6eWl4WHxhg+9SvBZ0
         bqscgIZdzeoQ8IDLZ+0i7jpFyHxw8oin0pPI85H9xjH+ZiugAxI7LYEq4oCB3R/t/8O9
         P9NmBYOztPK9w7xgbg982mHdMuuUtwOufxCq00e94XU8xEBtjVN9q2yvz/aAl4Gsw4n/
         Y21aeTWKjmxUx5zC4y2uCsTo/vzdgf+uRr09xIxVvn0ITT0WEByyWq6IQCwnMA1BAIiQ
         NKebG+Q/ALGkz/AiQWBhLGddIleFsBRSnclNxPt7HJdNi2GyMz4saYe5STIzNQDWdgCE
         PRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tt/VlbO+igImLkepQJBqwL30PnoA8x9FYvcXGMTcDYw=;
        b=s77mquVsl2IkfFz7dgVT4GetBF1iBsbYWDEZKWcjEc1YXClCRZi/tQcekYaC7hxcI8
         Hs7FCAKjMmO0E27QAkM/PwZ1Ft8ZW2IiVNzAGMUtV20rYJOHHWISCRzz3lnVH2XkkS0A
         E3NyWi3ITIpmKZR8O3NwzIHBS8NBKJhMSX020rVqfA34qNataiuHZoi2C1R4Y8SPuSoy
         cpBWKUEOk60bSzx2E2Y5NhFeQeTvHtfKxez529ya4cwoJHAAtbncaPqFY/dEKlKeO+km
         nY1gSdJL4mDff5qFjapBpMPy/RCu5txR4UQTZRyHGm3hmgAnGu6LDn4wdD+WmWaoIK0+
         XwUQ==
X-Gm-Message-State: APjAAAV9XJHDfjc90b+oK5i+qzPXNfzC4VMZE23GGFYdMO5L3KnDspWg
        giNv43LTmjdObh0buE39SrxNK6KJYtFijoG8ToYEPxXyWeDDzDxVEWNis80P6++epUAZ5yZanMa
        qX97jjgir5CsIqg+RyePycZG1d1zv
X-Received: by 2002:a81:848b:: with SMTP id u133mr14474837ywf.249.1572287485189;
        Mon, 28 Oct 2019 11:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdS2/es6j9HHrsCkQGYL6DtKHSGg0H+WNsXY+UpzKPg1CIgtE3W/3jPS5Q92CHzMEUvQZuBA==
X-Received: by 2002:a81:848b:: with SMTP id u133mr14474807ywf.249.1572287484704;
        Mon, 28 Oct 2019 11:31:24 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v198sm7033511ywv.44.2019.10.28.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:31:24 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: fix potential race conditions bypassing checks
Date:   Mon, 28 Oct 2019 13:31:14 -0500
Message-Id: <20191028183114.15709-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"obj" is a local variable. Elements are deep-copied from external
package to obj and security-checked. The original code is
seemingly fine; however, compilers optimize the deep copies into
shallow copies, introducing potential race conditions. For
example, the checks for type and length may be bypassed. The fix
tells compilers to not optimize the deep copy by inserting
"volatile".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 532a1ae3595a..6f4d86f8a9ce 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -413,7 +413,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *ptc = NULL;
-	union acpi_object obj = { 0 };
+	volatile union acpi_object obj = { 0 };
 	struct acpi_processor_throttling *throttling;
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
-- 
2.17.1

