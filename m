Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE29F20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Hw+JKlHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfCXWjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:39:31 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59240 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:39:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 9B64296C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tAi5S4xsYFSJ for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 17:39:27 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 7269C80F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:39:27 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id w11so6490249iom.20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MSZ9302ITZs8dJ/k0dQkz3TFxIDi838B1mmrgn4iO+c=;
        b=Hw+JKlHlphuYIfhA86OcYH7QJJNT+yEV1dpMGblJ4W4+6rm06OZN+43p/LZrTuU7Sv
         RC+YRDIj2YBKND1q1qj8GoxA/eupsikspXfEKy5w+IE9Qi5lAFzFwnu7WrgiFEkxvRXv
         Sml7SBVb1O05kbBSo9WX3dh8URHbfIqOkQRipIKjJpoDgl1qJPtlAae12PW6LKbVRkKk
         mTZFNE+99qwpIlZf/tZtTUu+VRT0L+M2ahyqTwgFYR0aY94bdhq89wdrjwdeMKSXwegx
         rziBKLFM/D7KK/yxk0MkdfGxaiuzdikVa438yPkqeHDzt2d8vD4cRa861OHUL9LA2XaW
         dytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MSZ9302ITZs8dJ/k0dQkz3TFxIDi838B1mmrgn4iO+c=;
        b=iYNz2v6BBuyYk3GSFZayxvXTZ9Yvqn7CzBKc/bTbTpS+Ine87S4Trj7nBm1khYyM+v
         ++3LTtqZxW/s7dbNiIzP8MhSfK6V1kqlf8wsOJ1saXRHrz50hAGGY0j7RSCaUiKxDYvV
         7gsOf1gmHnKXOCNcfX3gV08/wc3jHyK9PyVEH0Xkh8UfwiSVFnRP9pzIM5ludY+NYE2C
         3axxjiOXqY60KKHiryLRWeDXMKn2lQrL+rL3J0N5P9j3rn3qfsVAhElq8kFYihkzQBMc
         OilGCrYzNCT6tOL8MkNCCs3vL0v8HkaHYAhhINo9TAaErVjvPQbpwspw3Ch/7D9tXx2T
         LpYQ==
X-Gm-Message-State: APjAAAXzpmYdpJ/ZjITEosaxaFyovlvEGJ3C8KCbklDW940psv4s0NTD
        Rc5E2zZ6kQmPW9nqqCac6fL2TVzltKvyKszgk5dqPPH5hyp/Nkh0ybdv5vayHVyz6ljhxQ9He1X
        iuo41t2hd0dm+pftZ5Ik/7JACO6gp
X-Received: by 2002:a5e:d608:: with SMTP id w8mr14493735iom.293.1553467166847;
        Sun, 24 Mar 2019 15:39:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6qD9mf251+TcHDyhf9i4142WlTt8nVZvse0W3jyS5GuseyoKNZZYuMQUrpICnyfxniXvznA==
X-Received: by 2002:a5e:d608:: with SMTP id w8mr14493721iom.293.1553467166653;
        Sun, 24 Mar 2019 15:39:26 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id f17sm4477400itb.36.2019.03.24.15.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:39:25 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: sierra: fix a missing check of device_create_file
Date:   Sun, 24 Mar 2019 17:39:20 -0500
Message-Id: <20190324223920.961-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_create_file() could fail and return an error code. The fix
captures the error and returns the error code upstream in case it
indeed failed.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/usb/storage/sierra_ms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index 6ac60abd2e15..2c049e3a56eb 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -195,6 +195,10 @@ int sierra_ms_init(struct us_data *us)
 	}
 complete:
 	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
+	if (result) {
+		kfree(swocInfo);
+		return result;
+	}
 
 	return 0;
 }
-- 
2.17.1

