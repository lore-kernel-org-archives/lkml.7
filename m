Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1E20650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpMmeBjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfJJDNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:13:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36917 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfJJDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:13:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so2948464pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZQcFgWUIrTcWj7FyEedzTRJF4iB85mO1ITqvOndRRj8=;
        b=ZpMmeBjM7WLUJLHtImTbPCHC6yufQ4tGvkyHc35VqQpOM9u/hUsfG3SRdnXx9D5Sz6
         3EpL3CW1Kcn/hUkWVnpPlXgFij00bHxnvOOKR6JuUqjN/A/dhMdLTWY1a6JAMtofNuaU
         QWr0wqeyFwifaHbb6fGw485T+AY5jYI09qdERMvvSSZqpetr47+Lm0rr3wwLrmytIAWD
         6OOwe3Zyv37gI6hFmaAbtWDme5BBS5axWUpb1qVcKzmeu9HOMDX7Sy8AN4b+rlxJmhbT
         abVQODQTIfQ285K0G+UXNvC0KHGu1mDlrqWtp+tBXPGhlfCGw+Jzil/KUuyVXaNL25QT
         gKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZQcFgWUIrTcWj7FyEedzTRJF4iB85mO1ITqvOndRRj8=;
        b=pwrQeYfOqyAZBNo/1YaDfc/foZy+jv4PM59VM5iXGYpo7k9GGjLN04ioaofaVNUCNP
         bV/Fulki6vCZc71JSDFdcZXg3SCleL/yAvQ5gpSj5crFoUnHGKAYG4NK7lbrZ6jciAcX
         0K8kVb5zvNwCO5W86TBwn0Vu+O7kdyaXNXV7vlX/Xk4iYEjLEfULOYOspQquxl26LXzo
         7NrOXLorAOAotinYT8rbsilprm+3LGpxu1PX2e+b8CR+DZrc4zkdP6IUkNkpyeJbXeGD
         e5veyp2pVxXehIcvX7Hk8sQXISliqsY91n+I76vusLc1a0pxENwVeAVYHmmBfNlPfXNe
         iLfA==
X-Gm-Message-State: APjAAAVWvilO3B7A0Mdc+0voqNq68e3VfCigzbQSGBS9aUTTayH77wTJ
        1IALv2jHB0RPMQuJjUCmy6w=
X-Google-Smtp-Source: APXvYqwBO47alOWhJ/L2D3mbujH52tPnfBNWao80sTi2OzvKzEqXncqlFQnTWtVg1oKKEux4yMsqBQ==
X-Received: by 2002:a63:231e:: with SMTP id j30mr8348953pgj.419.1570677199234;
        Wed, 09 Oct 2019 20:13:19 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id r23sm3712164pgk.46.2019.10.09.20.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:13:18 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (Unecessary parenthesis)
Date:   Wed,  9 Oct 2019 20:13:10 -0700
Message-Id: <1570677190-4301-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: CHECK: Unnecessary parentheses around table[i]

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 2082d86..e702ada 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -478,7 +478,7 @@ kp_spi_probe(struct platform_device *pldev)
 	/* register the slave boards */
 #define NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(table) \
 	for (i = 0 ; i < ARRAY_SIZE(table) ; i++) { \
-		spi_new_device(master, &(table[i])); \
+		spi_new_device(master, &table[i]); \
 	}
 
 	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
-- 
2.7.4

