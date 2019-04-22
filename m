Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056CAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54402075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUqEtnJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfDVTKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:10:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46213 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDVTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:10:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so9729344lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RQBvK352n6IG70PiAuF9PHJ3+pOwOrYxoqOGbDIMN+w=;
        b=CUqEtnJ0t1st5dvhmM4wWbhnrg0m9I3W9Yd1A7trOyBA3h4W0KvertWLFvYF0IFI2Q
         vWq0TLOQNUS6wuWiqTfBeV4Zv6yX3RFKwzMqztIg/izT/0xvl1CyF3MafQYv4Yp4StaX
         iE2b1PDM0uFojazdME1TFhHR1o0VQcUizKPn2H5SxA39jwGjD3NYnPCONSOuYufPwBfT
         lDuzmSI6xKO/X6ADfIAULXPAMi2cn5lhO+aPAY3LZKRLmCDrd/+K3TWl1VxjPEm1pdH3
         nJHl4WzCMmxhVFKEJiWFaSsMuhZXln3EkxVjmWviaOqmUxsUSCn+iimPgtSaMtqb9mpW
         IA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQBvK352n6IG70PiAuF9PHJ3+pOwOrYxoqOGbDIMN+w=;
        b=sRI17njF22MNlnArwolv7bNBCZwurWKF3MBb2ZNo8vxuLE/KqEjdkAJVH+Y6KYYePW
         CpwSJBXqCLtXazDfvUId/rDcEO/HOE8whytEY8sOnFQekc6wblDdURU0rYE5Z+bka3O8
         AHL3Xe7K2ECHLeOzVQuquNkVRpyj1Rbf8DaeOUqM7u9tqIyupbiMtoJ/o2kSXkFtm2Su
         qRpiFQkBx0Sj/TI/TBDwdOnDXxXfkqnj2HJYB31gq4hfJI+VXaskyI6PIEORkai1j3Dc
         ZZ+MhX+8MI4fJOOHEzmSCLscoNqcqXkqL/B6c5ykhRz34PIBOa4o2OceXiDOWJs2y2Mg
         KgZg==
X-Gm-Message-State: APjAAAXSXT0cwAjDZHi+B3raXKh+qmBgf0ux7sTqy7ao+zoF0cwx5kuH
        WPbGpZPisSGlX7przRCBt8w=
X-Google-Smtp-Source: APXvYqxdmFusbFIGDtcjcMM2AmTfP6ue2cb7sIDjqVYEncBFM+83M4cxZmPHhKYSbXiB0me8WXX7Mw==
X-Received: by 2002:ac2:4214:: with SMTP id y20mr10802104lfh.75.1555960199361;
        Mon, 22 Apr 2019 12:09:59 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id m28sm3139000lfc.71.2019.04.22.12.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:09:58 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: TI power management: add missing of table registration
Date:   Mon, 22 Apr 2019 21:09:50 +0200
Message-Id: <1555960190-8645-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          spi:tps65912

After this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          of:N*T*Cti,tps65912C*
alias:          of:N*T*Cti,tps65912
alias:          spi:tps65912

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/mfd/tps65912-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 3bd7506..f78be03 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -27,6 +27,7 @@ static const struct of_device_id tps65912_spi_of_match_table[] = {
 	{ .compatible = "ti,tps65912", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tps65912_spi_of_match_table);
 
 static int tps65912_spi_probe(struct spi_device *spi)
 {
-- 
2.7.4

