Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF49C32757
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B57206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsbFFroY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfHOGA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:00:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47060 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:00:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so700618plz.13;
        Wed, 14 Aug 2019 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHk0jK1HEft/SVCetsI5tXpmz7bQuY1G+3y6n19Cwo8=;
        b=BsbFFroYY5WlVlovWF6nQoym+VeuI4m+UOU/asXHXRK37/2ZRav2UStHmccwdXS6AU
         fYL1l4spKZ2mDGQfOGRMkwCr9Yvkq2PwXEvjdEjaeRTR0OzJK6oZ9r5PD5SSxDGbIr6U
         9axlTs9u4s1L9HdjjigQPgdILgMCplm2lWyhDFyxg1Zb50tbpqpVPnuVxCvJE92w0Eae
         upsJeL/rifQrLBhHWUKoGvkDcvm+ZYep2p9MpvFTkgEsJJhEcsvRfPZ/ns/FxLpTWl4u
         1d7vwY6G41CuCRJnJp2GTqtlLlTDYt+JrAv2c3bwgZFFRAwGKsRZYshW+qwFP+CgF7Yj
         lj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHk0jK1HEft/SVCetsI5tXpmz7bQuY1G+3y6n19Cwo8=;
        b=gSsRd7jMz77aim8NzmRCof6D6H3GpEZLYv449LEr4WPy0ROgc/zPVmm0LhQmaE5KxD
         8JlH/0pusf2skMiqf2F03cjE3DzFM4Y+G4gJbclN/xhPlXZofxRbr0CQHeLmmROXGOUc
         yN9XgtBG7TcsxQC7dWXiK3ZXbsC3O1G5dgt7ByzVXksMSdsuzF/681OnQlatbtSHi5d+
         b1c9SK2Rj0UlOHgv7+OY2l9Bup/welbzzBhYa4Iv/2wVzcNrF5zriiNByZ3LDI3JLU1R
         gI7gaw3S2qhQe7PLnYfSi8UpMYeWewXLqtRVfIf/Qx2LmE3UDl+zOPdsfVqCHdlXMly2
         uhgg==
X-Gm-Message-State: APjAAAWZ07sdZ9rTABHv7g4VVaz9KuBM04b7wYsNfSXXQmVCMgHpy9PV
        wSDbmDkWd1bYqzMNVaqmgc0=
X-Google-Smtp-Source: APXvYqxTK4pEpESpRen2PMxU8JXsjr2HKEhQxS6NEA104v0fy9n/EKwCRxgxbzoakUSR0MEiP8/3lA==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr2829873plg.117.1565848828134;
        Wed, 14 Aug 2019 23:00:28 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id a6sm798014pjv.30.2019.08.14.23.00.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 23:00:27 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] ata: libahci_platform: Add of_node_put() before loop exit
Date:   Thu, 15 Aug 2019 11:30:14 +0530
Message-Id: <20190815060014.2191-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous node, but
in the case of a goto from the middle of the loop, there is no put,
thus causing a memory leak. Add an of_node_put before three such goto
statements.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/ata/libahci_platform.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 9e9583a6bba9..e742780950de 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -497,6 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
+				of_node_put(child);
 				goto err_out;
 			}
 
@@ -514,14 +515,18 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
-				if (rc == -EPROBE_DEFER)
+				if (rc == -EPROBE_DEFER) {
+					of_node_put(child);
 					goto err_out;
+				}
 			}
 #endif
 
 			rc = ahci_platform_get_phy(hpriv, port, dev, child);
-			if (rc)
+			if (rc) {
+				of_node_put(child);
 				goto err_out;
+			}
 
 			enabled_ports++;
 		}
-- 
2.19.1

