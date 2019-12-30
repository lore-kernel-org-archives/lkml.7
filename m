Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35159C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991320722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726882;
	bh=cb2Iaj0ggf2QTwJp6dt00bYXbNkMmqHeppfae+zRfzo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZDdaNG9w62juSPSvsltsbsA4H52zdARlxt6SdXcVUbHyWsoGzIr2XYr2IhdeyOHw5
	 xA3/r1ct7XZcQFsrz3idBzzs4SB+g12VRer47JRkO7cAWPXOnvRwoeTv3T8sPIJBcl
	 M2JL3BE5iGiqTGEbM21ZV7ZAC6KcowOF2uxdfioQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfL3R2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3R2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:28:00 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7651206DB;
        Mon, 30 Dec 2019 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726879;
        bh=cb2Iaj0ggf2QTwJp6dt00bYXbNkMmqHeppfae+zRfzo=;
        h=From:To:Cc:Subject:Date:From;
        b=MsZteBXw7tmqiQErptqpbJHbDpozN7LSBUww1chEtMr1gL6lCeCMe+xzboAzkt8pG
         RjTgpmshR2e3cfqO6PUb0LUVJkX6hzaSRT6UDxsAacKcy1nyZIqKYavTQulwLNxjzw
         5C8N3R1ZmDIcpixkqwll5nza7IYTakzHIzvxow5Q=
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
Subject: [PATCH 1/5] i2c: pmcmsp: Use proper printk format for resource_size_t
Date:   Mon, 30 Dec 2019 18:27:47 +0100
Message-Id: <20191230172751.17985-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource_size_t should be printed with its own size-independent format
to fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-pmcmsp.c: In function ‘pmcmsptwi_probe’:
    drivers/i2c/busses/i2c-pmcmsp.c:276:25: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 3 has type ‘resource_size_t {aka long long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 4fde74eb34a7..5d3a12bd420b 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -274,8 +274,8 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	if (!request_mem_region(res->start, resource_size(res),
 				pldev->name)) {
 		dev_err(&pldev->dev,
-			"Unable to get memory/io address region 0x%08x\n",
-			res->start);
+			"Unable to get memory/io address region %pa[p]\n",
+			&(res->start));
 		rc = -EBUSY;
 		goto ret_err;
 	}
@@ -285,7 +285,7 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 						resource_size(res));
 	if (!pmcmsptwi_data.iobase) {
 		dev_err(&pldev->dev,
-			"Unable to ioremap address 0x%08x\n", res->start);
+			"Unable to ioremap address %pa[p]\n", &(res->start));
 		rc = -EIO;
 		goto ret_unreserve;
 	}
-- 
2.17.1

