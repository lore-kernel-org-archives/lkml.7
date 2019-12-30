Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542BBC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BC320730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726893;
	bh=pDY2jgrEvo3eCGKykGqpYhFSgX4nnKOmj1O3sl70LGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NzZZifZC9GsJNJy6Q/Z7RhFOUaxKypNjnUSoDjmqMYzpAHuvVvmGAAlkB4Vt3qCdQ
	 Esb0cXTrzM3eQhAMTWJtuAAcY1VSyB+ggzOGaITputDnnhj/AnKc0frAfGGIMYC3py
	 GnzpsU8qI2EQp1Nt1NAOUAdtuKT4ClEAhwB4SMXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfL3R2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3R2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:28:10 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B536820730;
        Mon, 30 Dec 2019 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726889;
        bh=pDY2jgrEvo3eCGKykGqpYhFSgX4nnKOmj1O3sl70LGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW/fGdwVeC/XZXDIQ8/J9YupbFrwIPe45lulGGilx3WLfB/M15RJog2O3ruzS6Uyl
         StHDrTongR2eAP293fgQ7dQyUlbJWGkUPV20CoTNBYy1qWOWe5ekVArtzzWng4wSxa
         5coDyCrdsfXtu1kAQe//Sq1R9v2RUp2m16IhC8mc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Max Staudt <max@enpas.org>,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] i2c: stu300: Use proper printk format for iomem pointer
Date:   Mon, 30 Dec 2019 18:27:50 +0100
Message-Id: <20191230172751.17985-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172751.17985-1-krzk@kernel.org>
References: <20191230172751.17985-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iomem pointers should be printed with pointer format to hide the
actual value and fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-stu300.c: In function ‘stu300_wait_while_busy’:
    drivers/i2c/busses/i2c-stu300.c:446:76: warning:
        cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 8c3e2d409d63..42e0a53e7fa4 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -444,7 +444,7 @@ static int stu300_wait_while_busy(struct stu300_dev *dev)
 		       "Attempt: %d\n", i+1);
 
 		dev_err(&dev->pdev->dev, "base address = "
-			"0x%08x, reinit hardware\n", (u32) dev->virtbase);
+			"0x%p, reinit hardware\n", dev->virtbase);
 
 		(void) stu300_init_hw(dev);
 	}
-- 
2.17.1

