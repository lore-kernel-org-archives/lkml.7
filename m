Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC39C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B12089E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmV9lnNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfHJMiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:38:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfHJMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:38:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so7882180wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kYB/c+V7fw2nVZpSXs3G/s3m+v/12xlUVibdKycHaUo=;
        b=YmV9lnNhsoJGTusqp3b7Zfs3QyX1e9ihjR3v8HOvBvNZ6hGLjhGulKbN2dw/vwlc3d
         BCIYvjoBkW3Ad2QqCVrA3Qfmp4xjgU+ErD4WYTR3xoD1dxma8sXNLpZrZjcNmdQbjNqP
         O8qZ6Dkjvh3og+uWizANQOkEqIhCnZpUIywjLGKiXrkdxqDdcFNJb7ejuxdTr3KMPf5f
         pItieBUzWaSiMvhMuQf/HWDrT6ar80zGojAil27GOyL4I8CAOZod/6+gVFGbyA3vlgcd
         KCMppNqxUcmaBST/f+T8wRc3d2Tkn6ImeNzgnkuBZbi5xHF9PxtAZePBiXXfCjk/SXeZ
         8naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kYB/c+V7fw2nVZpSXs3G/s3m+v/12xlUVibdKycHaUo=;
        b=WHVhtl9daNTM1cbgm4BhuOikeoOHf3jPACU+szuzhIBc1fycdLa8Y6I6E8sKce0T0P
         pdPgxYsiyt0jFCEoltXS+ke/74S8yx5poE76sUPuBLATHV1JrJAVPtDfauknnPWCIBh2
         MIepLyskYAeJ2W6O+4lwnlBhvw00mS3u+ewxbKWX8qlKEBQLZ4Mks5RUcm91wOWecMXf
         WpLy5Rllhh8zLnzgagEVNWdh7CiDV31efwn2zDoF+upcT12BlSvxuBwGfci3BtlY4SQs
         2NsIzklP2H+x94+YueHIvOPvzl0mpUpufyOCVkAFXPrEwEfBXncbYTmnAheDY8jh531C
         yMKg==
X-Gm-Message-State: APjAAAVQQoopb+EgBeyzOMWnJ5PWi02hob9YqYQ6MCbsm0ob8SMmg3CO
        zocd0Ue5nRTnsnYHJulz/2fnPPMzP1c=
X-Google-Smtp-Source: APXvYqxXQxbdBkioiHJu0fn085VtqrJjrw2HuKg5e3EN9rZUHHbs//AvxwMhGMhqmKa3sa9aZwe1qw==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr16717466wmj.155.1565440690615;
        Sat, 10 Aug 2019 05:38:10 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f12sm112141769wrg.5.2019.08.10.05.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:38:10 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: print to kernel log when reset is finished
Date:   Sat, 10 Aug 2019 15:38:08 +0300
Message-Id: <20190810123808.13845-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't print the queue testing messages, we need to print when
the reset is finished so whoever looks at the kernel log will know the
reset process was finished successfully and the driver is not stuck.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 9a5926888b99..1fac808c2546 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	else
 		hdev->soft_reset_cnt++;
 
+	dev_info(hdev->dev, "Successfully finished resetting the device\n");
+
 	return 0;
 
 out_err:
-- 
2.17.1

