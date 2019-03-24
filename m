Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF7C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09269218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Qhxu5P4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCXGAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:00:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39467 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfCXGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:00:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so532396pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 23:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dVkkvvEC9dZji9AaxOK3PlO37wTFCS4BaTFBvJo9Bqs=;
        b=Qhxu5P4OqAywl+/Q0p/ozdJggXaSmjr1Ie6IpdVyZTKhCCo9NvgUN+14aNtaT6fpMJ
         OZurZaoS0HLg+i8sj5o29jFfmumTBWpvk3aR4Q86vrrGUHdo1ljJqOhmkSXDSWYkAFNT
         OWRcHYqg8YjaRVN3yOW/bIPKtRuTKWm+3Re4BJE+GUTMAvNrvL0np0zhLUIp5HFKnRXI
         ZBKAiHznJGpriQ86ycRXugwoQo4NMh1oc5NqUUv14bKfNkbl8KojYBjbz70Cf9zd3IbY
         IsymBEoAwuxnSA5KUu3wUzpqp4smvGRggE8j+jeLyk8uR449Oa+bhaAl9i9Y8/hPZV5J
         zuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dVkkvvEC9dZji9AaxOK3PlO37wTFCS4BaTFBvJo9Bqs=;
        b=eIRpjn03jRTy8Nw7IWMuqrTli512j5xatDXgm7WWpv9m0kWcBJShlmLCVlnyEnv3n/
         yXQ4cg4qkEJVwUvGpCgn678wSuw+BTzIRC6WZE/+PQdDpxwSRFlkCft9RY5haEGU7beb
         eSL+0Spj2HSp70/+b5XElp2bn2D7zyI8d0Kke9S2PjwjUKEnNkxM0oy7HnvHRjYHSYQ+
         0d6ZVw2qk4xgYdl9GP6vty65C5G3laxn9HFIhMASGQ319ur2h2zRSDhXk8DZ1LVtsT6Q
         586bS2M574KMPdesvuuyi5kT8P0Ku4e9tkegrAoK1Lje4M/PUweVJUMn5u92PI97d0TV
         VoWw==
X-Gm-Message-State: APjAAAXf+aNrNP59kRG9WVHfmCFL1W7ZVJp7C7m111yTYF481+zGbnsq
        KQDbi2dFYVhr99N7+GmOFhLUyA==
X-Google-Smtp-Source: APXvYqwlO5hb0pQon6Xdjr+94LaHBkMJT2QoTvJOB2KQjMc5XAnSx88MyF2AhnZwwdrVGyl1is4J2A==
X-Received: by 2002:a17:902:f08a:: with SMTP id go10mr5780581plb.121.1553407217860;
        Sat, 23 Mar 2019 23:00:17 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-125.dynamic-ip.hinet.net. [118.171.129.125])
        by smtp.gmail.com with ESMTPSA id f6sm17426197pfd.115.2019.03.23.23.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 23:00:16 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Russ Dill <Russ.Dill@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: tps65217: Fix off-by-one for latest seletor of tps65217_uv1_ranges
Date:   Sun, 24 Mar 2019 14:00:04 +0800
Message-Id: <20190324060005.22895-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the latest seletor 11 1111b = 3.3 V.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65217-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index ada62f792258..ead31741dc13 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -60,7 +60,7 @@ static const struct regulator_linear_range tps65217_uv1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 25000),
 	REGULATOR_LINEAR_RANGE(1550000, 25, 52, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 53, 55, 100000),
-	REGULATOR_LINEAR_RANGE(3300000, 56, 62, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 56, 63, 0),
 };
 
 static const struct regulator_linear_range tps65217_uv2_ranges[] = {
-- 
2.17.1

