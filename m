Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A83C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718052077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AK7td0w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMQNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:13:47 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:43532 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:13:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id C1A5AB1C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ykirlwYn0AjP for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 11:13:45 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8D377B04
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:13:45 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id v3so1968017iol.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=32vpybNlcaMFCXXUjSPpB2GgCaFhoq0xtr8trajNy9s=;
        b=AK7td0w7RxPG9s4cVmdHrpJMDKDzm/tvYAqRpITz3RoI3chFIiKzxdfJ0Y0fWeDruP
         TZYZIDiKGYQfOjcajzlxv89xTZGieWN0VHq1zZCnLuhGkzHm+xtTYn+a9Wp+hyqSVn51
         q5bOpfAuGsrBCCK31Vc7nt5OaeH3A1ngKLpOM6dHv4QJHS7mMtkNz94EOuiV/VaPkWr+
         0/xU3sTjNVzTZZYJJ4RbW6IQMAKGaF6jdd6phJ5G3LcMBMv+Tt3qdVKIB73JA3Ret/5F
         mIrnW/gqpDibO1sNvit5A1hiWqUzziu42xTc8mlD2gPQOsR543HWjeFbzRfMKnPSdD1C
         OmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=32vpybNlcaMFCXXUjSPpB2GgCaFhoq0xtr8trajNy9s=;
        b=Huz7oXSrDvD9XeJ+Z8fWWO4LdIlcR+kdrIfWYKQV1AGB7WwVMrXgY4+HTS53B7EJuD
         gQwYIcsJfbAtfktoMEsFUtWL1fNvG7QaDTiiI+Pc8rOFqnVWmRpWS5sehpzMo9mXINTk
         JfaQ/ClRI6wfnnINQI6FWRNYInLDhH4oGf36z32uQildwPfTAB/XIdOVdmWMQAVhxfvR
         MVqCtpS0I8NbU9858iTJGw+FiA/Fs58rA78jJX6mCgFDioLLDbFujocCOwtLbvGwrhD/
         PQzF7rcgkIm7ycstr0JxnHCCPJLgcggwDgz9SRUYNJwXr36cLKw+/1KYAmhWVRAS1YW6
         gtVw==
X-Gm-Message-State: APjAAAXvpOQFDkDaHQEosrnsoyzOMzpYQzG97jfTcmYL6if2BydU01C0
        0gtgq1KF06vY7x21sZPCm9SnEyvGVvh1xdlE0Z84l9In2PPcGKvV9r/uWhUz/Axqzj6HkH3Kzv0
        /R19AaF8BCHht6WMR+o8+M0KKIKtS
X-Received: by 2002:a24:5e47:: with SMTP id h68mr2219003itb.157.1552493625161;
        Wed, 13 Mar 2019 09:13:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8JjpVREd937rXZ8jU8VGJfXE0T4d2yRwQoMR84Z4FFffx7RijwATFzm4oy7ec2xZfN8+GWQ==
X-Received: by 2002:a24:5e47:: with SMTP id h68mr2218992itb.157.1552493624939;
        Wed, 13 Mar 2019 09:13:44 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id t24sm554915ioi.66.2019.03.13.09.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 09:13:44 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: Fix potential NULL pointer dereference
Date:   Wed, 13 Mar 2019 11:13:34 -0500
Message-Id: <20190313161336.20182-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phydm.internal is allocated using kzalloc which is used multiple
times without a check for NULL pointer. This patch avoids such a
scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtlwifi/phydm/rtl_phydm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
index 9930ed954abb..37c7fcb72b65 100644
--- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
+++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
@@ -181,6 +181,9 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
 	rtlpriv->phydm.internal =
 		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
 
+	if (!rtlpriv->phydm.internal)
+		return -ENOMEM;
+
 	_rtl_phydm_init_com_info(rtlpriv, ic, params);
 
 	odm_init_all_timers(dm);
-- 
2.17.1

