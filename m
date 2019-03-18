Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B5D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="L8ildnKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCRQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:41:32 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:50488 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCRQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:41:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 42C8C680
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fFT6zl3wNXUu for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 11:41:30 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 0D933249
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:41:30 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id i4so15050166itb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2ag1l3dTyIJNKbLIv9DiWd1m7u6kFyQYVKVYVkCRyc0=;
        b=L8ildnKo9dh7nPdQtFCICziNaVZ/TZpeU/q59MF8dkCgYFOipfZNAaoXstV7/hXGHt
         aTsAk4r52NKJaUN5JCdJRuCa3m1OY/iJjI629HZ5EN2soYwxxoP+CL35tuh4/DCmDy+M
         WKExqfTLbjsaGNIAGewMek6P4ZJ6YdKtfX5skghV0Iiazm0pjBVLZh0z5qRQN/yLGE5R
         JDIsfmE/8Pwr5pWOFmnptzPKfHSvOsMO8h+zeTMXRsL9sdxX1x+PfrnBvePBLSpzgxmZ
         FO195IOo5S/J4JCDNY0e7ACezF5FG1kRzi1/cLggTdmqC8X92BOxzR5ckgrWXD1jrJb4
         25TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ag1l3dTyIJNKbLIv9DiWd1m7u6kFyQYVKVYVkCRyc0=;
        b=BTaiMD7b4DD2Dx6STzydn150mQR77oMgP4fVvad2B46PzMO095N2SEA0dutP1K1Kmo
         2ofSFLlCQOj/VIPIAgd76kWTFfvcGNsJDxFjLsuyJzGSaJIQpSCXXrCywP17nI1UDStT
         XraPP7/od8wAWg6x5nlHYJ1q/T1qQyN+O8bINv3WIwlC5ivhWzHIghkE3wTJi96ECyR1
         l8wX5dfhuZxMnpPLuAj8roYtpwb2aRaa/bB6cXQUdhCRzm+Qsq15e9uBIAXYgG83uYUG
         sphevQbXepmGzkEcjaCkRpwLeuq1wT/sGPMR8HOhiVGnV7E+ra3yjwSijJeEOYNQX58E
         /E9A==
X-Gm-Message-State: APjAAAW5DpWRb8KtE8bWQtSbTz6BnlImMTqtKB05AiY3BijZ7Irp0z8u
        EXXLtdvPchxfTMuRAEfVXyhYgMH9vF/ws/Z3Xjw3BSkx4/xP5RpPkrqyOnqO575LQE2nj2TWiEw
        RKx8vVI0dtWxwrZ9SUbflT6GXC7Fi
X-Received: by 2002:a6b:7601:: with SMTP id g1mr5159378iom.108.1552927289668;
        Mon, 18 Mar 2019 09:41:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFmMAYwYK5Mr15gBj1HlvxnbM057JbdoZHG/TCah7bVCMgW+sJ5UL+EXNdVHzv5b3J0vmjMA==
X-Received: by 2002:a6b:7601:: with SMTP id g1mr5159363iom.108.1552927289414;
        Mon, 18 Mar 2019 09:41:29 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id j15sm379886itb.3.2019.03.18.09.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:41:27 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: fix a missing check of regmap_read
Date:   Mon, 18 Mar 2019 11:41:21 -0500
Message-Id: <20190318164121.13838-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When regmap_read fails, it doesn't make sense to use the read
value "val" because it can be uninitialized.

The fix returns if regmap_read fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/extcon/extcon-axp288.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a983708b77a6..b2ba5f073aa7 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -143,6 +143,10 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 	int ret;
 
 	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
+	if (ret) {
+		dev_dbg(info->dev, "regmap_read error %d\n", ret);
+		return;
+	}
 	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
 		if (val & BIT(i)) {
 			dev_dbg(info->dev, "%s\n", *rsi);
-- 
2.17.1

