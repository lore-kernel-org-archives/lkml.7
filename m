Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100DC71142
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E3B20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1jW4w1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfGKRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:51:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36014 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfGKRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:51:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so5230229qtc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTCsPEunogKzV2kwceBfPefzG4vpX82bq73Wlt3bmJo=;
        b=u1jW4w1cKMBrfRcTai3sUouwYbdIldXVywH50mU5qX75xOwSpd4OkMjCkdAdeOMXLO
         /4N0OZPut0MTuvdDKDpwdwd/DjPUjelg1dxc/GJZmH+UeU250aM+HJhNmfy46rlRyUFs
         rieToPJD45Nh/iu5bMdp2QMeyqUI9xm3Ys4om9tNSOEYnrW1G1+kzzHH90bsINRDrCLn
         17RUlgAMrjF6ZfyZ/HwjbWmUT0D9Cu9hVigKYBIN6pqZt9Wizwq/9kCom9IznQjANl9Y
         el9y4jX1GpxDwyHuzhi/SoQBd7cjB/Xr62nbYybSBO1CWNy4wWtR/Cek9+aXcpwKgTPu
         ah/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTCsPEunogKzV2kwceBfPefzG4vpX82bq73Wlt3bmJo=;
        b=B9VwvgogWm9QM8LrmEtOAkaNkK2nD2P7e5EkDzsZrdWg9AKu8LWX/42qQB4riW1/hV
         MSE6LkwdoqSNyyNMZ4bF4eGqFw/vPn/Vn1Cc/3julpFLeSRuCsIxXjeH/iczyL9S/g9W
         z8ZNE+cMURjMwFbPNdCUmAxxqw2x4v6PcxayCwIQLcC7S0yYi9SsvlrmhHxIyiQ7jImq
         WMbTfixJmT0My2MmSHVSU1UYe+o6T4D64PZh3vqJf1nRl/7gByuBV3SVYahn/tu+1c6o
         /3XB4CQLwoitGFLvopzmxYjRujfNFpn0aGdd8QdkLyusFoIjQmpk7Yuw2KqUajGYWtoV
         W0Fw==
X-Gm-Message-State: APjAAAUjwjfj1baSdFxXFpvELy1y/E+/NTvmevM+MbjJqRZr6Su15lMz
        Sf4vGZ0ONGF7H86yA+i5pw==
X-Google-Smtp-Source: APXvYqxfR3f/fCPWThOEXsziSCmvYCJ6lC/eIaJ6hDOt9KP+p4C67YjxDl6skpF6wSR1/KtoI+UEbw==
X-Received: by 2002:aed:3ed8:: with SMTP id o24mr2679693qtf.252.1562867467751;
        Thu, 11 Jul 2019 10:51:07 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id g54sm2925494qtc.61.2019.07.11.10.51.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:51:07 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: most: remove redundant print statement when kfifo_alloc fails
Date:   Thu, 11 Jul 2019 13:50:52 -0400
Message-Id: <20190711175055.25157-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711173915.24200-1-iamkeyur96@gmail.com>
References: <20190711173915.24200-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This print statement is redundant as kfifo_alloc just calls kmalloc_array
and without the __GFP_NOWARN flag, already does a dump_stack().

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
Changes in v3:=0D
- fix checkpatch warrning
---
 drivers/staging/most/cdev/cdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/c=
dev.c
index d0cc0b746107..724d098aeef0 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -463,10 +463,8 @@ static int comp_probe(struct most_interface *iface, in=
t channel_id,
 	spin_lock_init(&c->unlink);
 	INIT_KFIFO(c->fifo);
 	retval =3D kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
-	if (retval) {
-		pr_info("failed to alloc channel kfifo");
+	if (retval)
 		goto err_del_cdev_and_free_channel;
-	}
 	init_waitqueue_head(&c->wq);
 	mutex_init(&c->io_mutex);
 	spin_lock_irqsave(&ch_list_lock, cl_flags);
--=20
2.22.0

