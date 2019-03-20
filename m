Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C152184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Yt+UUNDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCTHfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:35:38 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:51326 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:35:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 08784CE2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eypDx70Q4w2t for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 02:35:35 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id C6F9BCE1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:35:35 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so1397351itd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zfONtXWLTlknVBIhoCgVa9EP7g4rpRB2fEu/ggG/yeQ=;
        b=Yt+UUNDWNN0N+O2OZXWcRoIRe7qCCsgxUW82ZoNapUOWSFiUj2DMfNUVq4es1N7QQv
         QSqTUuQ9tFxHx9zHJypSKixfozZQ7n2wB/WZgS8vS9xP9zEvBy9Th7jVjktp6SN+WvG5
         DoLsOXUDsA/Jtaz9hYdiyTR/kk5v0WBxesNXi5JvPXF/f2noK3SWcxPbYQe+/hIAd9AU
         jFMJnlxV+tvpIyJKDZEBLOaLH16iCcyx1NKihdFrWYM2p1cRvdMsopOzdvHm32SFRKpa
         OTqDCvD3SdPoqZ2CcpZemZmb4NRRJnDvPRuIl4z5asyF8cAFHt+pIu4Z7UjTRLnT71xh
         logA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zfONtXWLTlknVBIhoCgVa9EP7g4rpRB2fEu/ggG/yeQ=;
        b=T4tKBjX1xn69IxFGFmh72w2FiVqbbxHkhF7yDbbR6B8jygHsDgrLdt16WV5lKUNKR+
         XOws3MuJ+KXbOOmhXVbT3VcmjGkYh49z7ljj92BVSOLg7TFMVdyR6re42dJWb/oxLIWj
         AgMql1UtKgg5SD1MkcGIQRxxw8p73uudaNUZh3DikaJF+Ov2qIeluWgDE//rf0Z+Cefp
         EY6hyU54LWc/aXqn25fcvHmHDBuwejm6TlZeY7H90mj4bPW0p3x7X/cJD3k5T2Iq4Qbn
         FvE5aC26SNWvNkA1iOcls6VqH4jDntDK10dUGymqF5NGsNTaspTSBXmR/mvi1DHOUjXq
         4WdQ==
X-Gm-Message-State: APjAAAVzNgB6sBQ3QjnXOeH1TYautpVZUlr40J6xAODjn5Ayytal1ucS
        M21vI94YOIYOLBOPcaQC29+HmzFXeAJBH5bTifDjGTz3+J3pL5jG6abJiI/es71vqcRNPN2khiR
        9jZZCBgA9MayS6LWWQVoqAOXmnOKm
X-Received: by 2002:a6b:640f:: with SMTP id t15mr4548986iog.32.1553067335423;
        Wed, 20 Mar 2019 00:35:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9GB4JQ8k6yDfTpfoDhp++/yXTXFmeNYPQwlYeWzQgdhNaqp4Ws1NqB4N7zVaA9Zcz/xHwSg==
X-Received: by 2002:a6b:640f:: with SMTP id t15mr4548973iog.32.1553067335181;
        Wed, 20 Mar 2019 00:35:35 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id l8sm762541itl.26.2019.03.20.00.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 00:35:34 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: fix a missing check of regmap_read
Date:   Wed, 20 Mar 2019 02:35:22 -0500
Message-Id: <20190320073522.26143-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b902ff68-3054-80c3-f5c3-658fd0a1920e@samsung.com>
References: <b902ff68-3054-80c3-f5c3-658fd0a1920e@samsung.com>
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
+		dev_err(info->dev, "failed to read BOOT_REASON_REG: %d\n", ret);
+		return;
+	}
 	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
 		if (val & BIT(i)) {
 			dev_dbg(info->dev, "%s\n", *rsi);
-- 
2.17.1

