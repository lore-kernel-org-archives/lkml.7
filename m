Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE5BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DC920675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X642QNn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfEVMPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:15:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44517 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfEVMOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id w25so1254455qkj.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3+FUMVAtUNqd7joLB2Rr4otnxHNV1reLiziKgDKNcc=;
        b=X642QNn8QYxNHPLxyuUwWX3jFVIOC5grd48XSK+K2rm7nsZA0NKHsdh62xKTAegUcR
         yLyKdKFRWnUt/5giHEV4Io6UUxfweTlMVGGzP8BHkIymEEj1GsjeT3S0K9OrO6GwoLan
         BewYEaRcyb5MP6HEzfaKRcPUTb/7fsHV3gbKS9F0no9G+ZtWWBnfuZFR/eoKT+eECmK9
         Z3/3u5EUwlurgr8nuuCVJW2CMuj/unUTmlp9lwaA8zOKpxP9SU461XckYuvbcJ8DMPGz
         1sS848+UBa76icY11pQXbNYTDCKeWpj9+dD2M0gjVRmM3xR9+efEy0lJ+Ba/Q6pw8xLZ
         LaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3+FUMVAtUNqd7joLB2Rr4otnxHNV1reLiziKgDKNcc=;
        b=Nx97RcmlyCHcvsnwgYH8gsAYqb8ZYJIVPYcjytBgmNWC17zbx0GI1MArJz75lajO42
         9ARkVTor3Jut3qIDyfg6BQ6ba2kBbHDciWNAJqxygRDb2g54bNvda6xg1pDW+nHot4hC
         YeLbb2Q7hOLAnm1cKuAVKl+TbOOcFLo/2EEDlXIw2Phu1L4OFjSzFtencRU4T1YsbfLW
         dS8A6hhNr4Jsi8Y0uga0vcmHUAW8I6z3QAKBVi2vmgaPRagIu/F0yAs1roSBMnygLw63
         3bhnCBf/bQN0sC46sYhRMrzrt7e5MiGd7F4fkqzkRN6IHp9qzi0H/Bp4monNCV3j6RB9
         P0zg==
X-Gm-Message-State: APjAAAWOD+ZT1tu+WNcJ+SJ9NC5uLRBLsbgViHM6BRVgjisM18YSJeFf
        4UIF7bkCbmDujASskxCq6XU=
X-Google-Smtp-Source: APXvYqzspNuecP6vjoKbVMlN1a+zmX6h3pOPqfRPbLQDm3gQyKx3/jQ5yCNmmGbrmJNg10WzZ1Utuw==
X-Received: by 2002:a37:7002:: with SMTP id l2mr68984568qkc.227.1558527294809;
        Wed, 22 May 2019 05:14:54 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:54 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 6/6] staging: kpc2000: kpc_i2c: add static qual to local symbols in kpc_i2c.c
Date:   Wed, 22 May 2019 12:14:02 +0000
Message-Id: <ca1e25c5b0387b54541cf686ceb6b7146c1c76da.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpc_i2c.c declares:
  - two functions
    - pi2c_probe()
    - pi2c_remove()
  - one struct
    - i2c_plat_driver_i
which are local to the file, yet missing the static qualifier. Add the
static qualifier to these symbols.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index f9259c06b605..97e738349ba2 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -579,7 +579,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 /********************************
  *** Part 2 - Driver Handlers ***
  ********************************/
-int pi2c_probe(struct platform_device *pldev)
+static int pi2c_probe(struct platform_device *pldev)
 {
 	int err;
 	struct i2c_device *priv;
@@ -626,7 +626,7 @@ int pi2c_probe(struct platform_device *pldev)
 	return 0;
 }
 
-int pi2c_remove(struct platform_device *pldev)
+static int pi2c_remove(struct platform_device *pldev)
 {
 	struct i2c_device *lddev;
 
@@ -644,7 +644,7 @@ int pi2c_remove(struct platform_device *pldev)
 	return 0;
 }
 
-struct platform_driver i2c_plat_driver_i = {
+static struct platform_driver i2c_plat_driver_i = {
 	.probe      = pi2c_probe,
 	.remove     = pi2c_remove,
 	.driver     = {
-- 
2.21.0

