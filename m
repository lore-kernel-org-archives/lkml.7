Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8846C216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="MBhySszZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfFZN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:26:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41284 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:26:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id y72so1226319pgd.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KkjIEWuvBf7zc0GINznLy2IcxBym+z5vEk9sZ3vG7M=;
        b=MBhySszZUbVd8/OYyYuorpH67jBzTVvfKEb3Yw7Vk91sRSJr91KYR5gVMCnad6IxAe
         2T5c7TjfeskPmXYDTJXiKuFSDmg/RsH8Nb0YdmjPNFLUqN6fQsqMtGyN3ekzzULUSkVh
         9hsfbLFcPiSR989uNqZHtW8C5ZD8sxhQ0UQZ1n7WQCE05VqvP7oT6YoFvpBLT6CPtiS6
         5QHAnQDwxeiqy73h3tNIKipFC7SIRRYar5ACYqQk4ZIYHRAeNf+EhbpCTjxCw0rJ+lGt
         buFi1/SNjrz2R0lkmeobmNJ8cqyPHMxrT8BxhX4p1GZaTMBkPuiJHZV1ilDVFn0kbCPm
         oeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KkjIEWuvBf7zc0GINznLy2IcxBym+z5vEk9sZ3vG7M=;
        b=BpdmzBcjSKQHQnZBqivM7kCspOObvpeDtPz/p0dq94kvVwyYVYRdicDpFTfT6fhnt7
         RPQCin6MB27zNbYLAoohP4Fs+pPk6PsOSsVkuDQRKGdl1pW29ESM8gZshbcdsYAHqwRc
         eB5skuiaUGAQJOe1dTUkYSSLzV5evX8AlO+bb9Cgdj4aY5Udj9ILrSZvQ2HSBq/JyuJ2
         +kVl/XEZcnwj4Az+JPMzNEK1LTQ37QeX6SjrSehq4j5DzUY+pa1pmRp/em/KKsVWjXgc
         AIQN7tDBWgw2883UB5f1OoA0A6UX+YgkVWzhcliUMk36EZqoTuCmmC0gWLTaYdNuQMCi
         ODOA==
X-Gm-Message-State: APjAAAU7lEm6ulOPVhJn4QPqMsGcSYClYIAVl7qME6+/BFxzHJU+Wapq
        RpmHEYTI1JRQtEj6jIWo6//uJw==
X-Google-Smtp-Source: APXvYqwPGu55AjfaZd1TTCWoTMolJzPxRrzyUyXSP/xhSDDq2xbvtu1VChXYl7dFT/JANgcf4Rx5bg==
X-Received: by 2002:a65:45c1:: with SMTP id m1mr3137351pgr.260.1561555615012;
        Wed, 26 Jun 2019 06:26:55 -0700 (PDT)
Received: from localhost.localdomain (36-239-239-167.dynamic-ip.hinet.net. [36.239.239.167])
        by smtp.gmail.com with ESMTPSA id a21sm28649147pfi.27.2019.06.26.06.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:26:54 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Milo Kim <milo.kim@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 1/2] regulator: lm363x: Fix off-by-one n_voltages for lm3632 ldo_vpos/ldo_vneg
Date:   Wed, 26 Jun 2019 21:26:31 +0800
Message-Id: <20190626132632.32629-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pdf
Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
000000: 4 V
000001: 4.05 V
000010: 4.1 V
....................
011101: 5.45 V
011110: 5.5 V (Default)
011111: 5.55 V
....................
100111: 5.95 V
101000: 6 V
Note: Codes 101001 to 111111 map to 6 V

The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum voltage
can match the datasheet.

Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lm363x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 5647e2f97ff8..e4a27d63bf90 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -30,7 +30,7 @@
 
 /* LM3632 */
 #define LM3632_BOOST_VSEL_MAX		0x26
-#define LM3632_LDO_VSEL_MAX		0x29
+#define LM3632_LDO_VSEL_MAX		0x28
 #define LM3632_VBOOST_MIN		4500000
 #define LM3632_VLDO_MIN			4000000
 
-- 
2.20.1

