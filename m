Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF0BC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D320859
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMbWeGnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfDWCz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:55:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34312 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfDWCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:55:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so6811133pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tb9GtvfiuyPoAzgJ59A7PgJjsI8k18M+HPWTTzVRLjI=;
        b=VMbWeGnvhIZOvskwqTiG/qW37A8P7dQ6P4kW4uTNxV6lUsUmSuPsCJZy4hM2brMcXx
         fMjVw/E9AB/OLqwLRDNY3Me3mQls4aR08aW3o2dTzVyerPy3txfOlaxwZdEMhxFRZIir
         be5Qe7BPDrOfyBs3CTSPNMSWkeJukvXwJIYn5iLfjerbhtwc/+wpmRZOWdRckrfU7onY
         hN31U9Nn62OpuuSvXm+3deYQz6LSe4iTfcaT9xfaHnlK6f/Sopi/onwOHtQl4fxbpwD6
         FMbD3rvA1I8WJlOblC0LVnNFhd+DrsAB75zHxdVOTmYgxd/cBk7vrRuI2d6Qrd/n956e
         CNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tb9GtvfiuyPoAzgJ59A7PgJjsI8k18M+HPWTTzVRLjI=;
        b=pSWCXAxCeadgeziyh/WybFy6Hlf0Flld6huJNA1Oz3lIZlCh9pTcPX8aMpVXur8nAQ
         tnswD/2+FpqnEXN3SkwB3OPUOhBS2qE4h1GRsI2YU+efZxnpOxuUbCIr/wpF7zim7/HB
         ucYjWH8vVqUj5gRHkn7p3xHBf4Us1VnIsMt1wVePZ2csEqO/+qhXftJ7Qfur8F36Rjij
         CnoyuMRLyvdWdZV67LBUHzOIravvjE56VpmpS3CYQ0eeZ6QuLFmjSxkPJWHVkdHZhXq8
         2zR3iUys+f2mbLF7VTSKA7jkzphXf9VOOhXL9fvgaP0sjnTObA8tBZ0EfK/VXkRVUpd7
         5AAg==
X-Gm-Message-State: APjAAAUCN8vqgmzRnt87xRgjgyMys5ri1LlS1Eat48UKJzhQRrWMtsKk
        +biQiifc7Dlnk3ZdKStC5biPoqaHQAw=
X-Google-Smtp-Source: APXvYqzpQ//OObHxU4g0bS1apHu35Ji4ZbfXT71DN3S1DzT3CgLj3cpDux5bCSQMqPMNJ9gWpdIDjg==
X-Received: by 2002:a65:63c3:: with SMTP id n3mr7990276pgv.170.1555988124363;
        Mon, 22 Apr 2019 19:55:24 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id v19sm19156654pfn.62.2019.04.22.19.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 19:55:23 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: Fix misuse of %x
Date:   Tue, 23 Apr 2019 10:55:13 +0800
Message-Id: <20190423025513.17356-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to unsigned long type and printed with %lx.
Change %lx to %pK to print the pointers.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 064d0db..c2c9fae 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1486,16 +1486,16 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) &&
 		(ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
 			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 				ioctl_names[_IOC_NR(cmd)] :
 				"<invalid>",
 			status, ret);
 	else
 		vchiq_log_trace(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
+			"  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance,
 			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 				ioctl_names[_IOC_NR(cmd)] :
 				"<invalid>",
-- 
2.11.0

