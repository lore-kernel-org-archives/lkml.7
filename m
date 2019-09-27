Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15549C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA0B207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569546805;
	bh=7qtojZp5zJHlXpkEO8yCgrlaXTzo4YIuiYBry43Vq+U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SRQApXq5kwtOBVr6OfdLLhLKoKUxdwFKZ/+20VT8c/wztcS4p6VLFLHdPc1RQ2bfz
	 JiQYo80hUeefcwkvGvK84ZKiX84v5HwdbUa2zE3+oebCF4e7Mr8GqBGx/YJc2Vh1fF
	 15TVbEvKbXmIIkrhL/kj/eRzqkpCQp10d8QRce4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfI0BNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:13:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43662 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0BNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:13:24 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so11718452iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 18:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEE9lOyJedYGEKwzVDnKuOkrG0RTwYW04dLMK0cfVNI=;
        b=aewx8DaVgi2IdGL01e4RMmtoymyhqnU1GKAbN4jN+2MeIAH5LDTe27X9hTI4aQQZ6v
         9TRC9vcS29nS6XOnSEfGzgsIU6hpszM9EamSBK20+M5v1RzMXAoG5eM5ccdafnaMZgsC
         j7Jiv/gSplXSNatW+xjRZG6YvpXWe+QvxtcNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEE9lOyJedYGEKwzVDnKuOkrG0RTwYW04dLMK0cfVNI=;
        b=GHd3M6aedf4Egh4z87vJCQZrbu4T5VndNNFc2JqXCVt8XYnbmsam9xXgnl3ZeC+mn+
         zj5M0vYiIP6sBJJ3q9QDp+PPGqAWwL6ZZalYtQbqSuNR4KT4RwE3OwEQLkDDHt/WGdk+
         PcTffvtAS0+2NRPYEAWw3vKxd4lydjNV3pAn239dBAc2V4SX3yZ98a+6deGIP79q3CPw
         oZ3mEvda2a7n80rOGJvfttTlBXlWgCFweSw47XM0qqKqNs+rYJl/BGrvA3fLCcWXrdZ/
         Vy6TuLMwmrzn7ooI0+2CKnDEgWlC20nMQTV19td5KMscEc0Ier6rnIWPD1bEbddm6l8r
         1bFA==
X-Gm-Message-State: APjAAAVLVWZTyUqYXwL1gjgMRZzgGgmjoNwC5K1CoR5YPmwbcDaLeQ7T
        K6euKcte/JHHiCm03Q3SG9WdIA==
X-Google-Smtp-Source: APXvYqyi25JQWLz5zuPdbjoyS7rTFaHfpEmPpxHwSsRTBjT+rhIcseiZPcgjtZuZTSP2Nu6zbDvXAw==
X-Received: by 2002:a92:1685:: with SMTP id 5mr2085408ilw.81.1569546804169;
        Thu, 26 Sep 2019 18:13:24 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z5sm1717813ioh.23.2019.09.26.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 18:13:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, --cc=linux-kselftest@vger.kernel.org
Subject: [PATCH] tools: gpio: Use !building_out_of_srctree to determine srctree
Date:   Thu, 26 Sep 2019 19:13:21 -0600
Message-Id: <20190927011321.4612-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make TARGETS=gpio kselftest fails with:

Makefile:23: tools/build/Makefile.include: No such file or directory

When the gpio tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/gpio Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=gpio kselftest" build failure.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/gpio/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 6ecdd1067826..1178d302757e 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -3,7 +3,11 @@ include ../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
-ifeq ($(srctree),)
+# This will work when gpio is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
-- 
2.20.1

