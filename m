Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23492C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD8C2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfI0Voy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:44:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56579 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfI0Vox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:44:53 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iDy2l-0004ko-Sh
        for linux-kernel@vger.kernel.org; Fri, 27 Sep 2019 21:44:52 +0000
Received: by mail-pf1-f197.google.com with SMTP id o73so2833246pfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uQvH5eP9xpiy0f1cPY42CaQQPMr87X6kYcWUTyFt77M=;
        b=E3RGK1OqGQNpjzAaawvNYb1mjK7w4F4jnJIskiNznci07QbKKBg6eyhHrleOvbUGO7
         XcEiSAcnV5VNAjDDYKxjEKSlkCKh6tRVNT8td2xZQVCqGGpEidpdYHjGiPdbpO5t6FpS
         PqC6OegD39i/oQLFZjlPh390sih2IVTk3/3wjVKjePCODBfvI+/t27g0tm2cjjtUSIpe
         vx8jippDvQCOSlygK1l1RLunsPqNgMuX8lVMBBzWZi/DTXgvxLKHvCJrUMG5yFBBZ6tf
         79WSFggDErdrLEi1Ywz8gJqzExLcf4Q/NiIMr+DWH2n8vxXaD3VuHkjTmI2aqxkgiEH+
         pRTw==
X-Gm-Message-State: APjAAAWGH07+P0mzSzHwnRA5nYmLD/2M8Q8Gx9TbwLurZV28dvuY81uJ
        6NJ75JyA5ievT5FqdRHTHsxjk8t5egXqTamPzYBH1w0iCEWpESDU0EfTDlmzaUDvPs6COICpd+h
        18C8WX+BuHAOgtg57mVBbvpPEfofIB3Nwnrflmg9mFw==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr6844805pfq.46.1569620689696;
        Fri, 27 Sep 2019 14:44:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5fadg5CEjQhSH0zmkl5ewNifNh5xW4jmDcza4yWN2DbT2bNZYx2VRVKTGjCnUlTYTBz1cWA==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr6844794pfq.46.1569620689563;
        Fri, 27 Sep 2019 14:44:49 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id p66sm7150579pfg.127.2019.09.27.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 14:44:48 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: fix null dereference when kzalloc fails
Date:   Fri, 27 Sep 2019 14:44:15 -0700
Message-Id: <20190927214415.899-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kzalloc() returns NULL, the error path doesn't stop the flow of
control from entering rtw_hal_read_chip_version() which dereferences the
null pointer. Fix this by adding a 'goto' to the error path to more
gracefully handle the issue and avoid proceeding with initialization
steps that we're no longer prepared to handle.

Also update the debug message to be more consistent with the other debug
messages in this function.

Addresses-Coverity: ("Dereference after null check")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 664d93a7f90d..4fac9dca798e 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -348,8 +348,10 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	}
 
 	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
-	if (!padapter->HalData)
-		DBG_88E("cant not alloc memory for HAL DATA\n");
+	if (!padapter->HalData) {
+		DBG_88E("Failed to allocate memory for HAL data\n");
+		goto free_adapter;
+	}
 
 	/* step read_chip_version */
 	rtw_hal_read_chip_version(padapter);
-- 
2.17.1

