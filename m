Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20578CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4DC20679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axy9avYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfJRWmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:42:33 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:42464 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJRWmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:42:33 -0400
Received: by mail-yb1-f182.google.com with SMTP id 4so2298831ybq.9;
        Fri, 18 Oct 2019 15:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zrsI5rFL6aWl8+FvhNVZd4YBmAJUYa6PdGTurxD/7o=;
        b=axy9avYMDMNr51+VyGcyNhHilqglIkhIqEfInbqrI+Y1d5KFx8GRBEVZ/Z2tLf02Pn
         xBgyNC2jrZULg/somCXRbBL9Ys5c+FRhU6ecpg+99o19dgH9D8UZ9rJ3dSk/9TWFOBbs
         SQWmQqiNsxaFlccnnaf4p+G+TtqpM9zyqBhFSKdAkuMID3JDQ3QeIIv9AGkDXvByGN2l
         TLUukDdAgz7qdch5LiKU2eKNPj08jNeekntSZAmPF5rUjTuvFuEhSBPsFNun4CoPOYKy
         wv9uuQ9N7Hb6g2H3bcevNB3lJjQz88FzJ+FP34qWfDWneqLMi+E4MsAbuhqFy4GjgzEL
         UX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zrsI5rFL6aWl8+FvhNVZd4YBmAJUYa6PdGTurxD/7o=;
        b=r6V9RFPeigh2Plc87INtYNR9ocEk7VY+c89HmxHe0NbMiZ/alBHvQBYSRHQiBe+Ffm
         7pXsak6gkFPMXQjhEENB18Ak48ge7rgoDJsocXcERMFcqqq3MZhijn04bWaCGBDrSJlL
         mACjdFc06/+6S076Kin0MzoPDouacq7B+8dmNYgS0iSfL62/kROPh4gTo5m0CIgoy9PS
         8hXBIg8TobPB5teF9ATbLs7pJHmNEF6qR+KYj7hrVw0SQwDJYz07b1Hn6ABmAOjGPtT0
         JehCA1xbpjKCyXaqN8NE32zM+Cwemf9skPcbLh7PtCqgJ9P+/hmL7/D4YNina6hhpn0R
         az/A==
X-Gm-Message-State: APjAAAWlb8ozwyFA/npUXwfORhHRHIXLmmzJ3YzWacCFD8GCaYtj994A
        pDvqS5bMiiVZyNT//degrQ==
X-Google-Smtp-Source: APXvYqw5DvbASEeHlQBZa248ii+jELoiVL2K94crkEBUhLUR/acf3+6rbM525u+o61cM6SDqccnWpQ==
X-Received: by 2002:a25:13c1:: with SMTP id 184mr8369705ybt.20.1571438552294;
        Fri, 18 Oct 2019 15:42:32 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id d188sm1645412ywa.88.2019.10.18.15.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:42:31 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: huawei-wmi: Stricter battery thresholds set
Date:   Fri, 18 Oct 2019 18:42:13 -0400
Message-Id: <20191018224221.15495-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if battery thresholds are within 0 and 100.
---
 drivers/platform/x86/huawei-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 5837d1b8693d..26041d44286a 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -345,7 +345,7 @@ static int huawei_wmi_battery_set(int start, int end)
 	union hwmi_arg arg;
 	int err;
 
-	if (start < 0 || end > 100)
+	if (start < 0 || end < 0 || start > 100 || end > 100)
 		return -EINVAL;
 
 	arg.cmd = BATTERY_THRESH_SET;

base-commit: fd13c8622a5ad4f7317b64de4f6aa2de1962220e
-- 
2.21.0

