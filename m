Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0654C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8620835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNEXFy16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfJFSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:45:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35220 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:45:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so10245371wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ryt44dYF+Okzl6PcwuHu8tX6xIio9b6pLvqbXSxoGw=;
        b=eNEXFy16//OMOnrla/5phF7B1i2UyMD183QB619gmOb+MsXwdp1G559C7zzNZmcgxj
         GbO+xuCd92PDKL62/aD+UD1zMeMlYW0muQ8yUvpttSLZV98WVt8BTRVquIUc7kvWpa2c
         LnCrKDh0Tyg66hkOa78rSS8AGAZA1hFns8tPkvhBRYDR4148qBtIdUanzj6Z90mdV5dn
         HVZtQdLHHXbA+BqZa+tdC1pd+0BG5TdcmIrdbbp4yx3lSCzrnmzOO0o7nJNI/ZebbbGN
         wKv8XaX4Mh0MjxQ6ZGXATGBX34RhGs9iqwTcW4Xv7XN6dR2OMzP9svdgUoeP0NLcyOA+
         TudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ryt44dYF+Okzl6PcwuHu8tX6xIio9b6pLvqbXSxoGw=;
        b=l5N2tZ2650emwnjSpvEpTvYvuC3RRqKqx/fBchy3w1M5hmwOfk0iNvTW+y4GtidjnE
         bqYjex6Ubc428+MHXza//kJAbwfAv5RhBPRpxoo4aL9r8QGLeXMYhjDL7rTWvibKej42
         dumBiJ+YnbMTfVJLGd4ahWTVGVtbfEzUOL2ZshfHLRd/RqnC6vQ2GlmitjVNL1770qSh
         TcQmvWJmaBqlvfmQS9oX+OBS37u4voS8QXujrWg5W52TNH2yODxY3uh9aE3M16GdrRpM
         bzGu40iBP06dxmeFDTaOAneyW3CDGESmZJqQh+fg6wi4lcdhskXky/YmgYX4w4++2+/x
         BkWw==
X-Gm-Message-State: APjAAAVMcETKAGMI2LEUiZgIhEFDg1jTkvAtCq6ybral7DdYvDccbTQr
        9FSDvvxDfLHJKI5EgV7gesjwl16brLbG
X-Google-Smtp-Source: APXvYqy0PZGhtELWmehD0sPE/LxSPcKpneJR6YQHUlQlmztU96zitOq8IboYZm4dEaPbMiO7XR09yw==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr18622742wmh.101.1570387533861;
        Sun, 06 Oct 2019 11:45:33 -0700 (PDT)
Received: from ninjahub.lan (host-92-15-175-166.as43234.net. [92.15.175.166])
        by smtp.googlemail.com with ESMTPSA id t17sm28212757wrp.72.2019.10.06.11.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 11:45:33 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, olsonse@umich.edu,
        hsweeten@visionengravers.com, abbotti@mev.co.uk,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: comedi: Capitalize macro name to fix camelcase checkpatch warning
Date:   Sun,  6 Oct 2019 19:45:21 +0100
Message-Id: <20191006184521.11849-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capitalize RANGE_mA to fix camelcase check warning.
Issue reported by checkpatch.pl

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/comedi/comedidev.h           | 2 +-
 drivers/staging/comedi/drivers/adv_pci1724.c | 4 ++--
 drivers/staging/comedi/drivers/dac02.c       | 2 +-
 drivers/staging/comedi/range.c               | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index 54c091866777..2fc536db203c 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -603,7 +603,7 @@ int comedi_check_chanlist(struct comedi_subdevice *s,
 
 #define RANGE(a, b)		{(a) * 1e6, (b) * 1e6, 0}
 #define RANGE_ext(a, b)		{(a) * 1e6, (b) * 1e6, RF_EXTERNAL}
-#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
+#define RANGE_MA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
 #define RANGE_unitless(a, b)	{(a) * 1e6, (b) * 1e6, 0}
 #define BIP_RANGE(a)		{-(a) * 1e6, (a) * 1e6, 0}
 #define UNI_RANGE(a)		{0, (a) * 1e6, 0}
diff --git a/drivers/staging/comedi/drivers/adv_pci1724.c b/drivers/staging/comedi/drivers/adv_pci1724.c
index e8ab573c839f..f20d710c19d3 100644
--- a/drivers/staging/comedi/drivers/adv_pci1724.c
+++ b/drivers/staging/comedi/drivers/adv_pci1724.c
@@ -64,8 +64,8 @@
 static const struct comedi_lrange adv_pci1724_ao_ranges = {
 	4, {
 		BIP_RANGE(10),
-		RANGE_mA(0, 20),
-		RANGE_mA(4, 20),
+		RANGE_MA(0, 20),
+		RANGE_MA(4, 20),
 		RANGE_unitless(0, 1)
 	}
 };
diff --git a/drivers/staging/comedi/drivers/dac02.c b/drivers/staging/comedi/drivers/dac02.c
index 5ef8114c2c85..4503cbdf673c 100644
--- a/drivers/staging/comedi/drivers/dac02.c
+++ b/drivers/staging/comedi/drivers/dac02.c
@@ -54,7 +54,7 @@ static const struct comedi_lrange das02_ao_ranges = {
 		UNI_RANGE(10),
 		BIP_RANGE(5),
 		BIP_RANGE(10),
-		RANGE_mA(4, 20),
+		RANGE_MA(4, 20),
 		RANGE_ext(0, 1)
 	}
 };
diff --git a/drivers/staging/comedi/range.c b/drivers/staging/comedi/range.c
index 89d599877445..dacdd7b6f1a0 100644
--- a/drivers/staging/comedi/range.c
+++ b/drivers/staging/comedi/range.c
@@ -23,11 +23,11 @@ const struct comedi_lrange range_unipolar5 = { 1, {UNI_RANGE(5)} };
 EXPORT_SYMBOL_GPL(range_unipolar5);
 const struct comedi_lrange range_unipolar2_5 = { 1, {UNI_RANGE(2.5)} };
 EXPORT_SYMBOL_GPL(range_unipolar2_5);
-const struct comedi_lrange range_0_20mA = { 1, {RANGE_mA(0, 20)} };
+const struct comedi_lrange range_0_20mA = { 1, {RANGE_MA(0, 20)} };
 EXPORT_SYMBOL_GPL(range_0_20mA);
-const struct comedi_lrange range_4_20mA = { 1, {RANGE_mA(4, 20)} };
+const struct comedi_lrange range_4_20mA = { 1, {RANGE_MA(4, 20)} };
 EXPORT_SYMBOL_GPL(range_4_20mA);
-const struct comedi_lrange range_0_32mA = { 1, {RANGE_mA(0, 32)} };
+const struct comedi_lrange range_0_32mA = { 1, {RANGE_MA(0, 32)} };
 EXPORT_SYMBOL_GPL(range_0_32mA);
 const struct comedi_lrange range_unknown = { 1, {{0, 1000000, UNIT_none} } };
 EXPORT_SYMBOL_GPL(range_unknown);
-- 
2.21.0

