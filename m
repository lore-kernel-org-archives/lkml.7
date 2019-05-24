Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7AE2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0jrzHPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbfEXID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:03:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42941 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbfEXID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:03:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id 33so1650458pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNkTrSPrWeWXveHzjDoSXQ5IdGPBHWE+lGuP4zZQGbw=;
        b=M0jrzHPvGSEb/QQcjkX5SYTXMN4ZnJ8qzPhFLxGZxd1MC9AkDd+XcmUa4CKSKzab25
         D2Y9lwHkr42f70AhMTht8xWC/9iG9O67cjGijU4N4VdFttTm6bVu+7RkrqSo2UHZ+N30
         LIXg9adlweQfZgOayvEC1jlQmy+GFgm33xskvgS1t5O9OJ6zl4xz9yNhvJZJ1Um90urT
         Lo2Y7AuXM+DKZKpLxRWx/fiQ5unKTXHZ9Bf070djy70jZoffHBXBdia015ENZsGUdyv4
         vGyRq8lG1CCCARTMklGQe8Ql6+2n/CGqhd+hh11OmgrLHEoRx4nTHIgwU+POuXf1SQI9
         3eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNkTrSPrWeWXveHzjDoSXQ5IdGPBHWE+lGuP4zZQGbw=;
        b=UIt9y4VwsSxInxWoapMS6OLt9daDy5be29qEHoDZ3fehvz5Rvp63cgPoKlXlHBVyBn
         t3d8wFG40o3mEDtFKrteMfxIlDtxAb+a9W23Nm7IvpipXsstI3fWamrqJV1m3slOBc91
         ftJu1vmK6EnPfFe8g/qSWjpznd79BQmh4aJWapy3vQDAxqpZo1BgwsD/GIkmSv8xuhYY
         mphkUGZycKPZ1jycyqR66+2dNuv00STrVb+nTP9Fi5+MMuQ5uaPFmhjuAwHeUILbuNTo
         rNDVONoFu5q0mjLxbXoNjONOlz8tfDek3cHygM7fnOl4EHSg8IhotfHEDhYKOWa1ZUpW
         yzVg==
X-Gm-Message-State: APjAAAXq0iIyDjl6vbZY58JRZNzXUGACtb4htCPS+jbvFHNkMvp59E0o
        zffAiBmbAQHWIXUoBMSiVS8=
X-Google-Smtp-Source: APXvYqyhvamRxC3mOGXVell9YlzIZ6rkR8DMzJTRP8++UqiW0MPrqj9nwS/gxZ33Gx0lNT5yFlvPfg==
X-Received: by 2002:a63:4d0b:: with SMTP id a11mr15759506pgb.74.1558685037809;
        Fri, 24 May 2019 01:03:57 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id n9sm1730202pfq.53.2019.05.24.01.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:03:57 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        herbert@gondor.apana.org.au, qader.aymen@gmail.com,
        sergio.paracuellos@gmail.com, bhanusreemahesh@gmail.com,
        mattmccoy110@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: ks7010: Remove initialisation in ks_hostif.c
Date:   Fri, 24 May 2019 13:33:30 +0530
Message-Id: <20190524080330.4740-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of return variable result is never used, so it can be
removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Fixed typo in commit message
- Clarified subject line to include filename

 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index e089366ed02a..3775fd4b89ae 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1067,7 +1067,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	unsigned int length = 0;
 	struct hostif_data_request *pp;
 	unsigned char *p;
-	int result = 0;
+	int result;
 	unsigned short eth_proto;
 	struct ether_hdr *eth_hdr;
 	unsigned short keyinfo = 0;
-- 
2.19.1

