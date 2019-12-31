Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0724F206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuWH2Zd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaRcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:32:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 12:32:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so19789571pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hbn9T0WEquldwLrNS92g1HHCDxMmFMLfGfxo1URZsUU=;
        b=EuWH2Zd2THEALu8UGE3zjlgf109pwcYntt4yplbyc/FGqtvnu6un2uZMV7KrXoMrdK
         ukDw4++LXcFb9/zQawp5v/ob9bMcFx7jpa4Vo5NPnk1453SpPJr5/F+6JEDnlS3HqFCF
         BltqGQ0kNxu8i5BctWf+/Mnh34vmzUHs5MzQULG0MuvfaW/N01ppLZJdUcECWhBOv+Ov
         nfbg8kiOmYGw2JKE6CB1tkrICaqyhcMJZsIUYZWnkRdglYX3/C7Uz4c0MPC9S+E/8Iqh
         rFr1YFWFak9Wg/VfSCt/aqiSI9pMcxcxsFRp40d7gR/jWosik/31Hiy8PLVN5IbhrVga
         qfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hbn9T0WEquldwLrNS92g1HHCDxMmFMLfGfxo1URZsUU=;
        b=D+r47QK8IDtp0nD8RhTRzqAD5XbxnNGEJrMZG0n+NwlyiSj5CqWDbYIGH7SU/kRYtO
         u8H8lh/OaPMeELrnyynGcPRh3LDbzPH4bpux3KJCq3PrXzE/0bUYyr3a+R0aQYeIXDZO
         nm7HmFLzUz7cn+glx5tN63yobYgIasZYTAsZ+boDlTboRxby3OYL3WqY9UnWUqO6JESA
         SJljE1JLAofuV30jUhHFuUrCIoDqUrWaeDzQLaUo21pSs0KADsMTaLmsSIO0o542eieO
         /KGE6OjZkiOKGRn+MFWVLiGwjT4vPGtgWV5DydciYqi2VsBT48bnBPOlFkJHN8XGc+/J
         a/+Q==
X-Gm-Message-State: APjAAAWZKJ4aJ0V0619VurSP1MVk7icgZjIEsDH6G8e0kEFnnHZv9kAp
        7hXb/GvWBGu9M8I50W0QOI0PXIUo
X-Google-Smtp-Source: APXvYqymkI+kJ1i4YKRNSQDAzsFguiBNc5qIzGlZa2E2sK1tVIlbgp4+Pyp7rV+/luBXzfGAr3n64Q==
X-Received: by 2002:a63:c652:: with SMTP id x18mr79704741pgg.211.1577813529749;
        Tue, 31 Dec 2019 09:32:09 -0800 (PST)
Received: from localhost.localdomain ([113.30.156.69])
        by smtp.googlemail.com with ESMTPSA id o19sm4915232pjr.2.2019.12.31.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 09:32:09 -0800 (PST)
From:   Mohana Datta Yelugoti <ymdatta.work@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     ymdatta.work@gmail.com, trivial@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: fix a gramatical error in the comments
Date:   Tue, 31 Dec 2019 23:01:42 +0530
Message-Id: <20191231173144.13077-1-ymdatta.work@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a gramatical mistake in the comments which says 'an dtb'
which instead should be 'a dtb', as dtb doesn't begin with a vowel
sound. Fix it.

Signed-off-by: Mohana Datta Yelugoti <ymdatta.work@gmail.com>
---
 arch/arm/kernel/devtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 39c978698406..8883caed6cb6 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -202,7 +202,7 @@ static const void * __init arch_get_next_mach(const char *const **match)
 }
 
 /**
- * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
+ * setup_machine_fdt - Machine setup when a dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
  *
  * If a dtb was passed to the kernel in r2, then use it to choose the
-- 
2.17.1

