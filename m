Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45246C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170FE2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VYt6Pe/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLQW6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:58:41 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53184 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLQW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:58:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47ctq41Rhvz9vKZK
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 22:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Tl8U5ki2QpB for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 16:58:40 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47ctq40Br3z9vBrd
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:58:40 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id r189so4470731ywf.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+DniVWRQRuuRULTt2ujrzvnukyX1kBCOSc7XPdFvCE=;
        b=VYt6Pe/ibVhF8EwUqqP2ezD/BN0JKQLt50DbeCujZ7gLON92O9gMCRaGKpaSWEaTP4
         GDDDjBBmQya7oN/wrQsp0uvpjtB74TjKXWiyU5x9Y12zN1fRY7ndAes0zEZ3GuEQB3qD
         Gw3WWShH2yyJ9Q8U+Lro+3tdvjMWdxwQYJoMtY+X4jhTmNIBnhu4ObdUTDVYXoU7dJ4i
         bQF331CLPi5BBk4MOOXSwDyG0t40V+Fy5hjshWeCbNJ+x8/bh2DJHus1DbvqeEFv59+/
         Em05MaPtSXOI2qbLmg7T9U9aN0iaJxjsH7F/kAaIOP/UWyw+JwtLC92Vs1zb/yn4UbIU
         WjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+DniVWRQRuuRULTt2ujrzvnukyX1kBCOSc7XPdFvCE=;
        b=eJTKv2hwQeR5deZ6SGbfZQF/N92uggR3Z4h+oO9WY0K1Tzdnktou0iKOdCrHYg47vC
         mVmbmPc9jYSNozZLceb8wUCTKdapeq7NM7nefuxNrE7A7NgQig3hh9MRY0FkhY7aMlTz
         82m5O5hsgGRGTf8wOnvv5yu+PLAdwldFoVQQWHTp2c8tOal+9y85hQBduvDdcVpAtE0y
         YJ+K2ZU4/hdfSMt5wuwMLeUfpkBi3752dap5iiHEbrL6ZyzJUFLa+9xc9y9Ip1vMRHPd
         ZhjHN7lY2YFvlT2V6QVwgh7V3hPJVISt7Oz0vgyONmWT2iXkRB+Sz/GlzXA9Hco0q+fX
         QW7Q==
X-Gm-Message-State: APjAAAXSDLbE01a++vMde1YeGVWA8Qxbe4mWC2YiGSIt0pNvQDsOQUzZ
        TUcmDkkymEERunG5a/u0T5gEurUt4uPuC6UWDdC5Hf7e04+Q34EUS0lAjV1ofJyMn2xhawxE5Wf
        RAL9HmIsOlWtXQzD9JI063LCxXVXa
X-Received: by 2002:a0d:d58d:: with SMTP id x135mr1006460ywd.3.1576623519535;
        Tue, 17 Dec 2019 14:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmX6D7gn9+9Ql2XJypQv6Pffkm1nQ5KJROMUeXRvP4hpQREmfGhm2eszWNkQ688r6A4W3lPQ==
X-Received: by 2002:a0d:d58d:: with SMTP id x135mr1006450ywd.3.1576623519311;
        Tue, 17 Dec 2019 14:58:39 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id e76sm140926ywe.25.2019.12.17.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:58:39 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vandana BN <bnvandana@gmail.com>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Harsh Jain <harshjain32@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: kpc2000: remove unnecessary assertion on priv
Date:   Tue, 17 Dec 2019 16:58:24 -0600
Message-Id: <20191217225830.4018-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kpc_dma_transfer(), the assertion that priv is NULL is never
satisfied. The two callers of the function, dereference the priv
pointer before the call is executed. This patch removes the
unnecessary BUG_ON call.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Replace the recovery code by removing the assertion, as suggested
by Greg Kroah-Hartman.
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index cb52bd9a6d2f..61d762535823 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -49,7 +49,6 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	u64 dma_addr;
 	u64 user_ctl;
 
-	BUG_ON(priv == NULL);
 	ldev = priv->ldev;
 	BUG_ON(ldev == NULL);
 
-- 
2.20.1

