Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE76221874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="H7yKvN/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCTPmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:42:42 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33202 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:42:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4D473BDA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6fFAPjlo8M0Z for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 10:42:41 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1C8E6BCF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:42:41 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id h82so1170221ita.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bFfrjurZJiusr/r9n3XebpAudrU9ZgSouZwuOHkTTsA=;
        b=H7yKvN/8WbZQ+dZfbGTqrGs+fIb91XcbcGTkNMJgC5LsaLhvpgmHbjKgBNdO0tIuvR
         nV59POarD13MeumIlYfoib3MF3QH8p5MHU5rU6ZMC5Pv5/1gz3vDysvZR5qbgbQL9Kp8
         fyRG0duDmPzKS5AIM91I1Tz8quX9/zWgqdwG10BVXGARR+bkv+NW9jQ5K4qnoVNk8W/I
         yexJzjuh3Ee850jyW5+HL93qAqtFADKTJtdaV9SoCG0l2fgmWua+r7yA/6Iyd/+6l46A
         mE7GTLQboZPPy6Y8igT1sePlWfogrYKNeQG9p5QP8QdXtEod9NMu7fLVsSpswdGy+lGB
         V1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bFfrjurZJiusr/r9n3XebpAudrU9ZgSouZwuOHkTTsA=;
        b=ggg8FVTRf3g9DSz5Nl315hIapSDAyKRO32yH1ghRqRRsDUqSKC5cuwL50tmt2yZz3k
         ia5W6EBCxSx/VPdXwKxCihmlp/CYLIzczx4h7jj/thtcel2Yvu4c2XDAijNAwnlu/pKg
         wTtgl+57DX6MYq7RZBvRRjO2xlpHUhxkIrvGuFZ94GTabkOmak6T4xgQE8O+2OdlTCsv
         gG6gWGtfz/pcpz8+vDRbALX46zWn3A1VJyOIo7k9l4fGXfhHr6ahsM5P1jdy6QQTF51u
         GaJ6p9iYqM89TBLitET20qp1ytBws8vVIBXxJ1tvrS0nyQ2EyPXSz9bmqX/4Q1/Essrk
         /oUg==
X-Gm-Message-State: APjAAAVQw8MJsUEEUNw6WHef+Res38B9ijk69cAVcEtQUnekantAbLqp
        4vWCr/NP6t1r1eLq3lNKNikdzU2eAzMoKmbakCKfBuMxDb5HVziUWlAWo8Fikp1/2UDz/xbHq3Z
        qQXY1cTmxYSyf+I/DMbaRoicpSFtd
X-Received: by 2002:a05:660c:50:: with SMTP id p16mr5404428itk.139.1553096560779;
        Wed, 20 Mar 2019 08:42:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUiNpMB4BAem39KsCtQT4tI10IWBYI2ehOA4F7+/m+3MX4YibKsQU1R+u96EN2SE9vDYjvrA==
X-Received: by 2002:a05:660c:50:: with SMTP id p16mr5404382itk.139.1553096560239;
        Wed, 20 Mar 2019 08:42:40 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z13sm944355ioj.21.2019.03.20.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:42:39 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc
Date:   Wed, 20 Mar 2019 10:42:32 -0500
Message-Id: <20190320154234.29242-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phydm.internal is allocated using kzalloc which is used multiple
times without a check for NULL pointer. This patch avoids such a
scenario by returning 0, consistent with the failure case.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Move the signed off line above
v1: Patch collision with different things, fix as per Greg
---
 drivers/staging/rtlwifi/phydm/rtl_phydm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
index 9930ed954abb..4cc77b2016e1 100644
--- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
+++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
@@ -180,6 +180,8 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
 
 	rtlpriv->phydm.internal =
 		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
+	if (!rtlpriv->phydm.internal)
+		return 0;
 
 	_rtl_phydm_init_com_info(rtlpriv, ic, params);
 
-- 
2.17.1

