Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16987206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HcVWnhPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:21:24 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45910 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:21:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47dzDz05z8z9vhYt
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kQC3kW0Rk04H for <linux-kernel@vger.kernel.org>;
        Thu, 19 Dec 2019 11:21:22 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47dzDy5ld6z9vhYj
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:21:22 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id 16so4496467ywz.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZet5/8oAF/RkVe8aOI8XLGZBrvCqMDHvpE19fg8kTA=;
        b=HcVWnhPGj57k0g+tWAn2Av/8Bukx9CzCkdb+BN1itEFxQINnpef0Jd1yXfwSC9aAf8
         yRH9lEj8qOgs0MS/Ta7ppmyMwGgn282Rzvq5DVm9Lux3/EH3ZoJlGvY4lSlea+Wtya3a
         eCGR/9Zc0H7rlQv6d4wZcHU8IVBL81eHfL8Ufs7hlLEXTiXKOCy+LXM9KTGMRuVnRj27
         jx/kYJa6ik9/UtMZu/8QArDjcLD0l6Nze95zhbHxHnFvMz1aMHKbDa0IXSwURWskQUCW
         +Sormf5EHb8z/RnLAbFmnEaqY5/v1/Z6oM0CYQbX16+D/5HceDtXt955S5lv9F89VoFG
         PDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZet5/8oAF/RkVe8aOI8XLGZBrvCqMDHvpE19fg8kTA=;
        b=bFH/Dop4qk//i4kxdqoDKAm9G+G4K8f7VTMdLI8poLBzOjeM9/e1h30FuTxiaPVNwS
         E3BezaI+QasA+XBriRmvhHoX8mUwvIiVNqyyVByfqsrzkQjJFNyv8xl4t87KOyqUjxf5
         GQUR/17cHXiVQef6dg1oEROqQeABO9GhoS5pbu2PMmF2p/KOlf9SacjIWk8w1RmCYpyp
         QBTWCoR7qRL36NjhfhM8GthZrnlbzeOOP+HBWPgFZ6yZy73EPhqVzRROcsTVTFDlO6MP
         niWxsKnH1grJUXu+hK3RQZX4fJA5hCwYe69qXqx2CRfWksJn8EjMziyec0TG/ijzdgxW
         j5mw==
X-Gm-Message-State: APjAAAVbYAdVvN8HePFskey+IufOSmnJI0aKUqIuPphOayySD2BSFek0
        eq3/xnJFceDv52oJtfVc2wyjJf4/KrpRrkWx6PXpXE7H/Pj4t7rkh9ypdQwJ+9UjonWpWhtxx5w
        QLQJZOlcve5GtRoln0f48HXp2G+IU
X-Received: by 2002:a81:8451:: with SMTP id u78mr6848979ywf.127.1576776082215;
        Thu, 19 Dec 2019 09:21:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm6MhF/Zip53QgVRHuvPGYfTUuzQeQ5ipzeYUp0KU1vA33iZSd8Cc0ZwbsC2mIH4Cj9Bl8HA==
X-Received: by 2002:a81:8451:: with SMTP id u78mr6848962ywf.127.1576776081989;
        Thu, 19 Dec 2019 09:21:21 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id h68sm2696217ywe.21.2019.12.19.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:21:21 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vandana BN <bnvandana@gmail.com>,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: kpc2000: remove unnecessary assertions in kpc_dma_transfer
Date:   Thu, 19 Dec 2019 11:21:11 -0600
Message-Id: <20191219172118.17456-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kpc_dma_transfer(), the assertion that priv is NULL and priv->ldev
is NULL, are never satisfied. The two callers of the function,
dereference the fields before the function is called. This patch
removes the two BUG_ON calls.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v2: Also remove BUG_ON call for ldev, suggested by Greg.

v1: Replace the recovery code by removing the assertion, as suggested
by Greg Kroah-Hartman.
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index cb52bd9a6d2f..40525540dde6 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -49,9 +49,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	u64 dma_addr;
 	u64 user_ctl;
 
-	BUG_ON(priv == NULL);
 	ldev = priv->ldev;
-	BUG_ON(ldev == NULL);
 
 	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd) {
-- 
2.20.1

