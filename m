Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D3C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BBB20663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="k7E1pG+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLUIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:10:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37550 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLUIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:10:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so5188955pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 00:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2QmcthC509cj/Eli7yMbtVeL3DFFQon0cv5ps2fld8=;
        b=k7E1pG+gptopsZpkb7xBs2FacvzybhT00CmylaWlJvb8S1IOU3DVUi6W+KcHWoV7Hn
         3XrD+M8K+B1WM5GWNs+NBZJSia4qJfe04zXDx63bJSGLYCS3wIYEx/s9IMIjeFgesWjY
         xeZdORgpL/Ot6bzrNc5Ei+AhSA1DUT3WtB+fKm8GcMQpO5pyiFGFaRSjhumjHS9qCYlP
         GkByatqVKIvMDLrbFO3SaSLzMZ2Js0mrGuuCNdJ0J85WQ16NJy1gohDJuX3sQFjvQphD
         wVNAtYn8erqHztFvyZmMqRPK6z+6HIYkuvKD/U6F6uQ3PALERWJ/Ms6KmZ9Vi9g6/WAX
         JhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2QmcthC509cj/Eli7yMbtVeL3DFFQon0cv5ps2fld8=;
        b=WO2LR51TCJ8e4PCm0kllKjE5dcq+CvLgKngPN84U+GB/Mx1gGQNFOCLjUL6G4zhB8r
         z4bqQM/ctmsfaSzoVrUyoBEfGlM4EhLjxR4pgxRVgqLQ3G0eMwtoCf8DMMq250Xc44I0
         Qg6k/y41xWaWuaH3cRcXfgBuVUuj898IH5DK6yMZd8/++1WytnR9tbBpciUXTX6r2GtX
         RiN+lIOyWgyYeM/8Nud4DwnvqwDpjLZNPoxYhK258/XdKefY5kZmqEMmJUSSx1YCQer1
         XACBSHpmlxYJeNCKhtVhnER/dz70fQZqyOt7mQuRt+jpX/60gSGagRzkRN/oUyuRrDVE
         qcag==
X-Gm-Message-State: APjAAAWsoqlGNRXxCWZs8J/XRioYR8bIE0aWzeBVQRqVQl25dPFcZSYW
        5LFfKo97wmKVtQRFDUSQcnzysQ==
X-Google-Smtp-Source: APXvYqwaTwLS3KQkICvTV3yz9Eozslv+UH1ExiXFjtRGKR7BnMLYsKGQt7clw5XBQyYV7DBk6uJFTw==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr21703816pjq.11.1576915858612;
        Sat, 21 Dec 2019 00:10:58 -0800 (PST)
Received: from localhost.localdomain (118-171-138-160.dynamic-ip.hinet.net. [118.171.138.160])
        by smtp.gmail.com with ESMTPSA id k44sm2484425pjb.20.2019.12.21.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 00:10:57 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: axp20x: Fix axp20x_set_ramp_delay
Date:   Sat, 21 Dec 2019 16:10:49 +0800
Message-Id: <20191221081049.32490-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code set incorrect bits when set ramp_delay for AXP20X_DCDC2,
fix it.

Fixes: d29f54df8b16 ("regulator: axp20x: add support for set_ramp_delay for AXP209")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/axp20x-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index fe369cba34fb..16f0c8570036 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -413,10 +413,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 		int i;
 
 		for (i = 0; i < rate_count; i++) {
-			if (ramp <= slew_rates[i])
-				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
-			else
+			if (ramp > slew_rates[i])
 				break;
+
+			if (id == AXP20X_DCDC2)
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(i);
+			else
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
 		}
 
 		if (cfg == 0xff) {
-- 
2.20.1

