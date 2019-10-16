Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E65C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C672082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMn/uozy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391320AbfJPHtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:49:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJPHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so14168657pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxVCTrKNjWhjlkyA4a4PjlbJLD0+omh4Y9cUtwpdEOA=;
        b=OMn/uozybDyJ9qIacgsKR5i2xsl4C51c37saVXfjn6GamJRMlpOt5MAVHteJ1qGRro
         dGXg6ajSh5gn8ytw2CfWKPLyjAaHXxeeHUmr69I1/WUcU/Mku5vCUpDSar4dvWjH4lWR
         8W+9/5zn8OQfsHaf9u/WlpOYHIr4dmcbjXL2cU8SxnA1NG8RlLt5gjP4pHUt1hdQ9UtC
         tg9b2qqCGM+ispJa/kUI9KR3OxMNniw1JasulRBP61OzWup2N8r8vGplEnQ4i93njAxE
         ITcJH252Lg48dZ7YGSbF6VV5nsUQ5i01X7iF2FhCs7b/2bcZvVWdQajXpkFWXHzSMEYH
         mNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxVCTrKNjWhjlkyA4a4PjlbJLD0+omh4Y9cUtwpdEOA=;
        b=gnudRYMUjjoqiEoO1uQ1M1q/bIuQ2c2NpLl6XPEHs6lx0CJsw3v95A7yX8YmP2RKWj
         VRkfDD8oov6jazDcJJX0xKSSCpyBzy5+4yXa1ocZ8MQVmb89jne8CNAeZcJ1ziemnBpR
         z5BE4c2RHtdl1oQXD6bAPbg4WfX/ip8ru0QmtsF/Lmw+uvkfY0HG9CiBegMXz5dXozG8
         yK1cSPuUSMbV5T2rBes/ak/f5dFU89HUVvd1Csje+y3NLDizjl5xSqROQTr61tQnTZpz
         aMbqNZCX/XMhb9PGwPjhwua6rtFucu7JlGB958rmohOa/FKZICcw1f6tJUffVk9D5PX4
         F2Ig==
X-Gm-Message-State: APjAAAVtXL4sjpL3olSwzT9qJulcF90SY4845il7UYbdqYUbFPCw6oLt
        Fg8CNCD37AlxBsw+iRId5svkRxep/gnTcA==
X-Google-Smtp-Source: APXvYqyBIWi1fibA5NNpBIjOsULSY9vDiRqs7yaMjVWMqDHldO6QZCr82BIUx4zsyleI3ZT7gX8YFA==
X-Received: by 2002:a62:e312:: with SMTP id g18mr136443pfh.250.1571212186003;
        Wed, 16 Oct 2019 00:49:46 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id d1sm25185522pfc.98.2019.10.16.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:49:45 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (missing blank line)
Date:   Wed, 16 Oct 2019 00:49:24 -0700
Message-Id: <20191016074927.20056-1-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging.
 drivers/staging/kpc2000/kpc2000_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 6ba94b0131da..5712a88c8788 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -50,6 +50,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
-- 
2.20.1

