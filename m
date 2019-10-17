Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA076ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59EA2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394910AbfJQOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:20:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46183 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbfJQOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:20:23 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 533E220005;
        Thu, 17 Oct 2019 14:20:20 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/7] atmel-spi: Allow using more than 4 GPIOs as CS
Date:   Thu, 17 Oct 2019 16:18:39 +0200
Message-Id: <20191017141846.7523-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the main purpose of this series is allowing to use more than 4 GPIOs
as CS. But while doing it, I also clean-up the code and the comments
to match the actual support of the hardware.

Thanks to this series, it is now more clear to see what can be done
with CS GPIO and native CS. It is also possible to mix native and GPIO
CS as expected by the SPI binding.

In the end even managment of the specific use case for CS0 on
AT91RM9200 has been simplified.

Gregory

Gregory CLEMENT (7):
  spi: atmel: Remove and fix erroneous comments
  spi: atmel: Fix CS high support
  spi: atmel: Configure GPIO per CS instead of by controller
  spi: atmel: Remove useless private field
  spi: atmel: Remove platform data support
  spi: atmel: Improve and fix GPIO CS usage
  spi: atmel: Improve CS0 case support on AT91RM9200

 drivers/spi/Kconfig     |   1 +
 drivers/spi/spi-atmel.c | 154 ++++++++++++++++++++++++----------------
 2 files changed, 92 insertions(+), 63 deletions(-)

-- 
2.23.0

