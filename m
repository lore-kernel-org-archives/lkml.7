Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC614CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB2F222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="I3KLTDHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504057AbfJRFFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:12 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42224 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504037AbfJRFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1C357CBD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8X8NkepSQaWy for <linux-kernel@vger.kernel.org>;
        Thu, 17 Oct 2019 23:58:07 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E9125C97
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:58:06 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id a22so6882040ioq.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DvCdMzTpfcgTdM5FNIL3SmoCatqgS5bfknocDxp/cjQ=;
        b=I3KLTDHTGjfBbu0VTQnqOAqkus9ZWIle+c83vxb65BuPr+SnL0WXvRA0zgd9pSbhZY
         /jWnlNxJKkwZFARVmcNBBMBPS2G6RcmJNJL8kMRNIoxE6AK8gOXt3Mi8mrBZAwdhPK7s
         clBOJbFg40XKT+cjSUutDThqhI5tnTWaTsnwPiyDi/vNGAMdzvyyNJ6jml0YAqxekaOE
         2Rjt7GWqH26CUYDPcBS0QReinF6ejqKrB5o2tECtDc5yQOsFxdQbzomV8cfMG8ZVUbXv
         BdCPdThNmHEamWpFrHf1n7Hu9+Fupw2xuTj1R0Ffpto77qLteWEIqilNOLD0uaigZ1SQ
         AGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DvCdMzTpfcgTdM5FNIL3SmoCatqgS5bfknocDxp/cjQ=;
        b=baa80CCDdJJVFwPNPYYkxEMyiFqtplLXk8USss1J94usonkMUYZi/TX1U8rc448RAh
         z9pAqY+FM1eyEuwSmRy4aE1ovCk+Ru/wDe8YSzW9miLX7oCTcAkTkLkIuTk2PVTDddgH
         kDBmlCBFlP267a2peovm5f1xaODZs5iyWWiMFTPlcMhpHSaYLnqYUoIydcsn2ImuAAWU
         yv7Hgv3hCcZ8GAqmyYybEGf6HnwBEDMMx6jyuGrb0Tmp5swyDAc531b4dOFYoaGGOvGo
         iGpZDX7SLIfIPMbwZAaKWQYZpYvZw32ZSkLQO9I8QRYxTcsk42Z+AY16w4rkfk441ut4
         QAWA==
X-Gm-Message-State: APjAAAXrDbFQehu0+dY/WGCzP64S8xnvRXAsXOu/i/+ACyqramS5uwZU
        Ti6jGPGGZI8+1dl+DJBzbA9c38K5Cso4jogXdvPbQy0z9HQ6jB06dN29ZDDXkBfwaegBxikpV7j
        NDJ7ThbLY3mRS31geca3NAuzi/V9T
X-Received: by 2002:a6b:e401:: with SMTP id u1mr6900815iog.1.1571374686575;
        Thu, 17 Oct 2019 21:58:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwK5CXIQFUEytsTQuW9pdgHMGv2efU6PTSg8JPovkgAAk1DVOm6KhHkLb7Z8PtjN5RTRM3UfQ==
X-Received: by 2002:a6b:e401:: with SMTP id u1mr6900805iog.1.1571374686323;
        Thu, 17 Oct 2019 21:58:06 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v17sm1688965ilg.1.2019.10.17.21.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:58:05 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: initializing the wep buffer
Date:   Thu, 17 Oct 2019 23:57:58 -0500
Message-Id: <20191018045800.10909-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "wep" buffer is not initialized. To avoid memory disclosures,
the fix initializes it, as peer functions like rtllib_ccmp_set_key
do.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rtl8192e/rtllib_crypt_wep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index b1ea650036d2..0931777ed157 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -232,6 +232,7 @@ static int prism2_wep_set_key(void *key, int len, u8 *seq, void *priv)
 	if (len < 0 || len > WEP_KEY_LEN)
 		return -1;
 
+	memset(wep, 0, sizeof(*wep));
 	memcpy(wep->key, key, len);
 	wep->key_len = len;
 
-- 
2.17.1

