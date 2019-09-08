Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 03:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933CB214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 03:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="PeaqvvgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfIHD5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 23:57:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfIHD53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 23:57:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so5785619pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeVu754P9nGKY9RPZJvtpgzUUQF10TeTVJ0yPC6Gaek=;
        b=PeaqvvgDUDyujfI3H9NTkjbN5jvhPJJ0EqSJ9YIwJOKhd8f0NtenrqfKeK1tkoky/z
         XW+ngMJXWb7pMm/w+6efDY/WsEov4xPfHN1b1xB2+3pQN4TQa8Qse6ldKwPa649eO47l
         5aXoAO/HkipkFd+mPoDJAfJlihP2Q8diLmcXtmrpyoc8cYuQfPNr+61GJcQBU5/retYK
         SdxzVn0W588JwlqLkgfwuXOy39JPgXXhqhzv9D1VnZHvAvBlKkMmBD3j9I4XLuC1l3w+
         kPOfDir+fd6cR0DSgDHZgmgxQGeC059AF2LeGeEeRe/W/0Pdh7apNbdTR3+oHvwnPxgF
         Kmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeVu754P9nGKY9RPZJvtpgzUUQF10TeTVJ0yPC6Gaek=;
        b=XQUzOdeVPhRl/bWv0j0ReQ35926ZQVt3yJ1DMBdjq9by0+u7KiRu64Hl5moB9UZHSe
         12FK7K4cA8PnKGq+OmxKYMildaRC+QU39TA+pjx7K+a6B3Epg+WkJYxoc1dMYrhqAiH3
         aaAjF0zbbX+Cd331cxynyGFUan/mNEpZCJ6cVXKeau/EdMX6GJlRzwMCtce96hPWHcxr
         3GFF6MC44oJQRNCBSvuwpsSBtH836Q6c6FmwhPbzvU0gUrzyAxb23gxcAC9kI/XvwPND
         EdF4Mmdb9eiVfgp3NGCvjThsmQ5g13oOiUdDosygJcRJWWMLd8ob+aFRJUFAYiFFoGtm
         DLnA==
X-Gm-Message-State: APjAAAWb1FVBdGdwa+xFMcVR7OyJPnMUv4pHdIw1H3qlyWxiE8lXqeOw
        MAN7N3YUFP3XGPqEhWS6W6owEw==
X-Google-Smtp-Source: APXvYqxvNZzLcV1Un93mssw4F/Na8FLNTXI0RZHFibiVSKreKS+Ra6w5O65pa8jIjNI1uKZwf5fIYA==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr20360994pfd.158.1567915049267;
        Sat, 07 Sep 2019 20:57:29 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 196sm10060851pfz.99.2019.09.07.20.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 20:57:28 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: lp87565: Simplify lp87565_buck_set_ramp_delay
Date:   Sun,  8 Sep 2019 11:57:20 +0800
Message-Id: <20190908035720.17748-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev->regmap/&rdev->dev instead of lp87565->regmap/lp87565->dev.
In additional, the lp87565->dev actually is the parent mfd device,
so the dev_err message is misleading here with lp87565->dev.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: Add lp87565 prefix in subject line

 drivers/regulator/lp87565-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 0c440c5e2832..4ae12ac1f4c6 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -65,7 +65,6 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 				       int ramp_delay)
 {
 	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
 	unsigned int reg;
 	int ret;
 
@@ -86,11 +85,11 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 	else
 		reg = 0;
 
-	ret = regmap_update_bits(lp87565->regmap, regulators[id].ctrl2_reg,
+	ret = regmap_update_bits(rdev->regmap, regulators[id].ctrl2_reg,
 				 LP87565_BUCK_CTRL_2_SLEW_RATE,
 				 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
 	if (ret) {
-		dev_err(lp87565->dev, "SLEW RATE write failed: %d\n", ret);
+		dev_err(&rdev->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

