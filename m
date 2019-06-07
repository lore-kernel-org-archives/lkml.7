Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79152089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LGNaJv5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfFGJCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:02:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42110 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:02:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so1321682wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/xgR5j9++o/IJFaras/pmlOomePQdSslom82YUYeMA=;
        b=LGNaJv5PZkTpfOgsh2GlidgQ+SwvbmP2ki//SLuYiaD8SMqxB+yTnXeFR0P+/Z+err
         Aj3Ie4TJCW/CDIc/G9b6lEMG4S1yEO9M7y9OxEPT+n+DAAeC3PoZm6nMJk/WSbphkUGE
         pe88nwmO5d+ZD80k1sbbEJy9ULn/qUQOz6CEo6lpciXWWiN2yzczXUzAon3btnYxhtsm
         YIJPeGDylXB7SQyg+TZwvLaZvCTLkf/KNFy35TUISW5oIP6TnCrOoU3pNvmOQC09/zRX
         I2dc8ovK1QBCSbbClg3+bgt4iDAprAXF54kC8uYvJs49pabKoVszun2PCBxFx+/iyLaW
         H/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/xgR5j9++o/IJFaras/pmlOomePQdSslom82YUYeMA=;
        b=fuxYs6Oc+uk3Tzjb19UXNg8Y+BysyAcFGha/lVuKi1brV/o8PXDMxkWbGho/5VvxOX
         mo9/6M1d/MExtW378gocbDcPCaSB9hDJQYN3t3BEHT6ypKDozcC5yz7X+Y5IwUpmYfmG
         qmyitOrwsWCJbgLxpO4rPDkNwjwoIjIiC+7cTzdBcBAocsAP5tSWcLfnRi7GMTfkzH91
         G9QKPfKnoPZIOYzPC4rSS0yWtF+IO1WMnOtMmTo657aiR0cddd62IVJehvy41UBsi51C
         vDqwPcwy/JdTV0i9zyd3S57+QbtCqp+8R4ewnyqcjSeSKrNDKa9T471gOEY8fq0p+aJF
         CC2g==
X-Gm-Message-State: APjAAAV+WIzy14rErcKP6tglG5ZF2fiQ7gzW4B9zThF7x+OaoMmMrWYs
        r2Du2kCh5PREWd0qjJAn/kqobA==
X-Google-Smtp-Source: APXvYqxWxNSKoYoMGfHNmDh2K2l4SWVxASc8qfOvlvmrxrXJSe6LTdHa1sZFO8sV6S7XdvJQD713NQ==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr20099906wre.33.1559898129860;
        Fri, 07 Jun 2019 02:02:09 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id a125sm1487444wmf.42.2019.06.07.02.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 02:02:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: davinci: da850-evm: call regulator_has_full_constraints()
Date:   Fri,  7 Jun 2019 11:02:01 +0200
Message-Id: <20190607090201.5995-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The BB expander at 0x21 i2c bus 1 fails to probe on da850-evm because
the board doesn't set has_full_constraints to true in the regulator
API.

Call regulator_has_full_constraints() at the end of board registration
just like we do in da850-lcdk and da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 4ee65a8a3b80..31ae3be5741d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1480,6 +1480,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.21.0

