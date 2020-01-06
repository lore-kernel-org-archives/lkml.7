Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE8BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF72C207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Kq7Cs7IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:32:59 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:37222 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:32:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47ryfK3nkNz9vZ6C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 14:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id umicBlc0-EgD for <linux-kernel@vger.kernel.org>;
        Mon,  6 Jan 2020 08:32:57 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47ryfK2dzcz9vZ5p
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 08:32:57 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id l12so21727097ywk.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5l0p/vFRPZk6guP1BnAdEk2ZYGrbFqodbRjZ+j59qOY=;
        b=Kq7Cs7IZotx/82WeJdfwB9MXJggXXaHssfFQoQTrFQaJzvY7GPa/fMpe/4kUCTqmzc
         gK/zkpKz5SLclirD9vhP4CpBEXiww7a1/Ic8JubeyQU/BL0zqPfVUXYZrgUz5XVQGYax
         Dk/fwd/EGzATrxMizGpvFosb4bhr9w0iMVaUmOr0+eV54OLfeS9bpUfsyDYBbG4VITan
         nLB9pRBiSgkcTJ/vwobgF/tWqU12sYsZLGaJui38RUlDEJ6VUPi6/orZ2S2dWvSF/NeV
         fQ2npo/MLkGGwWx3lGGUNBcvdahsa70Ud+h2lFu9rXahpD1kFB3LGy3WR34HsYWX+rUY
         Yh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5l0p/vFRPZk6guP1BnAdEk2ZYGrbFqodbRjZ+j59qOY=;
        b=FrpJv0IOYCC53OJnyjuv7chLn632F7yCJbB9rBnVFUa32Suwex1tGKAgG6wUj91dfG
         P+iy0mWPlXFuNSeBjscjmbAJEyS/3EGatQtuvxoQFvErxPWeUUyj2UJodcq26ndLuZ61
         2cDs3PisFnkvKmZr5KBLNBchhc7L6ryIYxQtNRewJO+G4+c28f8V+aCjXCu366DcdcY0
         s1GfonClY5n1o1EMFefBlySHtxmjOHth+6rn+20tHw5nzHWuTBq5k5nKnaMSygsU+m2s
         il4N+YcCvTvi5/1XEujftJCWrV/uLQHuhfEk5/c82ok4UbdvsK7UfH8NTRqmEe7OUYB8
         5+Tw==
X-Gm-Message-State: APjAAAUPc9iGvIIhxWGslGlKVVfNCndb+vpsFhDxHQObfiyxd8bAvR9x
        jeObmX6xJHhBkpWHZj9Om1cdyOZXcYjAmVqjcTypnTsRjSV+cAmuexR6SCuUa52i3xIgTjddtfo
        o6LfmoUINkLMrzZt0V4l9qcDAtCQH
X-Received: by 2002:a81:6c55:: with SMTP id h82mr77451856ywc.311.1578321176357;
        Mon, 06 Jan 2020 06:32:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkV68WEDTQEyoyXmVebbHWiYnKmmEY9oPOGZeSJpiKfLcQmzj74d8oPwzY9h6TRNWXkKX1Xg==
X-Received: by 2002:a81:6c55:: with SMTP id h82mr77451819ywc.311.1578321175824;
        Mon, 06 Jan 2020 06:32:55 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id w74sm27845121ywa.71.2020.01.06.06.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 06:32:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure
Date:   Mon,  6 Jan 2020 08:32:51 -0600
Message-Id: <20200106143251.11684-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vpfe_register_ccdc_device(), failure to allocate dev->hw_ops
fields calls BUG_ON(). This patch returns the error to callers
instead of crashing. The issue was identified by a static
analysis tool, written by us.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v2: Fix alignment of checks within the condition, as suggested by
Hans Verkuil

v1: Fixed the type to a regular variable instead of a pointer,
also added fixes suggested by Ezequiel Garcia.
---
 drivers/media/platform/davinci/vpfe_capture.c | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 916ed743d716..9b1d9643589b 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -168,21 +168,22 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
 	int ret = 0;
 	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
 
-	BUG_ON(!dev->hw_ops.open);
-	BUG_ON(!dev->hw_ops.enable);
-	BUG_ON(!dev->hw_ops.set_hw_if_params);
-	BUG_ON(!dev->hw_ops.configure);
-	BUG_ON(!dev->hw_ops.set_buftype);
-	BUG_ON(!dev->hw_ops.get_buftype);
-	BUG_ON(!dev->hw_ops.enum_pix);
-	BUG_ON(!dev->hw_ops.set_frame_format);
-	BUG_ON(!dev->hw_ops.get_frame_format);
-	BUG_ON(!dev->hw_ops.get_pixel_format);
-	BUG_ON(!dev->hw_ops.set_pixel_format);
-	BUG_ON(!dev->hw_ops.set_image_window);
-	BUG_ON(!dev->hw_ops.get_image_window);
-	BUG_ON(!dev->hw_ops.get_line_length);
-	BUG_ON(!dev->hw_ops.getfid);
+	if (!dev->hw_ops.open ||
+	    !dev->hw_ops.enable ||
+	    !dev->hw_ops.set_hw_if_params ||
+	    !dev->hw_ops.configure ||
+	    !dev->hw_ops.set_buftype ||
+	    !dev->hw_ops.get_buftype ||
+	    !dev->hw_ops.enum_pix ||
+	    !dev->hw_ops.set_frame_format ||
+	    !dev->hw_ops.get_frame_format ||
+	    !dev->hw_ops.get_pixel_format ||
+	    !dev->hw_ops.set_pixel_format ||
+	    !dev->hw_ops.set_image_window ||
+	    !dev->hw_ops.get_image_window ||
+	    !dev->hw_ops.get_line_length ||
+	    !dev->hw_ops.getfid)
+		return -EINVAL;
 
 	mutex_lock(&ccdc_lock);
 	if (!ccdc_cfg) {
-- 
2.20.1

