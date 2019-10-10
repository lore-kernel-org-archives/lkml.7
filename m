Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C376D20650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmua95JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfJJDJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:09:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJJDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:09:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2046611pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=suMFKZQEGEwZr8PRAVj7Gyv2/NzjvEqwMzv67rGfm+k=;
        b=Bmua95JQ8Gp4DKSJGPuU+V73PT1xBrJUUOEmk+MkDx6be98iCs8yRGHFL+rdSgDoa5
         2w5BmBLPT5T43AREMJjHkYI5WusYapm2Pixdd7QtJ925mTNYfEyXtHH1RtQ3+6UuxJUT
         sPs9HoAYW3iG2UjgkMBPPJ0tEnYFxuKsOcthVfXRQtZ0vn0J+6JmbmEzQPLAJ8hyuaCR
         TN/iuNtKagXlnzyhsqClpAHp9KkpNELImOQFYdxZl3U0AIHenVm4dcUa2VEJ3zy1zF5w
         NX1k8hbf+nUOnommX5uL8Z3JA5zTrb8CejvAwaE4lm17MOacaZ2ECFWmOmYGQ+CzPyVl
         wvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=suMFKZQEGEwZr8PRAVj7Gyv2/NzjvEqwMzv67rGfm+k=;
        b=FfhEzmtc8mESEXNQIsGduas+y1hBc9VSm7yvAEEPddDw9Y1ELAOl5iUb66oeJ0Ya/5
         oTghln438M6pCyf0wPHUorznz4mly54b6gmh1UiBQQq6RZSNUADnjOsdFEaXmB+3Ofe6
         2+0FqqxNmSkv5x2kuwl5DfukKp1z/bRMSxvf5Bejg8uWBeEknqKqVg3LpixKbt9nEPdz
         BrETR/F31gb4WxA7cxSEW0LOn5aRHgI1PRtL+LDQzFGPFlUuNDL+l89ImQ4UJpdVBvDI
         KNtuqf1v8eeh4DE35XnAuk3/dVad+fX9Zz4tR/mU8a/b7ahmwT7kSSxFsjPwaqv850d2
         MEsg==
X-Gm-Message-State: APjAAAXqa7BTg8ddaZvKzqFGIYSmhuQKbWqvaLLsuBO6CrW39DvA2yL3
        JfEgSkqyWWI4rN23UYyj2W0=
X-Google-Smtp-Source: APXvYqwyj4UgbldcCqsMP605uHyuy2dA8ef1zfiZvkS6zJoecbO4KkZkKGNsoDshNSSb2DIv4dbGkA==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14mr6652911plz.91.1570676983514;
        Wed, 09 Oct 2019 20:09:43 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id v8sm9713196pje.6.2019.10.09.20.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:09:42 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (missing blank line)
Date:   Wed,  9 Oct 2019 20:09:32 -0700
Message-Id: <1570676972-4032-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index ef78b6d..0d510f0 100644
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
2.7.4

