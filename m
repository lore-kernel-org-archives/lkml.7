Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4DC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B29520700
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="MEyDrrP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfCaKHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:07:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:26525 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfCaKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554026858;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=9KpfqvSvmkzQs/oXlj5DbIY7Fkf8xkxjGwX+BlflBPM=;
        b=MEyDrrP9kpNDS2yJLRGmAIyiEcJWH0C7wsGXf/PxB7PoIk+mWtvNbrSs3dkjwrjEMh
        mzK3830BXG9F2VMuR39JUZpuXidifqHm28iLD4z7nDYEuBXSvXR8QQmf3NfZJ+cE5HVU
        hzlowNgxksDGRUo/NLcTcO36DYt5ggZN+CCXg56w4qA8SDLC37ll/wl6rPomDtmB0cZX
        e/GUnaEX7yfC/Qa/4+ZKLoFq81sPFOWvafHRcIOjWVR4Hlf82xQV3RDT6rkQ0gqn+DCf
        DzsetiWGC9o+xDClfsLIhFUlQh7laQ0pTCeUGQeuWKmOmWfQ7Vm5F1gb2R99Jq9jRO/7
        Z7pw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjXtNgX"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2VA7NX1m
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Mar 2019 12:07:23 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
Date:   Sun, 31 Mar 2019 12:07:19 +0200
Message-Id: <cover.1554026842.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-25 07:55:28: 

H. Nikolaus Schaller (4):
  DTS: GTA04: SPI / gpiolib: work around a regression that unhides a
    broken legacy handler, which makes the gta04 display inoperable
  REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix"
    our device tree file
  gpiolib: make legacy handling for spi-cs-high optional
  gpiolib: spi-cs-high is checking the wrong node (the controller and
    not the SPI slave device)

 drivers/gpio/Kconfig      | 8 ++++++++
 drivers/gpio/gpiolib-of.c | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.19.1

