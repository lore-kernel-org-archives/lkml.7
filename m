Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36632173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkkRlIN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfGQPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:03:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGQPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:03:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so5150589pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+35wY4n6TRGBA25+7fjzjSlCN1Rhjq9o1vYnjDLMlM=;
        b=VkkRlIN8iWWTBSr2SSVDfUDbi3S8rHZmETaBALoYvm0uoLEHS9lTpx7rWdKPwUYCll
         cFSr4ZMYCOp8bo/BprPz75j5hPk7X6rAjE5geNVNx+xA2L7B4oz+sNo5M0P4t5N6LX58
         TVtHHSXyMuQozCIOz4kw8aCVkeLalvCcLnRNRoSckmEPW9Ts2+UjfcDD4TWX2s7ryWa/
         j3aM6FhZuFP+riAQ9K/aIhSuvet42KUH+t2KiOWUk/Zmw6sDKkpKaH9YzWDDuH6p0IOb
         6omt3KOrGCEo8GKuhsPmIyGgFt+dd/rS7dMkMtbyfe86a2qCMpU2gXZYQWDjNngKMwar
         AMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+35wY4n6TRGBA25+7fjzjSlCN1Rhjq9o1vYnjDLMlM=;
        b=T35CcDZCCCkxPsNjSyFW51CQlLB2omjF08k4XfnUMtVvTGl8lEV1LzEVZ6kEpcqAQ+
         lcKximtwGi8LWaCh6YeGDfBCTP7x+f8F3x0x6lm1KS/hvleyUb1U7fF/81IcAkJ4Qcuc
         WqfS6VFsEbw+jzPvNcQ4Xk2HS4L/eJw4Q/t/30OyH4ITQYpw0DJ6EyH16aGvLzM63zpR
         MBz/jKJ8V+xUqBl+5Imbd+M6j9ki6mzSFSLqgW4dco+3lTUzpi4CR7g06o5nzf4RQm54
         HQHln7X/iX7cutKF5M7Tmv6GWoGIcSUR7WL4rR2pR9eTR1r0oGrS4tFFzYOGGHwnwJl4
         984Q==
X-Gm-Message-State: APjAAAUGuORIhXj2hvIq/vg4h9I3UmnCL3DBTt2e0w5ZMI+oQgOKoeWR
        8W9lnJLbIwSZYjfsdBHGLxU=
X-Google-Smtp-Source: APXvYqy7mQH4W8sbb/Iy1eG7LeTPa5Sk5gMkSlfKVdCrI7UaDwrnXGmpietbpJAA8uI8R7gBpbiDng==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9mr40905784plb.143.1563375779825;
        Wed, 17 Jul 2019 08:02:59 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b37sm44728961pjc.15.2019.07.17.08.02.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:02:59 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: vf610-zii-spb4: Drop unused pinctrl_i2c1 pinmux config
Date:   Wed, 17 Jul 2019 08:02:51 -0700
Message-Id: <20190717150253.20107-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinctrl_i2c1 pinmux config is not used anywhere. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-spb4.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 9dde83ccb9d1..77e1484211e4 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -316,13 +316,6 @@
 		>;
 	};
 
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			VF610_PAD_PTB16__I2C1_SCL		0x37ff
-			VF610_PAD_PTB17__I2C1_SDA		0x37ff
-		>;
-	};
-
 	pinctrl_leds_debug: pinctrl-leds-debug {
 		fsl,pins = <
 			VF610_PAD_PTD3__GPIO_82			0x31c2
-- 
2.21.0

