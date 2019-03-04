Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3097DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE2B20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0/sVrMNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCDI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:58:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43318 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCDI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:58:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so2522278pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=I8Z1Q2ph+9o6d3G/6/KZbgugiMkWdk4EFExZRqNBzxk=;
        b=0/sVrMNM43CApJzFimnBrudm6Wy+uBu6rWJlUxOpkiC6Mc3nDEhlCvWiz4Dl0k3op2
         qFRBIiyzoGdYDYJHSyftJHBGJPbmrA9Ywj0L9b9c4foO1s5IH39zVtW6mFF5WS8lAlJt
         m7tuz5cZfi82NIfaOfjvaUVycx79+RF5LdVs2PLkPXwDQzOm38Zn43BvA4zp2yWmDRLT
         haIU9b/P6tCJIxqJfgu8tHpt1eJZTRterRp745he0pVg5QTcR+Umyb2U2bb4TYqcHeoA
         tHx4zcrdvXiC3twIUu1YD0d0QQ8ctBcLRs/qOqoP1R6Og2J/fMyaicTC1is8AbXtmCbU
         kwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I8Z1Q2ph+9o6d3G/6/KZbgugiMkWdk4EFExZRqNBzxk=;
        b=fY2lu2TbUO8LJO3vaihGKI1F5RANBer+zyYnaUMAUzpxVw02fszkyQxuSMcXEZUT1u
         pmqGxeCPNxBLRd5TcQ8/+xcIulh0FZIlkFKuAWPE386yhN302hQ32pRIuwnPvlK9X2Ho
         AKJ7W16k8mmdFXO+nbZl5gaEJOGCvdbmCSvYSbQEgTyXF+mCQJfYMoaddxuVpM1MYz37
         3DQPxpx4xkOcOh+32c/+YyrtM2+CcMkOwfJbqvxX1/N7fyT9tKxwD82BvjnZM+kVQyCe
         82EtM3N5u5RqIbcQXC4fbMNXJmapTpQF1u/yWSxBfqINW4WMHXin0eths1E3MMg8Ph1k
         IHiQ==
X-Gm-Message-State: APjAAAU039yP+0VJbMMZDRA7WG46oE+E+0hCdKP0RaA+GSoxgvTxwix8
        0y6KGuv6ScJZzJUUSHiAmmnF6Q==
X-Google-Smtp-Source: APXvYqzpynX0riBgorLybd8FiwOmY6T2EUz65GoCkwKKBENoJBifshKhPtcjY9e8WQnfmqXEteTqIg==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr17243417pgi.135.1551689894987;
        Mon, 04 Mar 2019 00:58:14 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id p11sm14332614pfi.10.2019.03.04.00.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:58:14 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steven Kipisz <s-kipisz2@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps65086: Fix tps65086_ldoa1_ranges for selector 0xB
Date:   Mon,  4 Mar 2019 16:57:52 +0800
Message-Id: <20190304085752.15251-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selector 0xB (1011) should be 2.6V rather than 2.7V, fit ix.

Table 5-4. LDOA1 Output Voltage Options
VID Bits VOUT VID Bits VOUT VID Bits VOUT VID Bits VOUT
0000     1.35 0100     1.8  1000     2.3  1100     2.85
0001     1.5  0101     1.9  1001     2.4  1101     3.0
0010     1.6  0110     2.0  1010     2.5  1110     3.3
0011     1.7  0111     2.1  1011     2.6  1111     Not Used

Fixes: d2a2e729a666 ("regulator: tps65086: Add regulator driver for the TPS65086 PMIC")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Steven and Andrew,
I don't have this h/w to test. Can you help to verify it?

Thanks,
Axel

 drivers/regulator/tps65086-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 45e96e154690..5a5e9b5bf4be 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -90,8 +90,8 @@ static const struct regulator_linear_range tps65086_buck345_25mv_ranges[] = {
 static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1350000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 0x1, 0x7, 100000),
-	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xA, 100000),
-	REGULATOR_LINEAR_RANGE(2700000, 0xB, 0xD, 150000),
+	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xB, 100000),
+	REGULATOR_LINEAR_RANGE(2850000, 0xC, 0xD, 150000),
 	REGULATOR_LINEAR_RANGE(3300000, 0xE, 0xE, 0),
 };
 
-- 
2.17.1

