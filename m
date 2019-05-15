Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC4F20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0XrHxsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEOQRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:17:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40672 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:17:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so217869pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7vq4AlrJPt4Dwx7WQQ5gbytONnLDP5sNc25GZicQR2c=;
        b=j0XrHxsd4qrp8xmr3LTznq8e7py2bTdDHS5A/boMDtTVxOojkbpeL5DBwOcSKCFNCh
         qAj/Dtzw5eSOpOswrw6cSbg+0umNScGnedAyBWq8jxsEADlP0R0FD+Hty9e59yk7kDUf
         nC0epe20wvojigw7tlMa9G8+liH42frhfmqPPCLq9YeA+qR0em+rynLXX27cgXUmNFoU
         1Jlt7s5z26CanSGpunYO6bNGBcsnoqUMs/NHpQmetgNBCP2wH+og3ZyznTwqm71ESs7m
         oaNay9NWN5OTctyrFTCZK8FIFrHbtTsnq4AC5iO1M8NQ+OuFg/N78mO3GX9WMk0z0Bo3
         hDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7vq4AlrJPt4Dwx7WQQ5gbytONnLDP5sNc25GZicQR2c=;
        b=mp0gViKl8QgR2p+qcxGlpIs90yX191A1ivcqrfK+13R6MOZ39CyDYsGXXDJSCEyTt4
         XsgDokCQ/NzYgbLIe/7gWc+wWs/6WBZa2a5zTeFSiGOE50KwMqj+/rfRw6vAd+ZM50rX
         8kthOLDDwz6TK68Ka/F04POqZ1hmJgNMpFbPO5avpeOrAetG6f8Ru+r4P8OoED/+C4CV
         Ip4d+PXn4dtbez88wdKp3mddYhdVhb/QE/hY/cCirioUjD6Zz6wb4rHyvA93LuURFsZ7
         Ow48Uip4869tBj4fZ5a2pvlFG6zeLwmZBy9Ic4IZIrMK4FqkvWp5ka8JG13gRCRN3D0y
         QeNw==
X-Gm-Message-State: APjAAAVcvQ9pS+83/fFwE2IT0E/8bc4HpH/0OyA3cvi2HWPtgbRBhgOE
        YTvAMa6nu8+BV7AtxSFmj6E=
X-Google-Smtp-Source: APXvYqww8NkFW5yc1etXwL0rZQ+1hElVX5Nm5zcgVJk30J62idi2EhK9JgjRW8MHNjtj5l3S5MzLfw==
X-Received: by 2002:aa7:9f01:: with SMTP id g1mr35481640pfr.259.1557937072867;
        Wed, 15 May 2019 09:17:52 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id b4sm3261807pfd.120.2019.05.15.09.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:17:52 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH v3 1/1] bsr: do not use assignment in if condition
Date:   Wed, 15 May 2019 21:47:46 +0530
Message-Id: <20190515161746.29034-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

checkpatch.pl does not like assignment in if condition

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
Changes in v3:
The first patch has an extra space in if statement, so fixed it in v2 but 
forgot add what changed from the previous version. In v3 added the
complete change history.

 drivers/char/bsr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index a6cef548e01e..70de334554a8 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -322,7 +322,8 @@ static int __init bsr_init(void)
 		goto out_err_2;
 	}
 
-	if ((ret = bsr_create_devs(np)) < 0) {
+	ret = bsr_create_devs(np);
+	if (ret < 0) {
 		np = NULL;
 		goto out_err_3;
 	}
-- 
2.17.1

